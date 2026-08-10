#!/usr/bin/env python3
"""Генератор фикстуры tests/фикстуры/ci-токены.json.

Тесты доверенных конвейеров проверяют НАСТОЯЩУЮ подпись RS256, а подписать 2048-бит
закрытым ключом на чистом OneScript нельзя за разумное время (секретная экспонента —
две тысячи бит, это тысячи умножений по модулю). Поэтому пары ключей и подписи
делаются здесь, а в дерево кладётся JSON: документ JWKS и готовые компактные JWS.

Срок жизни годных токенов намеренно далёкий (2099 год): фикстура не должна протухать
календарём. Отдельный токен с истёкшим exp лежит рядом и закрывает проверку срока.

Запуск: python3 tests/фикстуры/сгенерировать-ci-токены.py
"""
import base64
import json
import os

from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding, rsa

ЗДЕСЬ = os.path.dirname(os.path.abspath(__file__))
КОРЕНЬ = os.path.dirname(ЗДЕСЬ)
ВЫХОД = os.path.join(КОРЕНЬ, "tests", "фикстуры", "ci-токены.json")

ИЗДАТЕЛЬ = "https://token.actions.githubusercontent.com"
АУДИТОРИЯ = "https://hub.example.test"
РЕПОЗИТОРИЙ = "acme/widgets"
КОНВЕЙЕР = "acme/widgets/.github/workflows/release.yml@refs/heads/main"
# верхнеуровневый workflow своего репозитория — именно он сверяется с записью доверия;
# job_workflow_ref при вызове reusable указывает на ЧУЖОЙ репозиторий и не сверяется
ЧУЖОЙ_REUSABLE = "octo-org/shared-workflows/.github/workflows/publish.yml@refs/heads/main"
ДРУГОЙ_ФАЙЛ = "acme/widgets/.github/workflows/nightly.yml@refs/heads/main"
# GitLab: клейм несёт ХОСТ и разделитель «//» между проектом и путём конфига
ИЗДАТЕЛЬ_GITLAB = "https://gitlab.com"
КОНФИГ_GITLAB = "gitlab.com/acme/widgets//.gitlab-ci.yml@refs/heads/main"
РЕФ = "refs/heads/main"
KID = "openhub-ci-1"

ДАЛЁКИЙ_EXP = 4102444800   # 2100-01-01
ДАВНИЙ_EXP = 1104537600    # 2005-01-01
IAT = 1704067200           # 2024-01-01


def b64u(данные: bytes) -> str:
    return base64.urlsafe_b64encode(данные).decode().rstrip("=")


def b64u_json(значение) -> str:
    return b64u(json.dumps(значение, separators=(",", ":"), ensure_ascii=False).encode())


def jwk(ключ: rsa.RSAPublicKey, kid: str) -> dict:
    числа = ключ.public_numbers()
    длина = (числа.n.bit_length() + 7) // 8
    return {
        "kty": "RSA",
        "use": "sig",
        "alg": "RS256",
        "kid": kid,
        "n": b64u(числа.n.to_bytes(длина, "big")),
        "e": b64u(числа.e.to_bytes((числа.e.bit_length() + 7) // 8, "big")),
    }


def подписать(закрытый: rsa.RSAPrivateKey, заголовок: dict, клеймы: dict) -> str:
    вход = b64u_json(заголовок) + "." + b64u_json(клеймы)
    подпись = закрытый.sign(вход.encode(), padding.PKCS1v15(), hashes.SHA256())
    return вход + "." + b64u(подпись)


def клеймы(**переопределения) -> dict:
    базовые = {
        "iss": ИЗДАТЕЛЬ,
        "aud": АУДИТОРИЯ,
        "sub": "repo:%s:ref:%s" % (РЕПОЗИТОРИЙ, РЕФ),
        "exp": ДАЛЁКИЙ_EXP,
        "nbf": IAT,
        "iat": IAT,
        "repository": РЕПОЗИТОРИЙ,
        "workflow_ref": КОНВЕЙЕР,
        "job_workflow_ref": КОНВЕЙЕР,
        "ref": РЕФ,
    }
    базовые.update(переопределения)
    return {ключ: значение for ключ, значение in базовые.items() if значение is not None}


def главная():
    свой = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    чужой = rsa.generate_private_key(public_exponent=65537, key_size=2048)

    заголовок = {"alg": "RS256", "typ": "JWT", "kid": KID}
    заголовок_чужой_kid = {"alg": "RS256", "typ": "JWT", "kid": "неизвестный-kid"}

    вход_none = b64u_json({"alg": "none", "typ": "JWT", "kid": KID}) + "." + b64u_json(клеймы())

    токены = {
        "годный": подписать(свой, заголовок, клеймы()),
        "чужая_подпись": подписать(чужой, заголовок, клеймы()),
        "неизвестный_kid": подписать(чужой, заголовок_чужой_kid, клеймы()),
        "истёкший": подписать(свой, заголовок, клеймы(exp=ДАВНИЙ_EXP)),
        # exp вовсе нет и nbf в будущем: собственную политику срока хаб держит независимо
        # от того, смотрит ли на срок установленный проверяющий подписи
        "без_срока": подписать(свой, заголовок, клеймы(exp=None)),
        "срок_ещё_не_начался": подписать(свой, заголовок, клеймы(nbf=ДАЛЁКИЙ_EXP)),
        "чужая_аудитория": подписать(свой, заголовок, клеймы(aud="https://evil.example.test")),
        "без_аудитории": подписать(свой, заголовок, клеймы(aud=None)),
        "аудитория_массивом": подписать(
            свой, заголовок, клеймы(aud=["https://other.example.test", АУДИТОРИЯ])),
        "чужой_репозиторий": подписать(свой, заголовок, клеймы(repository="evil/fork")),
        "чужой_реф": подписать(свой, заголовок, клеймы(
            ref="refs/heads/attacker",
            workflow_ref="acme/widgets/.github/workflows/release.yml@refs/heads/attacker",
            job_workflow_ref="acme/widgets/.github/workflows/release.yml@refs/heads/attacker")),
        # обычный запуск: оба клейма про один и тот же файл своего репозитория
        # reusable: верхнеуровневый workflow свой, а job определён в ЧУЖОМ репозитории —
        # доверие обязано сработать, потому что сверяется верхнеуровневый
        "reusable": подписать(свой, заголовок, клеймы(job_workflow_ref=ЧУЖОЙ_REUSABLE)),
        # МЕНЯЕТСЯ РОВНО ОДИН клейм — верхнеуровневый файл: иначе сверка сравнивала бы
        # значение сама с собой и проверка файла была бы ненагруженной
        "чужой_конвейер": подписать(свой, заголовок, клеймы(workflow_ref=ДРУГОЙ_ФАЙЛ)),
        "чужой_издатель": подписать(свой, заголовок, клеймы(iss="https://evil.example.test")),
        "издатель_gitlab": подписать(свой, заголовок, клеймы(iss="https://gitlab.com")),
        # полноценный токен GitLab: свой издатель, project_path и ci_config_ref_uri
        "gitlab_годный": подписать(свой, заголовок, клеймы(
            iss=ИЗДАТЕЛЬ_GITLAB, repository=None, project_path=РЕПОЗИТОРИЙ,
            workflow_ref=None, job_workflow_ref=None, ci_config_ref_uri=КОНФИГ_GITLAB)),
        # тот же токен, но конфиг другой — сверка пути нагружена и у GitLab
        "gitlab_чужой_конфиг": подписать(свой, заголовок, клеймы(
            iss=ИЗДАТЕЛЬ_GITLAB, repository=None, project_path=РЕПОЗИТОРИЙ,
            workflow_ref=None, job_workflow_ref=None,
            ci_config_ref_uri="gitlab.com/acme/widgets//other/.gitlab-ci.yml@refs/heads/main")),
        "alg_none": вход_none + ".",
    }

    фикстура = {
        "издатель": ИЗДАТЕЛЬ,
        "аудитория": АУДИТОРИЯ,
        "репозиторий": РЕПОЗИТОРИЙ,
        "конвейер": КОНВЕЙЕР,
        "издатель_gitlab_адрес": ИЗДАТЕЛЬ_GITLAB,
        "конфиг_gitlab": КОНФИГ_GITLAB,
        "реф": РЕФ,
        "kid": KID,
        "адрес_дискавери": ИЗДАТЕЛЬ + "/.well-known/openid-configuration",
        "адрес_ключей": ИЗДАТЕЛЬ + "/.well-known/jwks",
        "дискавери": json.dumps(
            {"issuer": ИЗДАТЕЛЬ, "jwks_uri": ИЗДАТЕЛЬ + "/.well-known/jwks"},
            separators=(",", ":")),
        "жвк": json.dumps({"keys": [jwk(свой.public_key(), KID)]}, separators=(",", ":")),
        "жвк_чужой": json.dumps({"keys": [jwk(чужой.public_key(), KID)]}, separators=(",", ":")),
        "токены": токены,
    }

    with open(ВЫХОД, "w", encoding="utf-8") as файл:
        json.dump(фикстура, файл, ensure_ascii=False, indent=1, sort_keys=True)
        файл.write("\n")
    print("записано:", ВЫХОД)


if __name__ == "__main__":
    главная()
