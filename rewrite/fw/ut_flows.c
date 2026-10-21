// SPDX-License-Identifier: AGPL-3.0-or-later
/* Модуль юнит-тестов 9 UT_HW_FLOWS_OPERATIONAL (WMI 0x900, ответ 0x1900): отладочные
 * регистры, калибровка, SDP, конфигурация RF, секторы RF-цепей, XPM (OTP RF-модуля),
 * LO power flow. Модуль 10 (SYSAPI) — fw/sysapi_stats.c. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/ut.h"
#include "../include/rf_obj.h"
#include "../include/mbox.h"
#include "../include/fwdata.h"




static inline void *caller(void) { return __builtin_return_address(0); }

/* ===================== модуль UT 9 ===================== */

/* 0x8036b0: таблица переходов vendor UT_HW_FLOWS_OPERATIONAL_cmd_handler (0x8fa884): ldh.as.x, 6 записей, цель = 0x8fa938 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8036b0) __attribute__((aligned(2))) const u16 ut_hw_flows_operational_cmd_handler_jt0[6] = {
    0x063, 0x22c, 0x069, 0x22c, 0x07b, 0x08c,
};

/* 0x8036bc: таблица переходов vendor UT_HW_FLOWS_OPERATIONAL_cmd_handler (0x8fa884): ldh.as.x, 7 записей, цель = 0x8fa970 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8036bc) __attribute__((aligned(2))) const u16 ut_hw_flows_operational_cmd_handler_jt1[7] = {
    0x0b1, 0x0e5, 0x111, 0x148, 0x190, 0x1b0, 0x1d1,
};

/* UT_HW_FLOWS_OPERATIONAL_cmd_handler (0x8fa884, до 0x8fada4; SYMS — 590 Б). Ответ
 * {module 9, subtype, status, ...}; буфер берётся до разбора — для неподдержанных
 * подкоманд он не отправляется и не освобождается (утечка элемента пула, так у
 * vendor). Подкоманды (subtype):
 *   0 / 1   отладочный регистр 0x88405c (ASIC) или 0x8860d4 биты 1..7 (FPGA; ассерт 0xac);
 *   0x305 / 0x306 только журнал; 0x700 калибровка всех; 0x97f SDP-импульс;
 *   0x981 конфигурация RF; 0x983 запись цепи сектора (hwf_sector_rf_chain_set 0x8d7154);
 *   0x984 чтение цепи сектора; 0x98a..0x991 XPM; 0xa01 накопление битов XPM;
 *   0xa02 младший бит; 0xa03 LO power flow.
 * Таблицы: 0x8036b0 (0x97f..0x984) и 0x8036bc (0x98b..0x991), ldh.as.x, цель =
 * 0x8fa938 / 0x8fa970 + 2·запись (JUMPTABLES-fw.txt). */
void ut_hw_flows_operational_cmd_handler(struct wmi_mbox *mbox, const struct ut_cmd *cmd)
{
    const volatile struct ut_cmd *c = cmd;
    const volatile struct wmi_mbox *mb = mbox;
    u32 sub = c->subtype_id;
    volatile struct ut_rsp *buf = ut_begin_response(mbox, 9, sub);
    u32 st = 0, len = 8;

    fw_log_emit1(0x20, 0x101bdcc, c->subtype_id);
    switch (sub) {
    case 0:                                            /* 0x8fa8d4 */
        if (platform_is_fpga() == 0) {
            MMIO32(PHY_TX_TEST_88405C) = 0x55443311;
            st = 1;
        } else {
            fw_sysassert_fatal(caller(), 0xac);
            MMIO32(MAC_TEST_REG_8860D4) = (MMIO32(MAC_TEST_REG_8860D4) & ~0xfeu) | 0x22446688u;
            st = 0x12340000;
        }
        break;
    case 1:                                            /* 0x8fa984 */
        fw_log_emit2(0x20, 0x101be58, c->arg[0], c->arg[1]);
        if (platform_is_fpga() == 0) {
            MMIO32(PHY_TX_TEST_88405C) = c->arg[0];
            st = 1;
        } else {
            if (c->arg[0] & ~0x7fu)
                fw_sysassert_fatal(caller(), 0xac);
            MMIO32(MAC_TEST_REG_8860D4) = (c->arg[0] << 1) | (MMIO32(MAC_TEST_REG_8860D4) & ~0xfeu);
            st = 0x12340001;
        }
        buf->data[0] = c->arg[0];
        buf->data[1] = c->arg[1] + 3;
        len = 0x10;
        break;
    case 0x305:                                        /* 0x8fa9e4 */
        fw_log_emit0(0x10, 0x101be8c);
        break;
    case 0x306:                                        /* 0x8fa912 */
        fw_log_emit0(0x10, 0x101be08);
        break;
    case 0x700:                                        /* 0x8fa9f4 */
        hwf_calib_all();
        st = 1;
        break;
    case 0x97f:                                        /* 0x8fa9fe */
        sdp_drive_pin_timed(c->arg[0]);
        st = 1;
        break;
    case 0x981:                                        /* 0x8faa0a */
        hwf_rf_config(c->arg[0]);
        st = 1;
        break;
    case 0x983:                                        /* 0x8faa2e */
        /* Аргументы — младшие байты слов 0..7 (ldb, без знака; commit 0..255). */
        hwf_sector_rf_chain_set((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12],
                                (u32)c->arg8[16], (u32)c->arg8[20], (u32)c->arg8[24],
                                (s32)(u32)c->arg8[28]);
        st = 1;
        break;
    case 0x984: {                                      /* 0x8faa50 */
        u8 v[4] = { 0 };                               /* шаблон 0x8036ac — нули */

        hwf_sector_rf_chain_get((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], v);
        buf->data[0] = *(u32 *)v;
        len = 0xc;
        st = 1;
        break;
    }
    case 0xa01:                                        /* 0x8faa16 */
        buf->data[0] = xpm_accumulate_bits();
        len = 0xc;
        st = 1;
        break;
    case 0xa02:                                        /* 0x8faa26 */
        buf->data[0] = bits_lowest_set_bit8((u32)c->arg8[0]);
        len = 0xc;
        st = 1;
        break;
    case 0xa03:                                        /* 0x8fad4a */
        fw_log_emit0(0x21, 0x101c4a8);
        memset0_words((void *)&buf->status, 0xec);
        st = hwf_calib_lo_power_flow((u32)c->arg8[0], (u32)c->arg8[4], c->arg[2], c->arg[3], c->arg[4], (u32)c->arg8[20],
                                     *(volatile u8 *)&rf_obj.rf_idx);
        break;
    case 0x98a: {                                      /* 0x8faa6e: чтение байта XPM */
        u32 rf = c->arg[0], bit = c->arg[1];
        u8 v;

        fw_log_emit2(0x21, 0x101bee0, rf, bit);
        buf->data[0] = 0;
        if (xpm_byte_check_inputs(rf, bit, 0) == 1) {
            v = 0xff;
            st = hwf_rf_xpm_read_byte(rf, bit, &v);
            buf->data[0] = v;
            fw_log_emit2(0x21, 0x101bf3c, st, v);
        } else {
            fw_log_emit0(1, 0x101bf80);
        }
        len = 0xc;
        break;
    }
    case 0x98b: {                                      /* 0x8faad2: чтение блока XPM */
        u32 rf = c->arg[0], addr = c->arg[1], n = c->arg[2];

        fw_log_emit3(0x21, 0x101bfc4, rf, addr, n);
        if (xpm_block_check_inputs(rf, addr, n, (void *)buf->data, mb->tx_entry_size - 8, 0) == 1)
            st = hwf_rf_xpm_read_block(rf, addr, n, (void *)buf->data);
        else
            fw_log_emit0(1, 0x101c038);
        len = (u16)(n + 8);
        break;
    }
    case 0x98c: {                                      /* 0x8fab3a: прожиг бита */
        u32 rf = c->arg[0], bit = c->arg[1], wait = c->arg[2], trials = c->arg[3];

        fw_log_emit3(0x21, 0x101c07c, rf, bit, wait);
        fw_log_emit1(0x21, 0x101c0fc, trials);
        if (xpm_byte_check_inputs(rf, bit, 0) == 1)
            st = hwf_rf_xpm_program_bit(rf, bit, wait, trials);
        else
            fw_log_emit0(1, 0x101bf80);
        break;
    }
    case 0x98d: {                                      /* 0x8fab92: прожиг байта */
        u32 rf = c->arg[0], bit = c->arg[1], val = (u32)c->arg8[8];
        u32 wait = c->arg[3], trials = c->arg[4], verify = c->arg[5];

        fw_log_emit3(0x21, 0x101c114, rf, bit, val);
        fw_log_emit3(0x21, 0x101c184, wait, trials, verify);
        if (xpm_byte_check_inputs(rf, bit, 0) == 1)
            st = hwf_rf_xpm_program_byte(rf, bit, val, wait, trials, verify);
        else
            fw_log_emit0(1, 0x101c1cc);
        break;
    }
    case 0x98e: {                                      /* 0x8fac00: запись блока */
        u32 rf = c->arg[0], addr = c->arg[1], n = c->arg[2];
        u32 wait = c->arg[3], trials = c->arg[4], verify = c->arg[5];
        const u8 *src = (const u8 *)&c->arg[6];      /* данные блока — с +0x1c */

        fw_log_emit3(0x21, 0x101c214, rf, addr, n);
        fw_log_emit3(0x21, 0x101c184, wait, trials, verify);
        /* предел — rx_entry_size (+0x70) − 0x1c (у чтения — tx_entry_size +0x74; так у vendor) */
        if (xpm_block_check_inputs(rf, addr, n, src, mb->rx_entry_size - 0x1c, 0) == 1 &&
            n < 72) {
            st = hwf_rf_xpm_write_block(rf, addr, n, src, wait, trials, verify);
        } else {
            st = 0;
            fw_log_emit0(1, 0x101c288);
        }
        break;
    }
    case 0x98f: {                                      /* 0x8fac90: запись конфигурации */
        u32 rf = c->arg[0];

        fw_log_emit1(0x21, 0x101c2d0, rf);
        if (rf_check_rf_id(rf, 0x101c318, 0) == 1) {
            hwf_rf_xpm_cfg_set(rf, (const u32 *)&c->arg[1]);
            st = 1;
        } else {
            fw_log_emit0(1, 0x101c32c);
        }
        break;
    }
    case 0x990: {                                      /* 0x8facd0: чтение конфигурации */
        u32 rf = c->arg[0];

        fw_log_emit1(0x21, 0x101c36c, rf);
        if (rf_check_rf_id(rf, 0x101c3b4, 0) == 1) {
            hwf_rf_xpm_cfg_get(rf, (u32 *)buf->data);
            st = 1;
        } else {
            fw_log_emit0(1, 0x101c3c8);
        }
        len = 0x88;
        break;
    }
    case 0x991: {                                      /* 0x8fad12: режим конфигурации */
        u32 rf = c->arg[0], mode = c->arg[1];

        fw_log_emit2(0x21, 0x101c408, rf, mode);
        if (xpm_enter_cfg_step(rf, mode, 0) == 1)
            st = hwf_rf_xpm_enter_cfg_mode(rf, mode);
        else
            fw_log_emit0(1, 0x101c460);
        break;
    }
    default:                                           /* 0x8fad90 (и 0x980, 0x982) */
        wmi_evt_send_command_not_supported(mbox, 0x900, sub, c->module_id);
        return;
    }
    buf->status = st;
    wmi_evt_send_words(mbox, buf, len);
}
