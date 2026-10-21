// SPDX-License-Identifier: AGPL-3.0-or-later
/* RF/RFC: секторные таблицы RFC (edge gain / edge phase / dist gain / x16 state), чтение
 * секторов, выбор активных RF-модулей, hwf-обёртки цепочек, sysapi-доступ к RGF RFC
 * (порт vendor 6.2.0.1000).
 *
 * Раскладка секторной таблицы RFC (по коду 0x8d3850..0x8d3da0): сектор s занимает 192 бита
 * (asl 6 + add1 = s·3·64); банк TX — бит 0x8000, банк RX — бит 0x10000; адрес RGF-слова
 * поля = ((бит) >> 3) & ~3. Смещения полей внутри сектора (в битах):
 *   +0x00, +0x20 — edge phase (по 2 бита на цепочку: цепочки 0..15 в +0x20, 16..31 в +0x00);
 *   +0xa0, +0x40, +0x60 — edge gain (бит chain: [2] в +0xa0, [1] в +0x40, [0] в +0x60);
 *   +0x80 — dist gain (по 3 бита на группу из 4 цепочек) и x16 state (биты 28/29). */
#include "types.h"
#include "hw.h"
#include "arc.h"
#include "bitfield.h"
#include "rf_obj.h"
#include "radio_mgr.h"
#include "ut.h"

/* Внешние функции (другие файлы fw/). */

/* Глобальные функции этого файла (прототипы для перекрёстных вызовов). */

#define CALLER() ((void *)__builtin_return_address(0))

/* Адрес RGF-слова поля секторной таблицы: бит (s·192 + банк + off) → байты, & ~3. */
static inline u32 rf_sector_addr(u32 sector, u32 tx, u32 off)
{
    return ((sector * 192u + (tx != 0 ? 0x8000u : 0x10000u) + off) >> 3) & ~3u;
}

/* ===================== помощники hwm_analog ===================== */

/* [0x8e6f24] hwm_analog__save_rfc_enabled (8 Б): байт [gp+0xbe] = 0x800242 = v (r0 не
 * используется). */
static void hwm_analog_save_rfc_enabled(struct rf_obj *obj, u32 v)
{
    (void)obj;
    rf_active_mask = (u8)v;
}

/* ===================== Секторные поля RFC ===================== */

/* Общий хвост сеттеров: commit < 0x10 (знаково) — применить сектор и записать commit
 * командой 0x508 (TX) / 0x507 (RX), журнал с номером сектора. */
static void rf_sector_commit(u32 rf, u32 sector, u32 tx, s32 commit, u32 tok_tx, u32 tok_rx)
{
    if (commit >= 0x10)
        return;
    if (tx != 0) {
        rf_sector_commit_tx(rf, sector);
        ut_hw_drivers_cmd_0x508(rf, sector, (u32)commit);
        fw_log_emit1(0x20, tok_tx, sector);
    } else {
        rf_sector_commit_rx(rf, sector);
        ut_hw_drivers_cmd_0x507(rf, sector, (u32)commit);
        fw_log_emit1(0x20, tok_rx, sector);
    }
}

/* hwd_rfc__read_sector_reg (0x8d3850, 54 Б): dist gain группы idx — 3 бита со сдвигом 3·idx
 * (add1 r0,r13,r13 = 3·idx) слова +0x80 сектора. */
u32 hwd_rfc_read_sector_reg(u32 rf, u32 sector, u32 tx, u32 idx)
{
    u32 w = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x80));

    return (w >> (idx * 3u)) & 7u;
}

/* hwd_rfc_sector_dist_gain_set (0x8d3888, 204 Б): поле dist gain группы idx (биты
 * 3·idx .. 3·idx+2 слова +0x80) = val & 7; маска поля (1<<(s+2)) | ((1<<(s+2)) − (1<<s)).
 * Затем commit (лог «…dist gain set» 0x101e664 TX / 0x101e6c8 RX). */
void hwd_rfc_sector_dist_gain_set(u32 rf, u32 sector, u32 tx, u32 idx, u32 val, s32 commit)
{
    u32 addr = rf_sector_addr(sector, tx, 0x80);
    u32 w = hwd_rfc_read_rgf(rf, addr);
    u32 sh = idx * 3u;
    u32 hi = 1u << (sh + 2);
    u32 mask = hi | (hi - (1u << sh));

    rfc_field_write(rf, addr, (w & ~mask) | ((val & 7u) << sh), 0);
    rf_sector_commit(rf, sector, tx, commit, 0x101e664, 0x101e6c8);
}

/* hwd_rfc__read_sector_chain (0x8d3954, 162 Б): edge gain цепочки chain (3 бита):
 * [2] — бит chain слова +0xa0, [1] — +0x40, [0] — +0x60 (порядок чтения a0, 40, 60). */
u8 hwd_rfc_read_sector_chain(u32 rf, u32 sector, u32 tx, u32 chain)
{
    u32 wa0 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0xa0));
    u32 w40 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x40));
    u32 w60 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x60));
    u32 m = 1u << chain;

    return (u8)((((wa0 & m) >> chain) << 2) + (((w40 & m) >> chain) << 1) + ((w60 & m) >> chain));
}

/* hwd_rfc_sector_edge_gain_set (0x8d39f8, 408 Б): три бита val в бит chain слов
 * +0xa0 (val[2]), +0x40 (val[1]), +0x60 (val[0]); чтение всех трёх до записи. Затем commit
 * (лог 0x101e410 TX / 0x101e474 RX). */
void hwd_rfc_sector_edge_gain_set(u32 rf, u32 sector, u32 tx, u32 chain, u32 val, s32 commit)
{
    u32 wa0 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0xa0));
    u32 w40 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x40));
    u32 w60 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x60));
    u32 nm = ~(1u << chain);

    rfc_field_write(rf, rf_sector_addr(sector, tx, 0xa0),
                    (((val & 4u) >> 2) << chain) | (wa0 & nm), 0);
    rfc_field_write(rf, rf_sector_addr(sector, tx, 0x40),
                    (((val & 2u) >> 1) << chain) | (w40 & nm), 0);
    rfc_field_write(rf, rf_sector_addr(sector, tx, 0x60),
                    ((val & 1u) << chain) | (w60 & nm), 0);
    rf_sector_commit(rf, sector, tx, commit, 0x101e410, 0x101e474);
}

/* hwd_rfc_sector_edge_phase_set (0x8d3c04, 352 Б): 2 бита val цепочки chain — в слово +0x20
 * (chain < 16, сдвиг 2·chain) или +0x00 (сдвиг (u8)(2·chain − 32)). Журналы до/после:
 * 0x101e4d8 (w00, w20, chain), 0x101e538 (w00, w20, сдвиг). Затем commit (0x101e59c TX /
 * 0x101e600 RX). */
void hwd_rfc_sector_edge_phase_set(u32 rf, u32 sector, u32 tx, s32 chain, u32 val, s32 commit)
{
    u32 w00 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x00));
    u32 w20 = hwd_rfc_read_rgf(rf, rf_sector_addr(sector, tx, 0x20));
    u32 v = val & 3u;
    u32 sh;

    fw_log_emit3(0x20, 0x101e4d8, w00, w20, (u32)chain);
    if (chain < 0x10) {
        sh = ((u32)chain << 1) & 0xffu;
        w20 = (w20 & ~(3u << sh)) | (v << sh);
    } else {
        sh = (((u32)chain << 1) - 0x20u) & 0xffu;
        w00 = (w00 & ~(3u << sh)) | (v << sh);
    }
    fw_log_emit3(0x20, 0x101e538, w00, w20, sh);
    rfc_field_write(rf, rf_sector_addr(sector, tx, 0x00), w00, 0);
    rfc_field_write(rf, rf_sector_addr(sector, tx, 0x20), w20, 0);
    rf_sector_commit(rf, sector, tx, commit, 0x101e59c, 0x101e600);
}

/* hwd_rfc_sector_x16_state_set (0x8d3da0, 184 Б): бит ((idx & 1) + 28) слова +0x80 = val.
 * ХРУПКО (vendor): bclr + (val << sh) без маски val — val > 1 заденет соседние биты; так и
 * у vendor (0x8d3de4 asl r3,r19,r1). Затем commit (0x101e72c TX / 0x101e790 RX). */
void hwd_rfc_sector_x16_state_set(u32 rf, u32 sector, u32 tx, u32 idx, u32 val, s32 commit)
{
    u32 addr = rf_sector_addr(sector, tx, 0x80);
    u32 w = hwd_rfc_read_rgf(rf, addr);
    u32 sh = (idx & 1u) + 0x1c;

    rfc_field_write(rf, addr, (w & ~(1u << sh)) | (val << sh), 0);
    rf_sector_commit(rf, sector, tx, commit, 0x101e72c, 0x101e790);
}

/* ===================== Модули RF ===================== */

/* rfc__probe_modules (0x8d3fb4, 90 Б): для каждого из 8 RF-модулей, который подключён и
 * есть в mask: сделать активным, импульс бита 15 RFC 0x3e0 (rfc_read_or_dead — vendor
 * передаёт RF-объект в r0, функция его не читает), обнулить счётчик команд модуля
 * [0x8019cc + 4i]; *out — маска пройденных модулей. */
void rfc_probe_modules(u32 mask, u8 *out)
{
    u32 conn = rf_get_connected_mask(&rf_obj);
    u32 i;

    *out = 0;
    for (i = 0; i < 8; i++) {
        u32 m = (u8)(1u << i);
        if ((conn & mask) & m) {
            hwm_analog_select_active_rf_module(m);
            rfc_read_or_dead();
            rfc_cmd_count[i] = 0;
            *out = (u8)(*out | m);
        }
    }
}

/* rfc__collect_rx_crc_stats (0x8d4010, 84 Б): для каждого подключённого модуля из mask:
 * сделать активным; out[2i] = счётчик команд [0x8019cc + 4i], out[2i+1] = RFC 0x428
 * (mdm_stt_rx_crc_ok). Остальные элементы out не трогаются. */
void rfc_collect_rx_crc_stats(u32 mask, u32 *out)
{
    u32 conn = rf_get_connected_mask(&rf_obj);
    u32 i;

    for (i = 0; i < 8; i++) {
        u32 m = (u8)(1u << i);
        if ((conn & mask) & m) {
            hwm_analog_select_active_rf_module(m);
            out[i * 2] = rfc_cmd_count[i];
            out[i * 2 + 1] = mdm_stt_rx_crc_ok();
        }
    }
}

/* hwf_rf_config (0x8d6f30, 56 Б): журнал «HWF_RF_CONFIG ch» (0x21, 0x101b3c4), роль/мощность
 * RF-объекта, затем для ch < 4 (беззнаково, blc) — настройка канала (mode 1). */
void hwf_rf_config(u32 ch)
{
    fw_log_emit1(0x21, 0x101b3c4, ch);
    rf_configure_role_power(&rf_obj);
    if (ch < 4)
        marlon_r_if_class_config_channel(&rf_obj, ch, 1);
}

/* hwm_analog_select_active_rf_module (0x8d7584, 358 Б): сделать активными ровно модули
 * mask (из подключённых). Неподключённый mask — журнал 0x101d0a4 и выход; mask уже
 * активен — 0x101d12c. По каждому из 8 модулей m: неподключён и в mask — журнал 0x101d22c;
 * был активен и не в mask — выключение (rfca_cmd_enable(m), hwd_setup_pair(0) = RFC deep
 * power-down, сплиттеры/активация по новой маске, rfca_cmd_enable(новая маска)); не был
 * активен и в mask — включение (сплиттеры/активация по новой маске, rfca_cmd_enable(m),
 * восстановление TX/RX наборов RFC, поле 0x434 = 0x2ec33). В конце новая маска →
 * [RF+0x45e] и [0x800242]; если что-то включали — hwf_rf_config(текущий канал). */
void hwm_analog_select_active_rf_module(u32 mask)
{
    u32 conn = rf_get_connected_mask(&rf_obj);
    u32 act, cur, i;
    u32 n_on = 0, n_off = 0;

    if (!(conn & mask)) {
        fw_log_emit2(0, 0x101d0a4, mask, conn);
        return;
    }
    act = rf_cfg_get_rf_mask_45e(&rf_obj);
    if (act == mask) {
        fw_log_emit2(0x20, 0x101d12c, mask, act);
        return;
    }
    fw_log_emit3(0x20, 0x101d1b4, mask, conn, act);
    cur = act;
    for (i = 0; i < 8; i++) {
        u32 m = (u8)(1u << i);
        u32 want = m & mask;

        if (!(conn & m)) {
            if (want)
                fw_log_emit1(0x20, 0x101d22c, i);
            continue;
        }
        if ((act & m) && !want) {
            hwd_abif_dvs_rfca_cmd_enable(m, 0);
            hwd_setup_pair(0, 0);       /* r1 vendor — мусор после вызова; функция его не читает */
            cur = (u8)(cur & ~m);
            hwd_abif_dvs_if_splitter_enable(cur);
            hwd_abif_dvs_lo_splitter_enable(cur);
            hwd_abif_dvs_rfca_cmd_enable(cur, 0);
            hwd_abif_dvs_rf_activate(cur);
            n_off = (u8)(n_off + 1);
            fw_log_emit2(0x20, 0x101d298, i, cur);
        } else if (!(act & m) && want) {
            cur = (u8)(cur | m);
            hwd_abif_dvs_if_splitter_enable(cur);
            hwd_abif_dvs_lo_splitter_enable(cur);
            hwd_abif_dvs_rf_activate(cur);
            hwd_abif_dvs_rfca_cmd_enable(m, 0);
            rfc_restore_txrx_sets_fw();
            n_on = (u8)(n_on + 1);
            rfc_write_field_434_2ec33();
            fw_log_emit2(0x20, 0x101d2f0, i, cur);
        }
    }
    field_set_0x00_8e6f2c(&rf_obj, cur);
    hwm_analog_save_rfc_enabled(&rf_obj, cur);
    fw_log_emit3(0x20, 0x101d344, cur, conn, mask);
    fw_log_emit2(0x20, 0x101d3c0, n_on, n_off);
    if ((s32)n_on >= 1)
        hwf_rf_config(radio_get_channel(&rf_obj));
}

/* ===================== hwf: секторная цепочка ===================== */

/* hwf_sector_rf_chain_get (0x8d70d4, 128 Б): out[0] = edge phase, out[1] = edge gain цепочки
 * chain; out[2] = dist gain группы chain>>2; out[3] = x16 state (chain>>2)>>2; журналы. */
void hwf_sector_rf_chain_get(u32 rf, u32 sector, u32 tx, u32 chain, u8 *out)
{
    u32 g;

    out[1] = hwd_rfc_read_sector_chain(rf, sector, tx, chain);
    out[0] = (u8)ut_hw_drivers_cmd_0x50f(rf, sector, tx, (s32)chain);
    g = (u8)((s32)chain >> 2);
    out[2] = (u8)hwd_rfc_read_sector_reg(rf, sector, tx, g);
    out[3] = ut_hw_drivers_cmd_0x513(rf, sector, tx, (u32)((s32)g >> 2));
    fw_log_emit3(0x20, 0x101b520, sector, tx, chain);
    fw_log_emit3(0x20, 0x101b570, out[1], out[0], out[2]);
    fw_log_emit1(0x20, 0x101b5c0, out[3]);
}

/* hwf_sector_rf_chain_set (0x8d7154, 514 Б): edge gain и edge phase цепочки chain (без
 * commit: 0xff). dist gain группы g = chain>>2: ненулевой пишется всегда; нулевой — только
 * если у остальных трёх цепочек группы (база chain & 0xfc) edge gain нулевой. x16 state
 * группы g>>2 = (dist_gain != 0): при dist_gain == 0 — только если нулевые dist gain
 * трёх других групп четвёрки (база g & 0xfc).
 * ХРУПКО (vendor): во второй проверке исключается индекс, равный chain (cmp r3/r13/r15/r22
 * с r21 = chain, 0x8d7260..0x8d72a0), а не g — для g ≠ chain читается и сама группа g.
 * Поведение сохранено. Затем commit < 0x10 (знаково): применить сектор + команда
 * 0x508/0x507, журнал 0x101b4c0. */
void hwf_sector_rf_chain_set(u32 rf, u32 sector, u32 tx, u32 chain, u32 edge_gain,
                             u32 edge_phase, u32 dist_gain, s32 commit)
{
    u32 g, g2, x16, b, s;

    hwd_rfc_sector_edge_gain_set(rf, sector, tx, chain, edge_gain, 0xff);
    hwd_rfc_sector_edge_phase_set(rf, sector, tx, (s32)chain, edge_phase, 0xff);
    g = (u8)((s32)chain >> 2);

    s = 0;
    if (dist_gain == 0) {
        b = chain & 0xfcu;
        if (b != chain)
            s += hwd_rfc_read_sector_chain(rf, sector, tx, b);
        if ((u8)(b + 1) != chain)
            s += hwd_rfc_read_sector_chain(rf, sector, tx, (u8)(b + 1));
        if ((u8)(b + 2) != chain)
            s += hwd_rfc_read_sector_chain(rf, sector, tx, (u8)(b + 2));
        if ((u8)(b + 3) != chain)
            s += hwd_rfc_read_sector_chain(rf, sector, tx, (u8)(b + 3));
    }
    if ((s32)s <= 0)                        /* bpnz: пропуск при сумме > 0 */
        hwd_rfc_sector_dist_gain_set(rf, sector, tx, g, dist_gain, 0xff);

    x16 = (dist_gain != 0) ? 1u : 0u;
    g2 = (u8)((s32)g >> 2);
    s = 0;
    if (dist_gain == 0) {
        b = g & 0xfcu;
        if (b != chain)
            s += hwd_rfc_read_sector_reg(rf, sector, tx, b);
        if ((u8)(b + 1) != chain)
            s += hwd_rfc_read_sector_reg(rf, sector, tx, (u8)(b + 1));
        if ((u8)(b + 2) != chain)
            s += hwd_rfc_read_sector_reg(rf, sector, tx, (u8)(b + 2));
        if ((u8)(b + 3) != chain)
            s += hwd_rfc_read_sector_reg(rf, sector, tx, (u8)(b + 3));
    }
    if ((s32)s <= 0)
        hwd_rfc_sector_x16_state_set(rf, sector, tx, g2, x16, 0xff);

    fw_log_emit3(0x20, 0x101b3e4, sector, tx, chain);
    fw_log_emit3(0x20, 0x101b42c, edge_gain, edge_phase, dist_gain);
    fw_log_emit3(0x20, 0x101b474, g, x16, (u32)commit);
    if (commit >= 0x10)
        return;
    if (tx != 0) {
        rf_sector_commit_tx(rf, sector);
        ut_hw_drivers_cmd_0x508(rf, sector, (u32)commit);
    } else {
        rf_sector_commit_rx(rf, sector);
        ut_hw_drivers_cmd_0x507(rf, sector, (u32)commit);
    }
    fw_log_emit1(0x20, 0x101b4c0, sector);
}

/* ===================== sysapi: доступ к RGF RFC по маске модулей ===================== */
/* Объект запроса — struct rfc_rgf_req (include/ut.h; экземпляр 0x80669c готовит UT
 * HW_FLOWS_SYSAPI). */

/* hw_sysapi_rfc_fetch_rgf_util (0x8ce1b4, 380 Б): по каждому модулю mask (по порядку
 * bitmap-итератора): выбрать модуль командой RFCA, прочитать n адресов в результаты
 * (0xdeadbeef — ошибка) либо записать n пар с верификацией (6 попыток). В конце RFCA
 * возвращается к исходной маске. Возврат: 1 — успех, 0 — ошибка чтения/записи,
 * 2 — модуль из mask не подключён, 3 — n·популяция ≥ 0x18 (переполнение 23 результатов). */
u32 hw_sysapi_rfc_fetch_rgf_util(struct rfc_rgf_req *o)
{
    u32 mask = o->rf_mask;
    u32 m, conn, saved, bit, ok = 1, i;
    u16 pop = 0;
    u32 it;

    fw_log_emit0(0x25, 0x101ab40);
    for (m = mask; m != 0; m &= m - 1)
        pop = (u16)(pop + 1);
    conn = rf_get_connected_mask(&rf_obj);
    saved = rfca_get_rf_mask();
    fw_log_emit1(0x25, 0x101ab64, conn);
    if (o->read != 0 && o->count * pop >= 0x18) {   /* mulu64 → mlo (r57), brlo 0x18 */
        fw_log_emit0(5, 0x101ab94);
        return 3;
    }
    if ((conn & mask) != mask) {
        fw_log_emit0(5, 0x101abc0);
        return 2;
    }
    field_set_0x00_8e5dfc(&it, (u8)mask);
    while ((bit = bitmap_alloc_bit(&it)) != 0xffffffffu) {
        hwd_abif_dvs_rfca_cmd_enable((u8)(1u << bit), 0);
        bit = (u8)bit;
        if (o->read != 0) {
            fw_log_emit0(0x25, 0x101abf0);
            ok = 1;
            for (i = 0; i < o->count; i++) {
                u32 v = hwd_rfc_read_rgf(bit, o->regs[i]);
                u32 k = o->nres;
                o->out[k] = v;
                o->nres = k + 1;
                if (v == 0xdeadbeefu) {
                    fw_log_emit0(0x25, 0x101ac38);
                    ok = 0;
                    break;
                }
            }
            if (ok)
                fw_log_emit0(0x25, 0x101ac08);
        } else {
            fw_log_emit0(0x25, 0x101ac68);
            ok = 1;
            for (i = 0; i < o->count * 2; i += 2) {
                if (hwd_rfc_write_verify(bit, o->regs[i], o->regs[i + 1], 6) == 0) {
                    fw_log_emit0(0x25, 0x101ac84);
                    ok = 0;
                    break;
                }
            }
            if (ok)
                fw_log_emit0(0x25, 0x101acb4);
        }
        if (!ok) {
            fw_log_emit1(5, 0x101ace8, 0);
            break;
        }
    }
    hwd_abif_dvs_rfca_cmd_enable(saved, 0);
    fw_log_emit1(0x25, 0x101ad18, ok);
    return ok;
}

/* [0x8ce3a8] колбэк радио-запроса hw_sysapi_rfc_read_write_rgf (60 Б; vendor передаёт его
 * числом 0xe3a8 — у нас адрес функции, как в temp_service.c): выполнить fetch, статус в
 * ответ +4; при чтении — 0x5c байт результатов (+0x74 запроса) в ответ +8, длина 0x64,
 * иначе 8; событие UT; освободить радио, снять флаг занятости [0x8004f8]. */
static void hw_sysapi_rfc_radio_locked_cb(struct rm_req *radio, u32 obj)
{
    struct rfc_rgf_req *o = (struct rfc_rgf_req *)obj;
    struct ut_rsp *resp;
    u32 len = 8;

    fw_log_emit0(0x25, 0x101ad48);
    resp = o->rsp;
    resp->status = hw_sysapi_rfc_fetch_rgf_util(o);
    if (o->read != 0) {
        memcpy_fw(resp->data, o->out, 0x5c);
        len = 0x64;
    }
    wmi_evt_send_words(o->host_if, resp, (u16)len);
    radio_mgr_call_method_10(radio);
    rf_sysapi_rfc_req = 0;
    fw_log_emit0(0x25, 0x101ad70);
}

/* hw_sysapi_rfc_read_write_rgf (0x8ce330, 118 Б): поставить запрос радио (колбэк выше,
 * obj, 0, 0xffff, 0); дескриптор → [0x8004f8]. Возврат: 5 — запрос поставлен (ответ придёт
 * из колбэка), 4 — уже занят (журнал 0x101a69c) или запрос не принят (0x101a62c).
 * Чтение маски 0x45e в начале — как у vendor (результат не используется). */
u32 hw_sysapi_rfc_read_write_rgf(struct rfc_rgf_req *obj)
{
    u32 h;

    (void)rf_cfg_get_rf_mask_45e(&rf_obj);
    fw_log_emit1(0x20, 0x101a5f8, obj->rf_mask);
    if (rf_sysapi_rfc_req != 0) {
        fw_log_emit0(0x15, 0x101a69c);
        return 4;
    }
    h = (u32)radio_mgr_request(hw_sysapi_rfc_radio_locked_cb, (u32)obj, 0, 0xffff, 0);
    rf_sysapi_rfc_req = h;
    if (h == 0) {
        fw_log_emit0(5, 0x101a62c);
        return 4;
    }
    fw_log_emit1(0x25, 0x101a660, h);
    return 5;
}

/* ===================== rf_chain: дескрипторы MACQ ===================== */

/* rf_chain__zero_and_program (0x8ea398, 30 Б): обнулённый 16-байтный дескриптор →
 * macq_desc__write_type6(desc, v). */
void rf_chain_zero_and_program(u32 v)
{
    u32 d[4];

    memset0_words(d, 0x10);
    macq_desc_write_type6(d, v);
}

/* rf_chain__bits_set32_s22_w2 (0x8ed448, 12 Б): *p биты 22..23 = v (bf__set_field_word_fw
 * 0x8edcb8, r10 = 22, r11 = 1 → ширина 2). */
void rf_chain_bits_set32_s22_w2(u32 *p, u32 v)
{
    *p = bf_put(*p, 22, 2, v);
}

/* rf_chain__bits_set32_s29_w2 (0x8ed4b4, 12 Б): *p биты 29..30 = v (r10 = 0x1d, r11 = 1). */
void rf_chain_bits_set32_s29_w2(u32 *p, u32 v)
{
    *p = bf_put(*p, 29, 2, v);
}
