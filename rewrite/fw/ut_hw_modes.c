// SPDX-License-Identifier: AGPL-3.0-or-later
/* Юнит-тесты WMI 0x900, модуль 11 — UT_HW_MODES (vendor 0x8fada4, 400 Б).
 * Все исполнители подкоманд уже портированы (power_halt.c, power.c, chan_sw.c, rf.c,
 * stubs.c); здесь только разбор подтипа и ответ 0x1900. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/ut.h"
#include "../include/power.h"
#include "../include/fwdata.h"



/* 0x8019ac: PS-контекст юнит-теста (struct ps_ctx, include/power.h; vendor передаёт адреса
 * константами): весь — power_halt_seq (0x309), его поля hw.flags — ut_hw_modes_cmd_0x308
 * (0x308), hw.power_mode — hw_modes_apply_power_mode (0x305), hw.apply_flags —
 * hwm__apply_mode_flags (0x306). */
FWDATA(8019ac) struct ps_ctx ut_hwm_ps_ctx = {
    .flags = 0xfb,
    .hw = { .flags = 0xb, .power_mode = 0x1f, .apply_flags = 0x1f },
};
#define HWM_HALT_FLAGS   (&ut_hwm_ps_ctx)                  /* power_halt_seq (0x309) */
#define HWM_0x308_FLAGS  (&ut_hwm_ps_ctx.hw.flags)         /* ut_hw_modes_cmd_0x308 (0x308) */
#define HWM_PWR_FLAGS    (&ut_hwm_ps_ctx.hw.power_mode)    /* hw_modes_apply_power_mode (0x305) */
#define HWM_MODE_FLAGS   (&ut_hwm_ps_ctx.hw.apply_flags)   /* hwm__apply_mode_flags (0x306) */

/* hwm__0x8d7cc4 (36 Б): ut_hw_modes_cmd_0x30b = 0x8ce500 (бит 18 0x88af48); у vendor
 * в ветке on != 1 после вызова ещё 8 nop_s (0x8d7cd8..0x8d7ce6) — тело в power_halt.c
 * их не содержит, выдержку держим здесь (короче vendor не делаем). */
static void ut_hw_modes_0x30b(u32 on)
{
    ut_hw_modes_cmd_0x30b(on);
    if (on != 1)
        arc_nops_mb(8);
}

/* hwm__0x8d7c70 (20 Б): 1 — биты 1 и 2 0x880c50 (0x8d03f4), иначе снять бит 2 (0x8d0444). */
static void ut_hw_modes_0x30c(u32 on)
{
    if (on == 1)
        pcie_set_880c50_b12(on);
    else
        pcie_clear_880c50_b2(on);
}

/* 0x803824: таблица переходов vendor UT_HW_MODES_cmd_handler (0x8fada4): ldb.x, 9 записей, цель = 0x8fae78 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(803824) __attribute__((aligned(1))) const u8 ut_hw_modes_cmd_handler_jt[9] = {
    0x1c, 0x21, 0x28, 0x2f, 0x33, 0x3a, 0x44, 0x48, 0x4c,
};

/* UT_HW_MODES_cmd_handler (0x8fada4). payload: u16 модуль, u16 подтип, далее слова
 * параметров (a0 = [payload+4]). Ответ — {u16 0xb, u16 подтип, u32 1} длиной 8.
 * FPGA (0x8da2c8 != 0): подкоманды не исполняются, ответ длиной 0x24 из 8 слов
 * «значение + 2»: первое — подтип + 2 (ldw [r14,2]), далее [payload+4..+0x1c] + 2
 * (vendor 0x8fadce..0x8fadfa; смысл «+2» не выяснен — поведение сохранено).
 * Неизвестный подтип — WMI_COMMAND_NOT_SUPPORTED (cmd 0x900, reason = подтип,
 * mid = u16 [payload+0], т. е. номер модуля — как vendor, r3 = ldw [r14,0]). */
void ut_hw_modes_cmd_handler(struct wmi_mbox *mb, const struct ut_cmd *c)
{
    u32 sub = c->subtype_id;
    struct ut_rsp *resp = ut_begin_response(mb, 0xb, sub);

    fw_log_emit1(0x20, 0x101d454, sub);
    if (platform_is_fpga() != 0) {
        u32 i;
        resp->status = sub + 2;
        for (i = 1; i < 8; i++)
            resp->data[i - 1] = c->arg[i - 1] + 2;
        wmi_evt_send_words(mb, resp, 0x24);
        return;
    }

    u32 a0 = c->arg[0];
    switch (sub) {
    case 0x101: hwm_reset_analog_block(); break;
    case 0x102: hw_modes_enable_pll(); break;
    case 0x103: hw_modes_pll_bypass(); break;
    case 0x104: hw_modes_pll_engage(); break;
    case 0x200: hwm_analog_channel_switch_thunk(a0 - 1); break;  /* sub_s r0,1 в слоте */
    case 0x206: ut_hw_modes_chain_3(c->arg8[0]); break;
    case 0x301: abif_mode_switch(a0); break;
    case 0x302: hw_modes_program_rf_clocks(a0); break;
    case 0x303: hw_pll_mode_switch(a0, 0); break;
    /* 0x304..0x30c — таблица переходов ldb.x [0x803824] (JUMPTABLES-fw: 9 входов). */
    case 0x304: ut_hw_modes_cmd_0x304_fw(a0, 0); break;
    case 0x305: hw_modes_apply_power_mode(a0, (u32 *)HWM_PWR_FLAGS); break;
    case 0x306: hwm_apply_mode_flags(a0, (u32 *)HWM_MODE_FLAGS); break;
    case 0x307: hwd_phy_power_up_seq(a0); break;
    case 0x308: ut_hw_modes_cmd_0x308(a0, (u32 *)HWM_0x308_FLAGS); break;
    case 0x309: power_halt_seq(a0, HWM_HALT_FLAGS); break;
    case 0x30a: hwm_apply_channel_config(a0); break;
    case 0x30b: ut_hw_modes_0x30b(a0); break;
    case 0x30c: ut_hw_modes_0x30c(a0); break;
    default:
        /* vendor 0x8faf24: буфер ответа, взятый 0x8eae60, не отправляется и не
         * освобождается — поведение сохранено. */
        wmi_evt_send_command_not_supported(mb, 0x900, sub, c->module_id);
        return;
    }
    resp->status = 1;
    wmi_evt_send_words(mb, resp, 8);
}
