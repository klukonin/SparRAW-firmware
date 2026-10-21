// SPDX-License-Identifier: AGPL-3.0-or-later
/* Движок калибровки (порт vendor 6.2.0.1000): автомат движка (описатель 0x802234),
 * общие методы классов калибровки (estimation_alg и окружение, таблицы методов
 * 0x800604/0x800634/0x800664/0x800694/0x8006c4/0x80072c) и CALIB_MNGR — запуск схем
 * калибровки по системному состоянию, периодические таймеры схем.
 * Раскладка объектов — include/calib_engine.h.
 *
 * Шесть движков: автоматы calib_mngr.eng[i] (0x804944 + i * 0x44), объект класса
 * калибровки calib_engine_objs[i] (0 SAR, 1 VGA/bb_gain_dc, 2 IF gain, 3 LO leakage,
 * 4 silent RSSI, 5 LO power).
 * События (таблица 0x802248, индекс = событие * 4 + состояние): CE_EV_*; состояния CE_ST_*.
 * Вердикт оценки (calib_engine.est.verdict): CALIB_EST_*.
 *
 * Схемы CALIB_MNGR: calib_schemes (0x800e2c, 5 × 0x4c). Номер схемы — calib_scheme_idx
 * [pcp_ap][состояние] (0x800fa8, 2 x 5 слов). Флаги движков calib_mngr.scheme_active,
 * таймеры calib_mngr.timer. */
#include "types.h"
#include "fwdata.h"
#include "calib.h"
#include "calib_engine.h"
#include "rf_obj.h"
#include "radio_mgr.h"


static inline void *caller(void) { return __builtin_return_address(0); }

/* ======================= объекты по фиксированным адресам ======================= */

/* 0x800da4: объекты классов калибровки движков 0..5 (calib__get_engine_by_index 0x8cbb84).
 * В DCCM, не const: vendor читает таблицу из памяти (gcc не должен сворачивать). */
FWDATA(800da4) struct calib_obj *calib_engine_objs[CALIB_ENG_NUM] = {
    &calib_sar_obj, &calib_vga_obj, &calib_if_gain_obj, &calib_lo_leakage_obj,
    &calib_silent_rssi_obj.base, &calib_lo_power_obj.base,
};

/* 0x804924: CALIB_MNGR (в образе нули; автоматы — ctor_calib_engines, calib_engine_init_all). */
FWDATA(804924) struct calib_mngr calib_mngr = { 0 };

/* 0x804b5c: объект silent RSSI (в образе нули; calib_silent_rssi_ctor). */
FWDATA(804b5c) struct calib_silent_rssi calib_silent_rssi_obj = { 0 };

/* 0x80676c: объект LO power полной калибровки hwf_calib_all (в образе нули;
 * таблица методов — ctor_obj_80676c_vtable). */
FWDATA(80676c) struct calib_lo_power calib_all_lo_power_obj = { 0 };

/* 0x800e2c: схемы калибровки (значения — vendor-образ). */
FWDATA(800e2c) struct calib_scheme calib_schemes[5] = {
    { 0, { { 2, 0, 0, 0 }, { 2, 0, 0, 0 }, { 2, 0, 0, 0 },
           { 2, 0, 0, 0 }, { 2, 0, 0, 0 }, { 2, 0, 0, 0 } } },
    { 1, { { 3, 0, 0, 0 }, { 3, 0, 0, 0 }, { 3, 0, 0, 0 },
           { 2, 0, 0, 0 }, { 3, 0, 0, 0 }, { 2, 0, 0, 0 } } },
    { 1, { { 2, 0, 0, 0 }, { 2, 0, 0, 0 }, { 2, 0, 0, 0 },
           { 2, 0, 0, 0 }, { 3, 0x100000, 0, 0 }, { 2, 0, 0, 0 } } },
    { 0, { { 3, 0x100051, 500, 0 }, { 0xf, 0x100055, 500, 100 }, { 3, 0x100051, 500, 0 },
           { 2, 0, 0, 0 }, { 3, 0x105002, 500, 25 }, { 3, 0x100007, 500, 0 } } },
    { 0, { { 3, 0x100051, 500, 0 }, { 0xf, 0x100055, 500, 100 }, { 3, 0x100051, 500, 0 },
           { 2, 0, 0, 0 }, { 3, 0x5002, 500, 0 }, { 3, 0x7, 500, 0 } } },
};

/* 0x800fa8: номер схемы [pcp_ap][системное состояние]. */
FWDATA(800fa8) u32 calib_scheme_idx[2][5] = { { 1, 2, 3, 0, 3 }, { 1, 1, 3, 4, 3 } };

/* 0x800fd0 / 0x800fe0: пороги температурных состояний LO power (BB / RF), °C. */
FWDATA(800fd0) struct calib_temp_thr calib_lo_power_bb_thr = { -30, 0, 85, 75 };
FWDATA(800fe0) struct calib_temp_thr calib_lo_power_rf_thr = { -30, 0, 200, 190 };

/* ======================= методы классов калибровки ======================= */

/* basic_calib::estimation_pre (0x8ca21c): [vt+8] всех классов — пусто. */
void basic_calib_estimation_pre(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
}

/* basic_calib::estimation_post (0x8ca224): [vt+0x10] всех классов — пусто. */
void basic_calib_estimation_post(struct calib_obj *obj, u32 mask)
{
    (void)obj; (void)mask;
}

/* basic_calib::is_temperature_changed (0x8c646c): [vt+0x14] — 1, если |cur - *last| >= thr
 * (беззнаково; порог — знаковый байт маски, отрицательный не срабатывает никогда) или
 * прежнего значения нет (*last == -1). */
u32 basic_calib_is_temperature_changed(struct calib_obj *obj, u32 thr, s32 cur,
                                                         s32 *last)
{
    s32 prev = *last;
    s32 d = cur - prev;

    (void)obj;
    if (d < 0)
        d = -d;                                 /* abs_s */
    if ((u32)d >= thr)
        return 1;
    return prev == -1;
}

/* basic_calib_check_g8000a4 (0x8cb91c): температура BB [gp,-0x38] = 0x8000a4 (м°C);
 * при a == 1 и известной температуре — в °C (знаковое деление на 1000). */
s32 basic_calib_get_bb_temperature(u32 a)
{
    s32 v = (s32)temp_bb_mdeg;
    if (a == 1 && v != -1)
        return fw_divmod_signed(v, 1000);
    return v;
}

/* Флаг «нужен захват радио» [vt+0x24]: у всех шести классов — отдельная копия
 * `j_s.d [blink]; mov_s r0,1` (вердикт 3, коррекция только с захваченным радио). */

/* calib_sar::is_radio_lock_needed (0x8ed5b4): calib_sar_vtbl. */
u32 calib_sar_is_radio_lock_needed(struct calib_obj *obj)
{
    (void)obj;
    return 1;
}

/* class_calib_lo_power::is_radio_lock_needed (0x8ed5b8): calib_lo_power_vtbl. */
u32 calib_lo_power_is_radio_lock_needed(struct calib_obj *obj)
{
    (void)obj;
    return 1;
}

/* calib_lo_leakage::is_radio_lock_needed (0x8ed5bc): calib_lo_leakage_vtbl. */
u32 calib_lo_leakage_is_radio_lock_needed(struct calib_obj *obj)
{
    (void)obj;
    return 1;
}

/* calib_if_gain::is_radio_lock_needed (0x8ed5c0): calib_if_gain_vtbl. */
u32 calib_if_gain_is_radio_lock_needed(struct calib_obj *obj)
{
    (void)obj;
    return 1;
}

/* calib_bb_gain_dc::is_radio_lock_needed (0x8ed5c4): calib_vga_vtbl. */
u32 calib_vga_is_radio_lock_needed(struct calib_obj *obj)
{
    (void)obj;
    return 1;
}

/* calib_silent_rssi_sparrow::is_radio_lock_needed (0x8ed5c8): calib_silent_rssi_vtbl. */
u32 calib_silent_rssi_is_radio_lock_needed(struct calib_obj *obj)
{
    (void)obj;
    return 1;
}

/* basic_calib::check_online_estimation_condition (0x8c6298): [vt+0x28] — условия онлайн-
 * оценки нет (0). Классы SAR, IF gain, LO leakage, LO power. */
u32 basic_calib_check_online_estimation_condition(struct calib_obj *obj)
{
    (void)obj;
    return 0;
}

/* calib_bb_gain_dc::check_online_estimation_condition (0x8c629c): calib_vga_vtbl —
 * разовый запрос G_RX_VGA_RANGE_CONFIG.VGA_DC_FINE_FORCE ([0x800514] == 1): снять, 1. */
u32 calib_bb_gain_dc_check_online_estimation_condition(struct calib_obj *obj)
{
    (void)obj;
    if (calib_vga_dc_fine_force != 1)
        return 0;
    fw_log_emit0(0x26, 0x100a1f4);
    calib_vga_dc_fine_force = 0;
    return 1;
}

/* basic_calib::set_fragments_num (0x8ed5d4): [vt+0x2c] — число фрагментов не задано
 * (out->nfrag = -1: остаётся calib_engine.nfrag из схемы). */
void basic_calib_set_fragments_num(struct calib_obj *obj, u32 mask,
                                                     struct calib_est *out)
{
    (void)obj; (void)mask;
    out->nfrag = 0xffffffffu;
}

/* calib_silent_rssi_sparrow::set_fragments_num (0x8cc200): calib_silent_rssi_vtbl — при
 * условиях из старших 12 бит маски — (число RF в out->rf_mask) + 1, иначе 1. */
void calib_silent_rssi_set_fragments_num(struct calib_obj *obj, u32 mask,
                                                           struct calib_est *out)
{
    u32 n = 1;

    (void)obj;
    if (mask & 0xfff00000u) {
        u32 m = out->rf_mask;
        n = 0;
        while (m) {
            m &= m - 1;
            n = (u16)(n + 1);
        }
        n += 1;
    }
    out->nfrag = n;
}

/* Общая часть estimation_alg классов (basic_calib_sparrow и silent RSSI): условия маски — бит 0 BB-температура
 * (порог — байт маски >> 4), бит 1 температура RF (порог — байт >> 12), бит 2 онлайн-
 * условие класса [vt+0x28]. obj->bb_temp — последняя BB-температура, obj->rf_temp[i] — RF[i].
 * forced != 0 (только silent RSSI): ненулевая одноразовая маска RF *forced
 * (до проверки бита 1) заменяет проверку температуры RF. tok — журнал {BB, RF, онлайн}. */
static u32 calib_estimate_conditions(struct calib_obj *obj, u32 mask, struct calib_est *out,
                                     s32 bb, volatile u32 *forced, const u32 *tok, u32 code)
{
    u32 bb_hit = 0, rf_hit = 0, online = 0, it, i, v;

    if (mask & 1) {
        bb_hit = obj->vt->is_temperature_changed(obj, (u32)(s32)(s8)(mask >> 4), bb,
                                                 &obj->bb_temp);
        if (bb_hit) {
            obj->bb_temp = bb;
            fw_log_emit1(0x26, tok[0], (u32)bb);
        }
    }
    if (forced != 0 && (v = *forced) != 0) {
        out->rf_mask = (u8)v;
        fw_log_emit1(0x26, 0x1009fd8, (u8)v);
        *forced = 0;
        rf_hit = 1;
    } else if (mask & 2) {
        field_set_0x00_8e5dfc(&it, rf_cfg_get_rf_mask_45e(&rf_obj));
        while (bit_iter_has_more(&it)) {
            i = bitmap_alloc_bit(&it);
            if (i >= 8)
                fw_sysassert_fatal(caller(), code);     /* vendor продолжает с этим i */
            u32 t = temp_get_rf_by_index(i, 1);
            if (obj->vt->is_temperature_changed(obj, (u32)(s32)(s8)(mask >> 12), (s32)t,
                                                &obj->rf_temp[i])) {
                out->rf_mask |= (u8)(1u << i);
                obj->rf_temp[i] = (s32)t;
                fw_log_emit2(0x26, tok[1], i, t);
                rf_hit = 1;
            }
        }
    }
    if (mask & 4) {
        online = obj->vt->check_online_estimation_condition(obj);
        if (online)
            fw_log_emit0(0x26, tok[2]);
    }
    return (bb_hit || rf_hit || online) ? 1 : 0;
}

/* Хвост estimation_alg: при нужде в коррекции — число фрагментов [vt+0x2c] и вердикт по
 * [vt+0x24] (0 → 2, 1 → 3, иначе ассерт code), иначе вердикт 1. */
static void calib_estimate_verdict(struct calib_obj *obj, u32 mask, struct calib_est *out,
                                   u32 need, u32 code)
{
    if (need != 1) {
        out->verdict = CALIB_EST_NONE;
        return;
    }
    obj->vt->set_fragments_num(obj, mask, out);
    u32 r = obj->vt->is_radio_lock_needed(obj);
    if (r == 0)
        out->verdict = CALIB_EST_CORRECT;
    else if (r == 1)
        out->verdict = CALIB_EST_CORRECT_LOCKED;
    else
        fw_sysassert_fatal(caller(), code);
}

/* basic_calib_sparrow::estimation_alg (0x8c9dd8): [vt+0xc] классов SAR, VGA, IF gain,
 * LO leakage — нужна ли коррекция (по маске условий; без условий — нужна всегда).
 * out: вердикт и маска RF, изменивших температуру. Возврат — нужна ли (0/1). */
u32 basic_calib_sparrow_estimation_alg(struct calib_obj *obj, u32 mask,
                                                         struct calib_est *out)
{
    static const u32 tok[3] = {0x100a104, 0x100a158, 0x100a1a8};
    u32 need = 1;

    out->verdict = 0;
    out->rf_mask = 0;
    s32 bb = basic_calib_get_bb_temperature(1);
    if (mask & 7)
        need = calib_estimate_conditions(obj, mask, out, bb, 0, tok, 0x1484);
    calib_estimate_verdict(obj, mask, out, need, 0x12e7);
    return need;
}

/* calib_silent_rssi_sparrow::estimation_alg (0x8ca06c): calib_silent_rssi_vtbl — как
 * basic_calib_sparrow, но принудительная маска RF [gp,-0x184] = 0x800000 (одноразовая:
 * берётся в out->rf_mask и обнуляется) заменяет проверку температуры RF. */
u32 calib_silent_rssi_sparrow_estimation_alg(struct calib_obj *obj, u32 mask,
                                                               struct calib_est *out)
{
    static const u32 tok[3] = {0x1009f7c, 0x100a010, 0x100a064};
    u32 need = 1;

    out->verdict = 0;
    out->rf_mask = 0;
    s32 bb = basic_calib_get_bb_temperature(1);
    if (mask & 7)
        need = calib_estimate_conditions(obj, mask, out, bb, &calib_silent_rssi_forced_rf_mask,
                                         tok, 0x1485);
    calib_estimate_verdict(obj, mask, out, need, 0x1564);
    return need;
}

/* class_calib_lo_power::change_state_by_temperature (0x8c5c68): температурное состояние
 * LO power (CALIB_LO_POWER_*) с гистерезисом; пороги {room_to_low, low_to_room,
 * room_to_high, high_to_room} (знаковые сравнения). */
static u32 calib_lo_power_change_state_by_temperature(struct calib_lo_power *obj, s32 cur, u32 st,
                                                      s32 room_to_low, s32 low_to_room,
                                                      s32 room_to_high, s32 high_to_room)
{
    (void)obj;
    switch (st) {
    case CALIB_LO_POWER_ROOM:
        if (cur > room_to_high) {
            fw_log_emit2(0x26, 0x100a4e4, (u32)cur, (u32)room_to_high);
            return CALIB_LO_POWER_HIGH;
        }
        if (cur < room_to_low) {
            fw_log_emit2(0x26, 0x100a550, (u32)cur, (u32)room_to_low);
            return CALIB_LO_POWER_LOW;
        }
        return CALIB_LO_POWER_ROOM;
    case CALIB_LO_POWER_HIGH:
        if (cur < high_to_room) {
            fw_log_emit2(0x26, 0x100a5b8, (u32)cur, (u32)high_to_room);
            return CALIB_LO_POWER_ROOM;
        }
        return CALIB_LO_POWER_HIGH;
    case CALIB_LO_POWER_LOW:
        if (cur > low_to_room) {
            fw_log_emit2(0x26, 0x100a47c, (u32)cur, (u32)low_to_room);
            return CALIB_LO_POWER_ROOM;
        }
        return CALIB_LO_POWER_LOW;
    default:
        fw_log_emit1(6, 0x100a428, st);
        fw_sysassert_fatal(caller(), 0x142d);
        return st;
    }
}

/* class_calib_lo_power::estimation_alg (0x8c9f60): calib_lo_power_vtbl — температурные
 * состояния BB (bb_state, пороги calib_lo_power_bb_thr) и RF[i] (rf_state[i], пороги
 * calib_lo_power_rf_thr; температура RF в base.rf_temp[i]). Коррекция (вердикт 3) — при
 * смене общего режима mode (1 — хоть одно состояние не ROOM). Маска условий не используется. */
u32 class_calib_lo_power_estimation_alg(struct calib_obj *o, u32 mask,
                                                          struct calib_est *out)
{
    struct calib_lo_power *obj = (struct calib_lo_power *)o;
    const struct calib_temp_thr *tb = &calib_lo_power_bb_thr, *tr = &calib_lo_power_rf_thr;
    u32 it, i, mode, changed;

    (void)mask;
    out->verdict = CALIB_EST_NONE;
    out->rf_mask = 0;
    obj->base.bb_temp = basic_calib_get_bb_temperature(1);
    obj->bb_state = calib_lo_power_change_state_by_temperature(obj, obj->base.bb_temp,
                                                               obj->bb_state, tb->room_to_low,
                                                               tb->low_to_room, tb->room_to_high,
                                                               tb->high_to_room);
    if (obj->base.bb_temp == -1)
        return 0;
    field_set_0x00_8e5dfc(&it, rf_cfg_get_rf_mask_45e(&rf_obj));
    while (bit_iter_has_more(&it)) {
        i = bitmap_alloc_bit(&it);
        if (i >= 8)
            continue;
        u32 t = temp_get_rf_by_index(i, 1);
        obj->base.rf_temp[i] = (s32)t;
        if (t == 0xffffffffu) {
            fw_log_emit1(0x16, 0x100a340, i);
            continue;
        }
        u32 st = calib_lo_power_change_state_by_temperature(obj, (s32)t, obj->rf_state[i],
                                                            tr->room_to_low, tr->low_to_room,
                                                            tr->room_to_high, tr->high_to_room);
        obj->rf_state[i] = st;
        if (st != CALIB_LO_POWER_ROOM)
            out->rf_mask |= (u8)(1u << i);
    }
    mode = (obj->bb_state != CALIB_LO_POWER_ROOM || out->rf_mask != 0) ? 1 : 0;
    changed = 0;
    if (mode != obj->mode) {
        obj->mode = mode;
        changed = 1;
        fw_log_emit2(0x26, 0x100a3b8, (u32)obj->base.bb_temp, mode);
    }
    out->verdict = (changed == 1) ? CALIB_EST_CORRECT_LOCKED : CALIB_EST_NONE;
    return changed;
}

/* ======================= автомат движка (описатель 0x802234) ======================= */

/* автомат движка: описатель 0x802234 и таблица переходов 0x802248 (vendor sm_802234) */
/* 0x802248: таблица переходов [событие][состояние] (6 × 4). */
FWDATA(802248) const struct sm_trans calib_engine_sm_table[6][4] = {
    [CE_EV_START][CE_ST_IDLE] = { SM_ACT(calib_engine_on_start), CE_ST_CHECK_CORRECTION_NEEDED },
    [CE_EV_START][CE_ST_CHECK_CORRECTION_NEEDED] = { SM_ACT(basic_sm_error_handler), CE_ST_CHECK_CORRECTION_NEEDED },
    [CE_EV_START][CE_ST_WAIT_FOR_RADIO_LOCK] = { SM_ACT(basic_sm_error_handler), CE_ST_WAIT_FOR_RADIO_LOCK },
    [CE_EV_START][CE_ST_CORRECTION] = { SM_ACT(basic_sm_error_handler), CE_ST_CORRECTION },
    [CE_EV_READY_FOR_CORRECTION][CE_ST_IDLE] = { SM_ACT(basic_sm_error_handler), CE_ST_IDLE },
    [CE_EV_READY_FOR_CORRECTION][CE_ST_CHECK_CORRECTION_NEEDED] = { SM_ACT(calib_engine_on_ready_for_correction), CE_ST_CORRECTION },
    [CE_EV_READY_FOR_CORRECTION][CE_ST_WAIT_FOR_RADIO_LOCK] = { SM_ACT(calib_engine_on_ready_for_correction), CE_ST_CORRECTION },
    [CE_EV_READY_FOR_CORRECTION][CE_ST_CORRECTION] = { SM_ACT(basic_sm_error_handler), CE_ST_CORRECTION },
    [CE_EV_LOCK_RADIO][CE_ST_IDLE] = { SM_ACT(basic_sm_error_handler), CE_ST_IDLE },
    [CE_EV_LOCK_RADIO][CE_ST_CHECK_CORRECTION_NEEDED] = { SM_ACT(calib_engine_on_lock_radio), CE_ST_WAIT_FOR_RADIO_LOCK },
    [CE_EV_LOCK_RADIO][CE_ST_WAIT_FOR_RADIO_LOCK] = { SM_ACT(basic_sm_error_handler), CE_ST_WAIT_FOR_RADIO_LOCK },
    [CE_EV_LOCK_RADIO][CE_ST_CORRECTION] = { SM_ACT(basic_sm_error_handler), CE_ST_CORRECTION },
    [CE_EV_FRAG_DONE][CE_ST_IDLE] = { SM_ACT(basic_sm_error_handler), CE_ST_IDLE },
    [CE_EV_FRAG_DONE][CE_ST_CHECK_CORRECTION_NEEDED] = { SM_ACT(basic_sm_error_handler), CE_ST_CHECK_CORRECTION_NEEDED },
    [CE_EV_FRAG_DONE][CE_ST_WAIT_FOR_RADIO_LOCK] = { SM_ACT(basic_sm_error_handler), CE_ST_WAIT_FOR_RADIO_LOCK },
    [CE_EV_FRAG_DONE][CE_ST_CORRECTION] = { SM_ACT(calib_engine_on_frag_done), CE_ST_CHECK_CORRECTION_NEEDED },
    [CE_EV_CALIB_DONE][CE_ST_IDLE] = { SM_ACT(basic_sm_error_handler), CE_ST_IDLE },
    [CE_EV_CALIB_DONE][CE_ST_CHECK_CORRECTION_NEEDED] = { SM_ACT(calib_engine_on_calib_done), CE_ST_IDLE },
    [CE_EV_CALIB_DONE][CE_ST_WAIT_FOR_RADIO_LOCK] = { SM_ACT(basic_sm_error_handler), CE_ST_WAIT_FOR_RADIO_LOCK },
    [CE_EV_CALIB_DONE][CE_ST_CORRECTION] = { SM_ACT(basic_sm_error_handler), CE_ST_CORRECTION },
    [CE_EV_ABORT][CE_ST_IDLE] = { SM_ACT(sm_action_nop_b), CE_ST_IDLE },
    [CE_EV_ABORT][CE_ST_CHECK_CORRECTION_NEEDED] = { SM_ACT(calib_engine_on_abort), CE_ST_IDLE },
    [CE_EV_ABORT][CE_ST_WAIT_FOR_RADIO_LOCK] = { SM_ACT(calib_engine_on_abort), CE_ST_IDLE },
    [CE_EV_ABORT][CE_ST_CORRECTION] = { SM_ACT(calib_engine_on_abort), CE_ST_IDLE },
};

/* 0x802234: описатель (ид [0x10] пишет конструктор). */
extern const u32 calib_eng_sm_state_names[4];   /* определение ниже */
extern const u32 calib_eng_sm_event_names[6];   /* определение ниже */
FWDATA(802234) struct sm_desc calib_engine_sm_desc = {
    .n_events = 6, .n_states = 4, .init_state = CE_ST_IDLE,
    .table = &calib_engine_sm_table[0][0],
    .state_names = calib_eng_sm_state_names, .event_names = calib_eng_sm_event_names,
};

/* basic_calib_sparrow__estimation_alg (0x8c9da0): оценка необходимости коррекции —
 * [vt+8] (obj, mask), r = [vt+0xc] (obj, mask, out), [vt+0x10] (obj, mask). */
static u32 calib_engine_estimate(struct calib_obj *obj, u32 mask, struct calib_est *out)
{
    obj->vt->estimation_pre(obj, mask);
    u32 r = obj->vt->estimation_alg(obj, mask, out);
    obj->vt->estimation_post(obj, mask);
    return r;
}

/* calib_engine__on_start (0x8c9d2c): START в IDLE → CHECK_CORRECTION_NEEDED. Оценка;
 * по вердикту — CALIB_DONE (1), READY_FOR_CORRECTION (2 или разовый запуск) или
 * LOCK_RADIO (3). Счётчик стартов calib_eng_stats[idx * CE_STAT_NUM + CE_STAT_STARTS]. */
void calib_engine_on_start(struct calib_engine *sm)
{
    u32 ev, st;

    (void)u_schd_now();             /* vendor зовёт и результат не использует */
    if (calib_engine_estimate(sm->obj, sm->mask, &sm->est) != 0
        && sm->est.nfrag != 0xffffffffu)
        sm->nfrag = sm->est.nfrag;
    calib_eng_stats[sm->idx * CE_STAT_NUM + CE_STAT_STARTS] += 1;
    st = sm->est.verdict;
    if (st == CALIB_EST_NONE) {
        ev = CE_EV_CALIB_DONE;
    } else if (st == CALIB_EST_CORRECT || sm->periodic == 0) {
        ev = CE_EV_READY_FOR_CORRECTION;
    } else if (st == CALIB_EST_CORRECT_LOCKED) {
        ev = CE_EV_LOCK_RADIO;
    } else {
        fw_sysassert_fatal(caller(), 0x12e6);
        return;
    }
    sm_defer_call(sm, ev, 0, 0, 0);
}

/* calib_engine__radio_locked_cb (0x8e4eb8): колбэк радио-менеджера cb(req, sm) — радио
 * захвачено: READY_FOR_CORRECTION (чужой запрос — ассерт 0x108b). */
static void calib_engine_radio_locked_cb(struct rm_req *req, u32 arg)
{
    struct calib_engine *sm = (struct calib_engine *)arg;

    if (req != sm->radio_req)
        fw_sysassert_fatal(caller(), 0x108b);
    basic_sm_handle_event(sm, CE_EV_READY_FOR_CORRECTION, 0, 0, 0);
}


/* calib_engine__on_lock_radio (0x8dca54): LOCK_RADIO в CHECK_CORRECTION_NEEDED →
 * WAIT_FOR_RADIO_LOCK: запросить радио (любой канал 0xffff). */
void calib_engine_on_lock_radio(struct calib_engine *sm)
{
    if (sm->periodic != 1)
        fw_sysassert_fatal(caller(), 0x1205);
    if (sm->radio_req != 0)
        fw_sysassert_fatal(caller(), 0x11bc);
    sm->radio_req = radio_mgr_request(calib_engine_radio_locked_cb, (u32)sm, 0, 0xffff, 0);
}

/* calib_engine__frag_pause_expired (0x8d9c1c): таймер паузы между фрагментами — снова
 * захватить радио (LOCK_RADIO). */
static void calib_engine_frag_pause_expired(u32 a0, u32 a1)
{
    struct calib_engine *sm = (struct calib_engine *)a0;

    (void)a1;
    sm->pause_timer = 0;
    basic_sm_handle_event(sm, CE_EV_LOCK_RADIO, 0, 0, 0);
}

/* calib_engine__on_frag_done (0x8c5f78): FRAG_DONE в CORRECTION → CHECK_CORRECTION_NEEDED.
 * Отпустить радио; все фрагменты сделаны — CALIB_DONE (счётчик CE_STAT_DONE); иначе (только
 * для вердикта 3) — таймер паузы pause_s с до следующего захвата радио. */
void calib_engine_on_frag_done(struct calib_engine *sm)
{
    if (sm->radio_req != 0) {
        radio_mgr_call_method_10(sm->radio_req);
        sm->radio_req = 0;
    }
    if (sm->frag == sm->nfrag) {
        calib_eng_stats[sm->idx * CE_STAT_NUM + CE_STAT_DONE] += 1;
        sm_defer_call(sm, CE_EV_CALIB_DONE, 0, 0, 0);
        return;
    }
    if (sm->est.verdict != CALIB_EST_CORRECT_LOCKED) {
        fw_sysassert_fatal(caller(), 0x12e5);
        return;
    }
    if (sm->frag == 0)
        fw_sysassert_fatal(caller(), 0x1206);
    if (sm->pause_timer != 0)
        fw_sysassert_fatal(caller(), 0x1209);
    sm->pause_timer = u_schd_schedule(calib_engine_frag_pause_expired, (u32)sm, 0, 0,
                                      (u32)sm->pause_s * 1000u, 0, 0);
}

/* calib_engine__on_calib_done (0x8c562c): CALIB_DONE в CHECK_CORRECTION_NEEDED → IDLE —
 * колбэк завершения done_cb(cb_a0, cb_a1). */
void calib_engine_on_calib_done(struct calib_engine *sm)
{
    calib_done_fn cb = sm->done_cb;
    if (cb != 0)
        cb(sm->cb_a0, sm->cb_a1);
}

/* calib_engine__on_abort (0x8c1d74): ABORT в CHECK_CORRECTION_NEEDED / WAIT_FOR_RADIO_LOCK /
 * CORRECTION → IDLE — снять запрос радио и таймер паузы. */
void calib_engine_on_abort(struct calib_engine *sm)
{
    if (sm->radio_req != 0) {
        radio_mgr_remove_request(sm->radio_req);
        sm->radio_req = 0;
    }
    if (sm->pause_timer != 0) {
        u_schd_cancel(sm->pause_timer);
        sm->pause_timer = 0;
    }
}

/* ======================= CALIB_MNGR: схемы калибровки ======================= */

/* calib_mngr__engine_step (0x8e79c0): запуск движка (должен быть IDLE, ассерт 0x1087;
 * разовый запуск — только с одним фрагментом, ассерт 0x1280): параметры, START.
 * Не static: зовёт и calib_mngr__engine_start (0x8ca25c) в wmi_h_bf.c. */
void calib_mngr_engine_step(struct calib_engine *eng, u32 mask, u32 periodic, u32 nfrag,
                            u32 pause, calib_done_fn cb, u32 cb_a0, u32 cb_a1)
{
    /* volatile: порядок записей полей — как у vendor (0x8e79e4..0x8e7a0e); без него gcc
     * переносит обнуления вперёд. */
    volatile struct calib_engine *sm = eng;

    if (sm->hdr.state != CE_ST_IDLE)
        fw_sysassert_fatal(caller(), 0x1087);
    if (periodic == 0 && nfrag != 1)
        fw_sysassert_fatal(caller(), 0x1280);
    sm->mask = mask;
    sm->periodic = periodic;
    sm->nfrag = nfrag;
    sm->pause_s = (u16)pause;
    sm->done_cb = cb;
    sm->cb_a0 = cb_a0;
    sm->cb_a1 = cb_a1;
    sm->frag = 0;
    sm->est.verdict = 0;
    sm->est.rf_mask = 0;
    sm->pause_timer = 0;
    sm->radio_req = 0;
    basic_sm_handle_event(eng, CE_EV_START, 0, 0, 0);
}

/* calib_mngr__engine_start (0x8ca25c, 116 Б): только на ASIC. Движок idx (автомат
 * calib_mngr.eng[idx], mul64 idx,68) свободен (байт состояния 0) — запуск
 * (calib_mngr__engine_step); занят — журнал с именем движка (строка — указатель
 * calib_engine_names[idx], ld.as). На FPGA — ничего. Зовут WMI_UNIT_TEST calib_mgr_ut
 * (wmi_h_misc.c) и calib__start_scheme4 (wmi_h_bf.c). */
void calib_mngr_engine_start(u32 idx, u32 mask, u32 periodic, u32 nfrag, u32 pause,
                             calib_done_fn cb, u32 cb_a0, u32 cb_a1)
{
    struct calib_engine *sm;
    if (platform_is_asic() == 0)
        return;
    sm = &calib_mngr.eng[idx];
    if (sm->hdr.state == CE_ST_IDLE)
        calib_mngr_engine_step(sm, mask, periodic, nfrag, pause, cb, cb_a0, cb_a1);
    else
        fw_log_emit_str1(0x26, 0x1009364, calib_engine_names[idx]);   /* «Engine of %s is already active» */
}

/* calib_cfg__get_scheme (0x8cc6bc): схема калибровки для режима PCP/AP (0/1, иначе ассерт
 * 0x11c7 → строка 0) и состояния st (< 5, иначе ассерт 0x11c8 → индекс st всё равно):
 * &calib_schemes[calib_scheme_idx[pcp_ap][st]]. */
struct calib_scheme *calib_cfg_get_scheme(u32 pcp_ap, u32 st)
{
    u32 row = 0;

    if (st >= 5)
        fw_sysassert_fatal(caller(), 0x11c8);
    if (pcp_ap == 1)
        row = 1;
    else if (pcp_ap != 0)
        fw_sysassert_fatal(caller(), 0x11c7);
    return &calib_schemes[calib_scheme_idx[row][st]];
}

static void calib_mngr_schedule_scheme_step(u32 i, const struct calib_scheme_entry *e, u32 first);

/* calib_mngr__engine_done_cb (0x8c5640): завершение движка i (колбэк engine_step) — если
 * схема движка ещё активна, взвести его таймер периода (без ускорения). */
static void calib_mngr_engine_done_cb(u32 i, u32 a1)
{
    (void)a1;
    if (i >= CALIB_ENG_NUM)
        fw_sysassert_fatal(caller(), 0x1095);
    if (calib_mngr.scheme_active[i] == 0)
        return;
    calib_mngr_schedule_scheme_step(i,
        &calib_cfg_get_scheme(chsw_pcp_ap_mode, calib_sys_state)->eng[i], 0);
}

/* calib_mngr__scheme_timer_cb (0x8c5680): таймер периода движка i — движок свободен:
 * периодический запуск по записи текущей схемы; занят — перевзвести таймер. */
static void calib_mngr_scheme_timer_cb(u32 i, u32 a1)
{
    (void)a1;
    if (i >= CALIB_ENG_NUM)
        fw_sysassert_fatal(caller(), 0x1094);
    calib_mngr.timer[i] = 0;
    const struct calib_scheme_entry *e =
        &calib_cfg_get_scheme(chsw_pcp_ap_mode, calib_sys_state)->eng[i];
    if (calib_mngr.eng[i].hdr.state == CE_ST_IDLE)
        calib_mngr_engine_step(&calib_mngr.eng[i], e->mask, 1, (u8)(e->flags >> 1), e->pause_s,
                               calib_mngr_engine_done_cb, i, 0);
    else
        calib_mngr_schedule_scheme_step(i, e, 0);
}

/* calib_mngr__schedule_scheme_step (0x8e498c): взвести таймер периода движка i (индекс
 * < 6, ассерт 0x120a) по записи схемы e. Движок выключен в схеме или период 0 — таймер
 * сбрасывается в 0 (без отмены); таймер уже идёт — ничего. first != 0 и [gp,0xb7]
 * (0x80023b) — первый запуск с задержкой [gp,0x204] (0x800388) мкс вместо периода. */
static void calib_mngr_schedule_scheme_step(u32 i, const struct calib_scheme_entry *e, u32 first)
{
    if (i >= CALIB_ENG_NUM)
        fw_sysassert_fatal(caller(), 0x120a);
    if (!(e->flags & 1) || e->period_s == 0) {
        calib_mngr.timer[i] = 0;
        return;
    }
    if (calib_mngr.timer[i] != 0)
        return;
    u32 delay = (u32)e->period_s * 1000u;
    if (first != 0 && calib_first_run_delay_en != 0)
        delay = calib_first_run_delay;
    calib_mngr.scheme_active[i] = 1;
    calib_mngr.timer[i] = u_schd_schedule(calib_mngr_scheme_timer_cb, i, 0, 0, delay, 0, 0);
}

/* calib_engine__schedule_all_schemes (0x8e91d4): таймеры периода всех шести движков. */
static void calib_engine_schedule_all_schemes(const struct calib_scheme *scheme)
{
    u32 i;
    for (i = 0; i < CALIB_ENG_NUM; i++)
        calib_mngr_schedule_scheme_step(i, &scheme->eng[i], 1);
}

/* calib_mngr__start_scheme (0x8e4a28): схема с all_at_once == 0 — каждый движок по своему
 * таймеру периода; иначе — сразу разовый запуск включённых свободных движков. */
void calib_mngr_start_scheme(const struct calib_scheme *scheme)
{
    u32 i;

    if (scheme->all_at_once == 0) {
        calib_engine_schedule_all_schemes(scheme);
        return;
    }
    const struct calib_scheme_entry *e = scheme->eng;
    for (i = 0; i < CALIB_ENG_NUM; i++, e++) {
        if (calib_mngr.eng[i].hdr.state != CE_ST_IDLE)
            continue;
        if (!(e->flags & 1))
            continue;
        calib_mngr_engine_step(&calib_mngr.eng[i], e->mask, 0, (u8)(e->flags >> 1), e->pause_s,
                               calib_mngr_engine_done_cb, i, 0);
    }
}

/* calib_engine__cancel_timer (0x8c68ec): снять схему движка i (< 6, ассерт 0x1214):
 * флаг 0, таймер периода — отменить. */
static void calib_engine_cancel_timer(u32 i)
{
    if (i >= CALIB_ENG_NUM)
        fw_sysassert_fatal(caller(), 0x1214);
    calib_mngr.scheme_active[i] = 0;
    if (calib_mngr.timer[i] != 0) {
        u_schd_cancel(calib_mngr.timer[i]);
        calib_mngr.timer[i] = 0;
    }
}

/* basic_sm__handle_event__r1_5_r2_0 (0x8c1d98): событие ABORT автомату движка. */
static void calib_engine_abort(struct calib_engine *sm)
{
    basic_sm_handle_event(sm, CE_EV_ABORT, 0, 0, 0);
}

/* calib_engine__abort_all (0x8e49fc): ABORT всем шести движкам и снять их схемы. */
void calib_engine_abort_all(void)
{
    u32 i;
    for (i = 0; i < CALIB_ENG_NUM; i++) {
        calib_engine_abort(&calib_mngr.eng[i]);
        calib_engine_cancel_timer(i);
    }
}

/* ======================= таблицы методов классов ======================= */

/* 0x800604: таблица методов calib_if_gain. */
FWDATA(800604) const struct calib_vt calib_if_gain_vtbl = {
    .reset = calib_vt_method1_noop,
    .estimation_pre = basic_calib_estimation_pre,
    .estimation_alg = basic_calib_sparrow_estimation_alg,
    .estimation_post = basic_calib_estimation_post,
    .is_temperature_changed = basic_calib_is_temperature_changed,
    .pre = calib_if_gain_pre,
    .main = calib_if_gain_main,
    .post = calib_if_gain_post,
    .is_radio_lock_needed = calib_if_gain_is_radio_lock_needed,
    .check_online_estimation_condition = basic_calib_check_online_estimation_condition,
    .set_fragments_num = basic_calib_set_fragments_num,
};

/* 0x800634: таблица методов calib_silent_rssi_sparrow. */
FWDATA(800634) const struct calib_vt calib_silent_rssi_vtbl = {
    .reset = calib_vt_method1_noop,
    .estimation_pre = basic_calib_estimation_pre,
    .estimation_alg = calib_silent_rssi_sparrow_estimation_alg,
    .estimation_post = basic_calib_estimation_post,
    .is_temperature_changed = basic_calib_is_temperature_changed,
    .pre = calib_silent_rssi_pre,
    .main = calib_silent_rssi_main,
    .post = calib_silent_rssi_post,
    .is_radio_lock_needed = calib_silent_rssi_is_radio_lock_needed,
    .check_online_estimation_condition = basic_calib_check_online_estimation_condition,
    .set_fragments_num = calib_silent_rssi_set_fragments_num,
};

/* 0x800664: таблица методов calib_bb_gain_dc (VGA). */
FWDATA(800664) const struct calib_vt calib_vga_vtbl = {
    .reset = calib_vt_method1_noop,
    .estimation_pre = basic_calib_estimation_pre,
    .estimation_alg = basic_calib_sparrow_estimation_alg,
    .estimation_post = basic_calib_estimation_post,
    .is_temperature_changed = basic_calib_is_temperature_changed,
    .pre = calib_vga_pre,
    .main = calib_vga_main,
    .post = calib_vga_post,
    .is_radio_lock_needed = calib_vga_is_radio_lock_needed,
    .check_online_estimation_condition = calib_bb_gain_dc_check_online_estimation_condition,
    .set_fragments_num = basic_calib_set_fragments_num,
};

/* 0x800694: таблица методов class_calib_lo_power. */
FWDATA(800694) const struct calib_vt calib_lo_power_vtbl = {
    .reset = calib_obj_reset_results,
    .estimation_pre = basic_calib_estimation_pre,
    .estimation_alg = class_calib_lo_power_estimation_alg,
    .estimation_post = basic_calib_estimation_post,
    .is_temperature_changed = basic_calib_is_temperature_changed,
    .pre = calib_lo_power_pre,
    .main = calib_lo_power_main,
    .post = calib_lo_power_post,
    .is_radio_lock_needed = calib_lo_power_is_radio_lock_needed,
    .check_online_estimation_condition = basic_calib_check_online_estimation_condition,
    .set_fragments_num = basic_calib_set_fragments_num,
};

/* 0x8006c4: таблица методов calib_sar. */
FWDATA(8006c4) const struct calib_vt calib_sar_vtbl = {
    .reset = calib_vt_method1_noop,
    .estimation_pre = basic_calib_estimation_pre,
    .estimation_alg = basic_calib_sparrow_estimation_alg,
    .estimation_post = basic_calib_estimation_post,
    .is_temperature_changed = basic_calib_is_temperature_changed,
    .pre = calib_sar_pre,
    .main = calib_sar_main,
    .post = calib_sar_post,
    .is_radio_lock_needed = calib_sar_is_radio_lock_needed,
    .check_online_estimation_condition = basic_calib_check_online_estimation_condition,
    .set_fragments_num = basic_calib_set_fragments_num,
};

/* 0x80072c: таблица методов calib_lo_leakage. */
FWDATA(80072c) const struct calib_vt calib_lo_leakage_vtbl = {
    .reset = calib_vt_method1_noop,
    .estimation_pre = basic_calib_estimation_pre,
    .estimation_alg = basic_calib_sparrow_estimation_alg,
    .estimation_post = basic_calib_estimation_post,
    .is_temperature_changed = basic_calib_is_temperature_changed,
    .pre = calib_lo_leakage_pre,
    .main = calib_lo_leakage_main,
    .post = calib_lo_leakage_post,
    .is_radio_lock_needed = calib_lo_leakage_is_radio_lock_needed,
    .check_online_estimation_condition = basic_calib_check_online_estimation_condition,
    .set_fragments_num = basic_calib_set_fragments_num,
};

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x800de0: имена состояний автомата движка калибровки (описатель 0x802234). */
FWDATA(800de0) const u32 calib_eng_sm_state_names[4] = {
    0x0101fb7b,   /* IDLE */
    0x0101fb80,   /* CHECK_CORRECTION_NEEDED */
    0x0101fb98,   /* WAIT_FOR_RADIO_LOCK */
    0x0101fbac,   /* CORRECTION */
};

/* 0x800df0: имена событий автомата движка калибровки (описатель 0x802234). */
FWDATA(800df0) const u32 calib_eng_sm_event_names[6] = {
    0x0101fbb7,   /* EVT_START */
    0x0101fbc1,   /* EVT_READY_FOR_CORRECTION */
    0x0101fbda,   /* EVT_LOCK_RADIO */
    0x0101fbe9,   /* EVT_FRAG_DONE */
    0x0101fbf7,   /* EVT_CALIB_DONE */
    0x0101fc06,   /* EVT_ABORT */
};
