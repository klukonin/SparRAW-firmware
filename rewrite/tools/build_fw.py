#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Собрать .fw образ из нашей перереализации + вендорских сегментов данных.

Мы переписываем КОД (fw_code). Всё, что данные/калибровка (fw_data наполняем
сами, uc_code/uc_data пока копируем у вендора, AGC-таблицы — вендорские),
берём из эталонного образа.

Раскладка (хост-адреса в .fw):
  fw_code 0x8c0000  (наш ELF, секция .text)
  fw_data 0x900000  (наш ELF, секции .data/.bss — ARC видит их по 0x800000)
  uc_code 0x920000  (вендор, до портирования uc)
  uc_data 0x940000  (вендор)
  + прочие сегменты вендора (AGC_tbl и т.п.)
"""
import argparse, os, re, struct, subprocess, sys, zlib

import logstr

HEAD = struct.Struct('<HHI')
FILE_HEADER = struct.Struct('<IIIII32s')
FW_MAGIC = 0x36323130  # "0621"

# Сегменты, которые копируем у вендора как есть (пока не портированы).
KEEP_VENDOR_REGIONS = {
    'uc_code': 0x920000,
    'uc_data': 0x940000,
    # board data (AGC и пр.) — диапазоны 0x88a000..0x88afff
}


def parse_fw(blob):
    recs, off = [], 0
    while off + HEAD.size <= len(blob):
        typ, flags, size = HEAD.unpack_from(blob, off)
        payload = blob[off + HEAD.size: off + HEAD.size + size]
        if len(payload) != size:
            break
        recs.append((typ, flags, payload))
        off += HEAD.size + size
    return recs


def extract_elf(elf, section, out):
    subprocess.run(['arc-elf32-objcopy', '-O', 'binary',
                    '--only-section=%s' % section, elf, out], check=True)


# Указатели на код в vendor uc_data (DCCM 0x800000 = uc_data 0x940000): таблица автомата BI
# (uc_sm_handle_event) — 20 записей по 5 байт с 0x8015dc: 4 Б 0-базового адреса обработчика
# + 1 Б следующего состояния. В нашем образе — адреса наших функций.
SM_TABLES = [(0x8015dc, 20, 5)]

# Одиночные указатели на код в uc_data: адрес слова -> (vendor-цель, наша функция).
#  - init-дескрипторы (+4), обходятся timer_list_init;
#  - дескриптор очереди команд 0x800730 (+4), вызывается uc_queue_dispatch_and_commit;
#  - слоты колбэков bf_req_enqueue (0x800fec, 0x8013f4/f8), вызываются bf_sm_process_request_fifo.
UC_DATA_PTRS = {
    0x8007cc: (0x92097c, 'uc_init_cb_globals'),
    0x800fe4: (0x920968, 'uc_init_cb_copy_8006b7'),
    0x8013ec: (0x9209a4, 'uc_init_cb_cmdq'),
    0x801644: (0x920994, 'uc_init_cb_801aec'),
    0x8016e4: (0x920988, 'uc_init_cb_more'),
    0x800734: (0x92d880, 'ucode_cmdq_handler'),
    0x800fec: (0x92df38, 'notify_aoa_build'),
    0x8013f4: (0x92dec4, 'notify_aoa_event'),
    0x8013f8: (0x92dec4, 'notify_aoa_event'),
}


def relocate_uc_data(payload, uc_elf, objcopy):
    import importlib.util, os
    here = os.path.dirname(os.path.abspath(__file__))
    spec = importlib.util.spec_from_file_location('uh', os.path.join(here, 'uc_hybrid.py'))
    uh = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(uh)
    v2c = {}
    for n, (vb, f) in uh.c_map().items():
        if vb:
            v2c.setdefault(vb['addr'], []).append(n)
    nm = objcopy.replace('objcopy', 'nm')
    syms = {}
    for l in subprocess.run([nm, uc_elf], capture_output=True, text=True).stdout.splitlines():
        p = l.split()
        if len(p) == 3 and p[1] in 'Tt':
            syms[p[2]] = int(p[0], 16)
    b = bytearray(payload)
    n_ok = 0
    for base, cnt, stride in SM_TABLES:
        for k in range(cnt):
            off = 4 + (base - 0x800000) + k * stride
            v = struct.unpack_from('<I', b, off)[0]
            va = v + 0x920000 if v < 0x20000 else v
            ours = next((syms[n] for n in v2c.get(va, []) if n in syms), None)
            if ours is None:
                raise SystemExit('uc_data: нет нашей функции для vendor 0x%x (таблица 0x%x[%d])' % (va, base, k))
            struct.pack_into('<I', b, off, ours)
            n_ok += 1
    for addr, (vt, name) in UC_DATA_PTRS.items():
        off = 4 + addr - 0x800000
        v = struct.unpack_from('<I', b, off)[0]
        if v + 0x920000 != vt:
            raise SystemExit('uc_data 0x%x: ожидали vendor 0x%x, там 0x%x' % (addr, vt, v))
        if name not in syms:
            raise SystemExit('uc_data 0x%x: нет символа %s в uc.elf' % (addr, name))
        struct.pack_into('<I', b, off, syms[name])
        n_ok += 1
    print('uc_data: перенесено указателей на код: %d' % n_ok)
    return bytes(b)


# Начальный образ DCCM uc из нашего uc.elf: секции .ucdata.<адрес> (uc/data.c), рантайм-адреса
# 0x800000..; в .fw — запись по 0x940000. Длина — не меньше UC_DATA_MIN_END (как у vendor 6.2:
# нули до 0x801be8 — тоже начальные значения).
UC_DATA_MIN_END = 0x801be8


# fw: то же для fw/fw_data.c (.fwdata.<адрес>); длина — как у vendor fw_data (0x80691c).
FW_DATA_MIN_END = 0x80691c


def uc_data_from_elf(uc_elf, objcopy, prefix='.ucdata.', min_end=UC_DATA_MIN_END, what='uc_data'):
    import os, tempfile
    od = objcopy.replace('objcopy', 'objdump')
    secs = []
    for l in subprocess.run([od, '-h', uc_elf], capture_output=True, text=True).stdout.splitlines():
        p = l.split()
        if len(p) >= 4 and p[1].startswith(prefix):
            secs.append((p[1], int(p[3], 16), int(p[2], 16)))
    if not secs:
        return None
    end = max([min_end] + [v + n for _, v, n in secs])
    img = bytearray(end - 0x800000)
    tmp = tempfile.mkdtemp()
    for name, vma, size in secs:
        if not (0x800000 <= vma and vma + size <= 0x808000):
            raise SystemExit('%s: секция %s вне DCCM: 0x%x' % (what, name, vma))
        out = os.path.join(tmp, 'sec.bin')
        subprocess.run([objcopy, '-O', 'binary', '--only-section=' + name, uc_elf, out], check=True)
        b = open(out, 'rb').read()
        assert len(b) == size, (name, len(b), size)
        img[vma - 0x800000:vma - 0x800000 + size] = b
    img += b'\0' * (-len(img) % 4)
    print('%s: наш образ, %d объектов, %d Б' % (what, len(secs), len(img)))
    return bytes(img)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--elf', default=None, help='наш fw.elf (без него — fw_code/fw_data vendor)')
    ap.add_argument('--uc-elf', default=None, help='наш uc.elf (код uc)')
    ap.add_argument('--vendor', required=True, help='эталонный .fw (данные/uc)')
    ap.add_argument('--out', required=True)
    ap.add_argument('--version', default=None, help='строка версии (по умолчанию FW_VERSION_STRING из include/version.h)')
    ap.add_argument('--objcopy', default='arc-elf32-objcopy')
    ap.add_argument('--compare-uc-data', action='store_true', help='сверить наш uc_data с vendor+подменой указателей')
    ap.add_argument('--compare-fw-data', action='store_true', help='сверить наш fw_data (fw/fw_data.c) с vendor+fw_ptrmap')
    ap.add_argument('--no-late', action='store_true', help='не добавлять .textlate из --elf')
    ap.add_argument('--no-uc', action='store_true', help='не заменять vendor uc_code даже при --uc-elf')
    ap.add_argument('--iccm-guard', nargs='?', const='entry', default=None, choices=['entry', 'caller'],
                    help='отладка: неписаную ICCM за кодом fw заполнить ловушкой (tools/iccm_guard)')
    ap.add_argument('--no-fw-reloc', action='store_true',
                    help='не подменять указатели на vendor-код в vendor fw_data (tools/fw_ptrmap.py)')
    ap.add_argument('--keep-vendor-code', action='store_true',
                    help='эксперимент: оставить vendor fw_code (0x8c0000), наш .text не класть')
    a = ap.parse_args()
    vh = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'include', 'version.h')).read()
    if a.version is None:
        a.version = re.search(r'#define FW_VERSION_STRING "([^"]+)"', vh).group(1)
    fw_id = (re.search(r'#define FW_ID_STRING "([^"]+)"', vh).group(1) % a.version.split('-SparRAW')[0]).encode() + b'\0'

    vend = parse_fw(open(a.vendor, 'rb').read())

    # 1) Наш код и данные из ELF.
    import tempfile
    tmp = tempfile.mkdtemp()
    code = os.path.join(tmp, 'code.bin')
    data = os.path.join(tmp, 'data.bin')
    if a.elf:
        subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.text', a.elf, code], check=True)
        try:
            subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.data', a.elf, data], check=True)
        except subprocess.CalledProcessError:
            open(data, 'wb').write(b'')  # .data может отсутствовать
        code_b = open(code, 'rb').read()
        data_b = open(data, 'rb').read()
        if data_b:
            raise SystemExit('fw.elf: непустой .data — начальный образ DCCM только в fw/fw_data.c')
        data_b = uc_data_from_elf(a.elf, a.objcopy, '.fwdata.', FW_DATA_MIN_END, 'fw_data') or b''
    else:
        code_b = data_b = b''
    # .textlate (функции fw с -ffunction-sections, fw.ld: после 0x8c6400) — по адресу секции.
    late_b, late_addr = b'', None
    if a.elf and not a.no_late:
        out = subprocess.run([a.objcopy.replace('objcopy', 'objdump'), '-h', a.elf],
                             capture_output=True, text=True, check=True).stdout
        for l in out.splitlines():
            f = l.split()
            if len(f) > 4 and f[1] == '.textlate':
                late_addr = int(f[3], 16)
        if late_addr is not None:
            late = os.path.join(tmp, 'late.bin')
            subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.textlate', a.elf, late], check=True)
            late_b = open(late, 'rb').read()
    if a.keep_vendor_code:
        code_b = late_b = data_b = b''

    # 2) Собираем записи: наш код/данные + (опц.) наш uc_code + вендорское.
    records = []
    # файловый заголовок (заполним позже)
    records.append(dict(type=6, flags=0, payload=FILE_HEADER.pack(FW_MAGIC, 0, 0, 1, 0, b'')))
    records.append(dict(type=1, flags=0, payload=fw_id))      # метка: проект, автор, ссылка (include/version.h)
    if a.elf:   # свои строки журнала (include/logstr.h): декодер берёт их из образа
        records.append(dict(type=1, flags=0, payload=logstr.record('fw')))
    if a.uc_elf and not a.no_uc:
        records.append(dict(type=1, flags=0, payload=logstr.record('uc')))
    if code_b:
        records.append(dict(type=2, flags=0, payload=struct.pack('<I', 0x8c0000) + code_b))
    if late_b:
        records.append(dict(type=2, flags=0, payload=struct.pack('<I', late_addr) + late_b))
    if a.iccm_guard and late_b:
        gstart = (late_addr + len(late_b) + 0x3ff) & ~0x3ff
        here = os.path.dirname(os.path.abspath(__file__))
        gs, go, ge, gb = [os.path.join(tmp, n) for n in ('g.S', 'g.o', 'g.elf', 'g.bin')]
        subprocess.run([sys.executable, os.path.join(here, 'iccm_guard', 'gen.py'),
                        hex(gstart), '0x900000', gs, a.iccm_guard], check=True)
        tc = a.objcopy.replace('objcopy', '')
        subprocess.run([tc + 'as', '-mcpu=arc600', gs, '-o', go], check=True)
        subprocess.run([tc + 'ld', '--section-start=.guard=0x%x' % gstart, go, '-o', ge], check=True)
        subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.guard', ge, gb], check=True)
        records.append(dict(type=2, flags=0, payload=struct.pack('<I', gstart) + open(gb, 'rb').read()))
        print('iccm-guard: 0x%x..0x900000' % gstart)
    # fw_data: если наш ELF ещё без .data — берём вендорский (там начальные
    # значения глобалов: MAC, конфиг и т.п.). Пустую запись драйвер отвергает.
    if data_b:
        records.append(dict(type=2, flags=0, payload=struct.pack('<I', 0x900000) + data_b))

    # Наш uc_code (если передан uc.elf).
    uc_code_b = None
    if a.uc_elf and not a.no_uc:
        uc_code = os.path.join(tmp, 'uc_code.bin')
        # .vectors (0x920000) + .text (0x920100..): двоичный образ с 0x920000
        subprocess.run([a.objcopy, '-O', 'binary', '--only-section=.vectors', '--only-section=.text',
                        a.uc_elf, uc_code], check=True)
        uc_code_b = open(uc_code, 'rb').read()
        if uc_code_b:
            records.append(dict(type=2, flags=0,
                                payload=struct.pack('<I', 0x920000) + uc_code_b))

    # Вендорские сегменты, которые не трогаем (fw_data при его отсутствии,
    # uc_data + board data; uc_code — только если у нас его нет).
    kept = []
    caps = []
    for typ, flags, payload in vend:
        if typ == 7:   # direct_write: драйвер применяет до старта ARC (такты CAR, сбросы) — как в vendor-образе
            records.append(dict(type=7, flags=flags, payload=payload))
            continue
        if typ == 1:   # comment: capabilities fw (маркер 0xabcddcba) — как в vendor-образе
            caps.append(dict(type=1, flags=flags, payload=payload))
            continue
        if typ != 2 or len(payload) < 4:
            continue
        addr = struct.unpack_from('<I', payload, 0)[0]
        if addr == 0x900000 and data_b and a.compare_fw_data:
            import fw_ptrmap
            ref = fw_ptrmap.relocate_fw_data(payload, a.elf, a.objcopy.replace('objcopy', 'nm'))[4:]
            n = max(len(ref), len(data_b))
            diff = [i for i in range(n) if (ref[i] if i < len(ref) else 0) != (data_b[i] if i < len(data_b) else 0)]
            print('fw_data: отличий от vendor+fw_ptrmap: %d Б%s' % (len(diff), (' (первые: %s)' % [hex(0x800000 + i) for i in diff[:8]]) if diff else ''))
        if (uc_code_b and 0x920000 <= addr < 0x940000):
            continue  # наш uc_code заменяет вендорский
        if addr >= 0x920000 or (0x88a000 <= addr < 0x88b000) or \
           (0x900000 <= addr < 0x920000 and not data_b) or (not code_b and addr < 0x920000):
            if addr == 0x900000 and code_b and not a.no_fw_reloc:
                import fw_ptrmap
                payload = fw_ptrmap.relocate_fw_data(payload, a.elf, a.objcopy.replace('objcopy', 'nm'),
                                                     report=a.out + '.ptrmap.txt')
            if uc_code_b and addr == 0x940000:
                ours = uc_data_from_elf(a.uc_elf, a.objcopy)
                if ours is None:
                    payload = relocate_uc_data(payload, a.uc_elf, a.objcopy)
                else:
                    if a.compare_uc_data:
                        ref = relocate_uc_data(payload, a.uc_elf, a.objcopy)[4:]
                        n = max(len(ref), len(ours))
                        diff = [i for i in range(n) if (ref[i] if i < len(ref) else 0) != (ours[i] if i < len(ours) else 0)]
                        print('uc_data: отличий от vendor+указатели: %d Б%s' % (len(diff), (' (первые: %s)' % [hex(0x800000 + i) for i in diff[:8]]) if diff else ''))
                    payload = struct.pack('<I', 0x940000) + ours
            records.append(dict(type=2, flags=flags, payload=payload))
            kept.append(addr)
    # Запись capabilities драйвер (fw_inc.c fw_handle_capabilities) читает вместо WMI: маску
    # берём из нашего fw_caps_list (fw/wmi_h_sta.c), чтобы драйвер видел то же, что сообщает
    # прошивка (в открытой версии снят бит FTM). Формат: u32 0xabcddcba, затем битовая маска.
    if a.elf and data_b and caps:
        nm = subprocess.run([a.objcopy.replace('objcopy', 'nm'), a.elf], capture_output=True,
                            text=True, check=True).stdout
        sym = [l.split() for l in nm.splitlines() if l.endswith(' fw_caps_list')]
        if sym:
            off = int(sym[0][0], 16) - 0x800000
            for c in caps:
                p = bytearray(c['payload'])
                if struct.unpack_from('<I', p, 0)[0] == 0xabcddcba and len(p) >= 8:
                    p[4:8] = data_b[off:off + 4]
                    c['payload'] = bytes(p)
                    print('capabilities: 0x%08x (fw_caps_list)' % struct.unpack_from('<I', p, 4)[0])
    records += caps   # vendor кладёт запись capabilities последней
    print('скопированы вендорские сегменты: %s' % [hex(x) for x in kept])

    # 3) Файловый заголовок: comment = "FW version: <версия>".
    comment = ('FW version: %s' % a.version).encode()
    if len(comment) > 31:
        sys.exit('версия длиннее 19 символов: %r' % a.version)
    comment += b'\0' * (32 - len(comment))

    body = bytearray()
    for r in records:
        if r['type'] == 6:
            r['payload'] = FILE_HEADER.pack(FW_MAGIC, 0, 0, 1, 0, comment)
        p = r['payload']
        if len(p) % 4:
            p += b'\0' * (4 - len(p) % 4)
        body += HEAD.pack(r['type'], r['flags'], len(p))
        body += p

    data_len = len(body)
    struct.pack_into('<I', body, HEAD.size + 16, data_len)
    # CRC: с обнулённым полем crc
    patched = bytearray(body)
    struct.pack_into('<I', patched, HEAD.size + 8, 0)
    crc = zlib.crc32(bytes(patched)) & 0xffffffff
    struct.pack_into('<I', body, HEAD.size + 8, crc)

    open(a.out, 'wb').write(bytes(body))
    print('собран %s: %d Б (код %d Б, данные %d Б, uc %d Б), crc 0x%08x'
          % (a.out, len(body), len(code_b), len(data_b),
             len(uc_code_b) if uc_code_b else 0, crc))


if __name__ == '__main__':
    sys.exit(main())
