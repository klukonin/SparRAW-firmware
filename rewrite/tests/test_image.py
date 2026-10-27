# SPDX-License-Identifier: AGPL-3.0-or-later
"""Статическая проверка образа .fw (без железа): то, на что драйвер или загрузчик молча отреагируют сбоем."""
import re, struct, zlib
import pytest

import stand as standlib
import logstr

pytestmark = pytest.mark.image

FW_MAGIC = 0x36323130                 # "0621", tools/build_fw.py
HEAD = 8                              # заголовок записи: u16 type, u16 flags, u32 size
TYPE_COMMENT, TYPE_DATA, TYPE_FILE_HEADER, TYPE_DIRECT_WRITE = 1, 2, 6, 7

# Куда можно писать данными записи типа 2 (хост-адреса, include/hw.h; fw_inc.c драйвера проверяет по своей карте).
REGIONS = [
    ('fw_code', 0x8c0000, 0x900000),
    ('fw_data', 0x900000, 0x908000),
    ('uc_code', 0x920000, 0x940000),
    ('uc_data', 0x940000, 0x948000),
    ('board/AGC', 0x88a000, 0x88b000),
]


def test_records_cover_file(fw_blob):
    off = 0
    while off < len(fw_blob):
        assert off + HEAD <= len(fw_blob), 'обрезанный заголовок записи на 0x%x' % off
        typ, _, size = struct.unpack_from('<HHI', fw_blob, off)
        assert size % 4 == 0, 'запись типа %d на 0x%x: размер %d не кратен 4' % (typ, off, size)
        assert off + HEAD + size <= len(fw_blob), 'запись типа %d на 0x%x выходит за файл' % (typ, off)
        off += HEAD + size
    assert off == len(fw_blob)


def test_file_header_crc_and_length(fw_blob):
    typ, _, size = struct.unpack_from('<HHI', fw_blob, 0)
    assert typ == TYPE_FILE_HEADER, 'первая запись — не файловый заголовок (тип %d)' % typ
    magic, _ver, crc, _x, data_len = struct.unpack_from('<IIIII', fw_blob, HEAD)
    assert magic == FW_MAGIC, 'магия заголовка 0x%08x' % magic
    assert data_len == len(fw_blob), 'data_len %d, файл %d — драйвер отвергнет образ' % (data_len, len(fw_blob))
    patched = bytearray(fw_blob)
    struct.pack_into('<I', patched, HEAD + 8, 0)
    assert zlib.crc32(bytes(patched)) & 0xffffffff == crc, 'CRC не совпадает — драйвер: checksum mismatch'


def test_version_string(fw_blob):
    v = standlib.fw_version(fw_blob)
    assert v, 'нет строки версии в заголовке'
    assert len(v) <= 19, 'версия длиннее 19 символов: %r' % v
    assert re.fullmatch(r'\d+\.\d+\.\d+\.\d+-SparRAW(-PRO)?', v), 'версия не в формате SparRAW: %r' % v


def test_marking_record(fw_blob):
    """Метка проекта и автора — запись-комментарий (include/version.h FW_ID_STRING)."""
    marks = [p for t, _, p in standlib.fw_records(fw_blob) if t == TYPE_COMMENT and b'Evil Wireless Man' in p]
    assert marks, 'нет записи-метки SparRAW'
    pro = standlib.fw_is_pro(fw_blob)
    assert (b'SparRAW PRO firmware' in marks[0]) == pro, marks[0][:80]


def test_data_records_in_known_regions(fw_blob):
    seen = {}
    for t, _, p in standlib.fw_records(fw_blob):
        if t != TYPE_DATA:
            continue
        addr = struct.unpack_from('<I', p, 0)[0]
        end = addr + len(p) - 4
        reg = [n for n, a, b in REGIONS if a <= addr and end <= b]
        assert reg, 'запись данных 0x%x..0x%x вне известных областей' % (addr, end)
        seen[reg[0]] = seen.get(reg[0], 0) + 1
    for need in ('fw_code', 'fw_data', 'uc_code', 'uc_data'):
        assert need in seen, 'нет сегмента %s' % need


def test_no_overlapping_data(fw_blob):
    spans = []
    for t, _, p in standlib.fw_records(fw_blob):
        if t == TYPE_DATA:
            a = struct.unpack_from('<I', p, 0)[0]
            spans.append((a, a + len(p) - 4))
    spans.sort()
    for (a0, e0), (a1, e1) in zip(spans, spans[1:]):
        assert e0 <= a1, 'сегменты 0x%x..0x%x и 0x%x..0x%x перекрываются' % (a0, e0, a1, e1)


@pytest.mark.parametrize('which', ['fw', 'uc'])
def test_log_strings_table(fw_blob, which):
    """Таблица своих строк журнала (include/logstr.h): есть, база по месту, строки целые и в пределах 64 КБ."""
    t = logstr.from_image(fw_blob, which)
    assert t, 'нет записи строк журнала %s' % which
    base, tab = t
    assert base == logstr.BASE[which]
    assert len(tab) <= 0x10000
    strs = tab.split(b'\0')[:-1]
    assert strs, 'таблица строк %s пуста' % which
    for s in strs:
        assert s and all(32 <= c < 127 for c in s), 'строка журнала с непечатными байтами: %r' % s[:60]
        assert s.count(b'%') - 2 * s.count(b'%%') <= 3, 'больше 3 аргументов: %r' % s
