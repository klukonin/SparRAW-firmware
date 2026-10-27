// SPDX-License-Identifier: AGPL-3.0-or-later
/* Тела обработчиков векторов главного ядра (vendor 0x8c0774..0x8c1460).
 *
 * Каждый vendor-вектор — C-функция с атрибутом прерывания; здесь её тело, вызываемое из
 * asm-обёртки (fw/start.S: IRQ_TRAMPOLINE / _irq_mem_error / _irq_instr_error).
 * Порт полный: все вызываемые vendor-функции портированы (здесь или в pcie.c, vring.c и др.).
 * Квитирование причин ICR — как у vendor, до обработки: иначе причина остаётся взведённой
 * и вектор входит снова.
 *
 * gp-переменные vendor (gp = 0x800184) — абсолютными адресами, смещение в комментарии.
 * Тексты журнала — strings-fw.bin по смещению (токен − 0x1000000).
 */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/arc.h"
#include "../include/dbg.h"
#include "../include/vring_schd.h"
#include "../include/fwdata.h"
#include "../include/wmi.h"


/* ------------------------------------------------------------------------
 * Вектор 1 — исключение памяти (vendor 0x8c13ec). Уровень 2 (адрес сбоя — ilink2).
 * «IntHandlerMemoryException!!!», «… blink=0x%X», «… sp=%d, ilink1=0x%X, ilink2=0x%X»,
 * фатал 0x11a7. vendor печатает blink уже после первого вызова журнала — это всегда
 * адрес возврата 0x8c143c, а не blink сбойного кода; здесь — blink прерванного кода
 * (обёртка берёт его до вызовов). После возврата обёртка останавливает ядро.
 */
void isr_memory_error(u32 blink, u32 sp, u32 ilink1, u32 ilink2)
{
    /* НЕ vendor: адрес сбоя (ilink2) и blink — в отладочную область до журнала (сбой может
     * повториться в самом журнале). */
    if (*(volatile u32 *)DBG_EXC_PC == 0) {
        *(volatile u32 *)DBG_EXC_PC = ilink2 | 1u;   /* бит 0 — признак исключения памяти */
        *(volatile u32 *)DBG_EXC_BLINK = blink;
        *(volatile u32 *)(DBG_SCRATCH + 0x10) = sp;
        *(volatile u32 *)(DBG_SCRATCH + 0x14) = ilink1;
    }
    fw_log_emit0(0, 0x10001e0);
    fw_log_emit1(0, 0x1000200, blink);
    fw_log_emit3(0, 0x1000228, sp, ilink1, ilink2);
    fw_sysassert_fatal((void *)blink, 0x11a7);
}

/* ------------------------------------------------------------------------
 * Вектор 2 — ошибка инструкции / action point (vendor 0x8c0774). Уровень 2.
 * instruction_error__report (0x8c442c): причина — ASR (DEBUG[10:3], 0x8c3b50); action
 * point 1 — защита ICCM, значение совпадения AP_AMV1 (aux 0x220 + 3·1, 0x8c3b5c(1)) =
 * адрес, к которому было обращение. Затем 16 строк «regs%u: %08x %08x» из кадра.
 */
#define ARC_AUX_DEBUG   0x5
#define ARC_AUX_AP_AMV0 0x220   /* AP_AMVn = 0x220 + 3·n */

static void instruction_error_report(u32 blink, u32 ilink2, const u32 *regs)
{
    u32 asr = (arc_lr(ARC_AUX_DEBUG) >> 3) & 0xff;
    if (asr == 0) {
        fw_log_emit0(0, 0x1000174);               /* «Bad instruction (unknown reason)» */
    } else if (asr & 2) {
        u32 amv = arc_lr(ARC_AUX_AP_AMV0 + 3 * 1);
        fw_log_emit0(0, 0x10000a0);               /* «… (attempt to access ICCM).» */
        fw_log_emit2(0, 0x10000cc, ilink2, amv);  /* «ST/LD cmd before [ilink2=…] (address …)» */
        fw_log_emit1(0, 0x1000114, blink);        /* «… check [blink=0x%X]» */
    } else {
        fw_log_emit1(0, 0x1000148, asr);          /* «… (unknown action point %X)» */
    }
    for (u32 i = 0; i < 32; i += 2)
        fw_log_emit3(0, 0x1000198, i, regs[i], regs[i + 1]);
}

void isr_instruction_error(u32 blink, u32 ilink2, const u32 *regs)
{
    if (*(volatile u32 *)DBG_EXC_PC == 0) {
        *(volatile u32 *)DBG_EXC_PC = ilink2;
        *(volatile u32 *)DBG_EXC_BLINK = blink;
    }
    instruction_error_report(blink, ilink2, regs);
    /* vendor 0x8c0862: mov_s r0,blink после bl.d 0x8c442c — это адрес возврата того
     * вызова (всегда 0x8c0862), а не blink сбойного кода. Как в векторе 1, передаём
     * blink прерванного кода (обёртка берёт его до вызовов). */
    fw_sysassert_fatal((void *)blink, 0x11a8);
}

/* ------------------------------------------------------------------------
 * Вектор 6 — ICR MAC 0x886e40 (vendor 0x8c1194): причина из ICM 0x886e44, квитирование
 * в ICR 0x886e40. Бит 15 — «Awake TSF interrupt expired! TSF: …»; иначе — сбой ucode
 * («LMAC CRASH detected !!!»): код сисассерта и blink ucode из 0x857014/0x857018,
 * sp/ilink1/ilink2 ucode из 0x886f4c/50/54, флаг [gp,-0x134] = 1 (его читает
 * fw_sysassert_fatal vendor), фатал 0x11ac.
 */
/* mac_icr__mask_awake_tsf (0x8e9a90): IMS 0x886e50 бит 15. Прерывание «Awake TSF» взводил только
 * deep sleep (вырезан, см. pcie_pm_event_unsupported) — обработка оставлена защитной: без неё бит
 * 15 ушёл бы в ветку «LMAC CRASH». */
void mac_icr_mask_awake_tsf(void)
{
    MMIO32(HW_MAC_SXD_ERRORS_IMS) = 0x8000;
}

void isr_mac_icr_886e40(void)
{
    u32 tsf[2];

    u32 cause = MMIO32(HW_MAC_SXD_ERRORS_ICM);
    MMIO32(HW_MAC_SXD_ERRORS_ICR) = cause;
    if (cause & (1u << 15)) {
        mac_icr_mask_awake_tsf();
        mac_read_tsf64(0, tsf, 0);
        fw_log_emit2(0x20, 0x1000528, tsf[1], tsf[0]);
        return;
    }
    fw_log_emit0(0, 0x1000558);
    MMIO32(HW_MAC_SXD_ERRORS_IMS) = 0x40;          /* IMS: замаскировать бит 6 */
    u32 uc_code = VOL(fwsh_diag.uc_assert_code);
    u32 uc_blink = VOL(fwsh_diag.uc_assert_caller);
    fw_log_emit2(0, 0x1000570, uc_code, uc_blink);
    u32 f4c = MMIO32(HW_UCPU_SP);
    u32 f50 = MMIO32(HW_UCPU_ILINK1);
    u32 f54 = MMIO32(HW_UCPU_ILINK2);
    fw_log_emit3(0, 0x10005a0, f4c, f50, f54);
    /* vendor 0x8c1256: caller = blink — адрес возврата только что вызванного emit3. */
    u32 bl;
    __asm__ volatile("mov %0,blink" : "=r"(bl));
    dbg_ucode_crash = 1;                 /* [gp,-0x134]: сбой ucode для 0x8c9b28 */
    fw_sysassert_fatal((void *)bl, 0x11ac);
}

/* ------------------------------------------------------------------------
 * Вектор 8 — DMA pring (vendor 0x8c12b8 → pring__isr_dispatch 0x8ebf00, 144 Б).
 * Статус 0x881c2c: из каждой тетрады (биты 0, 4, 8) vendor берёт только младший бит
 * (bmsk 0) и для взведённого ставит задачу u_schd (приоритет 2) с индексом бита;
 * затем квитирует статус в 0x881c38 и 0x881c28.
 */
/* hwd_dma__uses_rgf_881c00_8d07f8 (0x8d07f8): [0x881c2c] под запретом IRQ. */
static u32 hwd_dma_read_pring_status(void)
{
    u32 s = arc_irq_disable();
    u32 r = MMIO32(HW_DMA_FW_ICR_C24_ICM);
    arc_irq_restore(s);
    return r;
}

/* hwd_dma__uses_rgf_881c00_8d0b74 (0x8d0b74): [0x881c38] = v под запретом IRQ. */
static void hwd_dma_ack_pring_881c38(u32 v, u32 sync_flag)
{
    u32 s = arc_irq_disable();
    MMIO32(HW_DMA_FW_ICR_C24_IMS) = v;
    if (sync_flag)
        arc_sync();
    arc_irq_restore(s);
}

/* Колбэки задач (u_schd, аргумент — индекс бита = номер pring): объект — элемент
 * vring_schd.pring[] (0x804de4 + idx·0x3c; include/vring_schd.h), берётся через
 * sm_pring_by_index (vring.c): адрес &vring_schd.pring[idx] gcc -Os пересчитывает после
 * каждого вызова (__mulsi3 — у fw нет -mmul64), а указатель из вызова держит в регистре. */


/* obj__has_pending_1c_10 (0x8c3800, 44 Б): есть ли vring в списках готовых 1/0. */
static u32 vring_schd_has_pending(const struct vring_schd *s)
{
    return (s->ready[1].count != 0 || s->ready[0].count != 0) ? 1 : 0;
}

/* Остановка pring: tx_macq_is_empty (0x8da15c), sm_pring_stop_done (0x8c6954) и колбэк
 * таймера sm_pring_timeout_task (0x8e0f3c) — vring.c. Прежде здесь стояли заглушки (0 /
 * пусто): если DMA кольца не был свободен в момент остановки, остановка не завершалась —
 * vring оставался остановленным, BA не завершался (EVT_VRING_STOPPED не приходил), данные
 * STA не шли («assoc без данных» на стенде, 2026-10-19). */

/* (0x8e0eec, 80 Б) vring__stop_hw: бит 0 статуса pring — DMA кольца остановлен: снять
 * бит в 0x881c28 ([p] — ид кольца), VRING — в состояние 4 и vring_schd__stop_vring, если у
 * планировщика есть ожидающие. */
void pring_task_8e0eec(u32 idx, u32 a1)
{
    (void)a1;
    struct pring *p = sm_pring_by_index(idx);
    struct vring_rec *vr;

    vring_reg_write_locked_28(1u << p->id, 0);
    vr = p->bound;
    if (vr == 0)
        fw_sysassert_fatal(__builtin_return_address(0), 0x12bd);
    if (vring_schd_has_pending(&vring_schd) == 1) {
        vr->state = 4;
        vring_schd_stop_vring(&vring_schd, p);
    }
}

/* (0x8c3194, 180 Б) бит 4 статуса pring: DMA и MACQ пусты — отменить таймер [p+0x24] и
 * по состоянию [p+0x18]: 3/4 → завершить остановку (0x8c6954; MACQ не пуст — ассерт
 * 0x12ac), 1/2 → только журнал, 0 → журнал и ассерт 0x12ad (таблица 0x8023f4). */
static void pring_on_dma_done(struct pring *p)
{
    struct vring_tbl_entry *entry = vring_tbl_entry_addr(p->vr);
    u32 st;

    if (dma_is_idle(p->id, 0) == 0 || tx_macq_is_empty(entry, 0) == 0) {
        fw_log_emit2(0x27, 0x100d204, p->id, p->vr);
        return;
    }
    if (p->dma_timer != 0) {
        u_schd_cancel(p->dma_timer);
        p->dma_timer = 0;
    }
    st = p->state;
    switch (st) {
    case 3: case 4:
        if (tx_macq_is_empty(entry, 0) == 0)
            fw_sysassert_fatal(__builtin_return_address(0), 0x12ac);
        sm_pring_stop_done(p);
        return;
    case 1: case 2:
        fw_log_emit1(0x27, 0x100d240, u_schd_now() << 4);
        return;
    case 0:
        fw_log_emit1(0x27, 0x100d240, u_schd_now() << 4);
        fw_sysassert_fatal(__builtin_return_address(0), 0x12ad);  /* 0x8c3222 → 0x8c3236 */
        return;
    default:
        fw_sysassert_fatal(__builtin_return_address(0), 0x12ad);
        return;
    }
}

/* (0x8e0ecc, 16 Б) задача бита 4. */
void pring_task_8e0ecc(u32 idx, u32 a1)
{
    (void)a1;
    pring_on_dma_done(sm_pring_by_index(idx));
}

/* (0x8c9990, 196 Б) бит 8 статуса pring: время [p+0x38], снять таймер [p+0x1c] и флаг
 * L1 [p+0x20]; состояние 3/4 → выключить кольцо (0x881c28, бит id+4), пусто — завершить
 * остановку (0x8c6954), иначе таймер 0x8e0f3c ([gp,0x1c4] = 0x800348) и включить бит
 * в 0x881c3c; 1/2 → журнал; 0 или >= 5 → ассерт 0x12a6 (таблица 0x8023e4). */
static void pring_on_stop_req(struct pring *p)
{
    u32 st;
    struct vring_tbl_entry *entry;

    p->stop_end = u_schd_now() << 4;
    if (p->stop_timer != 0) {
        u_schd_cancel(p->stop_timer);
        p->stop_timer = 0;
        if (p->l1_hold != 0) {
            hwd_pcie_exit_l1(0);
            p->l1_hold = 0;
        }
    }
    st = p->state;
    switch (st) {
    case 3: case 4:
        vring_reg_write_locked_28(1u << (p->id + 4), 1);
        entry = vring_tbl_entry_addr(p->vr);
        tx_macq_is_empty(entry, 0);                 /* результат vendor не использует */
        if (dma_is_idle(p->id, 0) != 0) {
            sm_pring_stop_done(p);
        } else {
            p->dma_timer = u_schd_schedule(sm_pring_timeout_task, p->id, 0, 1,
                                           pring_stop_timeout, 0, 0);
            vring_reg_write_locked_3c(1u << (p->id + 4), 1);
        }
        return;
    case 1: case 2:
        fw_log_emit1(0x27, 0x100d0a4, u_schd_now() << 4);
        return;
    default:
        fw_sysassert_fatal(__builtin_return_address(0), 0x12a6);
        return;
    }
}

/* (0x8e0edc, 16 Б) задача бита 8. */
void pring_task_8e0edc(u32 idx, u32 a1)
{
    (void)a1;
    pring_on_stop_req(sm_pring_by_index(idx));
}

static void pring_schedule_bits(u32 bits, u_schd_fn cb)
{
    while (bits) {
        u32 idx = 31 - __builtin_clz(bits);   /* vendor: 30 − norm = старший бит */
        u_schd_add(cb, idx, 0, 2);
        bits &= ~(1u << idx);
    }
}

void pring_isr_dispatch(void)
{
    u32 st = hwd_dma_read_pring_status();
    pring_schedule_bits(st & 1u, pring_task_8e0eec);
    pring_schedule_bits((st >> 4) & 1u, pring_task_8e0ecc);
    pring_schedule_bits((st >> 8) & 1u, pring_task_8e0edc);
    hwd_dma_ack_pring_881c38(st, 1);
    vring_reg_write_locked_28(st, 1);
}

/* ------------------------------------------------------------------------
 * Векторы 10/11 — блоки RGF_ICR MAC 0x887000: причина из ICM, запись обратно в ICR
 * (только квитирование). vendor 0x8c08f0 / 0x8c0990.
 */
/* mac_icr__read_cause_887014 (0x8dd8b8), mac_icr__read_cause_887030 (0x8dd8c4). */
static u32 mac_icr_read_cause_887014(void) { return MMIO32(HW_MAC_CNT_ICM); }
static u32 mac_icr_read_cause_887030(void) { return MMIO32(HW_MAC_CNT2_ICM); }

void isr_mac_icr_887010(void)
{
    MMIO32(HW_MAC_CNT_ICR) = mac_icr_read_cause_887014();
}

void isr_mac_icr_88702c(void)
{
    MMIO32(HW_MAC_CNT2_ICR) = mac_icr_read_cause_887030();
}

/* ------------------------------------------------------------------------
 * Вектор 12 — MAC/PHY (vendor 0x8c0a30): счётчик [gp,0x18c], выключить RX PHY,
 * [0x886e2c] = 0x8000, [0x886028] = −1.
 */
void isr_mac_886028(void)
{
    mac_phy_irq_count += 1;                /* [gp,0x18c] */
    hwd_phy_rx_enable(0);
    MMIO32(HW_MAC_HW_ICR_ICS) = 0x8000;
    MMIO32(HW_MAC_IRQ_CTL_886028) = 0xffffffffu;
}

/* ------------------------------------------------------------------------
 * Вектор 13 — RGF_CAF_ICR (vendor 0x8c0aec): причина из ICM 0x889474, квитирование в
 * ICR 0x889470. Бит 2 «PLL5 UNLOCK interrupt!!!», бит 7 «FS8 UNLOCK interrupt!!!»:
 * счётчик (16 бит) и фатал (0x12ec / 0x12ee) только при взведённом байте политики.
 */
void isr_caf_icr_889470(void)
{
    u32 cause = MMIO32(HW_RGF_CAF_ICR_ICM);
    MMIO32(HW_RGF_CAF_ICR_ICR) = cause;
    if (cause & (1u << 2)) {
        dbg_pll5_unlock_count += 1;            /* [gp,0x84] */
        if (rf_pll5_unlock_fatal != 0) {       /* [gp,0xbb] */
            fw_log_emit0(0, 0x10004f4);
            fw_sysassert_fatal((void *)0, 0x12ec);
        }
    }
    if (cause & (1u << 7)) {
        rf_fs8_unlock_count += 1;            /* [gp,0x116] */
        if (rf_fs8_unlock_fatal != 0) {       /* [gp,0xb0] */
            fw_log_emit0(0, 0x1000510);
            fw_sysassert_fatal((void *)0, 0x12ee);
        }
    }
}

/* ------------------------------------------------------------------------
 * Вектор 15 — PCIe debug (vendor 0x8c0be4): счётчик [gp,0x198]; причина из ICM 0x882690,
 * квитирование в ICR 0x88268c; коды 0..3 → свои обработчики; ни одного —
 * «UN HANDLED PCIE DEBUG INTERRUPT (CAUSE=0X%X)», фатал 0x11a9.
 */
/* pcie_debug__read_and_ack_cause (0x8d11b8). */
static u32 pcie_debug_read_and_ack_cause(void)
{
    u32 c = MMIO32(HW_PCIE_DEBUG_ICR_ICM);
    MMIO32(HW_PCIE_DEBUG_ICR_ICR) = c;
    return c;
}

/* pcie_debug__code_to_index (0x8d11c4): код → бит причины (0→3, 1→12, 2→9, 3→0). */
static u32 pcie_debug_code_to_index(u32 cause, u32 code)
{
    switch (code) {
    case 0: return (cause >> 3) & 1;
    case 1: return (cause >> 12) & 1;
    case 2: return (cause >> 9) & 1;
    case 3: return cause & 1;
    default: return 0;
    }
}


/* pcie_debug__mask_tx_fifo_full_irq (0x8f6b88), dpal__mask_cpl_timeout_irq (0x8f6b4c),
 * pcie_dbg__rearm_irq_bit3 (0x8fa874), 0x8fa854, 0x8fa864, pcie__clear_cpl_timeout
 * (0x8fa818): маски/квитирование блока 0x882680 (+0x1c маска, +0xc/+0x20 снять). */
static void pcie_debug_mask_tx_fifo_full_irq(void) { MMIO32(HW_PCIE_DEBUG_ICR_IMS) = 8; }
static void dpal_mask_cpl_timeout_irq(void) { MMIO32(HW_PCIE_DEBUG_ICR_IMS) = 0x1000; }
static void pcie_dbg_rearm_irq(u32 bit)
{
    MMIO32(HW_PCIE_DEBUG_ICR_ICR) = bit;
    MMIO32(HW_PCIE_DEBUG_ICR_IMC) = bit;
}
static void pcie_clear_cpl_timeout(void)
{
    MMIO32(HW_DPAL_CPL_TO_CTL) = 999;
    MMIO32(HW_PCIE_DEBUG_ICR_ICR) = 0x1000;
    MMIO32(HW_PCIE_DEBUG_ICR_IMC) = 0x1000;
}

/* wbe_driver__pcie_debug (0x8f7d20, 316 Б): дамп отладки PXE в журнал. Маска колец —
 * младший байт 0x882edc; для каждого взведённого бита (кольцо r < 8) выбрать кольцо в
 * 0x882ed8 (поле [6:4] = r, бит 8 = (r != 0), поле [2:0] = r) и вывести 16 слов окна
 * 0x882ed8 + 4·i («PCIE DEBUG %d (ring#=%d): 0x%08X» — i, r, слово). Затем — 11 регистров
 * PXE/SW_PORT1. Проверки vendor «r & ~7 → ассерт 0xac» (перед каждой записью выбора) при
 * r < 8 недостижимы — не повторены. */
static void wbe_driver_pcie_debug(void)
{
    u32 mask = MMIO32(HW_PXE_DBG_CSU_LOCK) & 0xff;

    for (u32 ring = 0; ring < 8; ring++, mask >>= 1) {
        if ((mask & 1u) == 0)
            continue;
        u32 sel = (MMIO32(HW_PXE_DBG_SEL) & ~0x70u) | (ring << 4);
        MMIO32(HW_PXE_DBG_SEL) = sel;
        sel = MMIO32(HW_PXE_DBG_SEL);
        MMIO32(HW_PXE_DBG_SEL) = ring != 0 ? (sel | (1u << 8)) : (sel & ~(1u << 8));
        MMIO32(HW_PXE_DBG_SEL) = (MMIO32(HW_PXE_DBG_SEL) & ~7u) | ring;
        for (u32 i = 0; i < 16; i++)
            fw_log_emit3(0x2f, 0x10031b8, i, ring, MMIO32(HW_PXE_DBG_SEL + (i << 2)));
    }
    fw_log_emit1(0x2f, 0x10031dc, MMIO32(HW_PXE_PUP_DBG_0));
    fw_log_emit1(0x2f, 0x1003210, MMIO32(HW_PXE_PDN_CACHE_REQ_FIFO));
    fw_log_emit1(0x2f, 0x100325c, MMIO32(HW_PXE_PDN_TX_DP_FIFO));
    fw_log_emit1(0x2f, 0x1003288, MMIO32(HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_0));
    fw_log_emit1(0x2f, 0x10032d4, MMIO32(HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_1));
    fw_log_emit1(0x2f, 0x1003320, MMIO32(HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_2));
    fw_log_emit1(0x2f, 0x100336c, MMIO32(HW_PCIE_SW_PORT1_DBG_TX_PCPL_REMOTE_3));
    fw_log_emit1(0x2f, 0x10033b8, MMIO32(HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_0));
    fw_log_emit1(0x2f, 0x1003404, MMIO32(HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_1));
    fw_log_emit1(0x2f, 0x1003450, MMIO32(HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_2));
    fw_log_emit1(0x2f, 0x100349c, MMIO32(HW_PCIE_SW_PORT1_DBG_RX_PCPL_REMOTE_3));
}

/* wbe_driver__pcie_debug_isr (0x8f7e5c, 84 Б): код 0 — замаскировать; [0x882edc] != 0 →
 * счётчик [gp,0x1a4], разбор, задача разрыва связей; иначе снова разрешить бит 3. */
static void wbe_driver_pcie_debug_isr(void)
{
    u32 st;

    pcie_debug_mask_tx_fifo_full_irq();
    st = MMIO32(HW_PXE_DBG_CSU_LOCK) & 0xff;
    fw_log_emit1(0x2f, 0x10035e4, st);
    if (st == 0) {
        pcie_dbg_rearm_irq(8);
        return;
    }
    pcie_dbg_fifo_irq_count += 1;                 /* [gp,0x1a4] */
    wbe_driver_pcie_debug();
    fw_log_emit0(0x2f, 0x100362c);
    u_schd_add(vring_schd_disconnect_notify, 1, WMI_SPARRAW_DISC_PCIE_DEBUG_FIFO, 2);
}

/* (0x8c96ac, 188 Б) задача таймаута completion: журнал счётчиков 0x882d08..0x882d10;
 * картина «всё по 7 / кредиты согласованы» → разрыв связей, иначе сбросить и разрешить. */
void dpal_cpl_timeout_task(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    u32 b = MMIO32(HW_DPAL_CPL_VALID_VECTOR) & 0xff;
    s32 c0 = MMIO32(HW_DPAL_CPL_CNT_0_3) & 0x1f;
    s32 c1 = (MMIO32(HW_DPAL_CPL_CNT_0_3) >> 8) & 0x1f;
    s32 c2 = (MMIO32(HW_DPAL_CPL_CNT_0_3) >> 16) & 0x1f;
    s32 c3 = (MMIO32(HW_DPAL_CPL_CNT_0_3) >> 24) & 0x1f;
    s32 d0 = MMIO32(HW_DPAL_CPL_CNT_4_7) & 0x1f;
    s32 d1 = (MMIO32(HW_DPAL_CPL_CNT_4_7) >> 8) & 0x1f;
    s32 d2 = (MMIO32(HW_DPAL_CPL_CNT_4_7) >> 16) & 0x1f;
    s32 d3 = (MMIO32(HW_DPAL_CPL_CNT_4_7) >> 24) & 0x1f;

    fw_log_emit3(0x2f, 0x1003808, b, c0, c1);
    fw_log_emit3(0x2f, 0x100385c, c2, c3, d0);
    fw_log_emit3(0x2f, 0x10038a8, d1, d2, d3);
    if (c0 == 7 && c1 == 7 && d0 < c2 && c2 == c3 && d2 < d0 && d0 == d1 && d2 >= 1
        && d2 == d3) {
        fw_log_emit0(0x1f, 0x10038f4);
        vring_schd_disconnect_notify(1, WMI_SPARRAW_DISC_PCIE_CPL_TIMEOUT);
    } else {
        pcie_clear_cpl_timeout();
    }
}

/* dpal__cpl_timeout_log (0x8c9768, 38 Б): код 1. */
static void dpal_cpl_timeout_log(void)
{
    fw_log_emit0(0x2f, 0x1003670);
    dpal_mask_cpl_timeout_irq();
    u_schd_add(dpal_cpl_timeout_task, 0, 0, 2);
}

/* WBE_DRIVER::pxe_isoc_in_dir_bypass (0x8f7eb0, 136 Б): бит 14 в 0x882e08/0x882e1c/
 * 0x882e6c на время записи — снять биты 1,2,6 в 0x882dd4 (и бит 31 — «применить»).
 * v > 1 — ассерт 0xac на каждой записи (как vendor). */
static void pxe_isoc_in_dir_bypass(u32 v)
{
    u32 saved, bad = v & ~1u;

    fw_log_emit1(0x2f, 0x1003648, v);
    saved = MMIO32(HW_PXE_CTL);
    MMIO32(HW_PXE_CTL) = saved & ~70u;
    MMIO32(HW_PXE_CTL) |= 0x80000000u;
    if (bad)
        fw_sysassert_fatal(__builtin_return_address(0), 0xac);
    MMIO32(HW_PXE_CH_CFG_0) = (MMIO32(HW_PXE_CH_CFG_0) & ~(1u << 14)) | (v << 14);
    if (bad)
        fw_sysassert_fatal(__builtin_return_address(0), 0xac);
    MMIO32(HW_PXE_CH_CFG_1) = (MMIO32(HW_PXE_CH_CFG_1) & ~(1u << 14)) | (v << 14);
    if (bad)
        fw_sysassert_fatal(__builtin_return_address(0), 0xac);
    MMIO32(HW_PXE_CH_CFG_2) = (MMIO32(HW_PXE_CH_CFG_2) & ~(1u << 14)) | (v << 14);
    MMIO32(HW_PXE_CTL) = saved;
    MMIO32(HW_PXE_CTL) |= 0x80000000u;
}

/* pxe__isoc_in_dir_bypass_on (0x8f7d10) / _off (0x8f7d18): коды 2 и 3. */
static void pxe_isoc_in_dir_bypass_on(void) { pxe_isoc_in_dir_bypass(1); }
static void pxe_isoc_in_dir_bypass_off(void) { pxe_isoc_in_dir_bypass(0); }

void isr_pcie_debug(void)
{
    u32 handled = 0;

    pcie_dbg_irq_count += 1;                /* [gp,0x198] */
    u32 cause = pcie_debug_read_and_ack_cause();
    if (pcie_debug_code_to_index(cause, 0)) {
        handled = 1;
        wbe_driver_pcie_debug_isr();
    }
    if (pcie_debug_code_to_index(cause, 1)) {
        handled = 1;
        dpal_cpl_timeout_log();
    }
    if (pcie_debug_code_to_index(cause, 2)) {
        handled = 1;
        pxe_isoc_in_dir_bypass_on();
    }
    if (pcie_debug_code_to_index(cause, 3)) {
        handled = 1;
        pxe_isoc_in_dir_bypass_off();
    }
    if (!handled) {
        fw_log_emit1(0, 0x1000264, cause);
        fw_sysassert_fatal((void *)0, 0x11a9);
    }
}

/* ------------------------------------------------------------------------
 * Вектор 16 — PCIe PERST/D3 (vendor 0x8c0cf4): причина из ICM 0x882674, квитирование в
 * ICR 0x882670; коды pcie_irq__extract_bit_by_code. Код 5 — PERST deassert: выход из L1,
 * ожидание phy_pll_lock (до 100000 опросов, прерывается новым PERST assert), затем
 * DBI-записи / обход A2 SSID/SSVID; не дождались — фатал 0x11aa. Ни одного кода — 0x11ab.
 */
/* hwd_pcie__rgf_882600 (0x8d13d4). */
static u32 hwd_pcie_read_and_ack_cause_882670(void)
{
    u32 c = MMIO32(HW_RGF_PAL_UNIT_ICR_ICM);
    MMIO32(HW_RGF_PAL_UNIT_ICR_ICR) = c;
    return c;
}

/* 0x8038fc: таблица переходов vendor pcie_irq__extract_bit_by_code_fw (0x8d1484): ldb.x, 10 записей, цель = 0x8d1498 + 2·запись.
 * Наш порт её не читает — объект держит образ fw_data (aligned — без добивки секции до 4 Б). */
FWDATA(8038fc) __attribute__((aligned(1))) const u8 pcie_irq_extract_bit_by_code_jt[10] = {
    0x00, 0x03, 0x06, 0x09, 0x0c, 0x0f, 0x12, 0x1b, 0x15, 0x18,
};

/* pcie_irq__extract_bit_by_code (0x8d1484, таблица 0x8038fc): код → бит причины. */
static u32 pcie_irq_extract_bit_by_code(u32 cause, u32 code)
{
    static const u8 bit_of_code[10] = { 11, 13, 14, 3, 18, 5, 4, 0xff, 29, 24 };
    if (code >= 10 || bit_of_code[code] == 0xff)
        return 0;
    return (cause >> bit_of_code[code]) & 1;
}

/* pcie__get_phy_pll_lock (0x8d1434): бит 11 регистра 0x88262c. */
static u32 pcie_get_phy_pll_lock(void)
{
    return (MMIO32(HW_PCIE_PHY_STATUS) >> 11) & 1;
}


/* (0x8e2078, 62 Б) задача таймера кода 0: снять [gp,-0x4c]; при [gp,0x2c0] — снова
 * разрешить бит 3 отладочного блока; при [gp,0x2bc] — выключить обход ISOC и разрешить
 * биты 9 и 0; применить 0x882dd4. */
void pcie_isr_code0_timer_task(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    pcie_dbg_rearm_timer = 0;                  /* [gp,-0x4c] */
    fw_log_emit0(0x2f, 0x1003a10);
    if (pcie_code0_rearm_bit3_en != 0)             /* [gp,0x2c0] */
        pcie_dbg_rearm_irq(8);
    if (pcie_code0_isoc_restore_en != 0) {           /* [gp,0x2bc] */
        pxe_isoc_in_dir_bypass(0);
        pcie_dbg_rearm_irq(0x200);                  /* 0x8fa854 */
        pcie_dbg_rearm_irq(1);                      /* 0x8fa864 */
    }
    MMIO32(HW_PXE_CTL) |= 0x80000000u;
}

/* (0x8f0a44, 50 Б; имя ba_setup_sm__addba_resp ошибочно) код 0: перезапустить таймер
 * [gp,-0x4c] = 0x800138 на [gp,0x2c4] = 0x800448. */
static void pcie_isr_code0_8f0a44(void)
{
    if (pcie_dbg_rearm_timer != 0) {
        u_schd_cancel(pcie_dbg_rearm_timer);
        pcie_dbg_rearm_timer = 0;
    }
    pcie_dbg_rearm_timer = u_schd_schedule(pcie_isr_code0_timer_task, 0, 0, 0,
                                                pcie_code0_timer_delay, 0, 0);
}

/* (0x8f0e14, 160 Б; vendor-имя mlme_sm__assoc_req_handle ошибочно) запись BAR через DBI:
 * сначала теневой регистр (DBI2, бит 7 команды) — маска size − 1, затем сам регистр —
 * значение val; параметры функции/порта f0..f3 — младшие байты, режим завершения 1 (ждать).
 * Неудача — «dbi_write shadow DS #%d FAILED» (f3) и ассерт 0x11a2 / 0x11a3. */
static void pcie_dbi_write_bar(u8 f0, u8 f1, u8 f2, u8 f3, u32 reg, u32 val, u32 size)
{
    if (pcie_dbi_transfer(reg, size - 1u, f0, f1, f2, f3, 1, 1, 1) == 0) {
        fw_log_emit1(0, 0x1001630, f3);
        fw_sysassert_fatal(__builtin_return_address(0), 0x11a2);
    }
    if (pcie_dbi_transfer(reg, val, f0, f1, f2, f3, 1, 1, 0) == 0) {
        fw_log_emit1(0, 0x1001630, f3);
        fw_sysassert_fatal(__builtin_return_address(0), 0x11a3);
    }
}

/* hwd_pcie__read_8825c0 (0x8d141c). */
static u32 hwd_pcie_read_8825c0(void) { return MMIO32(HW_PCIE_MODE_FLAGS); }

/* pcie_perst_handler_step (0x8f0d28, 170 Б): при [gp,0x1f8] = 0x80037c по битам 0x8825c0
 * перепрограммировать BAR0/BAR1 (DBI 0x10/0x14) функций/портов. */
static void pcie_perst_handler_step(void)
{
    u32 cfg = hwd_pcie_read_8825c0();

    if (pcie_perst_cfg_fix_en == 0)
        return;
    if (hwd_pcie_is_ep_under_serdes() != 0 || (cfg & 2))
        pcie_dbi_write_bar(0, 1, 0, 0, 0x10, 4, 0x200000);
    if (cfg & 4) {
        pcie_dbi_write_bar(0, 0, 1, 0, 0x10, 8, 0x800000);
        pcie_dbi_write_bar(0, 0, 1, 0, 0x14, 1, 0x100);
    }
    if (cfg & 8) {
        pcie_dbi_write_bar(0, 0, 1, 1, 0x10, 0, 0x800000);
        pcie_dbi_write_bar(0, 0, 1, 1, 0x14, 1, 0x100);
    }
}

/* wbe__rearm_link_down_irq (0x8fa83c): [0x882670] = [0x882684] = 0x40000. */
static void wbe_rearm_link_down_irq(void)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_ICR) = 0x40000;
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMC) = 0x40000;
}


/* (0x8f5e6c, 60 Б) задача «связь поднята по всем трём»: снять таймер [gp,-0x8c],
 * перевооружить прерывания, событие 2 хосту.
 * Сознательное отличие: дальше vendor зовёт [0x8000e8]([0x8000e0], [0x8000e4], 1)
 * (jl_s [r3], r3 = [gp,-0x9c]). Доказательство, что указатель всегда 0: в образе fw_data
 * 0x8000e0..0x8000eb — нули; во всём vendor-коде (6.2/src/asm/fw) эти адреса читает только
 * эта функция, записей ни абсолютных, ни через gp нет; единственный индексный писатель рядом —
 * pcp_start/stop__cancel_timer (0x8d8778, [gp + 4·i − 0xe4]) — пишет 0. Вызов по 0 —
 * переход на адрес 0 (начало ICCM, вектор сброса); у нас вызова нет. */
void wbe_driver_link_up_task(u32 a0, u32 a1)
{
    (void)a0;
    (void)a1;
    if (wbe_link_up_timer != 0) {           /* [gp,-0x8c] */
        u_schd_cancel(wbe_link_up_timer);
        wbe_link_up_timer = 0;
    }
    wbe_rearm_link_down_irq();
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMS) = 0x2000;       /* 0x8f6b6c */
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMS) = 0x4000;
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMS) = 8;
    fw_log_emit0(0x2f, 0x10037cc);
    pcie_set_event_bit(2);
}

/* WBE_DRIVER::link_up_notif (0x8f5ea8, 106 Б): маска [gp,0xcf] = 0x800253 |= 1 << which;
 * все три (7) — задача 0x8f5e6c. */
static void wbe_driver_link_up_notif(u32 which)
{
    u8 m = pcie_link_up_mask | (u8)(1u << which);
    pcie_link_up_mask = m;
    switch (which) {
    case 0: fw_log_emit0(0x2f, 0x1003684); break;
    case 1: fw_log_emit0(0x2f, 0x10036b4); break;
    case 2: fw_log_emit0(0x2f, 0x10036e4); break;
    default: fw_sysassert_fatal(__builtin_return_address(0), 0x106b); break;
    }
    if (pcie_link_up_mask == 7) {
        fw_log_emit0(0x2f, 0x10036e4);
        u_schd_add(wbe_driver_link_up_task, 0, 0, 2);
    }
}

/* WBE_DRIVER::link_down_notif (0x8f5dd4, 54 Б): замаскировать (0x8f6b5c: [0x882680] =
 * 0x40000), для which == 0 — задача разрыва связей; иначе ассерт 0x106c. */
static void wbe_driver_link_down_notif(u32 which)
{
    MMIO32(HW_RGF_PAL_UNIT_ICR_IMS) = 0x40000;
    if (which != 0) {
        fw_sysassert_fatal(__builtin_return_address(0), 0x106c);
        return;
    }
    fw_log_emit0(0x2f, 0x1003718);
    u_schd_add(vring_schd_disconnect_notify, 1, WMI_SPARRAW_DISC_PCIE_LINK_DOWN, 2);
}

/* ЭНЕРГОСБЕРЕЖЕНИЕ PCIe ВЫРЕЗАНО СОЗНАТЕЛЬНО (решение владельца, 2026-10-20; вместе с PS
 * 802.11, см. fw/action.c psc_req_reject). У vendor было три механизма:
 *  - D3hot по команде хоста: WMI_TRAFFIC_SUSPEND (0x904) / RESUME (0x905), автомат
 *    pcie_device_power_sm (0x803d10, описатель 0x801ca8), отсрочка трафика в ucode (LMAC 0x27);
 *  - ASPM L1/L1SS по простою DMA (stats_timer_exp), если хост разрешил L1 в LnkCtl;
 *  - deep sleep чипа (POWER_MNGR_halt / deep_sleep_exit) по политике PS.
 * В ядре OpenWrt CONFIG_PM и CONFIG_PCIEASPM выключены: suspend драйвер не шлёт, ASPM не
 * включает. Теперь 0x904/0x905 — «не поддерживается», L1 остаётся запрещённым, как при старте
 * у vendor (pcie_l1_state = 0), в deep sleep чип не уходит. Обход A2 SSID/SSVID и квитирование
 * прерываний PCIe остаются. Остаётся и power_halt_seq: её зовёт hwm_analog_prepare_buf.
 *
 * pcie_device_power_if__pcie_interrupt (0x8e0470) у vendor: 5 PERST deassert, 6 PERST assert,
 * 8 вход в D3, 9 выход из D3 → события автомата. Без TRAFFIC_SUSPEND автомат всегда в D0, а в
 * D0 все четыре события у vendor — basic_sm__error_handler: журнал и фатальный ассерт 0x1033.
 * Здесь то же без автомата; иной код — ассерт 0x1445, как у vendor. */
static void pcie_pm_event_unsupported(u32 ev)
{
    if (ev == 5 || ev == 6 || ev == 8 || ev == 9) {    /* журнал события пишет isr_pcie_main */
        fw_sysassert_fatal((void *)0, 0x1033);
        return;
    }
    fw_sysassert_fatal(__builtin_return_address(0), 0x1445);
}

/* pcie__clear_dbi_gateway (0x8f1b6c, 22 Б): 0x8d1444 — [0x882648] = 0x4000000 и
 * pcie__dbi_ack_done (0x8d11e8). */
static void pcie_clear_dbi_gateway(void)
{
    fw_log_emit0(0x20, 0x1001650);
    MMIO32(HW_PCIE_DBI_CMD) = 0x4000000;
    pcie_dbi_ack_done();
}

/* pcie_device_power_sm__pcie_traffic_resume_req (0x8e05ec, 368 Б): обход A2 SSID/SSVID —
 * DBI 0x60 = 0x700d и 0x64 = 0x1ae9 (dbi_write 0x8c8338, режим 1, бит 8) для каждой
 * функции/порта: (sz 0) при «не под SerDes» (0x8d1470 == 0), sz 1/2 и a4/a4+a5 по битам
 * 0..3 0x8825c0. */
static void pcie_dbi_write_all_ports(u32 reg, u32 val, u32 serdes, u32 cfg)
{
    if (serdes == 0)
        dbi_write(reg, val, 0, 0, 0, 0, 1, 1, 0);
    if (cfg & 1)
        dbi_write(reg, val, 1, 0, 0, 0, 1, 1, 0);
    if (cfg & 2)
        dbi_write(reg, val, 2, 0, 0, 0, 1, 1, 0);
    if (cfg & 4)
        dbi_write(reg, val, 0, 0, 1, 0, 1, 1, 0);
    if (cfg & 8)
        dbi_write(reg, val, 0, 0, 1, 1, 1, 1, 0);
}

static void pcie_device_power_sm_traffic_resume_req(void)
{
    u32 cfg = hwd_pcie_read_8825c0();
    u32 serdes = hwd_pcie_is_ep_under_serdes();

    pcie_dbi_write_all_ports(0x60, 0x700d, serdes, cfg);
    pcie_dbi_write_all_ports(0x64, 0x1ae9, serdes, cfg);
}

/* Чтение-изменение-запись DBI-регистра (шаг pcie__l1_latency_wa): чтение с параметрами
 * (sz 0, a2 = f, режим 1), запись с a3 = f. Слово до чтения обнулено (у vendor для 0x40/0x70c
 * — остаток стека, если чтение не удалось; политика: в железо стековый мусор не идёт). */
static u32 pcie_dbi_read_f(u32 reg, u32 f)
{
    u32 v = 0;
    pcie_dbi_read(reg, 0, f, 0, 0, 1, &v);
    return v;
}

/* pcie__l1_latency_wa (0x8ed7b4, 536 Б; вызов через isr16__pcie_l1_latency_wa 0x8f173c).
 * f = 0x8d1470 (1 — «под SerDes», лог «EP under serdes», иначе «… under switch»).
 * 1) при f или бите 1 0x8825c0: DBI 0x40 (параметры a2 = 1 / a3 = 1) — поле [31:27] = 0
 *    (0x8ed49c), затем hwd_pcie_l1_sub_timing_config (0x8d169c);
 * 2) 0x70c: поле [29:27] = 4 — вход в L1 через 16 мкс;
 * 3) 0x7c (LnkCap): биты 10, 18 — 0, бит 11 — 1 (0x8f8f50) — BUG_5663_WA, без L0s;
 * 4) 0x708: поле [31:24] = 0x20 — счётчик входа в низкое потребление. */
static void pcie_l1_latency_wa(void)
{
    u32 f = hwd_pcie_is_ep_under_serdes();
    u32 cfg = hwd_pcie_read_8825c0();
    u32 v;

    if ((((cfg >> 1) & 1u) | f) != 0) {
        v = 0;
        pcie_dbi_read(0x40, 0, 1, 0, 0, 1, &v);
        v &= ~(0x1fu << 27);                                /* 0x8ed49c: [31:27] = 0 */
        dbi_write(0x40, v, 0, 1, 0, 0, 1, 1, 0);
        hwd_pcie_l1_sub_timing_config();
    }
    fw_log_emit0(0x20, f == 0 ? 0x10014f8 : 0x100152c);
    v = (pcie_dbi_read_f(0x70c, f) & 0xc7ffffffu) | (1u << 29);
    dbi_write(0x70c, v, 0, f, 0, 0, 1, 1, 0);

    fw_log_emit0(0x20, f == 0 ? 0x1001560 : 0x100158c);
    v = pcie_dbi_read_f(0x7c, f);
    pcie_set_l1_bit11(&v);
    dbi_write(0x7c, v, 0, f, 0, 0, 1, 1, 0);

    fw_log_emit0(0x20, f == 0 ? 0x10015b8 : 0x10015f4);
    v = (pcie_dbi_read_f(0x708, f) & 0xffffffu) | (1u << 29);
    dbi_write(0x708, v, 0, f, 0, 0, 1, 1, 0);
}

/* Код 5 — PERST deassert (vendor 0x8c0dbe..0x8c0e80).
 * ХРУПКО: ожидание phy_pll_lock ограничено числом опросов (100000, как vendor), а не
 * временем; итерация — два чтения RGF, их длительность определяет шина, а не код, так что
 * срок близок к vendor. Менять счёт/тело цикла — сверять с vendor 0x8c0dee..0x8c0e04.
 * Внешний срок — аппаратный (PCIe Base, Conventional Reset): хост шлёт конфигурационные
 * запросы через 100 мс после снятия PERST#; DBI-обходы (SSID/SSVID, L1) ниже должны успеть
 * до перечисления. Обработчик — в ISR, запас большой, если PLL встаёт за единицы мс. */
static void pcie_isr_perst_deassert(void)
{
    u32 b80 = 0, lock = 0;
    u32 cnt = 100000;

    fw_log_emit0(0x20, 0x1000294);
    hwd_pcie_exit_l1(1);
    fw_log_emit2(0x20, 0x10002bc, pcie_get_phy_pll_lock(), cnt);
    for (;;) {
        if (--cnt == 0xffffffffu)
            break;                                  /* время вышло: b80 != 0, lock == 0 */
        b80 = hwd_pcie_get_882b80();
        lock = pcie_get_phy_pll_lock();
        if (b80 == 0) {
            fw_log_emit0(0x20, 0x10002f8);          /* снова PERST assert */
            break;
        }
        if (lock != 0) {
            fw_log_emit2(0x20, 0x1000340, pcie_get_phy_pll_lock(), cnt);
            break;
        }
    }
    if (b80 != 0) {
        if (lock != 0) {
            fw_log_emit0(0x20, 0x100037c);          /* «starting DBI writes...» */
            pcie_clear_dbi_gateway();
            fw_log_emit0(0x10, 0x100039c);          /* «A2 PCIE SSID/SSVID Workaround» */
            pcie_device_power_sm_traffic_resume_req();
            pcie_l1_latency_wa();
            pcie_perst_handler_step();
            pcie_clear_dbi_gateway();
        } else {
            fw_log_emit0(0, 0x10003c4);             /* phy_pll_lock не готов */
            fw_sysassert_fatal((void *)0, 0x11aa);
        }
    }
    hwd_pcie_exit_l1(0);
    pcie_pm_event_unsupported(5);
}

void isr_pcie_main(void)
{
    u32 handled;

    u32 cause = hwd_pcie_read_and_ack_cause_882670();
    if (pcie_irq_extract_bit_by_code(cause, 0)) {
        handled = 1;
        pcie_isr_code0_8f0a44();
        pcie_perst_handler_step();
    } else {
        handled = 0;
    }
    if (pcie_irq_extract_bit_by_code(cause, 1)) {
        wbe_driver_link_up_notif(0);
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 2)) {
        wbe_driver_link_up_notif(1);
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 3)) {
        wbe_driver_link_up_notif(2);
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 4)) {
        wbe_driver_link_down_notif(0);
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 5)) {
        pcie_isr_perst_deassert();
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 6) && pcie_perst_assert_irq_en != 0) {  /* [gp,0x1f4] */
        fw_log_emit0(0x20, 0x1000404);              /* «perst assert interrupt...» */
        if (hwd_pcie_get_882b80() == 0)
            pcie_pm_event_unsupported(6);
        else
            fw_log_emit0(0x20, 0x1000428);          /* perst уже снят */
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 8)) {
        fw_log_emit0(0x20, 0x1000470);              /* «D3 Enter interrupt...» */
        pcie_pm_event_unsupported(8);
        handled = 1;
    }
    if (pcie_irq_extract_bit_by_code(cause, 9)) {
        fw_log_emit0(0x20, 0x1000490);              /* «D3 Exit interrupt...» */
        pcie_pm_event_unsupported(9);
        handled = 1;
    }
    if (!handled) {
        fw_log_emit1(0, LS_FW(PCIE_MAIN_UNHANDLED), cause);   /* vendor — без причины */
        fw_sysassert_fatal((void *)0, 0x11ab);
    }
}

/* ------------------------------------------------------------------------
 * Вектор 18 — PCIe L1 (vendor 0x8c0f64): причина из ICM 0x882fd4, квитирование в
 * ICR 0x882fd0; код 0 (бит 14) — вход в L1, код 1 (бит 19) — выход; ни одного —
 * «PCIE UNIT_ICR_PORT0_LTSSM_DBG_1: UN HANDLED INTERRUPT (CAUSE=0x%X)», фатал 0x130c.
 */
/* hwd_pcie__rgf_882f80 (0x8d13e0). */
static u32 hwd_pcie_read_and_ack_cause_882fd0(void)
{
    u32 c = MMIO32(HW_UNIT_ICR_PORT0_LTSSM_DBG_1_ICM);
    MMIO32(HW_UNIT_ICR_PORT0_LTSSM_DBG_1_ICR) = c;
    return c;
}

/* pcie_ltssm__code_to_index (0x8d158c): 0 → бит 14, 1 → бит 19. */
static u32 pcie_ltssm_code_to_index(u32 cause, u32 code)
{
    if (code == 0)
        return (cause >> 14) & 1;
    if (code == 1)
        return (cause >> 19) & 1;
    return 0;
}

/* 0x8d15fc: IMS 0x882fe0 бит 19 — замаскировать выход из L1. */
static void pcie_mask_l1_exit_irq(void)
{
    MMIO32(HW_UNIT_ICR_PORT0_LTSSM_DBG_1_IMS) = 0x80000;
}

/* hwd_pcie_l1_enter_isr (0x8d15d0). */
static void hwd_pcie_l1_enter_isr(void)
{
    if (hwd_pcie_ltssm_is_l1_idle() == 0)
        fw_log_emit0(1, 0x101dcd4);
    pcie_mask_l1_enter_irq();
}

/* fw_vector_18__pair (0x8d162c): результат 0x8d1070 vendor не использует. */
static void hwd_pcie_l1_exit_isr(void)
{
    (void)hwd_pcie_ltssm_is_l1_idle();
    pcie_mask_l1_exit_irq();
}

void isr_pcie_ltssm(void)
{
    u32 handled = 0;

    u32 cause = hwd_pcie_read_and_ack_cause_882fd0();
    if (pcie_ltssm_code_to_index(cause, 0)) {
        pcie_l1_enter_count += 1;            /* [gp,0x110] */
        handled = 1;
        hwd_pcie_l1_enter_isr();
    }
    if (pcie_ltssm_code_to_index(cause, 1)) {
        pcie_l1_exit_count += 1;            /* [gp,0x112] */
        handled = 1;
        hwd_pcie_l1_exit_isr();
    }
    if (!handled) {
        fw_log_emit1(0, 0x10004b0, cause);
        fw_sysassert_fatal((void *)0, 0x130c);
    }
}

/* 0x801be4: таблица переходов switch vendor pcie_device_power_if__pcie_interrupt (0x8e048e) (ldb.x [0x801be4, индекс] → переход на
 * 0x8e0496 + 2·байт; JUMPTABLES-fw.txt). Наш switch компилирует gcc — таблица не
 * используется, байты — данные образа fw_data. */
FWDATA(801be4) const u8 vendor_jt_pcie_device_power_if_pcie_interrupt[5] = {
    0x00, 0x07, 0x20, 0x1c, 0x1e,
};
