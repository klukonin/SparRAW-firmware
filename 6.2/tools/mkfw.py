#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Собирает прошиваемый .fw из кусков, полученных из нашего дерева исходников.

Формат контейнера — тот же, что понимает mainline-драйвер wil6210:
последовательность записей с восьмибайтовым заголовком (тип, флаги, размер),
тело выравнено на 4.  Первая запись — file_header с длиной и CRC всего файла.
"""
import argparse
import struct
import zlib

HDR = '<HHI'
T_COMMENT, T_DATA, T_FILE_HEADER, T_DIRECT_WRITE = 1, 2, 6, 7
SIGNATURE = 0x36323130


def rec(ty, body):
    # wil_fw_process отвергает запись, размер которой не кратен 4
    if ty != T_DATA and len(body) & 3:
        raise SystemExit('запись типа %d: размер %d не кратен 4' % (ty, len(body)))
    pad = (-len(body)) & 3
    return struct.pack(HDR, ty, 0, len(body)) + body + b'\0' * pad


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--rec', action='append', default=[], metavar='СПЕЦ',
                    help='запись образа в порядке следования: data:АДРЕС=файл, '
                         'dw:файл, comment:hex')
    ap.add_argument('--version', required=True, help='например 6.2.0.1000')
    ap.add_argument('--author', help='автор образа: запись-комментарий «Author: …» '
                    'сразу за заголовком (драйвер неизвестные комментарии пропускает)')
    ap.add_argument('--out', required=True)
    ap.add_argument('--verify-against', help='эталонный образ для побайтовой сверки')
    a = ap.parse_args()

    body = b''
    if a.author:
        # драйвер требует размер записи, кратный 4, — дополнить нулями
        text = ('Author: ' + a.author).encode() + b'\0'
        body += rec(T_COMMENT, text + b'\0' * ((-len(text)) & 3))
    for spec in a.rec:
        kind, _, arg = spec.partition(':')
        if kind == 'data':
            ad, _, path = arg.partition('=')
            body += rec(T_DATA, struct.pack('<I', int(ad, 16)) + open(path, 'rb').read())
        elif kind == 'dw':
            body += rec(T_DIRECT_WRITE, open(arg, 'rb').read())
        elif kind == 'comment':
            body += rec(T_COMMENT, bytes.fromhex(arg))
        else:
            raise SystemExit('неизвестный вид записи: %s' % spec)

    comment = ('FW version: ' + a.version).encode()
    if len(comment) > 32:
        raise SystemExit('строка версии длиннее 32 байт: %r' % comment)
    comment += b'\0' * (32 - len(comment))
    total = 8 + 52 + len(body)
    fh = struct.pack('<IIIII', SIGNATURE, 0, 0, 1, total) + comment
    img = bytearray(rec(T_FILE_HEADER, fh) + body)
    crc = zlib.crc32(bytes(img))
    struct.pack_into('<I', img, 16, crc)
    open(a.out, 'wb').write(bytes(img))
    print('%s: %d байт, CRC 0x%08x' % (a.out, len(img), crc))

    if a.verify_against:
        ref = open(a.verify_against, 'rb').read()
        if bytes(img) == ref:
            print('ПОБАЙТОВОЕ СОВПАДЕНИЕ с %s' % a.verify_against)
        else:
            n = sum(1 for x, y in zip(img, ref) if x != y)
            print('расхождение с %s: длина %d против %d, различных байт %d'
                  % (a.verify_against, len(img), len(ref), n))
            raise SystemExit(1)


if __name__ == '__main__':
    main()
