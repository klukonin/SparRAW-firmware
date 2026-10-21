// SPDX-License-Identifier: AGPL-3.0-or-later
/* Clock and Reset (CAR) + ABIF (аналоговый блок) — PLL3, ADC-клок. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"


/* Статус PLL3, бит 3. */
u32 car_get_pll3_status_bit3(void)
{
    return (MMIO32(RGF_CAF_PLL_LOCK_STATUS) >> 3) & 1;
}

/* Управление ADC-клоком: on=1 → 0, иначе 1. */
void hwd_abif_adc_clk_ctrl(u32 on)
{
    MMIO32(ABIF_ADC_CLK_CTRL) = (on == 1) ? 0 : 1;
}

/* Подтвердить снятие маски PLL-unlock IRQ (vendor 0x8d0114). */
void abif_ack_unmask_pll_unlock_irq(void)
{
    MMIO32(HW_RGF_CAF_ICR_ICR) = 4;   /* ack PLL-unlock ICR bit2 (W1C) — пропущено было */
    if (car_get_pll3_status_bit3() != 1)
        fw_sysassert_fatal((void *)0, 0x1417);
    MMIO32(HW_RGF_CAF_ICR_IMC) = 4;   /* unmask PLL-unlock IMC bit2 — пропущено было */
}

/* Переключение такта ARC/AHB XTAL ↔ PLL3 (165 МГц), 0x8d0320 («Switch from XTAL to 165MHZ»).
 * [0x880abc] бит 1 — запрос PLL-такта, [0x880c60] бит 3 — «переключение завершено»
 * (W1C/квитирование), [0x88afec] бит 3 — PLL3 активен. */
void car_enable_pll3_and_wait(u32 on)
{
    MMIO32(CLK_SWITCH_STATUS) |= (1u << 3);       /* подать enable */

    if (on != 0) {
        if (!(MMIO32(RGF_USER_CLKS_CTL_0) & (1u << 1))) {
            MMIO32(RGF_USER_CLKS_CTL_0) |= (1u << 1);
            /* ХРУПКО: vendor 0x8d034c..0x8d0362 — опрос, пока бит3 [0x880c60] == 0 И PLL3
             * активен; счётчик r16 = 1000..1, продолжение при (r16 - 1) >= 1 — ровно 1000
             * итераций (прежний порт делал 999). Каждая итерация — чтение 0x880c60 и вызов
             * чтения 0x88afec (car_get_pll3_status_bit3). Проверки после цикла — по значениям
             * последней итерации. Это ожидание смены такта ядра: ARC в это время ещё на XTAL. */
            u32 cnt = 1000;
            u32 c60, pll3_active;
            for (;;) {
                c60 = MMIO32(CLK_SWITCH_STATUS);
                pll3_active = car_get_pll3_status_bit3();
                if ((c60 & (1u << 3)) || pll3_active != 1)
                    break;
                if (cnt - 1 < 1)
                    break;
                cnt--;
            }
            if (!(c60 & (1u << 3)) && pll3_active == 1) {   /* таймаут: switch не завершён */
                fw_log_emit0(0, 0x101f7a4);                  /* "DO_WHILE_WITH_MAX_ITER OCCUR" */
                fw_sysassert_fatal(__builtin_return_address(0), 0x132b);
            }
            if (pll3_active != 1)                            /* PLL3 не активен */
                fw_sysassert_fatal(__builtin_return_address(0), 0x1418);
        }
    } else {
        if (MMIO32(RGF_USER_CLKS_CTL_0) & (1u << 1)) {
            MMIO32(RGF_USER_CLKS_CTL_0) &= ~(1u << 1);
            u32 i;
            u32 v = 0;
            /* vendor 0x8d03ca-3d6: опрашиваем бит3 0x880c60, ранний выход при ==1;
             * ассерт 0x132c ТОЛЬКО при таймауте (бит3 так и 0). */
            for (i = 0; i < 0x3e8; i++) {
                v = MMIO32(CLK_SWITCH_STATUS);
                if (v & (1u << 3))
                    break;
            }
            if (!(v & (1u << 3))) {
                fw_log_emit0(0, 0x101f7a4);
                fw_sysassert_fatal((void *)0, 0x132c);
            }
        }
    }
    /* vendor L_8d038a: повторно взвести бит3 PLL3-enable сразу после lock
     * (без settling-задержки — её вендор не делает). */
    MMIO32(CLK_SWITCH_STATUS) |= (1u << 3);
}

void car_enable_pll3_and_wait_on(void)
{
    car_enable_pll3_and_wait(1);
}

/* RFC тактирование и рестарт делителя: бит 0 [0x889394] (0x8ced8c). */
void hwd_abif_rgf_889380(u32 on)
{
    u32 v = MMIO32(HW_RFC_DIVIDER_CTRL);
    MMIO32(HW_RFC_DIVIDER_CTRL) = (on == 1) ? (v & ~1u) : (v | 1u);
}

/* Такт RFC: бит 3 [0x88941c] (0x8ced74). */
void hwd_abif_rfc_clk_ctrl(u32 on)
{
    u32 v = MMIO32(HW_ABIF_FS_CTRL);
    MMIO32(HW_ABIF_FS_CTRL) = (on == 1) ? (v & ~(1u << 3)) : (v | (1u << 3));
}

/* Рестарт делителя RFC (0x8ceda4); a != 0 — счётчик 0x800384. */
void hwd_abif_rfc_divider_restart(u32 a)
{
    if (a != 0) {
        u32 v = rf_rfc_div_restart_count;
        rf_rfc_div_restart_count = v + 1;
    }
    hwd_abif_rgf_889380(1);
    hwd_abif_rfc_clk_ctrl(0);
    hwd_abif_rfc_clk_ctrl(1);
    arc_zol_nops2(0x50);                /* vendor 0x8cedc4: lp 0x50 × 2 nop_s */
    hwd_abif_rgf_889380(0);
}

/* Loopback-режим ABIF (0x8ce5e8). */
void hwd_abif_caf_lpbk_mode(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(ABIF_CAF_MODE) = (v << 2) | (MMIO32(ABIF_CAF_MODE) & ~(1u << 2));
}

/* Конфигурация коммутаторов loopback (0x8ceb2c). */
void hwd_abif_lpbk_mode_switches_config(u32 a, u32 b, u32 c)
{
    if (a & ~0xfu)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(ABIF_LPBK_SWITCH_0) = ((a << 9) & 0x1e00u) | (MMIO32(ABIF_LPBK_SWITCH_0) & 0xffffe1ffu);
    if (b & ~0xfu)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(ABIF_LPBK_SWITCH_1) = ((b << 4) & 0xf0u) | (MMIO32(ABIF_LPBK_SWITCH_1) & ~0xf0u);
    if (c & ~0xfu)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(ABIF_LPBK_SWITCH_1) = ((c << 8) & 0xf00u) | (MMIO32(ABIF_LPBK_SWITCH_1) & ~0xf00u);
}

/* Конфигурация буфера LO-splitter (0x8ce6fc). */
void hwd_abif_dvs_lo_splitter_config_buf_val(u32 a, u32 b)
{
    u32 i;
    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))   /* busy снялся → выход */
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {        /* busy залип → assert */
        fw_log_emit0(0, 0x101eee4);
        fw_sysassert_fatal((void *)0, 0x13fa);
    }
    if (a == 0 || a == 2) {
        if (b & ~0xfu)
            fw_sysassert_fatal((void *)0, 0xac);
        MMIO32(ABIF_LO_SPLITTER_1) = b | (MMIO32(ABIF_LO_SPLITTER_1) & ~0xfu);
    }
    if (a == 1 || a == 2) {
        if (b & ~0xfu)
            fw_sysassert_fatal((void *)0, 0xac);
        MMIO32(ABIF_LO_SPLITTER_0) = b | (MMIO32(ABIF_LO_SPLITTER_0) & ~0xfu);
    }
}

/* ABIF: FS off/on, DVS сплиттеры, RF активация.
 * Маскировать IRQ FS8 UNLOCK (0x8d00e8). */
void abif_mask_fs_unlock_irq(void)
{
    MMIO32(HW_RGF_CAF_ICR_IMS) = 0x80;
}
void abif_ack_unmask_fs_unlock_irq(void)
{
    MMIO32(HW_RGF_CAF_ICR_ICR) = 0x80;   /* RGF_CAF_ICR.ICR W1C бит7 = FS8 UNLOCK (0x889800-0xe4*4) */
    MMIO32(HW_RGF_CAF_ICR_IMC) = 0x80;   /* RGF_CAF_ICR.IMC бит7 = снятие маски FS8 UNLOCK (0x889800-0xdf*4) */
}

/* FS off (0x8cea04). */
void hwd_abif_fs_off(u32 a)
{
    (void)a;
    abif_mask_fs_unlock_irq();
    /* vendor 0x8cea04: ДВА отдельных write в 0x88941c (сначала &~3, затем |0x10),
     * с перечитыванием между — не объединять в один RMW (нужен промежуточный
     * state для FS-автомата). */
    MMIO32(HW_ABIF_FS_CTRL) = MMIO32(HW_ABIF_FS_CTRL) & ~3u;
    MMIO32(HW_ABIF_FS_CTRL) = MMIO32(HW_ABIF_FS_CTRL) | (1u << 4);
    MMIO32(HW_ABIF_DVS_CTRL_24) = (MMIO32(HW_ABIF_DVS_CTRL_24) & ~0x7c0u) | (1u << 10);
}

/* FS on (0x8cea38): поднять частоту-синтезатор, опрос битов 4/5 готовности. */
void hwd_abif_fs_on(u32 v)
{
    MMIO32(HW_ABIF_DVS_CTRL_24) = (MMIO32(HW_ABIF_DVS_CTRL_24) & ~0x7c0u) | (1u << 9);

    u32 i;
    arc_zol_nops2_shl(0x7d, 6);         /* vendor 0x8cea54: mov_s 0x7d; asl_s 6; lp × 2 nop_s */

    MMIO32(HW_ABIF_FS_CTRL) = (MMIO32(HW_ABIF_FS_CTRL) & ~0x60u) | 0x60u;
    if (v & ~0xf)     /* vendor: assert когда (v & ~0xf)!=0 (v вне 0..15) */
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_ABIF_FS_CTRL) = (v << 16) | (MMIO32(HW_ABIF_FS_CTRL) & 0xfff0ffffu);
    MMIO32(HW_ABIF_FS_CTRL) |= 3u;
    MMIO32(HW_ABIF_FS_CTRL) &= ~(1u << 4);

    for (i = 0; i < 0x30d40; i++)
        if (MMIO32(RGF_CAF_PLL_LOCK_STATUS) & (1u << 4))
            break;
    /* Тайм-аут бита 4 — только журнал (у vendor на стенде он есть: «DO_WHILE_WITH_MAX_ITER
     * OCCUR curr_blink=0xea3e» перед сбросом RF). curr_blink у vendor — blink после вызова
     * millicode сохранения регистров, т. е. адрес внутри этой функции; у нас — её адрес. */
    if (!(MMIO32(RGF_CAF_PLL_LOCK_STATUS) & (1u << 4)))
        fw_log_emit1(0, 0x101ef04, (u32)hwd_abif_fs_on);

    arc_zol_nops2_shl(0x7d, 5);         /* vendor 0x8ceaca: mov_s 0x7d; asl_s 5; lp × 2 nop_s */

    for (i = 0; i < 0x30d40; i++)
        if (MMIO32(RGF_CAF_PLL_LOCK_STATUS) & (1u << 5))
            break;
    if (!(MMIO32(RGF_CAF_PLL_LOCK_STATUS) & (1u << 5))) {
        fw_log_emit0(0, 0x101eee4);
        fw_sysassert_fatal((void *)0, 0x1348);
    }

    MMIO32(HW_ABIF_FS_CTRL) &= ~0x60u;
    abif_ack_unmask_fs_unlock_irq();
}

/* Конфигурация ABIF через регистры 0x88939c/0x889398 (0x8d0098). */
void hwd_abif_uses_rgf_889380(u32 a0, u32 a1)
{
    MMIO32(ABIF_RGF_88939C) = a0;
    if (a1 & ~0x1fu)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(ABIF_RGF_889398) = (MMIO32(ABIF_RGF_889398) & ~0x1fu) | a1;
    arc_sync();
}

/* Бит 27 регистра 0x889488 = "uses RGF 889480" (режим доступа к полям через RGF).
 * Vendor 0x8cebac: flag==0 → УСТАНОВИТЬ бит 27; flag!=0 → сбросить. (была инверсия!) */
void hwd_abif_uses_rgf_889480(u32 flag)
{
    if (flag == 0)
        MMIO32(HW_ABIF_DVS_RF_CTRL) |= (1u << 27);
    else
        MMIO32(HW_ABIF_DVS_RF_CTRL) &= ~(1u << 27);
}

/* DVS IF splitter enable (0x8ce6b8): бит 24 [0x889488] — есть RF из маски 0xcc,
 * бит 25 — из 0x33. vendor `add1_s r1,r1,r0` = r1 + (r0 << 1); прежний порт
 * складывал r1 + r0 (при v = 0xff писал 2 вместо 3, при RF0 — 1 вместо 2). */
void hwd_abif_dvs_if_splitter_enable(u32 v)
{
    u32 r1 = ((v & 0xcc) == 0) ? 0 : 1;
    u32 r0 = ((v & 0x33) == 0) ? 0 : 1;
    u32 r13 = (u8)(r1 + (r0 << 1));
    if (r13 & ~3u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = (r13 << 24) | (MMIO32(HW_ABIF_DVS_RF_CTRL) & ~(3u << 24));
}

/* DVS LO splitter enable (0x8ce794): бит 4 регистров 0x88afa0/0x88af5c. */
void hwd_abif_dvs_lo_splitter_enable(u32 v)
{
    u32 r15 = ((v & 0xcc) == 0) ? 1 : 0;
    u32 r13 = ((v & 0x33) == 0) ? 1 : 0;

    u32 i;
    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))   /* busy снялся → выход */
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {        /* busy залип → assert */
        fw_log_emit0(0, 0x101eee4);
        fw_sysassert_fatal((void *)0, 0x13fa);
    }

    MMIO32(ABIF_LO_SPLITTER_1) = (r15 << 4) | (MMIO32(ABIF_LO_SPLITTER_1) & ~(1u << 4));
    MMIO32(ABIF_LO_SPLITTER_0) = (r13 << 4) | (MMIO32(ABIF_LO_SPLITTER_0) & ~(1u << 4));
}

/* DVS RFCA command enable (0x8ce910): байт значения в биты 8-15 регистра 0x889488;
 * b != 0 — туда прежняя маска. */
void hwd_abif_dvs_rfca_cmd_enable(u32 a, u8 *b)
{
    u32 i;
    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        fw_log_emit0(0, 0x101eee4);
        fw_sysassert_fatal((void *)0, 0x13fa);
    }

    u8 old = (u8)(MMIO32(HW_ABIF_DVS_RF_CTRL) >> 8);
    if (b)
        *b = old;
    if (a == old)
        return;

    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        fw_log_emit0(0, 0x101eee4);
        fw_sysassert_fatal((void *)0, 0x136e);
    }
    if (a & ~0xffu)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = (a << 8) | (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xffff00ffu);
}

/* DVS RF активация (0x8ce838): значение v в младший байт регистра 0x889488. */
void hwd_abif_dvs_rf_activate(u32 v)
{
    u32 i;
    for (i = 0; i < 0x30d40; i++)
        if (!(MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)))
            break;
    if (MMIO32(HW_RFC_CORE_CTRL) & (1u << 29)) {
        fw_log_emit0(0, 0x101eee4);
        fw_sysassert_fatal((void *)0, 0x13fa);
    }
    if (v & ~0xffu)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_ABIF_DVS_RF_CTRL) = v | (MMIO32(HW_ABIF_DVS_RF_CTRL) & 0xffffff00u);
}

/* Конфигурация VGA-таблицы приёмника по всем строкам. */

void hwd_abif_rx_table_config_vga_bias_all_rows(u32 a0, u32 a1, u32 a2, u32 a3)
{
    if (a1 < a0)
        return;
    u32 count = (u8)(a1 - a0) + 1;
    for (u32 row = a0; count >= 1; count--, row++)
        hwd_abif_rx_table_config_vga_bias(row, a2, a3);
}

void hwd_abif_rx_table_config_vga_stg1_fine_bias_all_rows(u32 a0, u32 a1, u32 a2)
{
    if ((s32)a1 < (s32)a0)
        return;
    u32 count = (u8)(a1 - a0) + 1;
    u32 row = a0;
    do {
        hwd_abif_rx_table_config_vga_stg1_fine_bias(row, 0, a2);
        hwd_abif_rx_table_config_vga_stg1_fine_bias(row, 1, a2);
        count--;
        row++;
    } while (count >= 1);
}

/* Включение/выключение питания аналогового блока (0x8cec90).
 * Последовательность записей в 0x88afb0/0x8893f4 + опрос готовности
 * битов 2/3 регистра 0x88afec. */
void abif_power_up_analog(u32 on)
{
    if (on == 1) {
        MMIO32(ABIF_PLL_CFG) = (MMIO32(ABIF_PLL_CFG) & 0xfffd0fffu) | (1u << 15);
        MMIO32(ABIF_PLL_CTRL) = (MMIO32(ABIF_PLL_CTRL) & ~0x60u) | 0x60u;
        MMIO32(ABIF_PLL_CTRL) = (MMIO32(ABIF_PLL_CTRL) & ~7u) | 3u;
        MMIO32(ABIF_PLL_CTRL) &= ~(1u << 4);

        /* ХРУПКО: опросы — lp 0x4e20 (тело: ld; btst; bne на конец цикла; nop_s), выход по
         * биту; проверка после цикла — по ПОСЛЕДНЕМУ прочитанному значению (без повторного
         * чтения). Перед вторым циклом у vendor nop_s. Число итераций и nop сохранены —
         * это единственная выдержка на включение LDO/питания ABIF. */
        u32 i, v = 0;
        for (i = 0; i < 0x4e20; i++) {
            v = MMIO32(RGF_CAF_PLL_LOCK_STATUS);
            if (v & (1u << 2))
                break;
            arc_nop_s();
        }
        if (!(v & (1u << 2))) {
            fw_log_emit0(0, 0x101eee4);    /* "DO_WHILE_WITH_MAX_ITER OCCUR" */
            fw_sysassert_fatal(__builtin_return_address(0), 0x1321);
        }
        arc_nop_s();
        for (i = 0; i < 0x4e20; i++) {
            v = MMIO32(RGF_CAF_PLL_LOCK_STATUS);
            if (v & (1u << 3))
                break;
            arc_nop_s();
        }
        if (!(v & (1u << 3))) {
            fw_log_emit0(0, 0x101eee4);
            fw_sysassert_fatal(__builtin_return_address(0), 0x1322);
        }
        MMIO32(ABIF_PLL_CTRL) &= ~0x60u;   /* vendor: одна запись (биты 5,6 сразу) */
    } else {
        /* vendor: bic 6; bset 2; bclr 0 — одна запись (прежде было две) */
        MMIO32(ABIF_PLL_CTRL) = ((MMIO32(ABIF_PLL_CTRL) & ~0x6u) | (1u << 2)) & ~1u;
    }
}

/* Режим power-down CAF (0x8c6dee?). */
void hwd_abif_caf_pwdn_mode(u32 v)
{
    if (v & ~1u)
        fw_sysassert_fatal((void *)0, 0xac);
    MMIO32(HW_ABIF_CAF_PWDN_MODE) = v | (MMIO32(HW_ABIF_CAF_PWDN_MODE) & ~1u);
}

/* Касание RF-модуля (0x8e2fc0) — enable/disable RFCA. obj (объект silent_rssi или 0) не
 * читается. */
void rfca_touch_rf_module(const struct calib_silent_rssi *obj, u32 bit, u32 flag)
{
    (void)obj;
    u8 buf = 0;
    /* vendor 0x8e2fd6: extb_s — маска модуля байтом; 0x8e2fe0: ldb_s r0,[sp] — второй вызов
     * восстанавливает прежний выбор RF (сохранённый первым вызовом в buf), а не 0. */
    if (flag != 0)
        hwd_abif_dvs_rfca_cmd_enable((u8)(1u << bit), &buf);
    if (flag != 0)
        hwd_abif_dvs_rfca_cmd_enable(buf, 0);
}

/* Конфигурация VGA-bias строки RX-таблицы (0x8cf2cc). */
void hwd_abif_rx_table_config_vga_bias(u32 row, u32 a, u32 v)
{
    /* vendor 0x8cf2d4: cmp_s r0,0x40; bge — знаковое; 0x8cf2de/0x8cf2e2: brge/brlt — знаковые.
     * Код ассерта 0x97 << 5 = 0x12e0 (vendor 0x8cf328: asl_s r1,r1,5 в слоте задержки bl.d),
     * первый аргумент — blink. */
    if ((s32)row >= 0x40)
        fw_sysassert_fatal(__builtin_return_address(0), 0x97u << 5);
    if ((s32)a >= 6 || (s32)a < 1)
        fw_sysassert_fatal(__builtin_return_address(0), 0x12e4);
    a--;
    u32 base = abif_rx_vga_bias_word[a];      /* 0x801af4 */
    u32 shift = abif_rx_vga_bias_sh[a];       /* 0x800564 */
    u32 addr = ABIF_RX_TABLE + (base + row * 4) * 4;
    u32 r3 = *(u32 *)addr;
    u32 mask = 0xfu << shift;
    *(u32 *)addr = (r3 & ~mask) | (v << shift);
}

/* Конфигурация STG1 fine-bias RX-таблицы (0x8cf4f8). */
void hwd_abif_rx_table_config_vga_stg1_fine_bias(u32 row, u32 a, u32 v)
{
    /* vendor 0x8cf502: brge r1,0x2; 0x8cf508: cmp_s r14,0x40; bge — знаковые; ассерт с blink. */
    if ((s32)a >= 2)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1307);
    if ((s32)row >= 0x40)
        fw_sysassert_fatal(__builtin_return_address(0), 0x1308);
    u32 shift = abif_rx_stg1_fine_bias_sh[a];   /* 0x800530 */
    u32 addr = ABIF_RX_TABLE + (a + 1 + row * 4) * 4;
    u32 r3 = *(u32 *)addr;
    u32 mask = 0xfu << shift;
    *(u32 *)addr = (r3 & ~mask) | (v << shift);
}
