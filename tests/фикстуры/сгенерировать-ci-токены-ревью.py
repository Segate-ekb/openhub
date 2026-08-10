#!/usr/bin/env python3
"""Генератор фикстуры ревью tests/фикстуры/ci-токены-ревью.json.

Надстройка над tests/фикстуры/сгенерировать-ci-токены.py: тот же ключ и тот же JWKS, но
добавлены атакующие токены, которых в наборе автора нет — массивная форма aud без
нашего адреса, подстрока и префикс адреса, регистр и хвостовой слэш издателя,
подделка конвейера, nbf в будущем, отсутствие exp, HS256-подмена алгоритма.
"""
import base64
import hashlib
import hmac
import json
import os

from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.asymmetric import padding, rsa

ЗДЕСЬ = os.path.dirname(os.path.abspath(__file__))
КОРЕНЬ = os.path.dirname(ЗДЕСЬ)
ВЫХОД = os.path.join(КОРЕНЬ, "tests", "фикстуры", "ci-токены-ревью.json")

ИЗДАТЕЛЬ = "https://token.actions.githubusercontent.com"
АУДИТОРИЯ = "https://hub.example.test"
РЕПОЗИТОРИЙ = "acme/widgets"
КОНВЕЙЕР = "acme/widgets/.github/workflows/release.yml@refs/heads/main"
РЕФ = "refs/heads/main"
KID = "openhub-ci-1"
KID_ГИТЛАБ = "gitlab-ci-1"
ИЗДАТЕЛЬ_ГИТЛАБ = "https://gitlab.com"

ДАЛЁКИЙ_EXP = 4102444800
IAT = 1704067200


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


def подписать(закрытый, заголовок: dict, клеймы: dict) -> str:
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
    гитлаб = rsa.generate_private_key(public_exponent=65537, key_size=2048)
    заголовок = {"alg": "RS256", "typ": "JWT", "kid": KID}
    заголовок_гитлаб = {"alg": "RS256", "typ": "JWT", "kid": KID_ГИТЛАБ}

    # HS256, где ключом взят модуль открытого ключа — классическая подмена алгоритма
    вход_hs = b64u_json({"alg": "HS256", "typ": "JWT", "kid": KID}) + "." + b64u_json(клеймы())
    числа = свой.public_key().public_numbers()
    длина = (числа.n.bit_length() + 7) // 8
    мак = hmac.new(числа.n.to_bytes(длина, "big"), вход_hs.encode(), hashlib.sha256).digest()

    токены = {
        "годный": подписать(свой, заголовок, клеймы()),

        # aud: массив БЕЗ нашего адреса — негатив массивной формы, которого у автора нет
        "aud_массив_чужой": подписать(свой, заголовок, клеймы(
            aud=["https://a.example.test", "https://b.example.test"])),
        # aud — наш адрес как ПРЕФИКС чужого хоста
        "aud_наш_как_префикс": подписать(свой, заголовок, клеймы(
            aud="https://hub.example.test.evil.test")),
        # aud — наш адрес плюс путь
        "aud_наш_с_путём": подписать(свой, заголовок, клеймы(
            aud="https://hub.example.test/publish")),
        # aud — подстрока нашего адреса
        "aud_подстрока": подписать(свой, заголовок, клеймы(aud="hub.example.test")),
        # aud — наш адрес другим регистром и с хвостовым слэшем (должен ПРОЙТИ)
        "aud_регистр_и_слэш": подписать(свой, заголовок, клеймы(
            aud="HTTPS://HUB.EXAMPLE.TEST/")),
        # aud — пустая строка
        "aud_пустой": подписать(свой, заголовок, клеймы(aud="")),
        # aud — массив с нашим адресом в другом регистре (должен ПРОЙТИ)
        "aud_массив_регистр": подписать(свой, заголовок, клеймы(
            aud=["https://x.example.test", "HTTPS://Hub.Example.Test/"])),

        # iss другим регистром и с хвостовым слэшем — сверка подписанного iss не должна ломаться
        "iss_регистр_и_слэш": подписать(свой, заголовок, клеймы(
            iss="HTTPS://TOKEN.ACTIONS.GITHUBUSERCONTENT.COM/")),
        # iss с юникод-двойником хоста (кириллические о/с/а)
        "iss_юникод_двойник": подписать(свой, заголовок, клеймы(
            iss="https://tоken.actions.githubusercontent.com")),
        # iss — хост со встроенным портом
        "iss_с_портом": подписать(свой, заголовок, клеймы(
            iss="https://token.actions.githubusercontent.com:443")),

        # конвейер чужой при том же рефе — проверка КонвейерСовпадает; меняется РОВНО
        # верхнеуровневый клейм, поэтому сверка файла нагружена
        "чужой_конвейер": подписать(свой, заголовок, клеймы(
            workflow_ref="acme/widgets/.github/workflows/evil.yml@refs/heads/main")),
        # конвейер тот же, но в другом регистре и с другим хвостом @ref (должен ПРОЙТИ)
        "конвейер_регистр": подписать(свой, заголовок, клеймы(
            workflow_ref="ACME/Widgets/.github/workflows/RELEASE.yml@refs/heads/main")),
        # верхнеуровневый клейм есть, а job определён в чужом репозитории (reusable):
        # сверяется первый, поэтому публикация проходит
        "reusable": подписать(свой, заголовок, клеймы(
            job_workflow_ref="octo-org/shared/.github/workflows/publish.yml@refs/heads/main")),
        # конвейера нет ни в каком виде
        "конвейера_нет": подписать(свой, заголовок, клеймы(
            workflow_ref=None, job_workflow_ref=None)),

        # nbf далеко в будущем
        "nbf_в_будущем": подписать(свой, заголовок, клеймы(nbf=4102444700)),
        # exp отсутствует
        "без_exp": подписать(свой, заголовок, клеймы(exp=None)),
        # exp строкой, а не числом
        "exp_строкой": подписать(свой, заголовок, клеймы(exp=str(ДАЛЁКИЙ_EXP))),

        # repository другим регистром (должен ПРОЙТИ — НРег с обеих сторон)
        "репозиторий_регистр": подписать(свой, заголовок, клеймы(repository="ACME/Widgets")),
        # repository отсутствует, но есть project_path чужого провайдера
        "репозиторий_через_project_path": подписать(свой, заголовок, клеймы(
            repository=None, project_path=РЕПОЗИТОРИЙ)),
        # repository отсутствует вовсе
        "репозитория_нет": подписать(свой, заголовок, клеймы(repository=None)),

        # HS256 c модулем в роли секрета
        "alg_hs256": вход_hs + "." + b64u(мак),

        # ключ ЧУЖОГО издателя: iss называет GitHub, а подписан ключом, который лежит
        # только в JWKS GitLab. Смешение источников ключей — единственное, что его пропустит
        "ключ_гитлаба_издатель_гитхаб": подписать(гитлаб, заголовок_гитлаб, клеймы()),
        # КОНТРОЛЬ к нему: тот же ключ и тот же kid, но iss = свой издатель ключа
        "ключ_гитлаба_издатель_гитлаб": подписать(
            гитлаб, заголовок_гитлаб, клеймы(iss=ИЗДАТЕЛЬ_ГИТЛАБ)),
    }

    фикстура = {
        "издатель": ИЗДАТЕЛЬ,
        "аудитория": АУДИТОРИЯ,
        "репозиторий": РЕПОЗИТОРИЙ,
        "конвейер": КОНВЕЙЕР,
        "реф": РЕФ,
        "kid": KID,
        "адрес_дискавери": ИЗДАТЕЛЬ + "/.well-known/openid-configuration",
        "адрес_ключей": ИЗДАТЕЛЬ + "/.well-known/jwks",
        "дискавери": json.dumps(
            {"issuer": ИЗДАТЕЛЬ, "jwks_uri": ИЗДАТЕЛЬ + "/.well-known/jwks"},
            separators=(",", ":")),
        "жвк": json.dumps({"keys": [jwk(свой.public_key(), KID)]}, separators=(",", ":")),
        # JWKS GitLab держит ДРУГОЙ ключ под другим kid: иначе «ключи не того издателя»
        # не отличить от «ключи того издателя»
        "издатель_гитлаб": ИЗДАТЕЛЬ_ГИТЛАБ,
        "жвк_гитлаб": json.dumps(
            {"keys": [jwk(гитлаб.public_key(), KID_ГИТЛАБ)]}, separators=(",", ":")),
        "токены": токены,
    }

    with open(ВЫХОД, "w", encoding="utf-8") as файл:
        json.dump(фикстура, файл, ensure_ascii=False, indent=1, sort_keys=True)
        файл.write("\n")
    print("записано:", ВЫХОД)


if __name__ == "__main__":
    главная()
