// SPDX-License-Identifier: AGPL-3.0-or-later
/* WMI (fw<->host): события (fw->host) и команды (host->fw).
 * Формат из драйвера wil6210: запись кольца mbox = sync(u32)+addr(u32);
 * буфер = mbox_hdr(8) + wmi_cmd_hdr(8) + payload (struct mbox_hdr, include/mbox.h). */
#include "../include/types.h"
#include "../include/ut.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/rf_obj.h"
#include "../include/wmi.h"
#include "../include/fwdata.h"



/* Явные объявления (были блоковыми extern'ами в телах функций — вынесены наверх). */
void silent_rssi_apply_all(u32 obj);                   /* calib.c */
struct mem_pool;

/* Прежние wmi_post_event / wmi_mbox_init / wmi_send_fw_ready / wmi_send_echo_rsp (прямая
 * запись полей ящика 0x8041f0, в сборку не попадали) удалены: события — wmi_evt_post
 * (fw/tx_helpers.c), WMI_READY — wmi_evt_notify_fw_ready (fw/l2mgr.c), ящики — include/mbox.h. */

/* === WMI_UNIT_TEST (0x900) → wmi_ut_handler (0x8ed038, sub-ID dispatch) === */

__attribute__((section(".textlate"))) void hwd_abif_xtal_ctrl(u32 on)
{
    u32 v = MMIO32(HW_RGF_CAF_OSC_CONTROL);
    if (on == 1) {
        MMIO32(HW_RGF_CAF_OSC_CONTROL) = v | 1u;
        u32 i; for (i = 0; i < 0x12c; i++) if (MMIO32(RGF_CAF_PLL_LOCK_STATUS) & 1u) break;
        if (!(MMIO32(RGF_CAF_PLL_LOCK_STATUS) & 1u)) { fw_log_emit0(0, 0x101eee4); fw_sysassert_fatal(0, 0x1323); }
    } else MMIO32(HW_RGF_CAF_OSC_CONTROL) = v & ~1u;
}

__attribute__((section(".textlate"))) void hwd_abif_rosc_ctrl(u32 on)
{
    u32 v = MMIO32(HW_RGF_CAF_OSC_CONTROL);
    if (on == 1) {
        MMIO32(HW_RGF_CAF_OSC_CONTROL) = v | 2u;
        u32 i; for (i = 0; i < 0x61a80; i++) if (MMIO32(RGF_CAF_PLL_LOCK_STATUS) & 2u) break;
        if (!(MMIO32(RGF_CAF_PLL_LOCK_STATUS) & 2u)) { fw_log_emit0(0, 0x101eee4); fw_sysassert_fatal(0, 0x1324); }
    } else MMIO32(HW_RGF_CAF_OSC_CONTROL) = v & ~2u;
}


/* Частичный прежний порт UT_HW_DRIVERS (0x8eaec8): weak — полный порт подменяет. */
__attribute__((weak, section(".textlate"))) void ut_hw_drivers_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c)
{
    u32 cmd = c->subtype_id;
    u32 a0 = c->arg[0];
    (void)mb;
    switch (cmd) {
    case 0x101: abif_power_up_analog(a0); break;
    case 0x102: hwd_abif_adc_clk_ctrl(a0); break;
    case 0x103: hwd_abif_xtal_ctrl(a0); break;
    case 0x104: hwd_abif_rosc_ctrl(a0); break;
    case 0x107: hwd_abif_rfc_clk_ctrl(a0); break;
    case 0x109: hwd_abif_caf_pwdn_mode(a0); break;
    case 0x156: hwd_abif_dvs_rf_activate(a0); break;   /* vendor UT 0x156 = dvs_rf_activate */
    case 0x158: hwd_abif_dvs_rfca_cmd_enable(a0, 0); break;  /* vendor UT 0x158 = dvs_rfca_cmd_enable */
    case 0x201: car_enable_pll3_and_wait_on(); break;
    case 0x202: hwd_wait_pll_lock(); break;
    case 0x501: hwd_program_889_group(a0); break;
    case 0x502: hwd_rfc_write_core_fw((u8)a0, c->arg8[4], c->arg16[4], c->arg[3]); break;
    case 0x503: rfc_field_write((u8)a0, c->arg16[2], c->arg[2], 0); break;
    case 0x507: hwd_rfc_write_core_fw(0, 2, (u8)a0, 0); break;   /* rf_sector_commit_rx */
    case 0x508: hwd_rfc_write_core_fw(0, 3, (u8)a0, 0); break;   /* rf_sector_commit_tx */
    case 0x564: hwd_mac_sxd_rx_mode_entry(); break;
    case 0x574: hwd_mac_sxd_mode_neutral(); break;
    case 0x5bc: hwd_phy_tx_enable(a0); break;
    case 0x636: hwd_phy_rx_enable(a0); break;
    default: break;
    }
}


/* wmi_ut_handler (0x8ed038, 104 Б): WMI_UNIT_TEST. mb — ящик (r0 диспетчера), тело =
 * u16 module + u16 ut_subtype + place_holder[6] (u32 с +4). Три журнала с полями тела,
 * затем таблица 0x8021e0 (7 байтовых записей, module − 7; ldb.x, цель = 0x8ed092 + 2·запись,
 * 6.2/ref/JUMPTABLES-fw.txt):
 *   7  calib_mgr_ut (0x8eadb8)                         — тело
 *   8  нет модуля → ассерт 0x10cf (запись указывает на ветку ассерта 0x8ed0ca)
 *   9  UT_HW_FLOWS_OPERATIONAL_cmd_handler (0x8fa884)  — mb, тело    (ut_flows.c)
 *   10 UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler (0x8faf34) — mb, тело   (sysapi_stats.c)
 *   11 UT_HW_MODES_cmd_handler (0x8fada4)              — mb, тело    (ut_hw_modes.c)
 *   12 UT_HW_DRIVERS_cmd_handler (0x8eaec8)            — mb, тело    (ut_hw_drivers.c)
 *   13 power_mgr_ut (0x8eae14)                         — PS вырезан: «не поддерживается»
 * module вне 7..13 — тот же ассерт 0x10cf.
 * Прежде здесь UT_HW_DRIVERS ошибочно был модулем 11 (пропущена пустая запись 8, всё сдвинулось
 * на 1). Доказательство: запись [5] таблицы → 0x8ed0b8 → bl 0x8eaec8,
 * и сам UT_HW_DRIVERS ставит в ответ module = 0xc (0x8eaed6 mov_s r1,0xc → ut__begin_response
 * 0x8eae60, stw r1,[r0,0]); UT_HW_MODES — 0xb (0x8fadae), SYSAPI — 0xa (0x8faf8e).
 * Ответы UT — ut__begin_response (0x8eae60) / wmi_evt__send_words (0x8eae78). */

/* 0x8021e0: таблица переходов switch vendor wmi_ut_handler (0x8ed038;
 * ldb, цель = 0x8ed092 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8021e0) const u8 wmi_ut_handler_jt[7] = {
    0x00, 0x1c, 0x04, 0x09, 0x0e, 0x13, 0x18,
};

__attribute__((section(".textlate"))) void wmi_ut_handler(struct wmi_mbox *mb, const void *payload)
{
    const struct wmi_ut_cmd *c = payload;
    u32 module = c->module_id;

    fw_log_emit2(0x20, 0x1008dcc, module, c->subtype_id);   /* "WMI_UT_HANDLER:: module_id=0x%x, ut_subtype_id=0x%x" */
    fw_log_emit3(0x20, 0x1008e00, c->place_holder[0], c->place_holder[1],
                 c->place_holder[2]);                        /* "[NNL] parameters: place_holder[0..2]" */
    fw_log_emit3(0x20, 0x1008e54, c->place_holder[3], c->place_holder[4],
                 c->place_holder[5]);                        /* "[NNL] place_holder[3..5]" */
    switch (module) {
    case 7:
        calib_mgr_ut(payload);
        break;
    case 9:
        ut_hw_flows_operational_cmd_handler(mb, payload);
        break;
    case 10:
        ut_module_hw_flows_sysapi_cmd_handler(mb, payload);
        break;
    case 11:
        ut_hw_modes_cmd_handler(mb, payload);
        break;
    case 12:
        ut_hw_drivers_cmd_handler(mb, payload);
        break;
    case 13:                                       /* power_mgr_ut: PS вырезан */
        wmi_evt_send_command_not_supported(mb, 0x900, 0, 13);
        break;
    default:                                       /* 8 и вне 7..13 (sub_s r0,7; brhs r0,7) */
        fw_sysassert_fatal(__builtin_return_address(0), 0x10cf);
        break;
    }
}

/* hwd_rfc_powerup_deep_all_rfs_fw (0x8d34c0, 200 Б): вывести RF из deep power-down.
 * Таймаут [gp,0xc0] (0x800244, им задаётся пауза в rfc__restore_txrx_sets_fw) = 10; цикл:
 * восстановить TX/RX-сеты при маске RFCA 0xff, затем по каждому RF из маски [rf+0x45e]
 * прочитать RF-регистр 0x428; первая неудача (res = 0) — [gp,0xc0] = 10 (vendor пишет r15,
 * а не растущий счётчик), счётчик += 10 и всё заново, пока счётчик ≤ 200. В конце
 * [gp,0xc0] = счётчик (на стенде у vendor 0x14 — одна повторная попытка).
 * Прежний порт не повторял восстановление сетов после неудачи и не выходил из
 * перебора RF на первой неудаче. */
__attribute__((section(".textlate"))) void hwd_rfc_powerup_deep_all_rfs_fw(void)
{
    u8 list[8];
    u8 old_mask;
    u32 res = 0;
    u32 to = 10;
    u32 mask;

    rf_restore_sets_delay = 10;
    mask = (u8)rf_cfg_get_rf_mask_45e(&rf_obj);
    fw_log_emit1(0x21, 0x101e324, mask);
    for (;;) {
        hwd_abif_dvs_rfca_cmd_enable(0xff, &old_mask);
        rfc_restore_txrx_sets_fw();
        hwd_abif_dvs_rfca_cmd_enable(old_mask, 0);
        field_set_0x00_8e5dfc((u32 *)list, mask);
        while (bit_iter_has_more((u32 *)list)) {
            u32 bit = bitmap_alloc_bit((u32 *)list);
            hwd_abif_dvs_rfca_cmd_enable((u8)(1u << bit), 0);
            rfc_read_core_result_fw(0x428, &res);
            hwd_abif_dvs_rfca_cmd_enable(old_mask, 0);
            if (res == 0)
                break;
        }
        if (res == 0) {
            rf_restore_sets_delay = 10;
            to = (u8)(to + 10);
        }
        if ((int)to > 200 || res != 0)
            break;
    }
    fw_log_emit2(0x21, 0x101e350, res, to);
    if (res == 0)
        fw_log_emit0(1, 0x101e384);
    hwd_abif_dvs_rfca_cmd_enable(old_mask, 0);
    rf_restore_sets_delay = (u8)to;
}

__attribute__((section(".textlate"))) void wmi_rf_bringup_extra(void)
{
    /* MAC-parser «sniffer»-конфиг (vendor wmi_cfg_rx_chain, секция
     * "configuring PRS TBL, PRS RGFs, PRP RGFs"). Ранее биты были неверны:
     * 0x886200 bit12→bit8, 0x886258 bits16-20→bits0-4=2, 0x886838|=1 и
     * 0x886dc8=0x31000400 были пропущены. */
    MMIO32(HW_PRS_CFG_886258) = (MMIO32(HW_PRS_CFG_886258) & ~0x1fu) | 0x2u;   /* bits0-4 = 2 */
    MMIO32(HW_MAC_PRS_CTRL_0) |= 0x100u;                              /* bit8 */
    MMIO32(HW_PRP_CTRL) &= ~1u;   /* vendor l2mgr__mac_bringup → mac__set_886838_b0(0) = bit0=0 */
    MMIO32(HW_SXD_LOCAL_WR_DATA) = 0x31000400u;                          /* PRS/PRP SXD-команда */
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_0) |= 0x00000100u;   /* vendor: bit8 (PHY clock) */
    MMIO32(HW_CLKS_CTL_SW_CLK_VEC_1) |= 0x02080000u;   /* vendor: bits19+25 (RF clock) */
    hwd_rfc_write_core_fw(0, 2, 0, 0);   /* rf_sector_commit_rx(0,0) — RX sector */
    hwd_rfc_write_core_fw(0, 3, 0, 0);   /* rf_sector_commit_tx(0,0) — TX sector */
    hwd_rfc_powerup_deep_all_rfs_fw();
    abif_power_up_analog(1);
    hwd_abif_rfc_clk_ctrl(1);
    hwd_abif_caf_pwdn_mode(0);
    hwd_abif_dvs_rf_activate(0x01);
    MMIO32(HW_ABIF_DVS_CLK_CFG) |= 0x60000u;
}
