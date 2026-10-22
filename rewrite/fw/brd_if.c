// SPDX-License-Identifier: AGPL-3.0-or-later
/* Интерфейс board-файла: brd_if_multi_array (vtable 0x8005e4, база 0x8005c4) и разбор
 * board-файла объектом marlon_r_if_class (0x8042c8) — init_board_file_interface
 * (0x8f5700), секция параметров (0x8dc690), секции RF-конфигурации (0x8dc830),
 * список TX-секторов (0x8ddbbc).
 *
 * Board-файл (0x84f800, 0x2400 Б): +0 магия 0xbdf0bdf0, +4 версия формата 0x20000000,
 * +8 таблица 10 × {смещение, размер/8} (смещения — от board+8). Секция по смещению off:
 *   +0      метка физической секции (сверяется с парой из таблицы 0x8022c0)
 *   +8      заголовок: б0..7 rf_vector (маска RF-модулей), б8..19 длина блока в словах,
 *           б20..23 физический тип, б24..25 формат данных (0 — пары адрес/данные,
 *           1 — только данные), б26..31 маска секторов
 *   +0xc    rf_base_address (база адресов для формата «только данные»)
 *   +0x10   блоки данных (по блоку на RF-модуль из rf_vector, либо один при rf_vector 0)
 *
 * Объект brd_if_multi_array — struct brd_if (include/brd_if.h), вложен в rf_obj (+4);
 * описатели секции/блока, окна сверки адресов — там же. Таблицы методов — brd_if_base_vtbl
 * (0x8005c4) и brd_if_vtbl (0x8005e4) ниже; статические конструкторы — ctors.c. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/brd_if.h"
#include "../include/fwdata.h"
#include "../include/rf_sets.h"

/* Таблицы наборов RF — struct fwsh_sets (0x857730) и rf_set_ranges (0x84783c),
 * include/rf_sets.h. */
#define CALLER ((void *)__builtin_return_address(0))

/* Слово board-файла по смещению off от board+8 (смещения секций и таблицы — от него). */
static inline const u32 *brd_at(const struct brd_if *o, u32 off)
{
    return (const u32 *)(o->data + 8 + off);
}

/* n-й (с 0) младший взведённый бит маски — значением бита (vendor: n раз m &= m-1 в
 * цикле lp, затем m & ~(m-1); 0x8ddc2e, 0x8e3024, 0x8f5866). */
static u32 brd_nth_low_bit(u32 m, u32 n)
{
    while (n--)
        m &= m - 1;
    return (m & ~(m - 1)) & 0xff;
}

/* Число взведённых битов (vendor: v &= v-1 со счётчиком, 0x8f57de и др.). */
static u32 brd_popcount(u32 v)
{
    u32 n = 0;
    while (v) {
        v &= v - 1;
        n++;
    }
    return n;
}

/* ===================== Описатели и мелкие помощники ===================== */

/* brd_section_info__reset (0x8c67a4; переход 0x8c18d0): описатель секции —
 * [0] = -1, [4]/[8]/[0xc] = 0, байт +0x14 = 0 (+0x10 и +0x15 не трогает). */
void brd_section_info_reset(struct brd_section_info *info)
{
    info->id = 0xffffffffu;
    info->num_blocks = 0;
    info->off = 0;
    info->size = 0;
    info->rf_vector = 0;
}

/* brd_if__clear_block_info (0x8c6790; переход 0x8c18cc): описатель блока —
 * [0] = [4] = -1, [8..0x14] = 0. */
void brd_if_clear_block_info(struct brd_block_info *blk)
{
    blk->id = 0xffffffffu;
    blk->blk_idx = 0xffffffffu;
    blk->chip = 0;
    blk->num_entries = 0;
    blk->off = 0;
    blk->len = 0;
}

/* brd_if__noop_hook_a/b/c (0x8ebd0c/0x8ebd10/0x8ebd14): пустые (j_s [blink]) — точки
 * отладочной печати заголовка секции / описателя блока / описателя секции. */
static void brd_if_hook_section_header(const u32 *hdr) { (void)hdr; }
static void brd_if_hook_block_info(const struct brd_block_info *blk) { (void)blk; }
static void brd_if_hook_section_info(const struct brd_section_info *info) { (void)info; }

/* brd_if_multi_array::physical_section_header_u (0x8e0f4c): журнал заголовка секции. */
static void brd_if_log_section_header(const u32 *hdr, u32 lvl)
{
    u32 h;

    fw_log_emit2(lvl << 4, 0x100a85c, hdr[0], hdr[1]);
    h = hdr[0];
    fw_log_emit3(lvl << 4, 0x100a8b8, *(const u8 *)hdr, (h >> 8) & 0xfff, (h >> 20) & 0xf);
    h = hdr[0];
    fw_log_emit3(lvl << 4, 0x100a900, (h >> 24) & 3, h >> 26, hdr[1]);
}

/* brd_if::block_info (0x8e0fa0): журнал описателя блока. */
static void brd_if_log_block_info(const struct brd_block_info *blk, u32 lvl)
{
    fw_log_emit3(lvl << 4, 0x100b360, blk->id, blk->blk_idx, blk->chip);
    fw_log_emit3(lvl << 4, 0x100b3ac, blk->off, blk->len, blk->num_entries);
}

/* brd_if::section_info (0x8e0fd8): журнал описателя секции. */
static void brd_if_log_section_info(const struct brd_section_info *info, u32 lvl)
{
    fw_log_emit2(lvl << 4, 0x100b2f4, info->id, info->num_blocks);
    fw_log_emit2(lvl << 4, 0x100b338, info->off, info->size);
}

/* bit_length (0x8c7cd4): число взведённых битов (32 шага lp; аргумент в r1). */
static u32 brd_bit_length(u32 v)
{
    u32 n = 0, i;

    for (i = 0; i < 32; i++)
        if (v & (1u << i))
            n++;
    return n;
}

/* brd_multi_array__elem_bits (0x8cbae4): число блоков секции — 1 для секции 0,
 * иначе bit_length(rf_vector), а при rf_vector 0 — 8. */
static u32 brd_multi_array_elem_bits(u32 id, u32 rf_vector)
{
    if (id == 0)
        return 1;
    if (rf_vector != 0)
        return brd_bit_length(rf_vector);
    return 8;
}

/* bitmap__nth_set_bit (0x8cbac4): номер n-го (с 0) взведённого бита 8-битной маски;
 * n при пустой маске, 8 — если битов не хватило. */
static u32 brd_bitmap_nth_set_bit(u32 n, u32 bitmap)
{
    u32 cnt = 0, i;

    if (bitmap == 0)
        return n;
    for (i = 0; i < 8; i++) {
        if (!(bitmap & (1u << i)))
            continue;
        if (cnt == n)
            break;
        cnt++;
    }
    return i;
}

/* edmg__channel_matches_mode (0x8c6430): номер секции ↔ физический тип: тип 0 —
 * секции 2/4/6/8, 1 — 3/5/7/9, 2 — 1, 3 — 0, прочие типы подходят любой секции. */
static u32 brd_section_matches_type(u32 id, u32 type)
{
    if (type == 0 && id != 2 && id != 4 && id != 6 && id != 8)
        return 0;
    if (type == 1 && id != 3 && id != 5 && id != 7 && id != 9)
        return 0;
    if (type == 2 && id != 1)
        return 0;
    if (type == 3 && id != 0)
        return 0;
    return 1;
}

/* brd_if__check_section_header (0x8ebdc4): физический тип < 4, формат < 2, маска
 * секторов не пуста; иначе — журнал заголовка и 0. */
static u32 brd_if_check_section_header(const u32 *hdr)
{
    u32 h = hdr[0];
    u32 ok = ((h >> 20) & 0xf) < 4 && ((h >> 24) & 3) < 2 && (h & 0xfc000000u) != 0;

    if (!ok)
        brd_if_log_section_header(hdr, 0);
    return ok;
}

/* ===================== Поиск секции ===================== */

/* brd_if_multi_array (0x8c630c): проверка физической секции id по смещению off,
 * размер size: метка — одна из pat[0..1], секция в пределах board-файла (иначе ассерт
 * 0x1366 — vendor после него продолжает), заголовок валиден, тип подходит номеру. */
static u32 brd_if_multi_array_check_section(const struct brd_if *o, u32 id, u32 off, u32 size,
                                            const u32 *pat)
{
    const u32 *sec;
    u32 tag, type;

    if (id >= 0xa) {
        fw_log_emit2(0, 0x100a940, id, 0xa);
        return 0;
    }
    sec = brd_at(o, off);
    tag = sec[0];
    if (tag != pat[0] && tag != pat[1]) {
        fw_log_emit3(0, 0x100a9a0, tag, pat[0], pat[1]);
        return 0;
    }
    if (o->size - 8 < size + off) {
        fw_log_emit1(0, 0x100aa14, id);
        fw_log_emit3(0, 0x100aa88, o->size - 8, off, size);
        fw_log_emit3(0, 0x100aafc, tag, pat[0], pat[1]);
        brd_if_log_section_header(sec + 2, 0);
        fw_sysassert_fatal(CALLER, 0x1366);
    }
    if (brd_if_check_section_header(sec + 2) == 0) {
        fw_log_emit0(0, 0x100ab68);
        return 0;
    }
    type = (sec[2] >> 20) & 0xf;
    if (brd_section_matches_type(id, type) == 0) {
        fw_log_emit2(0, 0x100abac, type, id);
        return 0;
    }
    return 1;
}

/* brd_if_multi_array::find_section (0x8caab8): по brd_section_map (0x8022c0, 12 Б на секцию:
 * номер записи в таблице board-файла, две допустимые метки) заполняет описатель.
 * Метки {-1, -1} — секции нет в формате: описатель пуст (0 блоков), успех. */
static u32 brd_if_multi_array_find_section(const struct brd_if *o, u32 id,
                                           struct brd_section_info *info)
{
    const struct brd_section_map *t = &brd_section_map[id];
    u32 pat[2] = { t->tag[0], t->tag[1] };
    const u32 *ent, *hdr;
    u32 off, size;

    if (pat[0] == 0xffffffffu && pat[1] == 0xffffffffu) {
        brd_section_info_reset(info);
        info->id = id;
        return 1;
    }
    ent = brd_at(o, t->entry * 8);
    off = ent[0];
    size = ent[1] << 3;
    if (brd_if_multi_array_check_section(o, id, off, size, pat) == 0) {
        fw_log_emit3(0, 0x100ac10, id, off, size);
        return 0;
    }
    info->id = id;
    info->off = off;
    info->size = size;
    hdr = brd_at(o, off + 8);
    info->num_blocks = brd_multi_array_elem_bits(id, *(const u8 *)hdr);
    info->rf_vector = *(const u8 *)hdr;
    info->type = (hdr[0] >> 20) & 0xf;
    info->rf_base = hdr[1];
    return 1;
}

/* (0x8ccb84) brd_if_multi_array::get_section_info, vtable 0x8005e4 [2]: описатель
 * секции id (< 10) board-файла. */
u32 brd_if_vt_get_section_info(struct brd_if *o, u32 id,
                                                 struct brd_section_info *info)
{
    if (o->valid == 0) {
        fw_log_emit0(0, 0x100ac98);
        return 0;
    }
    if (info == 0 || id >= 0xa) {
        fw_log_emit3(0, 0x100acf0, (u32)info, id, 0xa);
        return 0;
    }
    brd_section_info_reset(info);
    if (brd_if_multi_array_find_section(o, id, info) == 0) {
        fw_log_emit1(0, 0x100ad60, id);
        return 0;
    }
    brd_if_hook_section_info(info);
    return 1;
}

/* (0x8cb978) brd_if_multi_array::get_block_info, vtable 0x8005e4 [3]: описатель блока
 * blk_idx секции. Блок — RF-модуль blk_idx-го взведённого бита rf_vector; при
 * rf_vector 0 блок один на всю секцию. Последний блок обязан кончаться ровно на конце
 * секции. Число записей: длина / 8 (пары адрес/данные) или / 4 (только данные). */
u32 brd_if_vt_get_block_info(struct brd_if *o, const struct brd_section_info *info,
                                               u32 blk_idx, struct brd_block_info *blk)
{
    const u32 *hdr;
    u32 h, chip, whole, len, start, end, sec_end, last;

    if (o->valid == 0) {
        fw_log_emit0(0, 0x100adb4);
        return 0;
    }
    if (blk == 0 || info == 0) {
        fw_log_emit0(0, 0x100ae08);
        return 0;
    }
    brd_if_clear_block_info(blk);
    hdr = brd_at(o, info->off + 8);
    if (blk_idx >= info->num_blocks) {
        fw_log_emit2(0, 0x100ae3c, blk_idx, info->num_blocks);
        brd_if_log_section_info(info, 0);
        return 0;
    }
    chip = brd_bitmap_nth_set_bit(blk_idx, *(const u8 *)hdr) & 0xff;
    if (chip >= 8) {
        fw_log_emit2(0, 0x100ae9c, chip, 8);
        brd_if_log_section_info(info, 0);
        return 0;
    }
    h = hdr[0];
    whole = (h & 0xff) == 0;
    len = ((h >> 8) & 0xfff) * 4;                  /* bmsk_s 0xb: 12 бит длины */
    start = info->off + 0x10 + len * (whole ? 0 : blk_idx);
    end = start + len;
    sec_end = info->off + info->size;
    last = whole ? 1 : (blk_idx == info->num_blocks - 1);
    if (sec_end < end || (last && end != sec_end)) {
        fw_log_emit3(0, 0x100aef8, end, sec_end, last);
        brd_if_log_section_info(info, 0);
        brd_if_log_section_header(hdr, 0);
        return 0;
    }
    blk->id = info->id;
    blk->blk_idx = blk_idx;
    blk->chip = chip;
    blk->len = len;
    blk->off = start;
    blk->num_entries = len / ((hdr[0] & 0x3000000u) == 0 ? 8 : 4);
    brd_if_hook_section_header(hdr);
    brd_if_hook_block_info(blk);
    return 1;
}

/* ===================== Чтение порций (chunk) блока ===================== */

/* div_round_up (0x8cbea0): число порций блока — ⌈[blk+0xc] / per_chunk⌉. */
static u32 brd_if_block_num_chunks(const struct brd_block_info *blk, u32 per_chunk)
{
    u32 n = blk->num_entries;

    return n / per_chunk + (n % per_chunk != 0);
}

/* brd_if_multi_array::get_chunk (0x8ca760): адрес данных порции idx блока; в *out_n —
 * число записей в ней (не больше per_chunk). Запись — 8 Б (формат 0) или 4 Б.
 * Порция за концом блока — ассерт 0x1354 (vendor продолжает). */
static const u32 *brd_if_multi_array_get_chunk_data(const struct brd_if *o,
                                                    const struct brd_block_info *blk, u32 idx,
                                                    u32 per_chunk, u32 fmt, u32 *out_n)
{
    u32 esz = (fmt == 0) ? 8 : 4;
    u32 full = esz * per_chunk;
    u32 start = full * idx;
    u32 off = blk->off + start;
    u32 done = per_chunk * idx;
    u32 n = blk->num_entries;
    u32 end;

    n = (done < n) ? n - done : 0;
    if (per_chunk < n)
        n = per_chunk;
    end = start + n * esz;
    if (blk->len < end) {
        fw_log_emit3(0, 0x100af94, idx, full, n * esz);
        fw_log_emit2(0, 0x100b018, end, blk->len);
        brd_if_log_block_info(blk, 0);
        fw_sysassert_fatal(CALLER, 0x1354);
    }
    *out_n = n;
    return brd_at(o, off);
}

/* brd_if__chunk_offset (0x8c5410): адрес RF-регистра первой записи порции idx в
 * формате «только данные»: строка секторов — 6 слов (24 Б), в ней заняты слоты маски
 * секторов; *sector — слот первой записи. */
static u32 brd_if_chunk_offset(u32 idx, u32 per_chunk, u32 rf_base, u32 mask, u8 *sector)
{
    u32 nb = brd_bit_length(mask);
    u32 prod = per_chunk * idx;
    u32 q = prod / nb;                 /* nb ≠ 0: маска проверена check_section_header */
    u32 rem = prod - q * nb;
    u32 a = q * 24, cnt = 0, i;

    for (i = 0; i < 6; i++, a += 4) {
        if (!(mask & (1u << i)))
            continue;
        cnt++;
        if (rem < cnt)
            break;
    }
    *sector = (u8)i;
    return a + rf_base;
}

/* brd_if__bounds_check (0x8e2188): запись (addr, data) в окне [buf+0, buf+4] —
 * в массив пар [buf+8] (вместимость u16 [buf+0x10], счётчик u16 [buf+0x12]); без массива
 * запоминается первая: указатель на неё в [buf+0xc], режим в [buf+0x14]. */
static void brd_if_bounds_check(const u32 *p, u32 addr, u32 data, u32 mode, struct brd_win *w)
{
    struct rf_reg_pair *base;

    if (addr < w->lo || w->hi < addr)
        return;
    if (w->cnt >= w->cap)
        return;
    base = w->pairs;
    if (base != 0) {
        base[w->cnt].addr = addr;
        base[w->cnt].val = data;
    } else if (w->first == 0) {
        w->first = p;
        w->mode = mode;
    }
    w->cnt = w->cnt + 1;
}

/* brd_if__parse_chunk_header (0x8c7444): bounds = {окна (по 24 Б), u16 число окон};
 * одно окно — проверка напрямую, несколько — сначала общий диапазон
 * [первое.начало, последнее.конец], затем каждое окно. */
static void brd_if_parse_chunk_header(const u32 *p, u32 addr, u32 data, u32 mode,
                                      const struct brd_bounds *bounds)
{
    u32 n = bounds->n;
    struct brd_win *w = bounds->win;
    u32 i;

    if (n < 2) {
        brd_if_bounds_check(p, addr, data, mode, w);
        return;
    }
    if (addr < w[0].lo || w[n - 1].hi < addr)
        return;
    for (i = 0; i < bounds->n; i++, w++)
        brd_if_bounds_check(p, addr, data, mode, w);
}

/* brd_if_multi_array::get_chunk_in_address_data_pairs_format (0x8cbcd8): порция —
 * пары {адрес, данные} как есть. Выход за конец блока — ассерт 0x1352. */
static u32 brd_if_get_chunk_pairs(const struct brd_if *o, const struct brd_section_info *info,
                                  const struct brd_block_info *blk, u32 idx,
                                  struct rf_reg_pair *out, u32 per_chunk,
                                  const struct brd_bounds *bounds)
{
    u32 hdr = brd_at(o, info->off + 8)[0];
    u32 n = 0, i;
    const u32 *p, *blk_end;

    p = brd_if_multi_array_get_chunk_data(o, blk, idx, per_chunk, (hdr >> 24) & 3, &n);
    for (i = 0; i < n; i++, p += 2) {
        out[i].addr = p[0];
        out[i].val = p[1];
        if (bounds != 0)
            brd_if_parse_chunk_header(p, p[0], p[1], 0, bounds);
    }
    blk_end = brd_at(o, blk->off + blk->len);
    if (p > blk_end) {
        fw_log_emit2(0, 0x100b19c, (u32)p, (u32)blk_end);
        fw_sysassert_fatal(CALLER, 0x1352);
    }
    return n;
}

/* brd_if_multi_array::get_chunk_in_data_only_format (0x8cbd80): в board-файле только
 * данные, адрес — rf_base + 24·строка + 4·слот; слоты строки — по маске секторов.
 * Каждая строка начинается со слота первой записи порции (байт sector не меняется) —
 * так у vendor: при sector ≠ 0 и порции длиннее строки адреса второй и дальнейших строк
 * сдвинуты (см. отчёт; данные стенда этого не задевают — маска 0x3f даёт sector 0 при
 * per_chunk, кратном 6). Выход за конец блока — ассерт 0x1351. */
static u32 brd_if_get_chunk_data_only(const struct brd_if *o, const struct brd_section_info *info,
                                      const struct brd_block_info *blk, u32 idx,
                                      struct rf_reg_pair *out, u32 per_chunk,
                                      const struct brd_bounds *bounds)
{
    const u32 *hdr = brd_at(o, info->off + 8);
    u8 sector = 0;
    u32 n = 0, i = 0, addr;
    const u32 *p0, *p, *blk_end;

    addr = brd_if_chunk_offset(idx, per_chunk, info->rf_base, hdr[0] >> 26, &sector);
    p0 = brd_if_multi_array_get_chunk_data(o, blk, idx, per_chunk, (hdr[0] >> 24) & 3, &n);
    p = p0;
    while (i < n) {
        u32 s = sector, left;

        if (s >= 6) {
            /* недостижимо: rem < bit_length(маски) в chunk_offset всегда находит слот
             * < 6 (маска не пуста). vendor здесь зацикливается (brhs → тот же тест). */
            for (;;) {
            }
        }
        for (left = 6 - s;; left--) {
            if ((hdr[0] >> 26) & (1u << s)) {
                u32 v = p[0];

                out[i].addr = addr;
                out[i].val = v;
                if (bounds != 0)
                    brd_if_parse_chunk_header(p, addr, v, 1, bounds);
                i++;
                p++;
                if (i >= n)
                    break;
            }
            addr += 4;
            s++;
            if (left < 2)
                break;
        }
    }
    blk_end = brd_at(o, blk->off + blk->len);
    if (blk_end < p) {
        fw_log_emit3(0, 0x100b088, idx, (u32)blk_end, (u32)p);
        fw_log_emit3(0, 0x100b120, (u32)brd_at(o, 0), (u32)p0, n);
        brd_if_log_block_info(blk, 0);
        fw_sysassert_fatal(CALLER, 0x1351);
    }
    return n;
}

/* (0x8cbc48) brd_if_multi_array::get_chunk, vtable 0x8005e4 [4]: порция idx блока
 * (до per_chunk записей) в out парами {адрес, данные}; bounds ≠ 0 — сверка адресов с
 * окнами (parse_chunk_header). Возвращает число записей. */
u32 brd_if_vt_get_chunk(struct brd_if *o, const struct brd_section_info *info,
                                          const struct brd_block_info *blk, u32 idx,
                                          struct rf_reg_pair *out, u32 per_chunk,
                                          const struct brd_bounds *bounds)
{
    u32 hdr;

    if (o->valid == 0) {
        fw_log_emit0(0, 0x100b21c);
        return 0;
    }
    if (out == 0 || per_chunk == 0 || info == 0 || blk == 0 ||
        brd_if_block_num_chunks(blk, per_chunk) < idx) {
        fw_log_emit0(0, 0x100b26c);
        return 0;
    }
    hdr = brd_at(o, info->off + 8)[0];
    if ((hdr & 0x3000000u) == 0)
        return brd_if_get_chunk_pairs(o, info, blk, idx, out, per_chunk, bounds);
    return brd_if_get_chunk_data_only(o, info, blk, idx, out, per_chunk, bounds);
}

/* ===================== Прочие методы vtable ===================== */

/* (0x8cbbec) brd_if_multi_array::read, vtable 0x8005e4 [1]: out[0] = rf_vector секции
 * 2k+3, out[1] = rf_vector секции 2k+2 (у init_board_file_interface k = 0: маски
 * TX- и RX-модулей в [rf+0x45c]/[rf+0x45d]). Результат — последнего get_section_info. */
u32 brd_if_vt_read(struct brd_if *o, u32 k, u8 *out)
{
    struct brd_section_info info;
    u32 id[2] = { 2 * k + 3, 2 * k + 2 };
    u32 ok = 0, i;

    brd_section_info_reset(&info);
    for (i = 0; i < 2; i++) {
        ok = o->vt->get_section_info(o, id[i], &info);
        if (ok == 0)
            break;
        out[i] = info.rf_vector;
    }
    return ok;
}

/* (0x8cb800) vtable 0x8005c4/0x8005e4 [5]: список TX-секторов — сам объект (j_s [blink],
 * r0 как пришёл): байты +0..+0x3f. */
const u8 *brd_if_vt_tx_sectors(struct brd_if *o)
{
    return o->tx_sectors;
}

/* (0x8cb7f0) vtable 0x8005c4/0x8005e4 [6]: число TX-секторов — байт +0x40. */
u32 brd_if_vt_num_tx_sectors(struct brd_if *o)
{
    return o->num_tx_sectors;
}

/* rf_tbl__lookup_by_module (0x8cca88): первый набор RF (из n_sets), в маске
 * которого (set_rf_mask[i]) есть mod: *start = start[idx][i], *cnt = n_sec[idx][i]
 * (idx 0 — TX, 1 — второй тип). Не нашёлся — выходы не трогаются. */
void rf_tbl_lookup_by_module(const struct brd_if *o, u32 mod, u32 idx, u8 *start, u8 *cnt)
{
    u32 i;

    (void)o;
    for (i = 0; i < fwsh_sets.n_sets; i++) {
        if (fwsh_sets.set_rf_mask[i] & mod) {
            *start = fwsh_sets.start[idx][i];
            *cnt = fwsh_sets.n_sec[idx][i];
            return;
        }
    }
}

/* (0x8e2ff0) vtable 0x8005e4 [7]: при нескольких наборах RF (n_sets ≥ 2) и типе
 * секции 0/1 — rf_base_address описателя сдвигается на начальный сектор набора RF-модуля
 * блока blk_idx (24 Б на сектор). */
void brd_if_vt_module_rf_base(struct brd_if *o, struct brd_section_info *info,
                                                u32 blk_idx)
{
    u8 start = 0, cnt = 0;
    u32 type, base, mod;

    if (fwsh_sets.n_sets < 2)
        return;
    type = info->type;
    if (type >= 2)
        return;
    base = brd_at(o, info->off)[3];
    mod = brd_nth_low_bit(info->rf_vector, blk_idx);
    rf_tbl_lookup_by_module(o, mod, type == 0, &start, &cnt);
    info->rf_base = base + start * 24;
}

/* (0x8ed5a8) базовая vtable 0x8005c4 [1]: read без board-файла — out[0] = out[1] = 0. */
u32 brd_if_base_vt_read(struct brd_if *o, u32 k, u8 *out)
{
    (void)o;
    (void)k;
    out[0] = 0;
    out[1] = 0;
    return 1;
}

/* (0x8ed9c0) базовая vtable 0x8005c4 [7]: пусто (j_s [blink]). */
void brd_if_base_vt_module_rf_base(struct brd_if *o, struct brd_section_info *info,
                                                     u32 blk_idx)
{
    (void)o;
    (void)info;
    (void)blk_idx;
}

/* ===================== Таблицы методов и таблица секций ===================== */

/* vendor 0x8005c4: базовая (board-файла нет) — поиск секций/блоков/порций не определён (0). */
FWDATA(8005c4) const struct brd_if_vt brd_if_base_vtbl = {
    .rsv0 = 0,
    .read = brd_if_base_vt_read,
    .get_section_info = 0,
    .get_block_info = 0,
    .get_chunk = 0,
    .tx_sectors = brd_if_vt_tx_sectors,
    .num_tx_sectors = brd_if_vt_num_tx_sectors,
    .module_rf_base = brd_if_base_vt_module_rf_base,
};

/* vendor 0x8005e4: brd_if_multi_array. */
FWDATA(8005e4) const struct brd_if_vt brd_if_vtbl = {
    .rsv0 = 0,
    .read = brd_if_vt_read,
    .get_section_info = brd_if_vt_get_section_info,
    .get_block_info = brd_if_vt_get_block_info,
    .get_chunk = brd_if_vt_get_chunk,
    .tx_sectors = brd_if_vt_tx_sectors,
    .num_tx_sectors = brd_if_vt_num_tx_sectors,
    .module_rf_base = brd_if_vt_module_rf_base,
};

/* vendor 0x8022c0: секции 0..9 → запись таблицы board-файла и допустимые метки
 * (у секций 0 и 1 — одна метка, вторая -1; значения — из vendor-образа). */
FWDATA(8022c0) const struct brd_section_map brd_section_map[10] = {
    { 1, { 0xa000900du, 0xffffffffu } },
    { 0, { 0xb000900du, 0xffffffffu } },
    { 2, { 0xc001900eu, 0xc00c900eu } },
    { 3, { 0xc001900du, 0xc00c900du } },
    { 4, { 0xc002900eu, 0xc00c900eu } },
    { 5, { 0xc002900du, 0xc00c900du } },
    { 6, { 0xc003900eu, 0xc00c900eu } },
    { 7, { 0xc003900du, 0xc00c900du } },
    { 8, { 0xc004900eu, 0xc00c900eu } },
    { 9, { 0xc004900du, 0xc00c900du } },
};

/* ===================== Инициализация board-файла ===================== */

/* brd_if_multi_array::get_board_file_format_version (0x8cbafc): версия формата
 * ([+4]) при магии 0xbdf0bdf0, иначе -1. */
static u32 brd_if_multi_array_get_board_file_format_version(const struct brd_if *o, u32 verbose)
{
    /* volatile: verify (0x8ebd18) зовёт это дважды подряд и vendor перечитывает
     * [obj+0x48], магию и версию; gcc с известным объектом второе чтение схлопывал. */
    const volatile u32 *bf = (const volatile u32 *)((const volatile struct brd_if *)o)->data;

    if (bf == 0)
        return 0xffffffffu;
    if (verbose != 0)
        fw_log_emit2(0x20, 0x100a624, bf[0], bf[1]);
    if (bf[0] != 0xbdf0bdf0u)
        return 0xffffffffu;
    return bf[1];
}

/* brd_if_multi_array::verify_board_file_format_version (0x8ebd18): формат 0x20000000. */
static u32 brd_if_multi_array_verify_board_file_format_version(const struct brd_if *o, u32 verbose)
{
    if (brd_if_multi_array_get_board_file_format_version(o, verbose) == 0x20000000u) {
        if (verbose != 0)
            fw_log_emit1(0x20, 0x100a6fc, 0x20000000u);
        return 1;
    }
    fw_log_emit2(0x20, 0x100a684,
                 brd_if_multi_array_get_board_file_format_version(o, 0), 0x20000000u);
    return 0;
}

/* brd_if__scan_sections (0x8c6afc): размер board-файла по таблице секций — 8 Б
 * заголовка + размеры (×8) неповторяющихся записей {смещение, размер}. */
static u32 brd_if_scan_sections(const u32 *tbl, u32 n)
{
    u32 total = 8, i, j;

    for (i = 0; i < n; i++) {
        u32 off = tbl[i * 2], size = tbl[i * 2 + 1], uniq = 1;

        for (j = 0; j < i; j++)
            if (tbl[j * 2] == off && tbl[j * 2 + 1] == size)
                uniq = 0;
        if (uniq)
            total += size << 3;
    }
    return total;
}

/* brd_if_multi_array::init (0x8d8fe4): привязка board-файла, проверка формата и
 * размера; [obj+0x50] = 1 — board-файл годен (без этого методы vtable отказывают). */
static u32 brd_if_multi_array_init(struct brd_if *o, const u8 *data, u32 size)
{
    u32 need;

    o->data = data;
    o->size = size;
    o->valid = 0;
    if (data == 0 || size == 0)
        return 0;
    if (brd_if_multi_array_verify_board_file_format_version(o, 1) == 0)
        return o->valid;
    need = brd_if_scan_sections(brd_at(o, 0), 0xa);
    fw_log_emit2(0x20, 0x100a76c, need, size);
    if (o->size < need) {
        fw_log_emit2(0, 0x100a7cc, need, size);
        fw_sysassert_fatal(CALLER, 0x1367);
    } else {
        o->valid = 1;
    }
    return o->valid;
}

/* brd_if__build_tx_sector_list (0x8ddbbc): список TX-секторов из секции 3. Для каждого
 * блока (RF-модуль blk-го бита rf_vector) — начальный сектор набора модуля (rf_tbl,
 * idx 0); строки секции по 6 слов — сектора; ненулевая строка k даёт сектор
 * start + k/6, если позиция slot списка ещё свободна (0xff). Указатель строк общий для
 * всех блоков и не сбрасывается, длина — из заголовка секции (как у vendor). Пустой
 * список — ассерт 0x1562. */
void brd_if_build_tx_sector_list(struct brd_if *o)
{
    struct brd_section_info info;
    struct brd_block_info blk;
    const u32 *sec, *row;
    u32 rfvec, b;

    brd_section_info_reset(&info);
    brd_if_clear_block_info(&blk);
    if (o->vt->get_section_info(o, 3, &info) == 0)
        fw_sysassert_fatal(CALLER, 0x1368);
    rfvec = info.rf_vector;
    sec = brd_at(o, info.off);
    o->num_tx_sectors = 0;
    row = sec + 4;
    for (b = 0; b < info.num_blocks; b++) {
        u8 start = 0, cnt = 0;
        u32 slot, k;

        rf_tbl_lookup_by_module(o, brd_nth_low_bit(rfvec, b), 0, &start, &cnt);
        slot = start;
        o->vt->get_block_info(o, &info, b, &blk);
        for (k = 0; k < ((sec[2] >> 8) & 0xfff); k += 6) {
            u32 nz = 0, j;

            for (j = 0; j < 6; j += 2, row += 2)
                if (row[0] != 0 || row[1] != 0)
                    nz = 1;
            /* tx_sectors[0x40]: больше 64 секторов в board file — не за массив (vendor писал по num_tx_sectors) */
            if (nz && slot < 0x40 && o->num_tx_sectors < 0x40 && o->tx_sectors[slot] == 0xff) {
                u32 n = o->num_tx_sectors;

                o->tx_sectors[n] = (u8)(start + k / 6);
                o->num_tx_sectors = (u8)(n + 1);
            }
            slot = (slot + 1) & 0xff;
        }
    }
    if (o->num_tx_sectors == 0)
        fw_sysassert_fatal(CALLER, 0x1562);
}

/* rf_if__num_tx_sectors (0x8cb7e8): vtable [6] объекта board-файла [rf+0x58]. */
u32 rf_if_num_tx_sectors(struct rf_obj *rf)
{
    struct brd_if *o = rf->brd_if;

    return o->vt->num_tx_sectors(o);
}

/* 0x801fa4 / 0x801fa8: начальные значения handle_rf_sets_info — u16 пара начальных секторов
 * (нули) и байты пределов {0x80, 0x20} (vendor: ld [0x801fa4], ldw [0x801fa4 + 4]). */
FWDATA(801fa4) const u16 rf_sets_sec_start_tpl[2] = { 0, 0 };
FWDATA(801fa8) const u8 rf_sets_sec_lim_tpl[2] = { 0x80, 0x20 };

/* handle_rf_sets_info (0x8ed5ec): запись 0x8ffffe секции параметров — наборы RF.
 * За ней (запись *pidx + 1 и дальше, как сырые байты): 8 Б масок модулей наборов →
 * set_rf_mask (0x85778c), 16 Б числа секторов (8 — TX, 8 — второго типа) → n_sec
 * (0x857734); с записи
 * *pidx + 4 — таблицы секторов второго типа (по 2 Б на сектор) для наборов, где их ≥ 2.
 * Начальные сектора — нарастающим итогом от u16 пары rf_sets_sec_start_tpl с пределами
 * байтов rf_sets_sec_lim_tpl (vendor: счётчик, ограниченный пределом, всегда кладётся в
 * первый байт пары [sp+4], а второй тип прибавляет второй байт [sp+5], который всегда 0 — начало второго
 * типа у всех наборов одно; повторено как есть). Набор без TX-секторов — конец; без
 * второго типа или без маски — ассерт 0x1570. *pidx — последняя использованная запись. */
static void marlon_r_if_class_handle_rf_sets_info(struct rf_obj *rf, u32 *pidx)
{
    const u8 *e = (const u8 *)&rf->chunk[*pidx];
    u16 off[2];
    u8 cnt[2] = { 0, 0 };
    u8 lim[2];
    u8 *pc[2] = { &cnt[0], &cnt[1] };
    const u8 *src0, *src;
    u32 mask0, nsets = 0, err = 0, s;

    memcpy_fw(fwsh_sets.set_rf_mask, e + 8, 8);
    memcpy_fw(fwsh_sets.n_sec, e + 0x10, 0x10);
    *pidx += 4;
    src0 = (const u8 *)&rf->chunk[*pidx];
    src = src0;
    memcpy_fw(off, rf_sets_sec_start_tpl, 4);
    memcpy_fw(lim, rf_sets_sec_lim_tpl, 2);
    mask0 = rf->tx_mask;
    for (s = 0; s < 8; s++) {
        u32 j, m, n1;

        for (j = 0; j < 2; j++) {
            u32 c = fwsh_sets.n_sec[j][s];

            cnt[0] = (u8)c;
            if (c > lim[j]) {
                c = lim[j];
                cnt[0] = (u8)c;
            }
            if (c == 0)
                break;
            fwsh_sets.start[j][s] = (u8)off[j];
            off[j] = (u16)(off[j] + *pc[j]);
        }
        if (j == 0)
            break;
        if (j == 1) {
            err = 1;
            break;
        }
        m = fwsh_sets.set_rf_mask[s];
        if (m == 0) {
            err = 2;
            break;
        }
        nsets++;
        rf->tx_mask = (u8)(rf->tx_mask | m);
        n1 = fwsh_sets.n_sec[1][s];
        if (n1 >= 2) {
            fwsh_sets.multi_cfg = (u8)(fwsh_sets.multi_cfg | (1u << s));
            memcpy_fw(rf_set_ranges[s], src, n1 * 2);
            src += n1 * 2;
        } else {
            rf_set_ranges[s][0].last = (u8)(fwsh_sets.n_sec[0][s] - 1);
        }
        fwsh_sets.set_tx_mask[s] = (u8)(m & mask0);
    }
    if (err != 0) {
        fw_log_emit2(0, 0x1005374, s, err);
        fw_sysassert_fatal(CALLER, 0x1570);
    }
    if (nsets != 1) {
        rf->sets_mode = 2;
    } else if (brd_popcount(fwsh_sets.set_rf_mask[0]) != 1) {
        if (brd_popcount(fwsh_sets.set_tx_mask[0]) == 1)
            fw_sysassert_fatal(CALLER, 0x16cc);
        rf->sets_mode = 3;
    }
    fwsh_sets.n_sets = nsets;
    if (src == src0)
        *pidx -= 1;
    else
        *pidx += ((src - src0 + 7) >> 3) - 1;
}

/* marlon_r_if_class::load_brd_parameters_section (0x8dc690): секция 0 — пары
 * {адрес, данные} порциями по per_chunk в [rf+0x5c]: 0x8fffff — 8 слов 0x85776c
 * (32 Б с этой записи и слово записи +4 → [0x857038]; если до конца порции < 5 записей —
 * данные записи во все 8 слов), 0x8ffffe — наборы RF (handle_rf_sets_info), адреса
 * 0x880a3c..0x880abb и 0x880014 — запись в регистр, прочие пропускаются. */
u32 marlon_r_if_class_load_brd_parameters_section(struct rf_obj *rf, u32 per_chunk)
{
    struct brd_section_info info;
    struct brd_block_info blk;
    struct brd_if *obj = rf->brd_if;
    u32 t0, b;

    brd_section_info_reset(&info);
    if (obj == 0 || obj->vt->get_section_info(obj, 0, &info) == 0)
        return 0;
    t0 = u_schd_now();
    fw_log_emit1(0x20, 0x10053b0, info.id);
    brd_if_hook_section_info(&info);
    brd_if_clear_block_info(&blk);
    for (b = 0; b < info.num_blocks; b++) {
        u32 nch, ch;

        obj = rf->brd_if;
        if (obj->vt->get_block_info(obj, &info, b, &blk) == 0)
            return 0;
        nch = brd_if_block_num_chunks(&blk, per_chunk);
        brd_if_hook_block_info(&blk);
        for (ch = 0; ch < nch; ch++) {
            u32 n, i = 0;

            obj = rf->brd_if;
            n = obj->vt->get_chunk(obj, &info, &blk, ch, rf->chunk, per_chunk, 0);
            if (n == 0)
                continue;
            do {
                u32 addr = rf->chunk[i].addr;
                u32 data = rf->chunk[i].val;

                fw_log_emit3(0x20, 0x1005414, i, addr, data);
                if (addr == 0x8fffff) {
                    if (n - i < 5) {
                        u32 j;

                        for (j = 0; j < 8; j++)
                            fwsh_sets.brp_cfg_mask[j] = data;
                    } else {
                        memcpy_fw(fwsh_sets.brp_cfg_mask, &rf->chunk[i].val, 0x20);
                        fwsh_diag.brp_cfg_x = rf->chunk[i + 4].val;
                        i += 4;
                    }
                } else if (addr == 0x8ffffe) {
                    marlon_r_if_class_handle_rf_sets_info(rf, &i);
                } else if ((addr >= BL_READY && addr < RGF_USER_CLKS_CTL_0) || addr == HW_RGF_USER_USAGE_5) {
                    MMIO32(addr) = data;
                }
                i++;
            } while (i < n);
        }
    }
    fw_log_emit2(0x20, 0x1005468, 0, (u_schd_now() - t0) << 4);
    return 1;
}

/* marlon_r_if_class::load_brd_rf_cfg_section (0x8dc830): секция sec (0 — секция
 * параметров) — для каждого блока, чей RF-модуль подключён ([rf+0x45e]): RFCA-команды на
 * модуль и запись порций по per_chunk в RF (rf_write_with_block_retries, mode ≠ 0 —
 * ассерт при сбое записи). При нескольких наборах RF — сначала vtable [7] (база адресов
 * набора). В конце — регистры по умолчанию и RFCA на все модули [0x800242]. */
u32 marlon_r_if_class_load_brd_rf_cfg_section(struct rf_obj *rf, u32 sec,
                                              const struct brd_bounds *bounds, u32 per_chunk,
                                              u32 mode)
{
    struct brd_section_info info;
    struct brd_block_info blk;
    struct brd_if *obj;
    u32 t0, multi, b;

    if (sec == 0)
        return marlon_r_if_class_load_brd_parameters_section(rf, per_chunk);
    t0 = u_schd_now();
    brd_section_info_reset(&info);
    multi = fwsh_sets.n_sets > 1;
    obj = rf->brd_if;
    if (obj == 0 || obj->vt->get_section_info(obj, sec, &info) == 0)
        return 0;
    fw_log_emit1(0x20, 0x1005674, sec);
    brd_if_hook_section_info(&info);
    brd_if_clear_block_info(&blk);
    for (b = 0; b < info.num_blocks; b++) {
        u32 bit, nch, ch;

        obj = rf->brd_if;
        if (multi)
            obj->vt->module_rf_base(obj, &info, b);
        obj = rf->brd_if;
        if (obj->vt->get_block_info(obj, &info, b, &blk) == 0)
            return 0;
        bit = 1u << blk.chip;
        if ((rf->rf_mask & bit) == 0)
            continue;
        hwd_abif_dvs_rfca_cmd_enable(bit & 0xff, 0);
        nch = brd_if_block_num_chunks(&blk, per_chunk);
        brd_if_hook_block_info(&blk);
        for (ch = 0; ch < nch; ch++) {
            u32 n;

            obj = rf->brd_if;
            n = obj->vt->get_chunk(obj, &info, &blk, ch, rf->chunk, per_chunk, bounds);
            if (marlon_r_if_class_rf_write_with_block_retries(rf, 0, rf->chunk, n, 0x10, 5,
                                                              mode) == 0) {
                fw_log_emit3(0, 0x100574c, ch, b, sec);
                return 0;
            }
        }
    }
    hwd_args_to_regs_default(rf_connected_mask);
    hwd_abif_dvs_rfca_cmd_enable(rf_active_mask, 0);
    fw_log_emit2(0x20, 0x10056d4, sec, (u_schd_now() - t0) << 4);
    return 1;
}

/* marlon_r_if_class::init_board_file_interface (0x8f5700): board-файл 0x84f800
 * (0x2400 Б) → объект rf+4, [rf+0x58] = он (только после успешной проверки); маски
 * модулей (vtable read → [rf+0x45c]/[rf+0x45d]); секция параметров (сбой — RF выкл. и
 * ассерт 0x1185, vendor идёт дальше); список TX-секторов. Если секция параметров не
 * задала наборы RF (0x85778c..0x857793 пусты): один набор — маска [rf+0x45c] (пустая —
 * младший подключённый модуль [0x800243]) и все сектора; несколько модулей второго типа
 * — по набору на модуль, сектора делятся поровну ([rf+0x468] = 2). */
u32 marlon_r_if_class_init_board_file_interface(struct rf_obj *rf)
{
    struct brd_if *obj = &rf->brd;
    u32 c;

    if (brd_if_multi_array_init(obj, brd_file_buf, BRD_FILE_BUF_SIZE) == 0) {
        fw_log_emit0(0, 0x1005a78);
        return 0;
    }
    rf->brd_if = obj;
    fw_log_emit0(0x20, 0x1005ae4);
    /* out[0]/out[1] — tx_mask/rx_mask (соседние байты +0x45c/+0x45d) */
    if (obj->vt->read(obj, 0, &rf->tx_mask) == 0) {
        fw_log_emit0(0, 0x1005b44);
        rf->brd_if = 0;
        return 0;
    }
    if (marlon_r_if_class_load_brd_parameters_section(rf, 0x80) == 0) {
        rf_power_off();
        fw_sysassert_fatal(CALLER, 0x1185);
    }
    brd_if_build_tx_sector_list(obj);

    if ((fwsh_sets.set_rf_mask_w[0] | fwsh_sets.set_rf_mask_w[1]) == 0) {
        u32 nsec = rf_if_num_tx_sectors(rf);
        u32 m = rf->tx_mask, m2, nm, nm2;

        if (m == 0) {
            c = rf_connected_mask;
            m = c & ~(c - 1) & 0xff;
            rf->tx_mask = (u8)m;
            rf->rx_mask = (u8)m;
            m2 = m;
            nm = 1;
            nm2 = 1;
        } else {
            nm = brd_popcount(m);
            m2 = rf->rx_mask;
            nm2 = brd_popcount(m2);
        }
        if (nm2 >= 2) {
            u32 q, i;

            if (m != m2) {
                fw_log_emit2(0, 0x1005b84, m2, m);
                fw_sysassert_fatal(CALLER, 0x1573);
            }
            q = (u32)((s32)nsec / (s32)nm) & 0xffff;
            for (i = 0; i < nm2; i++) {
                fwsh_sets.set_rf_mask[i] = (u8)brd_nth_low_bit(rf->tx_mask, i);
                fwsh_sets.start[0][i] = (u8)(i * q);
                fwsh_sets.n_sec[0][i] = (u8)q;
                fwsh_sets.n_sec[1][i] = 1;
                fwsh_sets.start[1][i] = 0;
                rf_set_ranges[i][0].last = (u8)(q - 1);
                fwsh_sets.set_tx_mask[i] = rf->tx_mask;
            }
            rf->sets_mode = 2;
        } else {
            fwsh_sets.set_rf_mask[0] = (u8)m;
            fwsh_sets.n_sec[0][0] = (u8)nsec;
            fwsh_sets.start[0][0] = 0;
            fwsh_sets.start[1][0] = 0;
            fwsh_sets.n_sec[1][0] = 0;
            fwsh_sets.set_tx_mask[0] = rf->tx_mask;
        }
        fwsh_sets.n_sets = nm2;
    }
    c = rf_connected_mask;
    fw_log_emit3(0x20, 0x1005bcc, c, brd_popcount(c), rf->sets_mode);
    return 1;
}
