// SPDX-License-Identifier: AGPL-3.0-or-later
/* phy_stats__dump — периодический дамп статистики приёма PHY (6.2: 0x8e8ac0,
 * 316 байт).
 *
 * Метод периодической службы PHY-монитора (таблица 0x8007a0 + 0x0c, тот же
 * слот, что phy_monitor__task_step в 4.1).  Пока хост ведёт свой сеанс
 * статистики PHY (sysapi), дамп пропускается.  Фиксирует и снимает 14
 * счётчиков приёма, при необходимости сбрасывает их и печатает в модуль
 * журнала PHY_MON.
 *
 * Возвращено из 4.1: время с последнего сброса, TSF, INA sync, SFD timeout,
 * HEADER_CRC_OK, SFD sync, BER_LAST_ZERO, ложные тревоги и температуры — всё
 * это 6.2 снимала или вычисляла, но не печатала.  Строки 4.1 про
 * agc_start_val и rx/tx gain idx не возвращены: 6.2 печатает их замену.
 */
#include "fw.h"
#include "strings-fw.h"

/* Объект периодической службы PHY-монитора (только нужные поля). */
struct phy_monitor {
	u8  unknown_00[0x34];
	u32 clear_after_dump;    /* +0x34: сбрасывать счётчики после снимка */
	u32 host_session;        /* +0x38: идёт сеанс статистики хоста — дамп пропустить */
};

/* Снимок счётчиков приёма PHY (phy__read_rx_counters): SC/DP и CP. */
struct phy_rx_counters {
	u32 ina_sync_dp;             /* +0x00: 0x883964 */
	u32 sfd_sync_sc;             /* +0x04: 0x883968 */
	u32 sfd_timeout_dp;          /* +0x08: 0x883974 */
	u32 hdr_crc_ok_sc;           /* +0x0c: 0x88396c */
	u32 hdr_crc_error_sc;        /* +0x10: 0x883978 */
	u32 ber_last_zero_sc;        /* +0x14: 0x883970 */
	u32 ber_last_nonzero_sc;     /* +0x18: 0x88397c */
	u32 ina_sync_cp;             /* +0x1c: 0x8839a0 */
	u32 sfd_sync_cp;             /* +0x20: 0x8839a4 */
	u32 sfd_timeout_cp;          /* +0x24: 0x8839b0 */
	u32 hdr_crc_ok_cp;           /* +0x28: 0x8839a8 */
	u32 hdr_crc_error_cp;        /* +0x2c: 0x8839b4 */
	u32 ber_last_zero_cp;        /* +0x30: 0x8839ac */
	u32 ber_last_nonzero_cp;     /* +0x34: 0x8839b8 */
};
static_assert(sizeof(struct phy_rx_counters) == 0x38, "phy_rx_counters");

/* Конфигурация РЧ (0x8042c8): байт +0x45e — маска подключённых РЧ-модулей. */
#define RF_CFG ((void *)0x8042c8)
enum { MAX_RF = 8 };

/* Ложные тревоги PHY и температуры (общая память, пишут ucode и fw). */
#define g_false_alarms_total   FW_GLOBAL(u32, 0x853924)
#define g_false_alarms_out_ad  FW_GLOBAL(u32, 0x85393c)
#define g_temp_rf_t1000        FW_GLOBAL(u32, 0x85380c)   /* активный РЧ-модуль */
#define g_temp_bb_t1000        FW_GLOBAL(u32, 0x853808)
/* Строка калибровки с нулевым усилением. */
#define g_zero_db_row_number   FW_GLOBAL(u8, 0x800508)

/* Строки 6.2 */
enum {
	MSG_HDR_CRC_ERROR   = 0x010195e0,
	MSG_BER_NON_ZERO    = 0x01019620,
	MSG_SIGNAL_GAIN     = 0x01019664,
	MSG_INA_RSSI        = 0x010196a0,
	MSG_AGC_START_VAL   = 0x010196d4,
	MSG_AGC_GAIN_ARRAY  = 0x01019720,
	MSG_RF_RX_GAIN_IDX  = 0x01019760,
	MSG_RF_TX_GAIN_IDX  = 0x01019778,
};

/* Тик таймера u_schd — 16 мкс (как в 4.1): на стенде между дампами
 * curr_tm растёт на 625 000, TSF — на 10,01 с.  Период дампа 6.2 —
 * 10 000 000 мкс = 10 с (в 4.1 — 100 000 мкс). */
enum { TIMER_TO_USEC_SHIFT = 4 };

extern "C" {
u32  u_schd__now(void);
/* Время последнего сброса счётчиков PHY ([0x800524]). */
u32  phy_stats__get_cfg_word(void);
void hwd_phy__rx_statistics_lock(void);
void hwd_phy__rx_statistics_clear(void);
void phy__read_rx_counters(struct phy_rx_counters *out);
u32  phy__get_signal_gain_adc_db(void);
u32  phy__get_signal_gain_adc_db_sfd_locked(void);
u32  phy__get_ina_rssi_adc_db(void);
u32  phy__get_ina_rssi_adc_db_sfd_locked(void);
void *calib_obj4__reset_d4(void);
void agc__get_table_pair(void *cal, u32 direct0_omni1, u32 *start_val, u32 *gain_array);
u8   rf_cfg__get_rf_mask_45e(void *rf_cfg);
u32  silent_rssi__agc_param_const_2(void *cal, u32 rf);
u32  silent_rssi__agc_param_const_4(void *cal, u32 rf);
}

extern "C" void phy_stats__dump(struct phy_monitor *mon)
{
	const u32 h = FWLOG_HDR(FWLOG_MOD_PHY_MON, FWLOG_LVL_INFO);

	if (mon->host_session)
		return;

	u32 now = u_schd__now();
	u32 last_clear = phy_stats__get_cfg_word();

	if (mon->clear_after_dump)
		hwd_phy__rx_statistics_lock();
	struct phy_rx_counters c;
	phy__read_rx_counters(&c);
	if (mon->clear_after_dump)
		hwd_phy__rx_statistics_clear();

	u32 tsf[2];
	mac_read_tsf64(0, tsf, 0);

	fw_log_emit3(h, MSG64_PHY_TIME, now, last_clear,
	             (now - last_clear) << TIMER_TO_USEC_SHIFT);
	fw_log_emit3(h, MSG64_PHY_TSF_INA, tsf[0], c.ina_sync_cp, c.ina_sync_dp);
	fw_log_emit2(h, MSG64_PHY_SFD_TIMEOUT, c.sfd_timeout_cp, c.sfd_timeout_dp);
	fw_log_emit2(h, MSG_HDR_CRC_ERROR, c.hdr_crc_error_cp, c.hdr_crc_error_sc);
	fw_log_emit2(h, MSG64_PHY_HDR_CRC_OK, c.hdr_crc_ok_cp, c.hdr_crc_ok_sc);
	fw_log_emit2(h, MSG64_PHY_SFD_SYNC, c.sfd_sync_cp, c.sfd_sync_sc);
	fw_log_emit2(h, MSG64_PHY_BER_LAST_ZERO, c.ber_last_zero_cp, c.ber_last_zero_sc);
	fw_log_emit2(h, MSG_BER_NON_ZERO, c.ber_last_nonzero_cp, c.ber_last_nonzero_sc);

	u32 g = phy__get_signal_gain_adc_db();
	fw_log_emit2(h, MSG_SIGNAL_GAIN, g, phy__get_signal_gain_adc_db_sfd_locked());
	u32 r = phy__get_ina_rssi_adc_db();
	fw_log_emit2(h, MSG_INA_RSSI, r, phy__get_ina_rssi_adc_db_sfd_locked());

	u32 omni_start = 0, omni_gain = 0, direct_start = 0, direct_gain = 0;
	void *cal = calib_obj4__reset_d4();
	agc__get_table_pair(cal, 1, &omni_start, &omni_gain);
	agc__get_table_pair(cal, 0, &direct_start, &direct_gain);
	fw_log_emit3(h, MSG_AGC_START_VAL, omni_start, direct_start, g_zero_db_row_number);
	fw_log_emit2(h, MSG_AGC_GAIN_ARRAY, omni_gain, direct_gain);

	for (u32 rf = 0; rf < MAX_RF; rf++) {
		if (!(rf_cfg__get_rf_mask_45e(RF_CFG) & (1u << rf)))
			continue;
		fw_log_emit2(h, MSG_RF_RX_GAIN_IDX, rf, silent_rssi__agc_param_const_2(cal, (u8)rf));
		fw_log_emit2(h, MSG_RF_TX_GAIN_IDX, rf, silent_rssi__agc_param_const_4(cal, (u8)rf));
	}

	fw_log_emit2(h, MSG64_PHY_FALSE_ALARMS, g_false_alarms_out_ad, g_false_alarms_total);
	fw_log_emit2(h, MSG64_PHY_TEMPERATURE, g_temp_rf_t1000, g_temp_bb_t1000);
}
