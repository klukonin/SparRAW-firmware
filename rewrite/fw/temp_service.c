// SPDX-License-Identifier: AGPL-3.0-or-later
/* Служба температуры (TEMPERATURE_SERVICE) — порт vendor 6.2.
 *
 * gp-переменные vendor (см. также l2mgr.c temp_sense__*):
 *   [0x80017c] задача таймера службы        [0x800174] служба разрешена (m_temp_enabled)
 *   [0x800150] служба останавливается        [0x800140] запрос радио (radio_mgr__request)
 *   [0x8000f4] время последнего измерения    [0x800020] период измерений
 *   [0x800028]/[0x80002c] параметры измерения RF (режим 3 — однократный флаг)
 *   [0x8000a4] температура BB (мград)        [0x8000a8]/[0x8000ac] колбэк ожидающего запроса/ctx
 *   [0x80038c] первое измерение выполнено    [0x8002cc]/[0x8002d0] калибровка BB-сенсора
 *   [0x800004] множитель BB-сенсора          [0x800243] маска RF с сенсором
 *   [0x800450] множитель RF-сенсора          [0x800454] маска откалиброванных RF
 *   [0x80021e] число тактов компаратора
 * Таблицы: temp_rf_mdeg (0x847fa8) — температура RF по индексу (-1 — нет),
 * temp_rf_sensor_ofs (0x8019ec) — поправка RF, temp_snap (0x853808, блок статистики fw
 * 0x853800) — снимок BB / активного RF / RF 0..7, temp_first_meas (0x80114c: [0] BB,
 * [1 + i] RF i) — значения первого измерения.
 */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/temp_sense.h"

/* Снимок температур в блоке статистики fw (0x853808, вне DCCM — символ fw.ld). */
struct temp_snap {
    u32 bb_mdeg;                               /* 0x00 (0x853808) */
    u32 active_rf_mdeg;                        /* 0x04 (0x85380c) */
    u32 rf_mdeg[8];                            /* 0x08 (0x853810) */
};
_Static_assert(sizeof(struct temp_snap) == 0x28, "temp_snap");
extern volatile struct temp_snap temp_snap;    /* 0x853808 */


#define TS_TASK     (temp_timer_task)
#define TS_STOPPED  (temp_stopping)
#define TS_ENABLED  (temp_enabled)
#define TS_RADIO    (temp_radio_req)
#define TS_BB_TEMP  (temp_bb_mdeg)
#define TS_CB       (temp_pending_cb)
#define TS_CB_CTX   (temp_pending_ctx)

/* ---------------- ABIF: температурный сенсор BB ---------------- */

/* hwd_abif__sensor_select (0x8cf958): 0x8894a4 — биты 11..14 = on ? 4 : 0, бит 15 = !on.
 * Ассерты 0xad/0xae vendor (значения не влезают в поле) недостижимы. */
static void hwd_abif_sensor_select(u32 on)
{
    u32 hi = on ? 0u : 1u;
    u32 sel = (on ? 1u : 0u) << 2;
    MMIO32(HW_ABIF_DVS_CTRL_24) = (MMIO32(HW_ABIF_DVS_CTRL_24) & 0xffff07ffu) | (hi << 15) | (sel << 11);
}

/* hwd_abif__sensor_measure_start (0x8cf9e4): 0x889364 биты 1 и 2 = on (on ≤ 1, иначе
 * ассерт 0xad). */
void hwd_abif_sensor_measure_start(u32 on)
{
    if (on & ~1u)
        fw_sysassert_fatal(__builtin_return_address(0), 0xad);
    u32 v = MMIO32(ABIF_SENSOR_BGAP_CTRL);
    v = ((v & ~2u) | (on << 1)) & ~4u;
    MMIO32(ABIF_SENSOR_BGAP_CTRL) = v | (on << 2);
}

/* hwd_abif__sensor_set_thermal_mode (0x8cfaac): 0x889364 бит 4 = !on. */
void hwd_abif_sensor_set_thermal_mode(u32 on)
{
    u32 b = on ? 0u : 1u;
    MMIO32(ABIF_SENSOR_BGAP_CTRL) = (MMIO32(ABIF_SENSOR_BGAP_CTRL) & ~0x10u) | (b << 4);
}

/* hwd_abif__sensor_set_comp_value (0x8cfaa0): код R-лестницы компаратора → 0x889368. */
void hwd_abif_sensor_set_comp_value(u32 v)
{
    MMIO32(ABIF_SENSOR_COMP_VALUE) = v;
}

/* hwd_abif__sensor_get_comp_out (0x8cf9b0): [0x80021e] импульсов бита 8 регистра
 * 0x880b00 (0 → 1), затем выход компаратора — бит 0 регистра 0x889390. */
u32 hwd_abif_sensor_get_comp_out(void)
{
    u32 lo = MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) & ~0x100u;
    u32 hi = lo | 0x100u;
    u32 i;
    for (i = 0; (s32)i < (s32)temp_comp_clk_pulses; i = (u8)(i + 1)) {
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) = lo;
        MMIO32(HW_CLKS_CTL_SW_CLK_VEC_3) = hi;
    }
    return MMIO32(ABIF_SENSOR_COMP_OUT) & 1u;
}

/* rladder__init_bounds (0x8c075c; в NAMES-EXTRA ошибочно isr_pcie_main): начальный код и
 * шаг поиска: dir 0 (вверх) — код -1, шаг +1; иначе код 0x20, шаг -1. */
static void rladder_init_bounds(u32 dir, s8 *code, s8 *step)
{
    if (dir == 0) {
        *code = -1;
        *step = 1;
    } else {
        *code = 0x20;
        *step = -1;
    }
}

/* rladder__step_code (0x8c15e4): код += шаг, подать на компаратор 1 << код, вернуть его выход. */
static u32 rladder_step_code(s8 *code, s32 step)
{
    *code = (s8)(*code + step);
    hwd_abif_sensor_set_comp_value(1u << ((u32)*code & 31));
    return hwd_abif_sensor_get_comp_out();
}

/* hwf_rladder_scan (0x8c14f0, 244 Б): 32 прохода следящего поиска по R-лестнице (коды
 * 0..31) в направлении dir (0 — вверх, 1 — вниз) от init (0xff — от края); сумма
 * найденных кодов. mode — только для журнала (0 — температура, 1 — напряжение). */
static u32 hwf_rladder_scan(u32 dir, u32 init, u32 mode)
{
    s8 code, step;
    u32 sum = 0, n, out, cur;
    s32 c;

    rladder_init_bounds(dir, &code, &step);
    if (init != 0xff)
        code = (s8)init;
    for (n = 0; (s32)n < 0x20; n = (u8)(n + 1)) {
        out = rladder_step_code(&code, step);
        if (dir == 0 && out == 0)
            fw_log_emit3(0x20, 0x101cdb4, n, 0x20, mode);
        else if (dir == 1 && out == 1)
            fw_log_emit3(0x20, 0x101ce30, n, 0x20, mode);
        for (;;) {
            cur = rladder_step_code(&code, step);
            c = code;
            if (out != cur || c >= 0x20 || c < 0)
                break;
        }
        if (c < 0)
            c = 0;
        if (c > 0x1f)
            c = 0x1f;
        code = (s8)c;
        if (out == cur && cur == 0) {
            code = 0;
            fw_log_emit0(0x20, 0x101ceb0);
        } else if (out == cur && cur == 1) {
            code = 0x1f;
            fw_log_emit0(0x20, 0x101cd74);
        }
        sum += (u32)(s32)code;
        c = (s8)(code - step * 4);
        if (c < -1)
            c = -1;
        c = (s8)c;
        if (c > 0x20)
            c = 0x20;
        code = (s8)c;
    }
    return sum;
}

/* hwf__rladder_calibrate (0x8d4944): поиск вверх от края, затем вниз от среднего
 * (сумма + 0x70) / 32 (не больше 0x20); результат — полусумма двух сумм. */
static u32 hwf_rladder_calibrate(u32 mode)
{
    u32 up = hwf_rladder_scan(0, 0xff, mode);
    u32 st = (up + 0x70) >> 5;
    if (st >= 0x20)
        st = 0x20;
    u32 down = hwf_rladder_scan(1, (u8)st, mode);
    return (down + up) >> 1;
}

/* hwf__bb_temp_measure (0x8d4978; vendor-имя hwf__rf_lo_setup): включить BB-сенсор,
 * откалибровать R-лестницу; t = (k·код − 0x3e666 + калибровка) / 32 с округлением
 * (Q8 °C), сенсор выключить. */
static s32 hwf_bb_temp_measure(void)
{
    s32 r;

    hwd_abif_sensor_select(1);
    hwd_abif_sensor_measure_start(1);
    hwd_abif_sensor_set_thermal_mode(1);
    r = (s32)hwf_rladder_calibrate(0);
    r = (s32)(temp_bb_sensor_gain * (u32)r - 0x3e666u + (u32)temp_bb_calib_ofs);
    if (r >= 0)
        r = (r + 0x10) >> 5;
    else
        r = -((0x10 - r) >> 5);
    hwd_abif_sensor_select(0);
    hwd_abif_sensor_measure_start(0);
    return r;
}

/* temp__store_lo_temp (0x8e21f0): температура BB Q8 → мград: целая часть × 1000 +
 * (дробь × 1000) >> 8; в [0x8000a4] и снимок 0x853808. */
static void temp_store_lo_temp(void)
{
    s32 v = hwf_bb_temp_measure();
    s32 t = (v >> 8) * 1000 + (((s32)(v & 0xff) * 1000) >> 8);
    TS_BB_TEMP = (u32)t;
    temp_snap.bb_mdeg = (u32)t;
}

/* ---------------- RFC: температурный сенсор RF ---------------- */

/* rfc__field_write_repeat (0x8d42e0; vendor-имя rfc__read_block_loop): n раз записать поле. */
static void rfc_field_write_repeat(u32 rf, u32 field, u32 val, u32 n)
{
    for (; n >= 1; n--)
        rfc_field_write((u8)rf, field, val, 0);
}

/* rfc__temp_sensor_setup (0x8d3164; vendor-имя rfc__read_block_34c): настройка сенсора RF,
 * v — режим (биты 2.. регистра 0x440). */
static void rfc_temp_sensor_setup(u32 rf, u32 v)
{
    hwd_rfc_write_verify(rf, 0x34c, 0xf, 6);
    u32 r = hwd_rfc_read_rgf(rf, 0x440);
    hwd_rfc_write_verify(rf, 0x440, (r & 3u) | ((u32)(u8)v << 2) | 0x20u, 6);
    hwd_rfc_write_verify(rf, 0x444, 0x1010, 6);
    rfc_field_write_repeat(rf, 0x45c, 1, 1);
    hwd_rfc_write_verify(rf, 0x454, 0x10, 6);
    rfc_field_write_repeat(rf, 0x44c, 1, 1);
}

/* rfc__read_temperature (0x8d310c): wait — пауза 800 итераций (lp с nop), затем RFC 0x458:
 * 0xdeadbeef → -1, иначе ((k · raw) >> 5) − 30000 + поправка [0x8019ec + rf·4]
 * (k = [0x800450], младшие 32 бита произведения). */
static u32 rfc_read_temperature(u32 rf, u32 wait)
{
    u32 raw;

    if (wait != 0)
        arc_zol_nops2(800);                 /* vendor 0x8d3114: lp 800 × 2 nop_s */
    raw = hwd_rfc_read_rgf(rf, 0x458);
    if (raw == 0xdeadbeefu)
        return 0xffffffffu;
    return temp_rf_sensor_ofs[rf] + (((temp_rf_sensor_mult * raw) >> 5) - 0x7530u);
}

/* temp_sense__measure_rf_raw (0x8d7014; vendor-имя temp_sense__prepare_no_rf): выбрать RF
 * командой DVS RFCA (прежняя маска — в байте кадра), при cfg — настройка сенсора с режимом
 * v, прочитать температуру, вернуть маску RFCA. */
static u32 temp_sense_measure_rf_raw(u32 rf, u32 cfg, u32 v)
{
    u8 saved = 0;
    u32 t;

    hwd_abif_dvs_rfca_cmd_enable((u8)(1u << rf), &saved);
    if (cfg != 0)
        rfc_temp_sensor_setup(rf, v);
    t = rfc_read_temperature(rf, cfg);
    hwd_abif_dvs_rfca_cmd_enable(saved, 0);
    return t;
}

/* temp_sense__measure_rf (0x8e221c; vendor-имя temp_sense__no_rf): температура RF rf
 * (obj — RF-объект rf_obj). Нет сенсора (rf ≥ 8 или бит в [0x800243] снят) или RF —
 * -1 (во втором случае журнал). После импульса RFC 0x3e0 — измерение: при role_pwr_flag
 * (Sparrow-R) без настройки и режим 3, иначе настройка с флагом a2 и режимом a3. */
static u32 temp_sense_measure_rf(struct rf_obj *obj, u32 rf, u32 a2, u32 a3)
{
    if (rf >= 8 || !(rf_connected_mask & (1u << rf)))
        return 0xffffffffu;
    if (rf_is_present() == 0) {
        fw_log_emit0(0x10, 0x10052c4);
        return 0xffffffffu;
    }
    rfc_read_or_dead();
    if (obj->role_pwr_flag != 0)
        return temp_sense_measure_rf_raw((u8)rf, 0, 3);
    return temp_sense_measure_rf_raw((u8)rf, a2, a3);
}

/* temp_sense__measure_all (0x8e2348; vendor-имя STREAM_MGR__ready_for_modify — ошибочное):
 * температуры всех 8 RF в 0x847fa8 и снимок 0x853810, активный RF — в 0x85380c; режим 3
 * параметров ([0x80002c]) — однократный: флаг [0x800028] сбрасывается. */
static void temp_sense_measure_all(void)
{
    u32 i, t;

    for (i = 0; i < 8; i++) {
        t = temp_sense_measure_rf(&rf_obj, i, temp_rf_meas_flag,
                                  temp_rf_meas_mode);
        VOL(temp_rf_mdeg[i]) = t;
        temp_snap.rf_mdeg[i] = t;
    }
    temp_snap.active_rf_mdeg = temp_get_active_rf(0);
    if (temp_rf_meas_flag != 0 && temp_rf_meas_mode == 3)
        temp_rf_meas_flag = 0;
}

/* TEMPERATURE_SERVICE::consume_bb_sensor_calibration_parameters (0x8c73f0): из OTP-полей
 * s16 [0x80020e] (Tamb) и [0x800210] (начальная температура): калибровка BB
 * [0x8002cc] = ((T0 − Tamb) / 100) << 13, [0x8002d0] = 1. Любое из полей -1 — «BB not
 * calibrated». */
static void temp_consume_bb_sensor_calibration_parameters(void)
{
    s32 tamb = temp_bb_otp_tamb;
    s32 t0, d;

    if (tamb == -1 || (t0 = temp_bb_otp_t0) == -1) {
        fw_log_emit0(0x16, 0x1011ec8);
        return;
    }
    d = (s32)((u32)fw_divmod_signed(t0 - tamb, 100) << 13);   /* сдвиг влево отрицательного — UB; asl тот же */
    temp_bb_calib_ofs = d;
    temp_bb_calibrated = 1;
    fw_log_emit3(0x26, 0x1011f1c, (u32)t0, (u32)tamb, (u32)d);
}

/* TEMPERATURE_SERVICE::read_rf_sensor_calibration_parameters (0x8e2274): для каждого RF из
 * маски — XPM 0x2f0 (Tamb) и 0x300 (начальная температура, 0 → 3000): поправка
 * [0x8019ec + i·4] = (T0 − Tamb) · 10, бит RF в [0x800454]. Маска RFCA восстанавливается. */
static void temp_read_rf_sensor_calibration_parameters(void)
{
    u32 saved = rfca_get_rf_mask();
    u32 mask = rf_cfg_get_rf_mask_45e(&rf_obj);
    u32 i, bit;
    s16 cal[2];

    for (i = 0; i < 8; i = (u8)(i + 1)) {
        bit = 1u << i;
        if (!(bit & mask))
            continue;
        hwd_abif_dvs_rfca_cmd_enable((u8)bit, 0);
        if (hwf_rf_xpm_read_block(i, 0x2f0, 2, &cal[0]) == 0) {
            fw_log_emit0(6, 0x1011ff0);
            continue;
        }
        if (hwf_rf_xpm_read_block(i, 0x300, 2, &cal[1]) == 0) {
            fw_log_emit0(6, 0x1012060);
            continue;
        }
        if (cal[1] == 0)
            cal[1] = 0xbb8;
        if (cal[0] == 0) {
            fw_log_emit0(0x16, 0x1011fa0);
            continue;
        }
        temp_rf_sensor_ofs[i] = (u32)((s32)cal[1] - (s32)cal[0]) * 10u;
        temp_rf_calibrated_mask |= bit;
        fw_log_emit3(0x26, 0x10120cc, (u32)(s32)cal[1], (u32)(s32)cal[0],
                     (u32)((s32)cal[1] - (s32)cal[0]) * 10u);
    }
    hwd_abif_dvs_rfca_cmd_enable(saved, 0);
}

/* perform_first_measurement_operations (0x8e0908): запомнить первые измерения (BB в
 * 0x80114c, RF в 0x801150..), принять калибровку сенсоров и применить её: BB +=
 * round([0x8002cc] / 2^13) · 1000, RF += поправка (кроме -1). */
static void perform_first_measurement_operations(void)
{
    u32 i, v;
    s32 c, k;

    temp_first_meas_done = 1;
    temp_first_meas[0] = TS_BB_TEMP;
    for (i = 0; i < 8; i++)
        temp_first_meas[1 + i] = VOL(temp_rf_mdeg[i]);
    temp_consume_bb_sensor_calibration_parameters();
    temp_read_rf_sensor_calibration_parameters();
    c = temp_bb_calib_ofs;
    if (c >= 0)
        k = (c + 0x1000) >> 13;
    else
        k = -((0x1000 - c) >> 13);
    v = (u32)(k * 1000) + TS_BB_TEMP;
    TS_BB_TEMP = v;
    fw_log_emit1(0x26, 0x10122c0, v);
    for (i = 0; i < 8; i++) {
        v = VOL(temp_rf_mdeg[i]);
        if (v == 0xffffffffu)
            continue;
        v += temp_rf_sensor_ofs[i];
        VOL(temp_rf_mdeg[i]) = v;
        fw_log_emit2(0x26, 0x1012304, i, v);
    }
}

/* TEMPERATURE_SERVICE::radio_locked_cb (0x8e20dc): радио выдано (radio — дескриптор
 * для возврата, a — аргумент запроса). Плановое измерение (a == 0) при выключенной или
 * останавливающейся службе — вернуть радио. Иначе измерить все RF (первое — с
 * калибровкой), вернуть радио, отдать ожидающему колбэку активную температуру, при
 * разрешённой службе — следующий таймер через период [0x800020]. */
static void temperature_service_radio_locked_cb(struct rm_req *radio, u32 a)
{
    temp_done_fn cb;

    if (a == 0 && TS_ENABLED == 0) {
        fw_log_emit1(0x1c, 0x10121f8, (u32)radio);
        radio_mgr_call_method_10(radio);
        TS_RADIO = 0;
        return;
    }
    if (a == 0 && TS_STOPPED == 1) {
        fw_log_emit1(0x2c, 0x1012250, (u32)radio);
        radio_mgr_call_method_10(radio);
        TS_STOPPED = 0;
        TS_RADIO = 0;
        return;
    }
    u_schd_now();
    temp_sense_measure_all();
    if (temp_first_meas_done == 0)
        perform_first_measurement_operations();
    radio_mgr_call_method_10(radio);
    TS_RADIO = 0;
    if (TS_CB != 0) {
        cb = TS_CB;
        cb(TS_BB_TEMP, temp_get_active_rf(0), TS_CB_CTX);
        TS_CB = 0;
        TS_CB_CTX = 0;
    }
    if (TS_ENABLED != 0)
        temp_sense_schedule(temp_period);
}

/* TEMPERATURE_SERVICE::timer_exp_handler (0x8e9438, 102 Б): срабатывание таймера службы
 * (a == 0) или запрос измерения (a ≠ 0). Плановое — только при разрешённой службе;
 * останавливающаяся служба — снять флаг. Время измерения → [0x8000f4], температура BB,
 * затем запрос радио с колбэком radio_locked_cb (vendor передаёт его числом 0x220dc — у нас
 * адрес функции). Прежний запрос ещё не выполнен — журнал. */
void temperature_service_timer_exp_handler(u32 a, u32 a1)
{
    (void)a1;
    TS_TASK = 0;
    if (a == 0 && TS_ENABLED == 0) {
        fw_log_emit0(0x16, 0x101214c);
        return;
    }
    if (a == 0 && TS_STOPPED == 1) {
        TS_STOPPED = 0;
        return;
    }
    temp_last_meas_time = u_schd_now();
    temp_store_lo_temp();
    if (TS_RADIO != 0) {
        fw_log_emit0(0x16, 0x101218c);
        return;
    }
    TS_RADIO = (u32)radio_mgr_request(temperature_service_radio_locked_cb, a, 0, 0xffff, 0);
}
