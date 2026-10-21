// SPDX-License-Identifier: AGPL-3.0-or-later
/* Монитор PHY (объект 0x84e7e0 — struct phy_monitor, include/phy_monitor.h; таблица
 * методов 0x8007a0 — struct phy_monitor_vt) — порт vendor 6.2. База — периодическая служба
 * struct psvc (include/link_loss.h): методы start (0x8e77c4), stop (detector__arm_timer
 * 0x8e7e8c), задача прогона (phy_stats__dump 0x8e8ac0), run (0x8cdc18) и свой слот 0x14
 * on_system_state (0x8e889c). */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/rf_obj.h"
#include "../include/link_loss.h"
#include "../include/phy_monitor.h"
#include "../include/fwdata.h"
#include "../include/calib.h"


/* phy__get_signal_gain_adc_db (0x8d25cc): биты 0..6 регистра 0x883830. */
static u32 phy_get_signal_gain_adc_db(void)
{
    return MMIO32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB) & 0x7f;
}

/* phy__get_signal_gain_adc_db_sfd_locked (0x8d25d8): биты 14..20 регистра 0x883830. */
static u32 phy_get_signal_gain_adc_db_sfd_locked(void)
{
    return (MMIO32(HW_PHY_RX_SIGNAL_GAIN_ADC_DB) >> 14) & 0x7f;
}

/* phy__get_ina_rssi_adc_db_sfd_locked (0x8d2654): биты 0..5 регистра 0x883708. */
static u32 phy_get_ina_rssi_adc_db_sfd_locked(void)
{
    return MMIO32(HW_PHY_RX_INA_RSSI_ADC_DB_SFD_LOCKED) & 0x3f;
}

/* phy_stats__get_cfg_word (0x8d25c0): [0x800524] (vendor результат не использует). */
static u32 phy_stats_get_cfg_word(void)
{
    return phy_rx_stats_clear_time;
}

/* phy_stats__dump (0x8e8ac0, 316 Б): метод [3] монитора PHY — журнал снимка счётчиков
 * приёма (CRC заголовка CP/SC, BER), усилений ADC, INA RSSI, стартовых значений и массивов
 * AGC (omni/direct, объект калибровки 4) и индексов усиления RX/TX каждого RF из маски.
 * dump_off ≠ 0 — дамп запрещён. Кадр vendor: sp+0 — 14 счётчиков, sp+0x38 — TSF,
 * sp+0x40..0x4c — пары AGC. Хвостовой цикл из 8 пустых вызовов rf_cfg__get_rf_mask_45e
 * (остаток вычищенного кода) повторён. */
void phy_stats_dump(struct psvc *svc, u32 cnt)
{
    struct phy_monitor *obj = (struct phy_monitor *)svc;
    u32 ctr[14];
    u32 tsf[2];
    u32 agc[4];
    u32 a, b, i;
    const struct calib_silent_rssi *cal;

    (void)cnt;
    if (obj->dump_off != 0)
        return;
    u_schd_now();
    phy_stats_get_cfg_word();
    if (obj->freeze_stats != 0)
        hwd_phy_rx_statistics_lock();
    phy_read_rx_counters(ctr);
    if (obj->freeze_stats != 0)
        hwd_phy_rx_statistics_clear();
    mac_read_tsf64(0, tsf, 0);
    fw_log_emit2(0x24, 0x10195e0, ctr[11], ctr[4]);
    fw_log_emit2(0x24, 0x1019620, ctr[13], ctr[6]);
    a = phy_get_signal_gain_adc_db();
    b = phy_get_signal_gain_adc_db_sfd_locked();
    fw_log_emit2(0x24, 0x1019664, a, b);
    a = phy_get_ina_rssi_adc_db();
    b = phy_get_ina_rssi_adc_db_sfd_locked();
    fw_log_emit2(0x24, 0x10196a0, a, b);
    agc[0] = agc[1] = agc[2] = agc[3] = 0;
    cal = calib_obj4_reset_d4();
    agc_get_table_pair(cal, 1, &agc[0], &agc[1]);
    agc_get_table_pair(cal, 0, &agc[2], &agc[3]);
    fw_log_emit3(0x24, 0x10196d4, agc[0], agc[2], calib_zero_db.row8);
    fw_log_emit2(0x24, 0x1019720, agc[1], agc[3]);
    for (i = 0; i < 8; i++) {
        if (!(rf_cfg_get_rf_mask_45e(&rf_obj) & (1u << i)))
            continue;
        fw_log_emit2(0x24, 0x1019760, i, silent_rssi_agc_param_const_2(cal, (u8)i));
        fw_log_emit2(0x24, 0x1019778, i, silent_rssi_agc_param_const_4(cal, (u8)i));
    }
    for (i = 8; i >= 1; i--)
        rf_cfg_get_rf_mask_45e(&rf_obj);
}

/* 0x80340c: таблица переходов vendor phy_monitor__on_system_state (0x8e889c): ldb.x, 23 записей, цель = 0x8e88b6 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(80340c) __attribute__((aligned(1))) const u8 phy_monitor_on_system_state_jt[23] = {
    0x29, 0x29, 0x00, 0x0a, 0x0e, 0x0a, 0x0a, 0x0e, 0x0a, 0x0e, 0x0a, 0x0e,
    0x0a, 0x00, 0x00, 0x00, 0x0a, 0x1f, 0x18, 0x23, 0x1f, 0x18, 0x29,
};

/* phy_monitor::on_system_state (0x8e889c, 112 Б; таблица переходов 0x80340c; объект
 * 0x84e7e0): реакция монитора PHY на системное состояние st (idle — система простаивает,
 * conn — есть соединение mid 0). Разбор таблицы (байт × 2 от 0x8e88b6):
 *   0, 1, 22          — ничего;
 *   2, 13, 14, 15     — соединения быть не должно (иначе ассерт 0x1437), включить и
 *                       запустить прогон сразу;
 *   3, 5, 6, 8, 10, 12, 16 — простой без соединения: выключить и остановить, иначе
 *                       включить и прогон сразу;
 *   4, 7, 9, 11       — выключить и остановить;
 *   17..21, ≥ 23      — ассерт 0x1435 (19 — запись таблицы на ассерт у vendor; 17/20 и 18/21
 *                       у vendor — PS: остановить / возобновить, здесь не рассылаются). */
void phy_monitor_on_system_state(struct phy_monitor *obj, u32 st, u32 idle, u32 conn)
{
    if (st >= 0x17) {
        fw_sysassert_fatal(__builtin_return_address(0), 0x1435);
        return;
    }
    switch (st) {
    case 0: case 1: case 22:
        return;
    case 2: case 13: case 14: case 15:
        if (conn != 0)
            fw_sysassert_fatal(__builtin_return_address(0), 0x1437);
        break;
    case 3: case 5: case 6: case 8: case 10: case 12: case 16:
        if (conn == 0 && idle == 1) {
            obj->enabled = 0;
            detector_arm_timer(&obj->svc);
            return;
        }
        break;
    case 4: case 7: case 9: case 11:
        obj->enabled = 0;
        detector_arm_timer(&obj->svc);
        return;
    default:                                    /* 19; 17/18/20/21 — вход/выход из сна (PS) — больше не рассылаются: энергосбережение вырезано (см. fw/action.c psc_req_reject) */
        fw_sysassert_fatal(__builtin_return_address(0), 0x1435);
        return;
    }
    obj->enabled = 1;
    periodic_service_start(&obj->svc, 0);
}

/* Таблица методов монитора PHY (vendor 0x8007a0). */
FWDATA(8007a0) const struct phy_monitor_vt phy_monitor_vtbl = {
    .psvc = {
        .rsv0 = 0,
        .start = periodic_service_start,
        .stop = detector_arm_timer,
        .task = phy_stats_dump,
        .run = periodic_service_run,
    },
    .on_system_state = phy_monitor_on_system_state,
};
