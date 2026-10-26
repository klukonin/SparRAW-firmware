// SPDX-License-Identifier: AGPL-3.0-or-later
/* Фатальный ассерт — порт vendor fw_sysassert_fatal (0x8c9b28) и его дерева вызовов.
 *
 * vendor: флаг «ассерт в обработке» [0x80001c]; восстановить питание PHY/PCIe для дампа;
 * 0xdeaddead в 0x880a44/0x880a48; код и место вызова в 0x85700c/0x857010 и 0x80034c..54;
 * запись в расширенные core-регистры r33/r34; журнал (TSF, sp/ilink1/ilink2, стек fw и
 * ucode, link_lost_diag); прерывание хосту «FW error» (MISC ICR бит 31 + событие PCIe 25),
 * если разрешено [0x803c00]; LED-схема 5; по [0x80024a] — ожидание отладчика с
 * обслуживанием mbox; затем `flag 1` — останов ядра. Дальше код идёт только после
 * возобновления из отладчика (JTAG) — тогда fw_sysassert_fatal возвращается.
 *
 * gp-переменные vendor (gp = 0x800184) — абсолютными адресами, смещение в комментарии.
 * Тексты журнала — strings-fw.bin по смещению (токен − 0x1000000).
 */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/fwdata.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/dbg.h"
#include "../include/mbox.h"
#include "../include/sys_cfg.h"


/* Живые регистры ядра, которые vendor журналирует как есть. */
static inline u32 rd_sp(void)
{
    u32 v;
    __asm__ volatile("mov %0,sp" : "=r"(v));
    return v;
}

/* Код fw (fw/fw.ld, CODE): адреса возврата на стеке — отсюда. */
#define FW_CODE_START   0x8c0000u
#define FW_CODE_END     0x900000u

static inline u32 rd_ilink1(void)
{
    u32 v;
    __asm__ volatile("mov %0,ilink1" : "=r"(v));
    return v;
}

static inline u32 rd_ilink2(void)
{
    u32 v;
    __asm__ volatile("mov %0,ilink2" : "=r"(v));
    return v;
}

/* assert__restore_hw_for_dump (0x8e864c): питание PHY, режимы HW по флагам
 * power-менеджера, PCIe без low-power — чтобы хост смог снять дамп.
 * vendor передаёт сюда r0 = 1 (остаток от записи флага), функция его не читает. */
void assert_restore_hw_for_dump(void)
{
    hwd_phy_power_up_seq(0);
    /* vendor: hwm_apply_mode_flags(0, флаги текущего PS-контекста) — контекстов больше нет
     * (энергосбережение вырезано), флаги были нулевые: вызов ничего не делал. */
    hwd_pcie_set_low_power(0);
}

/* assert__notify_host (0x8e866c): «FW error» хосту — MISC ICR бит 31 (0x8d0cfc) и
 * событие PCIe 25 (0x8d1b00). */
void assert_notify_host(void)
{
    fw_log_emit0(0x20, 0x1003a68);
    host_irq_raise_fw_error();
    pcie_set_event_bit_19();
}

/* sysassert__dump_ucode_int6 (0x8c9ce0): подробности сбоя ucode по его коду сисассерта
 * [0x857014]: 0x26 — журнал [0x886e24]; 0x29 — журнал и пара [0x85701c]/[0x857020]. */
void sysassert_dump_ucode_int6(void)
{
    u32 c = VOL(fwsh_diag.uc_assert_code);

    if (c == 0x26) {
        fw_log_emit1(0, 0x1001484, MMIO32(HW_MAC_SXD_MAC_HW_ICR));
    } else if (c == 0x29) {
        fw_log_emit0(0, 0x1001440);
        u32 a = VOL(fwsh_diag.uc_wd_pm_ms[0]);
        u32 b = VOL(fwsh_diag.uc_wd_pm_ms[1]);
        fw_log_emit2(0, 0x1001454, a, b);
    }
}

/* sysassert__dump_stack (0x8c9a88): стек fw от текущего sp до вершины 0x807ffc; слова,
 * похожие на адрес кода, — в журнал с их адресом. sp — собственный (после пролога), как у vendor.
 * НЕ vendor: vendor берёт слова 0x160..0x40000 — младшее отображение ICCM, в котором слинкован его код;
 * наш код слинкован в 0x8c0000..0x900000 (fw/fw.ld), адреса возврата на стеке — оттуда, с фильтром
 * vendor дамп был бы пуст. */
void sysassert_dump_stack(void)
{
    u32 top = FW_DCCM_LAST_WORD;
    u32 p = rd_sp();

    fw_log_emit2(0x20, 0x10013f4, p, top);
    for (; p < top; p += 4) {
        u32 v = *(volatile u32 *)p;
        if (v < FW_CODE_START || v >= FW_CODE_END)
            continue;
        fw_log_emit2(0x20, 0x100140c, p, v);
    }
}

/* sysassert__dump_ucode_stack (0x8c9ad0): стек ucode — от его sp ([0x886f4c], адрес uc
 * DCCM + 0x940000 в окне fw) до 0x944000; слова 0x160..0x20000 (код ucode) — в журнал. */
void sysassert_dump_ucode_stack(void)
{
    u32 top = 0x944000;
    u32 p = MMIO32(HW_UCPU_SP);

    p += 0x130000;          /* vendor: два add_s (0x130000, 0x10000) */
    p += 0x10000;
    fw_log_emit1(0x20, 0x100141c, p);
    for (; p < top; p += 4) {
        u32 v = *(volatile u32 *)p;
        if (v < 0x160 || v > 0x20000)
            continue;
        fw_log_emit2(0x20, 0x100140c, p, v);
    }
}

/* sysassert__debug_hold (0x8c9c58): ожидание отладчика, пока байт [0x80024a]
 * ([gp,0xc6]) != 0. Прерывания выключены, поэтому mbox хоста обслуживается опросом
 * причин 0x880b50 (биты 18/19 — operational/debug mbox, как в ISR 0x880b50).
 * Флаг ассерта [0x80001c] сбрасывается — повторный ассерт из обработчиков команд
 * пройдёт целиком. [0x800249] ([gp,0xc5]) — «в ожидании»: занят — ждать. */
void sysassert_debug_hold(void)
{
    fw_log_emit0(0x20, 0x10014bc);
    irq_disable_all();
    while (dbg_sysassert_wmi_lock != 0)          /* [gp,0xc5] */
        ;
    u32 op = wmi_mbox_drain_active;            /* [gp,0x280] */
    dbg_assert_active = 0;                 /* [gp,-0x168] */
    dbg_sysassert_wmi_lock = 1;
    if (op != 0 || dbg_mbox_draining != 0) {   /* [gp,0x1ac] */
        struct wmi_mbox *mb = (op != 0) ? &operational_if_get_mbox()->wm : debug_mbox_get_or_init();
        struct mbox_ring *ring = &mb->mb.rx;
        *(volatile u32 *)&ring->cur->sync = 0;
        lmac_if_evt_fields(ring);
        ring->hw->tail = (u32)ring->cur;
    }
    while (dbg_sysassert_hold != 0) {        /* [gp,0xc6] */
        u32 c = MMIO32(HW_RGF_USER_USER_ICR_ICR);
        if (c == 0)
            continue;
        MMIO32(HW_RGF_USER_USER_ICR_ICR) = c;
        (dbg_sysassert_mbox_irq_count)++;             /* [gp,0x114] */
        if (c & (1u << 18))
            mbox_drain_operational(0, 0);
        if (c & (1u << 19))
            mbox_drain_debug(0, 0);
    }
}

/* fw_sysassert_fatal (0x8c9b28). caller — у vendor blink вызывающего (r0), code — r1.
 * Наши C-вызовы передают __builtin_return_address(0) объемлющей функции (её вызывающего) или 0.
 *
 * НЕ vendor: место ассерта — точный адрес вызова fw_sysassert_fatal (site, его blink). Код ассерта
 * повторяется в разных местах (0xac — десятки), а caller у половины вызовов 0 или общий для всех проверок
 * функции — по ним место не определить. Поэтому хосту (fwsh_diag.fw_assert_caller, драйвер печатает его
 * при «FW error») и в журнал (curr_blink) идёт site, caller — в журнал вторым (prev_blink) и в
 * DBG_ASSERT_PC − 4. Место по site — addr2line по fw.elf. */
void (fw_sysassert_fatal)(void *caller, u32 code)
{
    u32 tsf[2];
    u32 site = (u32)__builtin_return_address(0);

    if (dbg_assert_active != 0)            /* [gp,-0x168]: ассерт уже идёт */
        return;
    /* НЕ vendor: наша отладочная запись первого ассерта — код (младшие 16 бит) и
     * адрес возврата ((blink-0x8c0000)>>1, старшие 16) в DBG_ASSERT (include/dbg.h). */
    *(volatile u32 *)DBG_ASSERT = (code & 0xffff) | (((site - 0x8c0000) >> 1) << 16);
    /* старшая половина DBG_ASSERT теряет адреса ≥ 0x8e0000 — полный адрес отдельно */
    *(volatile u32 *)DBG_ASSERT_PC = site;
    *(volatile u32 *)(DBG_ASSERT_PC - 4) = (u32)caller;
    dbg_assert_active = 1;
    assert_restore_hw_for_dump();
    fw_status_set_state(0xdeaddead);               /* 0x880a44 */
    fw_status_set_assert_marker(0xdeaddead);       /* 0x880a48 */
    VOL(fwsh_diag.fw_assert_code) = code;
    VOL(fwsh_diag.fw_assert_caller) = site;
    /* Расширенные core-регистры r33/r34: маркер 0xde01, код, маркер 0xde02 — одним
     * блоком, порядок и форма (mov с limm) как в 0x8c9b64..0x8c9b70. */
    __asm__ volatile("mov r33,0xde01\n\t"
                     "mov r34,%0\n\t"
                     "mov r33,0xde02"
                     :: "r"(code) : "memory");
    mac_read_tsf64(0, tsf, 0);
    fw_log_emit3(0x20, 0x10012e8, tsf[1], tsf[0], code);
    dbg_assert_code = code;              /* [gp,0x1cc] */
    u32 lmac_crash = dbg_ucode_crash;    /* [gp,-0x134]: 1 — сбой ucode (вектор 6) */
    dbg_assert_caller = (u32)caller;       /* [gp,0x1c8] */
    dbg_assert_code2 = code;              /* [gp,0x1d0] */
    /* «curr_blink=%X, prev_blink=%X»: vendor — caller и свой blink после emit3 (константа внутри этой
     * функции, места не несёт); у нас — site и caller. */
    if (lmac_crash == 1)
        fw_log_emit2(0, 0x1001318, site, (u32)caller);
    else
        fw_log_emit3(0, 0x1001350, site, (u32)caller, code);
    fw_log_emit3(0, 0x100139c, rd_sp(), rd_ilink1(), rd_ilink2());
    if (dbg_ucode_crash == 1)
        sysassert_dump_ucode_int6();
    sysassert_dump_stack();
    sdp_drive_pin_timed(0);
    if (dbg_ucode_crash == 0) {
        fw_log_emit0(0x20, 0x10013d4);
        hwd_phy_rx_ina_det_mode(0);
        hwd_phy_tx_enable(0);
    }
    if (dbg_ucode_crash == 1)
        sysassert_dump_ucode_stack();
    link_lost_diag();
    if (dashboard.cfg.host_assert_notify_en != 0)            /* разрешено ли сообщать хосту */
        assert_notify_host();
    if (dashboard.cfg.assert_led_en != 0)
        led_scheme_apply(5);
    if (dbg_sysassert_hold != 0)             /* [gp,0xc6]: ждать отладчик */
        sysassert_debug_hold();
    /* Останов ядра (H в STATUS32) в окружении nop_s, как 0x8c9c3c..0x8c9c4e. */
    __asm__ volatile(ARC_NOPS_4 "\n\tflag 1\n\t" ARC_NOPS_4 ::: "memory");
}
