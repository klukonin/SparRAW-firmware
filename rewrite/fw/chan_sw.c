// SPDX-License-Identifier: AGPL-3.0-or-later
/* Канальный свитч: channels_switch_sm__switch_to_channel (0x8c5e64) + helper'ы. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/rf_obj.h"

/* Явные объявления (были блоковыми extern'ами в теле функций — вынесены наверх). */

/* hwd_mac_sxd_rx_mode_entry/sxd_mode_neutral — в mac.c. */
/* hwd_abif__rx_table_index_force_mode (0x8cf5a8, 68 Б): [0x88a204] — бит 0 = mode (форс
 * индекса RX-таблицы), биты 1..6 = idx: bclr_s r1,0; or_s r1,mode; bic 0x7e; or idx<<1.
 * Прежде бит 0 не сбрасывался — вызов с mode = 0 не снимал форс, и после калибровки
 * строка RX-таблицы оставалась зафиксированной (AGC не выбирала усиление). */
__attribute__((section(".textlate"))) void hwd_abif_rx_table_index_force_mode(u32 mode, u32 idx)
{
    if (mode & ~1u) fw_sysassert_fatal(__builtin_return_address(0), 0xad);
    if (idx & ~0x3fu) fw_sysassert_fatal(__builtin_return_address(0), 0xae);
    MMIO32(HW_ABIF_RX_TABLE_CTRL) = (((MMIO32(HW_ABIF_RX_TABLE_CTRL) & ~1u) | mode) & ~0x7eu) | (idx << 1);
}

/* hwd_phy__rx_agc_steps_disable (0x8d2260, 180 Б): применить AGC-шаги. */
__attribute__((section(".textlate"))) void hwd_phy_rx_agc_steps_disable(u32 on)
{
    if (on == 1) {
        MMIO32(PHY_RX_AGC_STEPS_A) = (MMIO32(PHY_RX_AGC_STEPS_A) & ~0x3fu) | 0x21u;
        MMIO32(PHY_RX_AGC_STEPS_B) = (MMIO32(PHY_RX_AGC_STEPS_B) & ~0x3fu) | 0x21u;
    } else {
        u8 g179 = chsw_rx_agc_step_c0_lo;
        u8 g181 = chsw_rx_agc_step_c4_lo;
        u8 g180 = chsw_rx_agc_step_c0_hi;
        u8 g182 = chsw_rx_agc_step_c4_hi;
        if (g179 & ~0x3fu) fw_sysassert_fatal(0, 0xae);
        MMIO32(PHY_RX_AGC_STEPS_A) = (MMIO32(PHY_RX_AGC_STEPS_A) & ~0x3fu) | g179;
        if (g181 & ~0x3fu) fw_sysassert_fatal(0, 0xae);
        MMIO32(PHY_RX_AGC_STEPS_B) = (MMIO32(PHY_RX_AGC_STEPS_B) & ~0x3fu) | g181;
        if (g180 & ~0x3fu) fw_sysassert_fatal(0, 0xae);
        MMIO32(PHY_RX_AGC_STEPS_A) = (MMIO32(PHY_RX_AGC_STEPS_A) & 0xfffff03fu) | ((u32)g180 << 6);
        if (g182 & ~0x3fu) fw_sysassert_fatal(0, 0xae);
        MMIO32(PHY_RX_AGC_STEPS_B) = (MMIO32(PHY_RX_AGC_STEPS_B) & 0xfffff03fu) | ((u32)g182 << 6);
    }
}


/* hwd_rfc_powerdown_deep_all_rfs_fw (0x8d3424, 60 Б): журнал; все RFCA принимают команды
 * (0xff, прежняя маска — в old); hwd__setup_pair(0); прежняя маска обратно; журнал. */
__attribute__((section(".textlate"))) void hwd_rfc_powerdown_deep_all_rfs_fw(void)
{
    u8 old;
    fw_log_emit0(0x21, 0x101e3c0);
    hwd_abif_dvs_rfca_cmd_enable(0xff, &old);
    hwd_setup_pair(0, 0);
    hwd_abif_dvs_rfca_cmd_enable(old, 0);
    fw_log_emit1(0x21, 0x101e3e0, old);
}

/* hwm__apply_channel_config (0x8d7b2c, 88 Б): on != 0 — принудительный индекс RX-таблицы
 * ABIF по [gp,0x95]/[gp,0x94] (0x800219/0x800218), AGC-шаги ([gp,0x96] = 0x80021a), SXD RX
 * → neutral, TX/RX PHY вкл.; on == 0 — TX/RX PHY выкл., SXD RX → neutral.
 * Прежняя версия добавляла сюда powerup_deep + маску RFCA + запись RF 0x44c — у vendor
 * их здесь нет (запись 0x44c — в hwm_analog_channel_switch, условно по [rf+0x46c]). */
__attribute__((section(".textlate"))) void hwm_apply_channel_config(u32 on)
{
    if (on != 0) {
        if (chsw_rx_table_force == 0)
            hwd_abif_rx_table_index_force_mode(0, 0);
        else
            hwd_abif_rx_table_index_force_mode(1, chsw_rx_table_index);
        hwd_phy_rx_agc_steps_disable(chsw_rx_agc_steps_disable != 0 ? 1u : 0u);
        hwd_mac_sxd_rx_mode_entry();
        hwd_mac_sxd_mode_neutral();
        hwd_phy_tx_enable(1);
        hwd_phy_rx_enable(1);
    } else {
        hwd_phy_tx_enable(0);
        hwd_phy_rx_enable(0);
        hwd_mac_sxd_rx_mode_entry();
        hwd_mac_sxd_mode_neutral();
    }
}

/* hwm_analog_channel_switch (0x8d73f4, 268 Б): переключение аналоговой части на канал ch.
 * Попытка: RF в deep power-down, делитель RFC в сброс, такт RFC выкл., FS выкл.; при v1 != 0 —
 * channel__check_range (ch, v1, v2); FS вкл. на ch, PHY-регистры канала, пауза 0x7d00×2 nop,
 * такт RFC вкл., пауза 0x190×2 nop, делитель из сброса; есть RF (rf_obj.rf_mask > 0) —
 * powerup_deep и config_channel (режим 1 только на последней попытке). Неудача config_channel —
 * счётчик [gp,0x2d8] (0x80045c) и hwm_analog__prepare_buf(0). Успех: [rf+0x46c] != 0 — маска
 * RFCA из rf и RF-регистр 0x44c := 1; затем маска RFCA = активная ([gp,0xbe] = 0x800242).
 * Попыток 10, при [gp,0x2d4] (0x800458) != 0 — одна.
 * ХРУПКО: паузы vendor (lp 0x7d00 и 400 итераций по 2 nop_s, 0x8d744c / 0x8d7464) — той же
 * формой arc_zol_nops2 (такты = vendor). */
void hwm_analog_channel_switch(u32 ch, u32 v1, u32 v2)
{
    u32 tries = (chsw_single_attempt != 0) ? 10u : 0u;
    u32 ok;

    do {
        tries = (u8)(tries + 1);
        hwd_rfc_powerdown_deep_all_rfs_fw();
        hwd_abif_rgf_889380(1);
        hwd_abif_rfc_clk_ctrl(0);
        hwd_abif_fs_off(0);
        if (v1 != 0)
            channel_check_range(ch, v1, v2);
        hwd_abif_fs_on(ch);
        phy_program_channel_regs(ch);
        arc_zol_nops2_shl(0x7d, 8);     /* vendor 0x8d7446: mov_s 0x7d; asl_s 8; lp × 2 nop_s */
        hwd_abif_rfc_clk_ctrl(1);
        arc_zol_nops2(0x190);           /* vendor 0x8d745e: lp 400 × 2 nop_s */
        hwd_abif_rgf_889380(0);
        if ((int)rf_cfg_get_rf_mask_45e(&rf_obj) <= 0) {
            ok = 1;
            break;
        }
        hwd_rfc_powerup_deep_all_rfs_fw();
        ok = marlon_r_if_class_config_channel(&rf_obj, ch, tries < 10 ? 0u : 1u);
        if (ok == 0) {
            chsw_config_fail_count += 1;
            hwm_analog_prepare_buf(0);
        } else if (rf_obj.role_pwr_flag != 0) {
            hwd_abif_dvs_rfca_cmd_enable(rf_cfg_get_rf_mask_45e(&rf_obj), 0);
            rfc_field_write(0, 0x44c, 1, 0);
        }
        if (ok == 1)
            hwd_abif_dvs_rfca_cmd_enable(rf_active_mask, 0);
    } while (ok == 0 && tries <= 10);
    fw_log_emit1(0x21, 0x101d064, ch + 1);
}

/* hwm_analog_channel_switch__thunk_arg1_zero (0x8d73ec): r1 = r2 = 0. */
void hwm_analog_channel_switch_thunk(u32 ch)
{
    hwm_analog_channel_switch(ch, 0, 0);
}

/* channels_switch_sm__switch_to_channel (0x8c5e64, 112 Б). Тот же канал ([gp,-0xc8] =
 * 0x8000bc) при уже выполненной настройке ([gp,0xcc] = 0x800250): в состояниях калибровки
 * ([gp,-0x14] = 0x800170) кроме 3/4 — пропуск (0); в 3/4 — пропуск только в режиме PCP/AP
 * ([gp,0xce] = 0x800252), иначе настройка заново. Прежний порт инвертировал условие и
 * писал канал в 0x800152 (st.as — смещение ×4: [gp,-0x32] = 0x8000bc). Возврат 1 —
 * канал настроен. */
__attribute__((section(".textlate"))) u32 channels_switch_sm_switch_to_channel(u32 ch)
{
    if (ch == chsw_cur_channel && chsw_configured != 0) {
        u32 st = calib_sys_state;
        if (st != 3 && st != 4)
            return 0;
        if (chsw_pcp_ap_mode != 0)
            return 0;
    }
    fw_log_emit1(0x26, 0x1009384, ch);
    chsw_configured = 1;
    chsw_cur_channel = ch;
    chan_sw_set_active_channel(ch);
    hwm_analog_channel_switch_thunk(ch);
    hwm_apply_channel_config(1);
    if (chsw_pcp_ap_mode == 1 || calib_sys_state == 3 || calib_sys_state == 4)
        power_mngr_check_mode(0);
    return 1;
}
