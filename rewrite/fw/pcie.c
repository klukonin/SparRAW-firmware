// SPDX-License-Identifier: AGPL-3.0-or-later
/* PCIe: прерывания PERST/D3, загрузочная инициализация (WBE_DRIVER::pcie_boot_init),
 * DBI-доступ к config-space, L1/L1SS. */
#include "../include/types.h"
#include "../include/hw.h"

/* hwd_pcie__clear_and_mask_interrupts (0x8d1a78): лог + RGF 0x882f80: IMS [+0x5c] и
 * ICR [+0x50] = 0xffffffff. */
void pcie_mask_interrupts(void)
{
    fw_log_emit0(0x20, 0x101dd10);              /* "Clear and mask PCIe interrupts" */
    MMIO32(HW_UNIT_ICR_PORT0_LTSSM_DBG_1_IMV) = 0xffffffffu;
    MMIO32(HW_UNIT_ICR_PORT0_LTSSM_DBG_1_ICR) = 0xffffffffu;
}

/* hwd_pcie_perst_deassert_int_clear (0x8d198c). */
void pcie_perst_deassert_int_clear(void)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_ICR) = 0x20;
}

/* hwd_pcie_perst_deassert_int_en (0x8d1998). */
void pcie_perst_deassert_int_en(void)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMC) = 0x20;
}

/* hwd_pcie_perst_assert_int_en (0x8d1980). */
void pcie_perst_assert_int_en(void)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMC) = 0x10;
}

/* hwd_pcie_enter_d3_int_en (0x8d1240). */
void pcie_enter_d3_int_en(void)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMC) = 0x20000000;
}

/* ---- загрузочная инициализация PCIe ---- */


/* Запись бита hotplug-контрола (0x8f8094): [0x88265c] бит bit = val; бит 0 пишется
 * значением бита 1 (vendor: (old & 2) >> 1 | ...). */
void pcie_hp_ctrl_write_bit(u32 bit, u32 val)
{
    u32 cur = MMIO32(HW_RGF_HP_CTRL);
    u32 old = (cur & 2) >> 1;
    u32 v = (val << bit) | (cur & ~(1u << bit));
    v &= ~1u;
    MMIO32(HW_RGF_HP_CTRL) = old | v;
}

/* (0x8f3d6c): при [0x8825c0] бит 1 — [0x800094] ([gp,-60] .as) = 0. */
void pcie_serdes_clear_flag_if_bit1(void)
{
    if (MMIO32(HW_PCIE_MODE_FLAGS) & (1u << 1))
        pcie_serdes_bit1_flag = 0;
}

/* hwd_pcie__port1_serdes_reset (0x8d1a00): flag ≠ 0 — сброс SerDes1: [0x880b08] бит 11,
 * перезапись [0x880b04] прочитанным значением, [0x882224] &= ~6; flag = 0 — обратно
 * (бит 11 снять, та же перезапись 0x880b04, [0x882224] |= 6). Прежде в ветке flag = 0 не
 * было перезаписи 0x880b04. */
void hwd_pcie_port1_serdes_reset(u32 flag)
{
    u32 v = MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1);
    if (flag != 0) {
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) = v | (1u << 11);
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) = MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0);
        MMIO32(HW_PCIE_SERDES1_CTL) &= ~6u;
    } else {
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) = v & ~(1u << 11);
        MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) = MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0);
        MMIO32(HW_PCIE_SERDES1_CTL) |= 6u;
    }
}

/* EP под SerDes? (0x8d1470): инверсия бита 3 регистра 0x8825bc. */
u32 hwd_pcie_is_ep_under_serdes(void)
{
    return ((MMIO32(HW_PCIE_TOPOLOGY_CTL) >> 3) ^ 1u) & 1u; /* vendor 0x8d147a: bxor — инверсия бита 3 */
}

/* hwd_pcie__get_ltssm_state (0x8d13fc): LTSSM (5 бит) из 0x8820c0 или, под SerDes, 0x88258c. */
u32 hwd_pcie_get_ltssm_state(void)
{
    if (hwd_pcie_is_ep_under_serdes() == 0)
        return MMIO32(HW_PCIE_SW_LTSSM_STATE) & 0x1f;
    return MMIO32(HW_PCIE_SERDES_LTSSM_STATE) & 0x1f;
}

/* hwd_pcie__is_l1_state (0x8d1054): LTSSM 0x11/0x12 — L1. */
u32 hwd_pcie_is_l1_state(void)
{
    u32 s = hwd_pcie_get_ltssm_state();
    return (s == 0x11 || s == 0x12) ? 1u : 0u;
}

/* hwd_pcie_config_lnkctl (0x8d17f8) / l1_pm_sub_ctl_get (0x8d164c) / lnkctl_set (0x8d1828):
 * DBI-чтение/запись LnkCtl (0x80) и L1 PM Substates Control (0x158); не под SerDes — лог
 * «EP under SWITCH Not supported». */
void hwd_pcie_config_lnkctl(u32 *out)
{
    if (hwd_pcie_is_ep_under_serdes() == 0)
        fw_log_emit0(1, 0x101de50);
    else
        pcie_dbi_read(0x80, 0, 1, 0, 0, 1, out);
}

void hwd_pcie_l1_pm_sub_ctl_get(u32 *out)
{
    if (hwd_pcie_is_ep_under_serdes() == 0)
        fw_log_emit0(1, 0x101de10);
    else
        pcie_dbi_read(0x158, 0, 1, 0, 0, 1, out);
}

void hwd_pcie_lnkctl_set(u32 *v)
{
    if (hwd_pcie_is_ep_under_serdes() == 0)
        fw_log_emit0(1, 0x101de8c);
    else
        dbi_write(0x80, *v, 0, 1, 0, 0, 1, 1, 0);
}

/* hwd_pcie_l1_pm_sub_ctl_set (0x8d167c): DBI-запись 0x158 без проверки SerDes. */
void hwd_pcie_l1_pm_sub_ctl_set(u32 *v)
{
    dbi_write(0x158, *v, 0, 1, 0, 0, 1, 1, 0);
}

/* hwd_pcie__l1_entry_irq_cfg (0x8d1554): on = 0 — [0x882f88] биты 26, 29 и снять бит 6
 * [0x88b0b0]; иначе — бит 6 [0x88b0b0] и снять биты 29, 26 [0x882f88] (порядок vendor). */
static void hwd_pcie_l1_entry_cfg(u32 on)
{
    if (on == 0) {
        MMIO32(HW_PCIE_PM_CTL_88) |= 1u << 26;
        MMIO32(HW_PCIE_PM_CTL_88) |= 1u << 29;
        MMIO32(HW_PCIE_RGF_EXT_B0) &= ~(1u << 6);
    } else {
        MMIO32(HW_PCIE_RGF_EXT_B0) |= 1u << 6;
        MMIO32(HW_PCIE_PM_CTL_88) &= ~(1u << 29);
        MMIO32(HW_PCIE_PM_CTL_88) &= ~(1u << 26);
    }
}

/* Шаги pcie_serdes__program_all (0x8d1720). */

/* (0x8d173c): RGF 0x880c00. */
void hwd_pcie_uses_rgf_880c00(void)
{
    MMIO32(HW_PCIE_SERDES_CFG_C40) &= ~1u;
    MMIO32(HW_PCIE_SERDES_CFG_C54) |= (1u << 31);
    MMIO32(HW_PCIE_SERDES_CFG_C54) = (MMIO32(HW_PCIE_SERDES_CFG_C54) & 0x8000ffffu) | (1u << 16);
    MMIO32(HW_PCIE_SERDES_CFG_C54) &= 0x7fffffffu;
}

/* (0x8d17a0): «Sparrow PCIe L1SS Support enabled». */
void pcie_l1ss_enable(void)
{
    fw_log_emit0(0x21, 0x101dbd0);
    u32 serdes = hwd_pcie_is_ep_under_serdes();
    u32 v = MMIO32(HW_PCIE_L1SS_CFG);
    if (serdes == 0)
        v |= (1u << 13) | (1u << 20);
    else
        v |= (1u << 16) | (1u << 23);
    MMIO32(HW_PCIE_L1SS_CFG) = v;
    MMIO32(HW_PCIE_RGF_EXT_60) &= ~1u;
    MMIO32(HW_PCIE_RGF_EXT_2C) &= ~1u;
    MMIO32(HW_PCIE_RGF_EXT_B0) &= ~1u;
    MMIO32(HW_PCIE_L1SS_CTL) |= (1u << 17);
}

/* (0x8d1764). */
void hwd_pcie_clear_88b000_bits(void)
{
    MMIO32(HW_PCIE_RGF_EXT_2C) &= ~8u;
    MMIO32(HW_PCIE_RGF_EXT_B0) &= ~4u;
    MMIO32(HW_PCIE_SW_CFG_0) &= ~(1u << 28);
    MMIO32(HW_PCIE_SERDES_L1_HOLD) &= ~(1u << 18);
    MMIO32(HW_PCIE_SW_CTL_24) &= ~(1u << 27);
    MMIO32(HW_PCIE_SERDES_CTL_60) &= ~8u;
}

/* (0x8d196c): [0x882f88] снять бит 29, затем бит 30 (два RMW). Прежде здесь стояла
 * запись [0x882fd0] = [0x882fd4] — не та функция. */
static void hwd_pcie_clear_882f88_b29_b30(void)
{
    MMIO32(HW_PCIE_PM_CTL_88) &= ~(1u << 29);
    MMIO32(HW_PCIE_PM_CTL_88) &= ~(1u << 30);
}

/* (0x8d117c). */
void pcie_mirror_link_bit(void)
{
    u32 v = MMIO32(HW_PCIE_TOPOLOGY_CTL);
    if (MMIO32(HW_PCIE_MODE_FLAGS) & 1u)
        v |= (1u << 9);
    else
        v &= ~(1u << 9);
    MMIO32(HW_PCIE_TOPOLOGY_CTL) = v;
    MMIO32(HW_PCIE_TOPOLOGY_CTL) &= ~(1u << 21);
    MMIO32(HW_PCIE_RGF_EXT_B4) &= ~0x78u;
}

void pcie_serdes_program_all(void)
{
    hwd_pcie_uses_rgf_880c00();
    pcie_l1ss_enable();
    hwd_pcie_clear_88b000_bits();
    hwd_pcie_clear_882f88_b29_b30();
    pcie_mirror_link_bit();
}

/* Принудительно очистить L0s (0x8d14d4): [0x882028] бит 18; под SerDes — exit_l1(1),
 * LnkCtl по DBI, при включённом L0s (бит 0) — снять, exit_l1(0). */
void pcie_force_clear_l0s(void)
{
    MMIO32(HW_PCIE_SW_CTL_28) |= (1u << 18);
    if (hwd_pcie_is_ep_under_serdes() == 0)
        return;
    hwd_pcie_exit_l1(1);
    u32 v;
    pcie_dbi_read(0x80, 0, 1, 0, 0, 1, &v);
    fw_log_emit1(0x21, 0x101dc4c, v);
    if (v & 1u) {
        fw_log_emit1(0x1, 0x101dc8c, v);
        v &= ~1u;
        dbi_write(0x80, v, 0, 1, 0, 0, 1, 1, 0);
    }
    hwd_pcie_exit_l1(0);
}

/* Исправление max read request (0x8d1864): под SerDes — DevCtl (0x78) по DBI; поле
 * [14:12] ≥ 3 (> 512 Б) → 2. Прежде поле маскировалось 2 битами, в первый лог шло поле
 * вместо DevCtl. */
void pcie_fix_max_read_req(void)
{
    if (hwd_pcie_is_ep_under_serdes() == 0)
        return;
    fw_log_emit0(0x21, 0x101dd30);
    u32 v;
    pcie_dbi_read(0x78, 0, 1, 0, 0, 1, &v);
    if (((v >> 12) & 7) < 3)
        return;
    fw_log_emit1(0x1, 0x101dd70, v);
    u32 nv = (v & ~((1u << 12) | (1u << 13) | (1u << 14))) | (1u << 13);
    fw_log_emit2(0x21, 0x101ddc8, v, nv);
    dbi_write(0x78, nv, 0, 1, 0, 0, 1, 1, 0);
}

/* Конфигурация L1 sub-timing (0x8d169c): регистр 0xb44 по DBI, поле [5:2] = 0xf
 * (0x8ed4d8). Лог: [1:0], [5:2], [7:6] (прежде маски 3/1 бит вместо 4/2). */
void hwd_pcie_l1_sub_timing_config(void)
{
    if (hwd_pcie_is_ep_under_serdes() == 0) {
        fw_log_emit0(0x1, 0x101e00c);
        return;
    }
    u32 v;
    pcie_dbi_read(0xb44, 0, 1, 0, 0, 1, &v);
    pcie_bits_set32_s2_w4(&v, 0xf, 0);
    dbi_write(0xb44, v, 0, 1, 0, 0, 1, 1, 0);
    fw_log_emit3(0x20, 0x101df9c, v & 3, (v >> 2) & 0xf, (v >> 6) & 3);
}

/* Инициализация последовательности SerDes (0x8f344c). */
void pcie_serdes_init_seq(void)
{
    hwd_pcie_exit_l1(1);
    pcie_fix_max_read_req();
    hwd_pcie_l1_sub_timing_config();
    hwd_pcie_exit_l1(0);
}

/* Тактирование ненужных PCIe-блоков (0x8d1114): под SerDes — все три поля = v; иначе —
 * по битам [0x8825c0]: [3:2] оба 0 → 0x880afc биты 9..11; бит 0 СБРОШЕН → 0x8d19a4;
 * бит 1 СБРОШЕН → 0x8d1a34 и 0x8d1250 (vendor bxor ..,0 — инверсия; прежде брались
 * сами биты). */
void pcie_program_seq_fw_8825c0(u32 v)
{
    u32 r13 = MMIO32(HW_PCIE_MODE_FLAGS);
    if (hwd_pcie_is_ep_under_serdes() != 0) {
        mac_set_bits_880af4_f8_fc(v);
        mac_set_880af8_afc_b25_b5(v);
        mac_set_880afc_bits9_11(v);
    } else {
        u32 r0 = ((r13 & (1u << 2)) || (r13 & (1u << 3))) ? 0 : 1;
        mac_set_880afc_bits9_11(r0 & v);
        mac_set_bits_880af4_f8_fc(((r13 ^ 1u) & 1u) & v);
        u32 b = (((r13 >> 1) ^ 1u) & 1u) & v;
        mac_set_880af8_afc_b25_b5(b);
        mac_set_880af8_afc_b30_b6(b);
    }
}

/* pcie_pm_host_config (0x8e033c): разрешить выход из L1 ([0x882554] бит 3), ждать L1
 * (до 0x1e8480 опросов), прочитать LnkCtl и L1SS-control; если [0x88001c] (USER_USAGE_7)
 * бит 1 — драйвер задал ASPM/L1SS: применить его биты к LnkCtl ([2]→L0s, [3]→L1, [4]→CLKREQ)
 * и L1SS ([8],[7],[6],[5] → биты 0..3), снять бит 26/29 L1-входа (0x8d1554(1)); иначе —
 * записать текущие LnkCtl/L1SS в USAGE_7 и взвести бит 1. Затем снять бит 3 [0x882554] и
 * лог. Прежде не было ветки «иначе», записи L1SS, 0x8d1554 и финального лога. */
void pcie_pm_host_config(void)
{
    MMIO32(HW_PCIE_SERDES_L1_HOLD) |= (1u << 3);

    u32 cnt = 0x1e8480, l1;
    do {
        l1 = hwd_pcie_is_l1_state();
        cnt--;                                    /* delay-слот bl.d 0x8d1054 */
    } while (l1 == 0 && cnt != 0);
    if (l1 == 0) {
        /* vendor логирует blink — адрес возврата последнего вызова (точка внутри функции). */
        u32 bl;
        __asm__ volatile("mov %0, blink" : "=r"(bl));
        fw_log_emit1(0, 0x10030a0, bl);
    }

    u32 lnkctl, l1sub;
    hwd_pcie_config_lnkctl(&lnkctl);
    hwd_pcie_l1_pm_sub_ctl_get(&l1sub);

    u32 u7 = MMIO32(HW_RGF_USER_USAGE_7);
    if (u7 & (1u << 1)) {
        lnkctl = (((u7 >> 4) & 1) << 8) | (((u7 >> 3) & 1) << 1)
               | ((u7 >> 2) & 1) | (lnkctl & ~0x103u);
        hwd_pcie_lnkctl_set(&lnkctl);
        l1sub = (((u7 >> 5) & 1) << 3) | (((u7 >> 6) & 1) << 2)
              | (((u7 >> 7) & 1) << 1) | ((u7 >> 8) & 1) | (l1sub & ~0xfu);
        hwd_pcie_l1_pm_sub_ctl_set(&l1sub);
        hwd_pcie_l1_entry_cfg(1);
    } else {
        u7 = (u7 & ~0xcu) | ((lnkctl & 1) << 2) | (((lnkctl >> 1) & 1) << 3);
        u7 = (u7 & ~0x30u) | (((lnkctl >> 8) & 1) << 4) | ((l1sub & 1) << 5);
        u7 = (u7 & ~0xc0u) | (((l1sub >> 1) & 1) << 6) | (((l1sub >> 2) & 1) << 7);
        u7 = (u7 & ~0x102u) | (((l1sub >> 3) & 1) << 8) | (1u << 1);
        MMIO32(HW_RGF_USER_USAGE_7) = u7;
    }

    MMIO32(HW_PCIE_SERDES_L1_HOLD) &= ~(1u << 3);
    fw_log_emit2(0x2e, 0x10030d0, lnkctl, u7);    /* "pcie_pm_host_config:: LnkCtl= usage7=" */
}

/* pcie_serdes__shlicht_wa (0x8f6f7c): для M_A0/M_A1 при пустом поле [22:16] 0x882f8c —
 * программирование SerDes под сбросом (SW_RST_VEC 0x880b08/0x880b0c). */
static void pcie_serdes_shlicht_wa(void)
{
    if (MMIO32(HW_PCIE_SERDES_SHLICHT_CFG_0) & 0x7f0000u)
        return;
    fw_log_emit0(0x2f, 0x1003a2c);              /* "PCIe serdes configuration shlicht" */
    MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) |= (1u << 11);
    MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_2) |= (1u << 13);
    MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) = 0;
    MMIO32(HW_PCIE_SERDES_SHLICHT_CFG_0) |= 0x7f7f0000u;
    MMIO32(HW_PCIE_SERDES_SHLICHT_CFG_1) = (MMIO32(HW_PCIE_SERDES_SHLICHT_CFG_1) & 0xc0c0c0ffu) | 0x23181800u;
    MMIO32(HW_PCIE_TOPOLOGY_CTL) &= ~1u;
    MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_2) = 0;
    MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_1) = 0;
    MMIO32(HW_RGF_USER_CLKS_CTL_SW_RST_VEC_0) = 0;
}

/* WBE_DRIVER::pcie_boot_init (0x8f6e08). r15 = [0x8825c0] читается до shlicht. Прежде
 * порт делал только shlicht (и только на A0/A1, с выходом), остальное отсутствовало. */
void pcie_serdes_init(void)
{
    u32 r15 = MMIO32(HW_PCIE_MODE_FLAGS);
    u32 id = MMIO32(HW_CHIP_STEPPING_ID);     /* chip_stepping_id (REGS-KNOWN) */
    if (id == 0x632072f || id == 0x1632072f)
        pcie_serdes_shlicht_wa();
    MMIO32(HW_USER_RGF_880204) = 1;              /* st.as 1,[0x880000,129] */
    if (pcie_marlon_compat == 1) {        /* [gp,-380] */
        fw_log_emit0(0x2f, 0x1003100);          /* wPCIeR backward compatibility with Marlon */
        MMIO32(HW_PCIE_MODE_FLAGS) = (MMIO32(HW_PCIE_MODE_FLAGS) & 0xf801ffffu)
                         | (1u << 17) | (1u << 18) | (1u << 23);
    }
    MMIO32(HW_PCIE_SW_PM_CFG) = 0x7fff;
    u32 v = MMIO32(HW_PCIE_SW_CTL_28);
    v &= ~((1u << 21) | (1u << 5) | (1u << 6));
    v |= (1u << 5) | (1u << 6) | (1u << 21);
    MMIO32(HW_PCIE_SW_CTL_28) = v;
    fw_log_emit0(0x2f, 0x1003140);              /* "Sparrow PCIe PM Support!" */

    pcie_force_clear_l0s();
    pcie_serdes_program_all();
    pcie_pm_host_config();
    if (!(r15 & 1)) {
        fw_log_emit0(0x2f, 0x100315c);          /* "Sparrow PCIe reset Serdes1!" */
        hwd_pcie_port1_serdes_reset(1);
    }
    fw_log_emit0(0x2f, 0x1003178);              /* "Clock gate PCIE uneeded clocks!" */
    pcie_program_seq_fw_8825c0(1);
    pcie_hp_ctrl_write_bit(0xd, 0);
    pcie_hp_ctrl_write_bit(0xe, 0);
    pcie_hp_ctrl_write_bit(0xa, 1);

    /* Поле [14:8] = 0x25 в семи регистрах PCIe-ядра. */
    static const u32 f8_regs[] = {HW_PCIE_SW_LANE_CFG_40, HW_PCIE_SW_LANE_CFG_48, HW_PCIE_SW_LANE_CFG_50, HW_PCIE_PORT_B_LANE_CFG_40, HW_PCIE_PORT_B_LANE_CFG_48,
                                  HW_PCIE_PORT_C_LANE_CFG_40, HW_PCIE_PORT_C_LANE_CFG_48};
    for (u32 i = 0; i < sizeof(f8_regs) / sizeof(f8_regs[0]); i++)
        MMIO32(f8_regs[i]) = (MMIO32(f8_regs[i]) & 0xffff80ffu) | (0x25u << 8);

    /* 0x882b80: восемь регистров = 10, порядок vendor (с чтением перед записью). */
    static const u32 b80_regs[] = {HW_PCIE_PM_TIMER_0B, HW_PCIE_PM_TIMER_1B, HW_PCIE_PM_TIMER_2B, HW_PCIE_PM_TIMER_3B,
                                   HW_PCIE_PM_TIMER_0A, HW_PCIE_PM_TIMER_1A, HW_PCIE_PM_TIMER_2A, HW_PCIE_PM_TIMER_3A};
    for (u32 i = 0; i < sizeof(b80_regs) / sizeof(b80_regs[0]); i++) {
        (void)MMIO32(b80_regs[i]);
        MMIO32(b80_regs[i]) = 0xa;
    }

    MMIO32(HW_PCIE_SW_CTL_24) |= 1u << 6;
    MMIO32(HW_PCIE_PORT_B_CTL_24) |= 1u << 6;
    MMIO32(HW_PCIE_PORT_C_CTL_24) |= 1u << 6;
    MMIO32(HW_PCIE_PORT_B_CTL_34) |= 0x300;
    MMIO32(HW_PCIE_PORT_C_CTL_34) |= 0x300;
    pcie_hp_ctrl_write_bit(0xb, 0);
    pcie_serdes_clear_flag_if_bit1();
    pcie_serdes_init_seq();
}

void pcie_d3_d0_int_en(void)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMC) = 0x1000000;
}

/* Вставить 4-битное поле со сдвигом 2 (bits 2..5). */
void pcie_bits_set32_s2_w4(u32 *p, u32 a, u32 b)
{
    (void)b;
    *p = (*p & ~0x3cu) | ((a & 0xfu) << 2);
}

/* Состояние канала PCIe (LTSSM, 0x88b0c0) и линия 0x882b80. */
u32 hwd_pcie_get_88b0c0_state4(void)
{
    return (MMIO32(HW_PCIE_LINK_STATE) >> 2) & 0xf;
}

u32 hwd_pcie_get_882b80(void)
{
    return MMIO32(HW_PCIE_PERST_STATUS) & 1;
}

/* hwd_pcie__ltssm_is_l1_idle (0x8d1070): 1, когда бит 23 [0x88b0d0] СБРОШЕН (vendor: and;
 * cmp 0; mov 1; sub.ne). Прежде было наоборот; вызывающие (0x8c894a, 0x8d10ac, 0x8d15d0)
 * портированы под vendor-полярность. */
u32 hwd_pcie_ltssm_is_l1_idle(void)
{
    return (MMIO32(HW_PCIE_LTSSM_STATUS) & 0x800000u) ? 0 : 1;
}


/* Маскировка IRQ L1-входа/выхода. */
void pcie_mask_l1_enter_irq(void)
{
    MMIO32(HW_UNIT_ICR_PORT0_LTSSM_DBG_1_IMS) = 0x4000;
}

/* Установка low-power PCIe (0x8d77dc). */
void hwd_pcie_set_low_power(u32 v)
{
    if (v == 0 && hwd_pcie_is_ep_under_serdes() == 0)
        hwd_pcie_exit_l1(1);
    pcie_lp_set_byte_field(3, v);
    pcie_lp_set_byte_field(4, v);
    if (v == 0 && hwd_pcie_is_ep_under_serdes() == 0)
        hwd_pcie_exit_l1(0);
}

/* Установка байт-поля low-power (0x8d473c): [0x880290] байт с бита bit = val. */
void pcie_lp_set_byte_field(u32 bit, u32 val)
{
    u32 v = MMIO32(HW_PCIE_LP_PARAMS);
    v &= ~(0xffu << bit);
    MMIO32(HW_PCIE_LP_PARAMS) = (val << bit) | v;
}

/* PCIe DBI-примитивы (config-space через Data Bus Interface, RGF 0x882600):
 * [0x88264c] адрес, [0x882650] данные, [0x882648] команда (бит 31 — запись, [27:16] —
 * параметры, [3:0] — byte enable), [0x882644] бит 29 — занято, 0x40000000 — квитирование.
 * Прежде read/write игнорировали все аргументы, кроме адреса (запись не передавала данные,
 * размер 0 давал код 0 вместо 1), а ожидание готовности считало в беззнаковом. */

/* (0x8d1220) / (0x8d1464) / (0x8d1458) / (0x8d122c) / (0x8d11e8). */
void pcie_dbi_set_addr(u32 v)
{
    MMIO32(HW_PCIE_DBI_ADDR) = v;
}

/* pcie__dbi_set_data (0x8d1464). */
void pcie_dbi_set_data(u32 v)
{
    MMIO32(HW_PCIE_DBI_DATA) = v;
}

static u32 pcie_dbi_get_data(void)
{
    return MMIO32(HW_PCIE_DBI_DATA);
}

void pcie_dbi_start_cmd(u32 a, u32 b, u32 c)
{
    MMIO32(HW_PCIE_DBI_CMD) = (a << 31) | (b << 16) | c;
}

/* pcie__dbi_ack_done (0x8d11e8). */
void pcie_dbi_ack_done(void)
{
    MMIO32(HW_PCIE_DBI_STATUS) = 0x40000000;
}

/* Ожидание готовности DBI (0x8d11f8): ровно 0x5281 чтений [0x882644] (lp без выхода);
 * счётчик 0x5280 уменьшается на каждое чтение с битом 29; результат 1 при счётчике > 0
 * (знаково: sub.le). ХРУПКО: число чтений — это и есть таймаут; цикл не прерывать. */
u32 pcie_wait_882644_ready(void)
{
    s32 r1 = 0xa5 << 7;   /* 0x5280 */
    for (u32 i = 0; i < 0x5281; i++) {
        if (MMIO32(HW_PCIE_DBI_STATUS) & (1u << 29))
            r1--;
    }
    return (r1 > 0) ? 1u : 0u;
}

/* (0x8e026c): готовность → квитирование → снова готовность. */
u32 pcie_ack_8e026c(void)
{
    if (pcie_wait_882644_ready() == 0)
        return 0;
    pcie_dbi_ack_done();
    return pcie_wait_882644_ready() != 0 ? 1u : 0u;
}

/* Код размера доступа (общий для чтения/записи): sz 0 → 1, 1 → 2, 2 → 4, прочие — нет. */
static u32 pcie_dbi_size_code(u32 sz, u32 *code)
{
    if (sz == 0) { *code = 1; return 1; }
    if (sz == 1) { *code = 2; return 1; }
    if (sz == 2) { *code = 4; return 1; }
    return 0;
}

/* pcie_dbi__transfer (0x8c828c): запись. a3 → бит 3 (и код 0), a4 → бит 4 (и код 1),
 * a5 → [6:5], a7 → бит 8, a6 → бит 11 (режим завершения: 1 — ждать 0x8e026c, 0 —
 * квитировать без ожидания, иное — 0), a8 (байт со стека) → бит 7. */
u32 pcie_dbi_transfer(u32 addr, u32 data, u32 sz, u32 a3, u32 a4, u32 a5, u32 a6,
                      u32 a7, u32 a8)
{
    u32 code;
    pcie_dbi_set_addr(addr);
    pcie_dbi_set_data(data);
    if (a4 != 0)
        code = 1;
    else if (a3 != 0)
        code = 0;
    else if (pcie_dbi_size_code(sz, &code) == 0)
        return 0;
    u32 r1 = (code & 7) | ((a3 & 1) << 3) | ((a4 & 1) << 4) | ((a5 & 3) << 5)
           | ((a7 & 1) << 8) | ((a6 & 1) << 11) | ((a8 & 1) << 7);
    pcie_dbi_start_cmd(1, r1 & 0x9ff, 0xf);
    if (a6 == 1)
        return pcie_ack_8e026c();
    if (a6 != 0)
        return 0;
    pcie_dbi_ack_done();
    return 1;
}

/* dbi_write (0x8c8338): 0x8c828c с теми же аргументами (a8 — младший байт); неудача —
 * два лога и сисассерт 0x10ee (vendor bset 12 к 0xee; прежде было 0xeee). */
u32 dbi_write(u32 addr, u32 data, u32 a2, u32 a3, u32 a4, u32 a5, u32 a6, u32 a7, u32 a8)
{
    u32 r = pcie_dbi_transfer(addr, data, a2, a3, a4, a5, a6, a7, a8 & 0xff);
    if (r == 0) {
        fw_log_emit3(0, 0x101e054, addr, data, a2);
        fw_log_emit3(0, 0x101e088, a3, a4, a5);
        fw_sysassert_fatal(__builtin_return_address(0), 0xee | (1u << 12));
    }
    return r;
}

/* pcie_dbi_read (0x8c8208): код как у записи (a3 → бит 4 и код 1, a2 → бит 3 и код 0),
 * a4 → [6:5], a5 → бит 11; команда чтения (бит 31 = 0, byte enable 0), ожидание
 * 0x8e026c; успех — данные из [0x882650] в *out, возврат 1. */
u32 pcie_dbi_read(u32 addr, u32 sz, u32 a2, u32 a3, u32 a4, u32 a5, u32 *out)
{
    u32 code;
    pcie_dbi_set_addr(addr);
    if (a3 != 0)
        code = 1;
    else if (a2 != 0)
        code = 0;
    else if (pcie_dbi_size_code(sz, &code) == 0)
        return 0;
    u32 r1 = (code & 7) | ((a2 & 1) << 3) | ((a3 & 1) << 4) | ((a4 & 3) << 5)
           | ((a5 & 1) << 11);
    pcie_dbi_start_cmd(0, r1 & 0x87f, 0);
    if (pcie_ack_8e026c() == 0)
        return 0;
    *out = pcie_dbi_get_data();
    return 1;
}
