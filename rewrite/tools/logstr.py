# SPDX-License-Identifier: AGPL-3.0-or-later
"""Свои строки журнала SparRAW (include/logstr.h): таблица из include/logstr_{fw,uc}.def и запись в образе.

Таблица — строки .def подряд, каждая с \\0, в порядке записей: смещение строки = offsetof в struct
logstr_fw/uc (char[sizeof строки] без выравнивания), токен = база + смещение. В образе — запись-комментарий
(тип 1): u32 магия, u32 база (смещение таблицы в общей таблице строк), строки.
"""
import os, re, struct

HERE = os.path.dirname(os.path.abspath(__file__))
INC = os.path.join(HERE, '..', 'include')
BASE = {'fw': 0x30000, 'uc': 0x10000}                 # LOGSTR_BASE_FW/_UC − 0x1000000
MAGIC = {'fw': 0x57464c53, 'uc': 0x43554c53}           # LOGSTR_MAGIC_FW/_UC
_X = re.compile(r'^X\((\w+),\s*"((?:[^"\\]|\\.)*)"\)\s*$', re.M)


def parse_def(text):
    """[(имя, байты строки)] из .def."""
    out = []
    for name, lit in _X.findall(text):
        out.append((name, lit.encode('latin1').decode('unicode_escape').encode('latin1')))
    return out


def table(which, inc=INC):
    """(база, байты таблицы) из include/logstr_<which>.def."""
    items = parse_def(open(os.path.join(inc, 'logstr_%s.def' % which)).read())
    return BASE[which], b''.join(s + b'\0' for _, s in items)


def record(which, inc=INC):
    """Полезная нагрузка записи-комментария для образа."""
    base, tab = table(which, inc)
    return struct.pack('<II', MAGIC[which], base) + tab


def from_image(blob, which):
    """(база, таблица) из записи образа .fw или None."""
    off = 0
    while off + 8 <= len(blob):
        typ, _flags, size = struct.unpack_from('<HHI', blob, off)
        p = blob[off + 8:off + 8 + size]
        if typ == 1 and len(p) >= 8 and struct.unpack_from('<I', p, 0)[0] == MAGIC[which]:
            return struct.unpack_from('<I', p, 4)[0], p[8:].rstrip(b'\0') + b'\0'
        off += 8 + size
    return None


def merged(vendor_tab, which, image=None, inc=INC):
    """Таблица vendor + своя по базе (из образа, если дан, иначе из .def)."""
    t = from_image(open(image, 'rb').read(), which) if image else None
    base, tab = t if t else table(which, inc)
    if len(vendor_tab) > base:
        raise SystemExit('logstr: таблица vendor (%d Б) заходит за базу 0x%x' % (len(vendor_tab), base))
    return vendor_tab + b'\0' * (base - len(vendor_tab)) + tab
