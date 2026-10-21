// SPDX-License-Identifier: AGPL-3.0-or-later
/* UT-модуль 12 (HW_DRIVERS) WMI_UNIT_TEST: полный порт UT_HW_DRIVERS_cmd_handler (vendor
 * 0x8eaec8, 3314 Б, 177 подкоманд в девяти таблицах переходов 0x8039f4..0x803b54 + прямые
 * сравнения) и помощники, у которых нет другого владельца (channel__check_range и др.). */
#include "types.h"
#include "hw.h"
#include "arc.h"
#include "calib.h"
#include "ut.h"
#include "fwdata.h"

/* Внешние функции (другие файлы fw/), которых нет в calib.h / ut.h. */
/* ABIF/CAR */
/* ABIF — abif_ext.c */
/* CAR / MAC / PHY / PCIe */
/* RFC */
/* RFC — rf_sector.c */
/* UT_HW_DRIVERS: помощники — misc_ext.c */
/* PCIe / XPM — mac_ext.c */
/* PHY — phy_ext.c */

#define CALLER() ((void *)__builtin_return_address(0))

/* ===================== помощники без другого владельца ===================== */

/* 0x803954: таблица переходов vendor channel__check_range (0x8cfadc): ldb.x, 4 записи (ch 0..3;
 * JUMPTABLES-fw.txt насчитал 3), цель = 0x8cfb04 + 2·запись. Наш порт её не читает — объект
 * держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803954) __attribute__((aligned(1))) const u8 channel_check_range_jt[4] = {
    0x00, 0x1c, 0x38, 0x54,
};

/* channel__check_range (0x8cfadc, 304 Б; зовёт и sysapi_stats.c): пара регистров канала ch (0..3):
 * [0x889420 + 8·ch] биты 0..9 = a (a > 0x3ff — ассерт 0xac), [0x889424 + 8·ch] биты 0..23 = b
 * (b > 0xffffff — ассерт 0xac); после ассерта vendor всё равно пишет (b_s назад к записи).
 * ch > 3 — журнал 0x101f0d4 (ch + 1, 4, 0) и ассерт 0x1457. Таблица 0x803954 (4 байта:
 * 00 1c 38 54 → 0x8cfb04/0x8cfb3c/0x8cfb74/0x8cfbac, проверено по fw_data.bin). */
void channel_check_range(u32 ch, u32 a, u32 b)
{
    u32 ra, rb;

    if (ch > 3) {
        fw_log_emit3(0, 0x101f0d4, ch + 1, 4, 0);       /* r4 = r0 после mov_s r0,0 */
        fw_sysassert_fatal(CALLER(), 0x1457);
        return;
    }
    ra = ABIF_FS_CH1_INT + ch * 8;
    rb = ra + 4;
    if (a & 0xfffffc00u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(ra) = a | (MMIO32(ra) & 0xfffffc00u);
    if (b & 0xff000000u)
        fw_sysassert_fatal(CALLER(), 0xac);
    MMIO32(rb) = (MMIO32(rb) & 0xff000000u) | b;
}

/* ut_hw_drivers__noop_hook [0x8d1b28, 2 Б]: пустая заглушка (j_s [blink]) — vendor
 * ничего не делает; NAMES-EXTRA: «пустая заглушка UT-команд драйверов». */
static void ut_hw_drivers_noop_hook(void)
{
}

/* ===================== UT_HW_DRIVERS_cmd_handler ===================== */

/* Тело команды — struct ut_cmd (include/ut.h): arg[k] — ld [payload + 4 + 4k], arg8 — ldb
 * (нулевое расширение), arg_s8 — ldb.x, arg16 — ldh/ldw, arg_s16 — ldh.x/ldw.x. */

/* 0x8039f4: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 44 записей, цель = 0x8eaf76 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8039f4) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt0[44] = {
    0x0ec, 0x0f1, 0x0f6, 0x0fb, 0x100, 0x106, 0x10a, 0x10f, 0x114, 0x119,
    0x11e, 0x166, 0x16c, 0x173, 0x179, 0x17f, 0x184, 0x18c, 0x194, 0x198,
    0x19f, 0x1a3, 0x1ab, 0x1b5, 0x1bd, 0x618, 0x1cb, 0x1d2, 0x1e1, 0x1ed,
    0x1f4, 0x1fb, 0x202, 0x208, 0x20e, 0x22b, 0x230, 0x235, 0x23a, 0x23e,
    0x242, 0x246, 0x24a, 0x24f,
};

/* 0x803a4c: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 36 записей, цель = 0x8eaf9e + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803a4c) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt1[36] = {
    0x244, 0x1d3, 0x1b1, 0x10f, 0x114, 0x11b, 0x122, 0x128, 0x137, 0x143,
    0x147, 0x14b, 0x604, 0x604, 0x604, 0x604, 0x604, 0x604, 0x248, 0x250,
    0x257, 0x25e, 0x264, 0x26a, 0x1c4, 0x604, 0x604, 0x604, 0x604, 0x604,
    0x604, 0x604, 0x604, 0x604, 0x271, 0x275,
};

/* 0x803a94: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 16 записей, цель = 0x8eafc6 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803a94) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt2[16] = {
    0x276, 0x288, 0x28f, 0x297, 0x29c, 0x2a2, 0x2ac, 0x5f0, 0x5f0, 0x5f0,
    0x5f0, 0x5f0, 0x5f0, 0x2b1, 0x2b6, 0x2bc,
};

/* 0x803ab4: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 5 записей, цель = 0x8eb044 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803ab4) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt3[5] = {
    0x290, 0x295, 0x299, 0x29d, 0x2a1,
};

/* 0x803ac0: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 44 записей, цель = 0x8eb06c + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803ac0) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt4[44] = {
    0x296, 0x29a, 0x29e, 0x2a3, 0x2a8, 0x2ad, 0x2b5, 0x2b9, 0x2c0, 0x2c5,
    0x2cc, 0x2d0, 0x2d7, 0x2de, 0x2e5, 0x2ea, 0x2f8, 0x2fd, 0x303, 0x59d,
    0x309, 0x30e, 0x313, 0x31b, 0x320, 0x328, 0x33c, 0x340, 0x345, 0x34c,
    0x353, 0x357, 0x35b, 0x369, 0x370, 0x37c, 0x390, 0x394, 0x398, 0x3a7,
    0x3ba, 0x3d0, 0x3ef, 0x402,
};

/* 0x803b18: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 9 записей, цель = 0x8eb0a6 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803b18) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt5[9] = {
    0x3ef, 0x3f3, 0x3f8, 0x3fd, 0x400, 0x403, 0x407, 0x40b, 0x414,
};

/* 0x803b2c: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 10 записей, цель = 0x8eb0c2 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803b2c) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt6[10] = {
    0x41f, 0x426, 0x42b, 0x431, 0x437, 0x43e, 0x445, 0x44a, 0x457, 0x45c,
};

/* 0x803b40: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 10 записей, цель = 0x8eb0e8 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803b40) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt7[10] = {
    0x45c, 0x468, 0x473, 0x47e, 0x485, 0x490, 0x497, 0x4ab, 0x4d5, 0x4de,
};

/* 0x803b54: таблица переходов vendor UT_HW_DRIVERS_cmd_handler (0x8eaec8): ldh.as.x, 5 записей, цель = 0x8eb10e + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803b54) __attribute__((aligned(2))) const u16 ut_hw_drivers_cmd_handler_jt8[5] = {
    0x4e0, 0x4e5, 0x4eb, 0x4f0, 0x4ff,
};

/* UT_HW_DRIVERS_cmd_handler (0x8eaec8, 3314 Б). Ответ — WMI_UT_RESPONSE (0x1900) из пула
 * obj: {u16 module = 0xc, u16 subtype} (ut__begin_response), +4 статус, +8.. данные.
 * Журнал «UT_HW_DRIVERS subtype» (0x20, 0x101f1d8). На FPGA (platform_is_fpga) команда не
 * исполняется: эхо-тест — +4 = subtype + 1, +8..+0x20 = place_holder[0..6] + 1, длина 0x24.
 * Иначе диспетч по subtype (сравнения + таблицы 0x8039f4/0x803a4c/0x803a94/0x803ab4/
 * 0x803ac0/0x803b18/0x803b2c/0x803b40/0x803b54, 6.2/ref/JUMPTABLES-fw.txt). Общие хвосты:
 *   0x8ebb94/0x8eb842 — статус 1, длина 8;
 *   0x8eb9c4/0x8eb9c8 — +8 = результат, статус 1, длина 0xc (r19 = 0xc);
 *   прочие — свои длины (r2 перед 0x8ebb98).
 * Неизвестный subtype — WMI_COMMAND_NOT_SUPPORTED (0x900, subtype, module); ответ UT не
 * шлётся.
 * ХРУПКО (vendor): буфер ответа к этому моменту уже взят из пула (ut__begin_response в
 * начале) и не освобождается — утечка элемента пула при каждой неизвестной команде
 * (0x8ebba6: сразу bl 0x8e5728, r16 больше не используется). Поведение сохранено.
 * Аргументы «без явной загрузки» (bl без ld перед вызовом, напр. 0x106 fs_off) у vendor —
 * мусорные r0..r3 диспетчера; вызываемые функции их не читают. */
void ut_hw_drivers_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c)
{
    u32 subtype = (u32)c->subtype_id;
    struct ut_rsp *resp = ut_begin_response(mb, 0xc, subtype);
    u32 status = 1, len = 8;
    u32 i;
    union {                                         /* стековые буферы vendor (sp+8..sp+0xa8) */
        u32 w[0x22];
        u8 b[0x88];
        s16 h[2];
        struct phy_apu_res apu;
    } buf;

    fw_log_emit1(0x20, 0x101f1d8, subtype);
    if (platform_is_fpga() != 0) {
        resp->status = subtype + 1;
        for (i = 0; i < 7; i++)
            resp->data[i] = c->arg[i] + 1;
        wmi_evt_send_words(mb, resp, 0x24);
        return;
    }

    switch (subtype) {
    /* ---------------- ABIF 0x101..0x171 ---------------- */
    case 0x101: abif_power_up_analog(c->arg[0]); break;
    case 0x102: hwd_abif_adc_clk_ctrl(c->arg[0]); break;
    case 0x103: hwd_abif_xtal_ctrl(c->arg[0]); break;
    case 0x104: hwd_abif_rosc_ctrl(c->arg[0]); break;
    case 0x105: hwd_abif_fs_on(c->arg[0] - 1); break;              /* sub_s r0,r0,1 в слоте задержки */
    case 0x106: hwd_abif_fs_off(0); break;                     /* r0 — мусор диспетчера, не читается */
    case 0x107: hwd_abif_rfc_clk_ctrl(c->arg[0]); break;
    case 0x108: hwd_abif_caf_phy_control_mode(c->arg[0]); break;
    case 0x109: hwd_abif_caf_pwdn_mode(c->arg[0]); break;
    case 0x10a: hwd_abif_caf_lpbk_mode(c->arg[0]); break;
    case 0x10b: hwd_abif_adc_sar_vreg_ctrl(c->arg[0]); break;
    case 0x10c: hwd_abif_txrx_table_index_lpbk_mode((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x10d: hwd_abif_lpbk_mode_switches_config((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x10e: hwd_abif_tx_table_index_force_mode(c->arg[0], (u32)c->arg8[4]); break;
    case 0x10f: hwd_abif_rx_table_index_force_mode(c->arg[0], (u32)c->arg8[4]); break;
    case 0x110: hwd_abif_sar_dc_config_rgf_mode(c->arg[0]); break;
    case 0x111: hwd_abif_rx_rgf_config_sar_dc((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); break;
    case 0x112: hwd_abif_rx_rgf_update_sar_dc((u32)c->arg8[0], (u32)c->arg8[4], (u32)(s32)c->arg_s8[8]); break;
    case 0x113: hwd_abif_rx_rgf_sar_dc_load(); break;
    case 0x114:                                     /* vendor: результат чтения отбрасывается */
        hwd_abif_rx_rgf_read_sar_dc((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]);
        break;
    case 0x115: hwd_abif_sar_cal_dc_rgf_clear_all(); break;
    case 0x116: hwd_abif_rx_rgf_config_sar_gain((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); break;
    case 0x117: hwd_abif_rx_table_config_sar_dc((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16]); break;
    case 0x118: hwd_abif_rx_table_config_vga_gain((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); break;
    case 0x119: hwd_abif_rx_table_config_vga_dc((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); break;
    case 0x11b: hwd_abif_rx_table_config_ifrx_ctrl((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x11c: hwd_abif_rx_table_config_ifrx_gain((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x11d: hwd_abif_tx_table_config_dac_fssel((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x11e: hwd_abif_tx_table_config_lo_leak_gain((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x11f: hwd_abif_tx_table_config_lo_leak_ctrl((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x120: hwd_abif_tx_table_config_iftx_ctrl((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x121: hwd_abif_tx_table_config_iftx_gain((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x122: hwd_abif_tx_table_config_xif_gain((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x123: hwd_abif_tx_table_config_xif_ctrl((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x124: hwd_abif_sensor_set_thermal_mode(c->arg[0]); break;
    case 0x125: hwd_abif_sensor_measure_start(c->arg[0]); break;
    case 0x126: hwd_abif_sensor_set_comp_value(c->arg[0]); break;
    case 0x127: resp->data[0] = hwd_abif_sensor_get_comp_out(); len = 0xc; break;
    case 0x128: resp->data[0] = hwd_abif_sar_dc_config_rgf_mode_get(); len = 0xc; break;
    case 0x129: resp->data[0] = hwd_abif_rx_table_index_force_en_get(); len = 0xc; break;
    case 0x12a: resp->data[0] = abif_get_rx_table_index_force_val(); len = 0xc; break;
    case 0x12b: hwd_abif_rx_prepare_ifrx_pwdn((u32)c->arg8[0]); break;
    case 0x12c: resp->data[0] = hwd_abif_rx_prepared_ifrx_pwdn_get(); len = 0xc; break;
    case 0x12d: hwd_abif_rx_prepare_rvga_pwdn((u32)c->arg8[0]); break;
    case 0x12e: resp->data[0] = hwd_abif_rx_prepared_rvga_pwdn_get(); len = 0xc; break;
    case 0x12f: hwd_abif_tx_table_config_tx_mixer_gate_ctrl((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x130: hwd_abif_rx_table_config_vga_dc_dac_pwdn((u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x131: hwd_abif_bgap_ctrl(c->arg[0]); break;
    case 0x132: resp->data[0] = hwd_abif_rx_table_read_vga_dc((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); len = 0xc; break;
    case 0x133: hwd_abif_rx_table_config_vga_bias((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x134: resp->data[0] = hwd_abif_rx_table_read_vga_bias((u32)c->arg8[0], (u32)c->arg8[4]); len = 0xc; break;
    case 0x135:                                     /* строка RX-таблицы (3 слова) → +8 */
        hwd_abif_uses_rgf_88a208_8cf5fc((u32)c->arg8[0], buf.w);
        memcpy_fw(resp->data, buf.w, 0xc);
        len = 0x14;
        break;
    case 0x136:
        buf.w[0] = c->arg[1];
        buf.w[1] = c->arg[2];
        buf.w[2] = c->arg[3];
        hwd_abif_rx_table_write_row((u32)c->arg8[0], buf.w);
        break;
    case 0x137: resp->data[0] = hwd_abif_tx_table_index_force_en_get(); len = 0xc; break;
    case 0x138: resp->data[0] = hwd_abif_tx_table_index_force_val_get(); len = 0xc; break;
    case 0x139: hwd_abif_sensor_set_bgp_params((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x140: hwd_abif_rx_table_config_vga_atten((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); break;
    case 0x141: resp->data[0] = hwd_abif_rx_table_read_vga_atten((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); len = 0xc; break;
    case 0x142: hwd_abif_rx_table_config_vga_stg1_fine_bias((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x143: resp->data[0] = hwd_abif_rx_table_read_vga_stg1_fine_bias((u32)c->arg8[0], (u32)c->arg8[4]); len = 0xc; break;
    case 0x144: hwd_abif_battery_config(c->arg[0], c->arg[1]); break;
    case 0x145: resp->data[0] = hwd_abif_rx_table_read_vga_gain((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); len = 0xc; break;
    case 0x146:
        hwd_abif_tx_table_read_dac_fssel((u32)c->arg8[0], buf.w);
        resp->data[0] = buf.w[0];
        len = 0xc;
        break;
    case 0x150: hwd_abif_tx_table_force_reload(); break;
    case 0x151: hwd_abif_rx_table_force_reload(); break;
    case 0x152:                                     /* 4 байта (младшие байты place_holder[1..4]) */
        buf.b[0] = (u8)c->arg[1];
        buf.b[1] = (u8)c->arg[2];
        buf.b[2] = (u8)c->arg[3];
        buf.b[3] = (u8)c->arg[4];
        hwd_abif_config_vga_rows((u32)c->arg8[0], buf.b);
        break;
    case 0x153:
        buf.b[0] = (u8)c->arg[2];
        buf.b[1] = (u8)c->arg[3];
        buf.b[2] = (u8)c->arg[4];
        buf.b[3] = (u8)c->arg[5];
        hwd_abif_set_agc_column((u32)c->arg8[0], (u32)c->arg8[4], buf.b);
        break;
    case 0x154: hwd_abif_rx_table_config_vga_stg1_fine_bias_all_rows((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x155: hwd_abif_rx_table_config_vga_bias_all_rows((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); break;
    case 0x156: hwd_abif_dvs_rf_activate((u32)c->arg8[0]); break;
    case 0x157: hwd_abif_dvs_rfca_activate(c->arg[0], (u32)c->arg8[4]); break;
    case 0x158: hwd_abif_dvs_rfca_cmd_enable((u32)c->arg8[0], 0); break;
    case 0x159: hwd_abif_dvs_if_splitter_enable((u32)c->arg8[0]); break;
    case 0x160: hwd_abif_dvs_lo_splitter_enable((u32)c->arg8[0]); break;
    case 0x161: hwd_abif_dvs_lo_splitter_config_buf_val(c->arg[0], (u32)c->arg8[4]); break;
    case 0x162: hwd_abif_dvs_rfca_config_en((u32)c->arg8[0]); break;
    case 0x163: ut_hw_drivers_check_index((s32)(u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x164: resp->data[0] = rfca_get_rf_mask(); len = 0xc; break;
    case 0x170: {
        /* Номер канала 1..4 из тела передаётся channel__check_range как есть, а та ждёт
         * 0..3: ch = 4 даёт ассерт 0x1457, ch = 1..3 пишет регистры канала ch, а не ch − 1.
         * ХРУПКО (vendor, 0x8eaff0..0x8eb3c2): так и у vendor — поведение сохранено. */
        u32 ch = (u32)c->arg8[0];

        if (ch == 0 || ch > 4) {
            fw_log_emit1(0, 0x101f208, ch);
        } else {
            fw_log_emit3(0, 0x101f254, ch, c->arg[1], c->arg[2]);
            channel_check_range(ch, c->arg[1], c->arg[2]);
        }
        break;
    }
    case 0x171: hwd_abif_out_to_bump_ctl(c->arg[0], (u32)c->arg8[4]); break;

    /* ---------------- CAR / PLL 0x201..0x203 ---------------- */
    case 0x201: car_enable_pll3_and_wait_on(); break;
    case 0x202: hwd_wait_pll_lock(); break;     /* vendor грузит place_holder[0] в r0 — не читается */
    case 0x203: ut_hw_drivers_cmd_0x203(); break;

    /* ---------------- MAC SXD 0x301..0x305 ---------------- */
    case 0x301: hwd_mac_trigger_sxd_tx_mode((u32)c->arg8[0]); break;
    case 0x302: hwd_mac_sxd_rx_mode_entry(); break;
    case 0x303: hwd_mac_sxd_mode_neutral(); break;
    case 0x304: hwd_mac_sxd_tx_phy_frame_start(); break;
    case 0x305: field_set_0x00_8db5bc(c->arg[0]); break;

    /* ---------------- PHY 0x401..0x438 ---------------- */
    case 0x401: hwd_phy_self_tx_mode_entry(); break;
    case 0x402: hwd_phy_self_rx_mode_entry(); break;
    case 0x403: hwd_phy_self_mode_exit(); break;
    case 0x404: hwd_phy_self_digital_loopback(c->arg[0]); break;
    case 0x405: hwd_phy_dbg_clk_enable(c->arg[0]); break;
    case 0x406: hwd_phy_tx_enable(c->arg[0]); break;
    case 0x407: hwd_phy_tx_self_transmit((u32)c->arg16[0], c->arg[1], (u32)c->arg8[8], c->arg[3]); break;
    case 0x408: hwd_phy_tx_self_transmit_wait_completion(); break;
    case 0x409: hwd_phy_tx_singen_config((s32)c->arg[0], (s32)c->arg[1], (u32)c->arg8[8]); break;
    case 0x40a: hwd_phy_tx_singen_transmit(c->arg[0]); break;
    case 0x40b: hwd_phy_tx_play_buffer_start((u32)c->arg8[0], c->arg[1], c->arg[2]); break;
    case 0x40c: hwd_phy_tx_play_buffer_stop(); break;
    case 0x40d: hwd_phy_tx_predist_iq_config(c->arg[0], (u32)(s32)c->arg_s16[2], (u32)(s32)c->arg_s16[4]); break;
    case 0x40e: hwd_phy_tx_predist_atten_man_config(c->arg[0], (u32)c->arg8[4], (u32)c->arg8[8]); break;
    case 0x40f: hwd_phy_tx_predist_dc_config(c->arg[0], (u32)(s32)c->arg_s16[2], (u32)(s32)c->arg_s16[4]); break;
    case 0x410: hwd_phy_rx_enable(c->arg[0]); break;
    case 0x411:
        if (c->arg[0] >= 4)
            fw_sysassert_fatal(CALLER(), 0xd | (1u << 12));
        hwd_phy_rx_ina_det_mode(c->arg[0]);
        break;
    case 0x412: hwd_phy_rx_agc_steps_disable(c->arg[0]); break;
    case 0x413: hwd_phy_rx_agc_index_force_mode(c->arg[0], (u32)c->arg8[4]); break;
    case 0x414: phy_program_channel_regs(c->arg[0] - 1); break;  /* sub_s в слоте задержки */
    case 0x416: hwd_phy_rx_postdist_dc_enable(c->arg[0]); break;
    case 0x417: hwd_phy_rx_postdist_dc_per_sar_mode(c->arg[0]); break;
    case 0x418: hwd_phy_rx_postdist_sar_dc_config((s32)(u32)c->arg8[0], (s32)(u32)c->arg8[4], (u32)(s32)c->arg_s8[8]); break;
    case 0x419: hwd_phy_rx_postdist_force_dc_set(c->arg[0]); break;
    case 0x41a: hwd_phy_rx_postdist_force_dc_config((s32)c->arg_s8[0], (s32)c->arg_s8[4]); break;
    case 0x41b:
        if (c->arg[0] >= 8)
            fw_sysassert_fatal(CALLER(), 0x16 | (1u << 12));
        hwd_phy_online_measurement_config(c->arg[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg16[6], (u32)c->arg16[8], (u32)c->arg8[20]);
        break;
    case 0x41c: hwd_phy_online_measurement_start(); break;
    case 0x41d: status = hwd_phy_online_sar_measurement_valid(); break;
    case 0x41e:                                     /* два s16 (I, Q) одним словом → +8 */
        hwd_phy_online_dc_measurement_read((u32)c->arg8[0], buf.h);
        resp->data[0] = buf.w[0];
        len = 0xc;
        break;
    case 0x41f:
        hwd_phy_online_gain_measurement_read((u32)c->arg8[0], (u16 *)buf.h);
        resp->data[0] = buf.w[0];
        len = 0xc;
        break;
    case 0x420: hwd_phy_rx_statistics_lock(); break;
    case 0x421: hwd_phy_rx_statistics_clear(); break;
    case 0x422:                                     /* 14 счётчиков → +8 (0x38 Б) */
        phy_read_rx_counters(buf.w);
        memcpy_fw(resp->data, buf.w, 0x38);
        len = 0x40;
        break;
    case 0x423: hwd_phy_rx_cal_corr_config(c->arg[0], (u32)c->arg8[4], (s32)c->arg[2]); break;
    case 0x424:
        hwd_phy_rx_cal_corr((s32 *)buf.w);
        resp->data[0] = buf.w[0];
        resp->data[1] = buf.w[1];
        len = 0x10;
        break;
    case 0x425:
        if (c->arg[0] >= 8)
            fw_sysassert_fatal(CALLER(), 0x1f | (1u << 12));
        hwd_phy_rx_sar_cal_measurement_config(1, c->arg[0], (u32)c->arg8[4], (u32)c->arg8[8], c->arg[3], c->arg[4]);
        break;
    case 0x426: hwd_phy_rx_sar_measurement_start(); break;
    case 0x427: hwd_phy_rx_sar_measurement_completed(); break;
    case 0x428:
        hwd_phy_read_sar_sample((u32)c->arg8[0], buf.w);
        memcpy_fw(resp->data, buf.w, 0x10);
        len = 0x18;
        break;
    case 0x429:
        hwd_phy_rx_cal_gain_measurement_read((u32)c->arg8[0], buf.w);
        memcpy_fw(resp->data, buf.w, 0x10);
        len = 0x18;
        break;
    case 0x42a:
        hwd_phy_rx_apu_calc((u32)c->arg8[0], (u32)(s32)c->arg_s16[2], (u32)(s32)c->arg_s16[4],
                            (u32)(s32)c->arg_s16[6], (u32)(s32)c->arg_s16[8],
                            (u32)(s32)c->arg_s16[10], &buf.apu);
        memcpy_fw(resp->data, &buf.apu, 0xc);
        len = 0x14;
        break;
    case 0x42b:
        if (c->arg[3] >= 0xd)
            fw_sysassert_fatal(CALLER(), 0x25 | (1u << 12));
        if (c->arg[4] >= 0x20)
            fw_sysassert_fatal(CALLER(), 0x2e | (1u << 12));
        hwd_phy_recording_mode_set((s32)(u32)c->arg8[0], c->arg[1], c->arg[2], c->arg[3], c->arg[4]);
        break;
    case 0x42c:
        /* ХРУПКО: vendor копирует хосту все 0x88 Б стекового буфера (sp+0x20), а
         * hwd_phy_recording_get заполняет лишь 2 + n слов (n ≤ 32; при ошибке — 2):
         * остаток — мусор стека vendor. Обнуляем, чтобы не отдавать память. */
        for (i = 0; i < 0x22; i++)
            buf.w[i] = 0;
        hwd_phy_recording_get(c->arg[0], c->arg[1], buf.w);
        memcpy_fw(resp->data, buf.w, 0x88);
        len = 0x90;
        status = (buf.w[0] == 1) ? 1u : 0u;
        break;
    case 0x42d:                                     /* обнулённое слово, пустой хук, → +8 */
        memset0_words(buf.w, 4);
        ut_hw_drivers_noop_hook();
        resp->data[0] = buf.w[0];
        len = 0xc;
        break;
    case 0x42e:
        hwd_phy_rx_sar_rssi_measure(c->arg[0], (s32 *)buf.w);
        resp->data[0] = buf.w[0];
        len = 0xc;
        break;
    case 0x430: hwd_phy_store_txrx_swap_iq(); break;
    case 0x431: hwd_phy_set_tx_swap_iq(c->arg[0]); break;
    case 0x432: hwd_phy_set_rx_swap_iq(c->arg[0]); break;
    case 0x433: resp->data[0] = phy_get_rx_ina_det_mode(); len = 0xc; break;
    case 0x434: resp->data[0] = hwd_phy_dbg_clk_enable_get(); len = 0xc; break;
    case 0x435: hwd_phy_online_measurement_stop(); break;
    case 0x436: hwd_phy_online_measurement_completed(); break;
    case 0x437:
        resp->data[0] = ut_hw_drivers_pair_2568((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16]);
        len = 0xc;
        break;
    /* 0x438 (поправки TOF) — только SparRAW-pro; здесь default. */

    /* ---------------- RFC 0x501..0x51e ---------------- */
    case 0x501: hwd_program_889_group(c->arg[0]); break;
    case 0x502: hwd_rfc_write_core_fw((u32)c->arg8[0], (u32)c->arg8[4], c->arg[2], c->arg[3]); break;
    case 0x503: rfc_field_write(0, c->arg[0], c->arg[1], 0); break;      /* r3 — мусор, не читается */
    case 0x504: resp->data[0] = hwd_rfc_read_rgf(0, c->arg[0]); len = 0xc; break;
    case 0x505: rf_sector_commit_rx(0, (u32)c->arg8[0]); break;
    case 0x506: rf_sector_commit_tx(0, (u32)c->arg8[0]); break;
    case 0x507: ut_hw_drivers_cmd_0x507(0, (u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x508: ut_hw_drivers_cmd_0x508(0, (u32)c->arg8[0], (u32)c->arg8[4]); break;
    case 0x509: hwd_rfc_write_core_fw_mode1(0); break;
    case 0x50a:
        if (c->arg[0] == 1)
            hwd_setup_pair(0, 0);                   /* r1 — мусор, не читается */
        else
            rfc_restore_txrx_sets_fw();
        break;
    case 0x50b: hwd_rfc_uses_rgf_889100(); break;
    case 0x50c:
        hwd_rfc_sector_edge_gain_set((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], (s32)(u32)c->arg8[20]);
        break;
    case 0x50d: resp->data[0] = hwd_rfc_read_sector_chain((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); len = 0xc; break;
    case 0x50e:
        hwd_rfc_sector_edge_phase_set((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (s32)(u32)c->arg8[12], (u32)c->arg8[16], (s32)(u32)c->arg8[20]);
        break;
    case 0x50f:
        resp->data[0] = ut_hw_drivers_cmd_0x50f((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (s32)(u32)c->arg8[12]);
        len = 0xc;
        break;
    case 0x510:
        hwd_rfc_sector_dist_gain_set((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], (s32)(u32)c->arg8[20]);
        break;
    case 0x511: resp->data[0] = hwd_rfc_read_sector_reg((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); len = 0xc; break;
    case 0x512:
        hwd_rfc_sector_x16_state_set((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12], (u32)c->arg8[16], (s32)(u32)c->arg8[20]);
        break;
    case 0x513: resp->data[0] = ut_hw_drivers_cmd_0x513((u32)c->arg8[0], (u32)c->arg8[4], (u32)c->arg8[8], (u32)c->arg8[12]); len = 0xc; break;
    case 0x514:
        hwd_program_rf_regs_seq((u32)c->arg8[0], c->arg[1], (u32)c->arg8[8], c->arg[3], c->arg[4], c->arg[5], c->arg[6],
                                c->arg[7], c->arg[8], (u8)(u32)c->arg8[36]);
        break;
    case 0x515:
        /* Шаблон 0x80399c (0x18 Б) в fw_data — нули (6.2/build/fw_data.bin @0x399c):
         * memcpy_fw шаблона заменён обнулением. */
        for (i = 0; i < 6; i++)
            buf.w[i] = 0;
        rfc_read_sector_params((u32)c->arg8[0], c->arg[1], (u32)c->arg8[8], &buf.w[0], &buf.w[1], &buf.w[2],
                               &buf.w[3], &buf.w[4], &buf.w[5]);
        memcpy_fw(resp->data, buf.w, 0x18);
        len = 0x20;                                 /* r18 = 0x20 из пролога */
        break;
    case 0x516:
        buf.b[0] = 0;
        rfc_probe_modules((u32)c->arg8[0], buf.b);
        resp->data[0] = buf.b[0];
        len = 0xc;
        break;
    case 0x517:
        /* Шаблон 0x8039b4 (0x40 Б) — нули (fw_data.bin @0x39b4): обнуление вместо копии. */
        for (i = 0; i < 0x10; i++)
            buf.w[i] = 0;
        rfc_collect_rx_crc_stats((u32)c->arg8[0], buf.w);
        memcpy_fw(resp->data, buf.w, 0x40);
        len = 0x48;
        break;
    case 0x518: xpm_wave_rd_set(c->arg[0], c->arg[1], c->arg[2]); break;
    case 0x519: resp->data[0] = xpm_read_cfg_378(c->arg[0], c->arg[1]); len = 0xc; break;
    case 0x51a: xpm_write_cfg_350(c->arg[0], c->arg[1], c->arg[2]); break;
    case 0x51b: resp->data[0] = xpm_read_cfg_350(c->arg[0], c->arg[1]); len = 0xc; break;
    case 0x51c: {                                   /* RFC 0x504: ниббл 0 (≠0) или 1 (0) */
        u32 v = hwd_rfc_read_rgf(0, 0x504);

        if (c->arg[0] == 0)
            v >>= 4;
        resp->data[0] = v & 0xfu;
        len = 0xc;
        break;
    }
    case 0x51d: {                                   /* RFC 0x504: запись ниббла 0 / 1 */
        u32 sel = c->arg[0], v;

        if (c->arg[1] & ~0xfu)
            fw_sysassert_fatal(CALLER(), 0x1545);
        v = hwd_rfc_read_rgf(0, 0x504);
        if (sel != 0)
            v = (v & ~0xfu) | c->arg[1];
        else
            v = (v & ~0xf0u) | (c->arg[1] << 4);
        rfc_field_write(0, 0x504, v, 0);
        break;
    }
    case 0x51e: hwd_rfc_read_calibrate(c->arg[0]); break;

    /* ---------------- PCIe / SDP 0x601..0x611 ---------------- */
    case 0x601: hwd_pcie_port1_serdes_reset(c->arg[0]); break;
    case 0x602: hwd_pcie_set_mode_map(c->arg[0]); break;
    case 0x610: {
        u32 a, b;

        ut_hw_drivers_zero_result(&a, &b);
        resp->data[0] = a;
        resp->data[1] = b;
        len = 0x10;
        break;
    }
    case 0x611: ut_hw_drivers_step_8f4480(c->arg[0], c->arg[1], c->arg[2]); break;

    /* 0x700: «не поддерживается» событием WMI, но ответ UT (статус 1) всё равно уходит. */
    case 0x700: ut_hw_drivers_reply_not_supported(mb, c); break;

    default:                                        /* 0x8ebba6 */
        wmi_evt_send_command_not_supported(mb, 0x900, subtype, (u32)c->module_id);
        return;
    }
    resp->status = status;
    wmi_evt_send_words(mb, resp, len);
}
