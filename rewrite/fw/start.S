/* SPDX-License-Identifier: AGPL-3.0-or-later
 * Векторы прерываний и сброс главного ядра (fw).
 *
 * ARC600 стартует с 0x8c0000 (вектор reset). Раскладка — как у vendor (0x8c0000..0x8c00a0):
 * 20 векторов по 8 байт, у каждого свой обработчик. 1 и 2 — исключения (память /
 * инструкция, на ARC600 всегда уровень 2), 3..19 — линии IRQ; уровень линии задаёт
 * aux_irq_lev (irq_set_level, fw/irq.c). Уровень обработчика виден по возврату vendor:
 * j.f [ilink1] — уровень 1, j.f [ilink2] — уровень 2 (из линий так только 7).
 */
#include "../include/hw_regs.h"
#include "../include/dbg.h"

    .section .vectors,"ax",@progbits
    .p2align 2

    .globl _vectors
_vectors:
    j   _reset                  /* 0: reset (vendor 0x8c0120) */
    .align 8
    j   _irq_mem_error          /* 1: исключение памяти (vendor 0x8c13ec) */
    .align 8
    j   _irq_instr_error        /* 2: ошибка инструкции / action point (vendor 0x8c0774) */
    .align 8
    j   _irq_timer0             /* 3: TIMER0 (vendor 0x8da014) */
    .align 8
    j   _irq_entry              /* 4: user-ICR 0x880b50 (vendor 0x8c1064 → 0x8c161c) */
    .align 8
    j   _irq_txrx_dma           /* 5: RX/TX-DMA (vendor 0x8c10fc → 0x8c9604) */
    .align 8
    j   _irq_mac_icr_886e40     /* 6: awake-TSF / сбой ucode (vendor 0x8c1194) */
    .align 8
    j   _irq_timer1_wd          /* 7: сторож TIMER1, уровень 2 (vendor 0x8da03c) */
    .align 8
    j   _irq_pring_dma          /* 8: DMA pring (vendor 0x8c12b8 → 0x8ebf00) */
    .align 8
    j   _irq_entry_vring        /* 9: DMA/VRING (vendor 0x8c1350) */
    .align 8
    j   _irq_mac_icr_887010     /* 10: ICR MAC 0x887010 (vendor 0x8c08f0) */
    .align 8
    j   _irq_mac_icr_88702c     /* 11: ICR MAC 0x88702c (vendor 0x8c0990) */
    .align 8
    j   _irq_mac_886028         /* 12: MAC/PHY (vendor 0x8c0a30) */
    .align 8
    j   _irq_caf_icr_889470     /* 13: срыв PLL5/FS8 (vendor 0x8c0aec) */
    .align 8
    j   _irq_ret_l1             /* 14: пустой (vendor 0x8c0be0: j.f [ilink1]) */
    .align 8
    j   _irq_pcie_debug         /* 15: PCIe debug (vendor 0x8c0be4) */
    .align 8
    j   _irq_pcie_main          /* 16: PCIe PERST/D3 (vendor 0x8c0cf4) */
    .align 8
    j   _irq_ret_l1             /* 17: пустой (vendor 0x8c0f60: j.f [ilink1]) */
    .align 8
    j   _irq_pcie_ltssm         /* 18: PCIe L1 enter/exit (vendor 0x8c0f64) */
    .align 8
    j   _irq_vec19_hang         /* 19: заглушка-зависание (vendor 0x8edcf4) */
    .align 8

/* ------------------------------------------------------------------------ */

    .section .text.startup,"ax",@progbits
    .p2align 2

    .globl _reset
    .type _reset,@function
_reset:
    /* Не vendor (диагностика): повторный вход в _reset после загрузки ([0x8002d8] уже
     * 0x33333333 — lmac_ready) — вызов по нулевому указателю. blink/ilink1/ilink2 в
     * DBG_REENTRY (0x806a80.., вне обнуляемой fw_main области); далее как vendor
     * (fw_main: ассерт 0x11b1). Перезаписывается при каждом повторном входе. */
    ld r0, [fw_data_fresh_magic]
    mov r1, 0x33333333
    brne r0, r1, 1f
    st blink, [DBG_REENTRY]
    st ilink1, [DBG_REENTRY + 4]
    st ilink2, [DBG_REENTRY + 8]
    st sp, [DBG_REENTRY + 0xc]
1:
    /* Не vendor: crt0 0x8c0120 начинает с flag 0 и масок не трогает. Причина/маска бита 9
     * (событие ucode) 0x880b50/0x880b60 снимается здесь до старта uc; размаскирует её
     * lmac (0x880b64 = 0x200), как vendor. */
    mov r0, 0x200
    st r0, [HW_RGF_USER_USER_ICR_ICR]   /* ICR W1C: снять уже взведённую причину bit9 */
    st r0, [HW_RGF_USER_USER_ICR_IMS]   /* IMS: замаскировать ucode-IRQ */
    flag 0                  /* STATUS32 = 0: гасит E1/E2/A1/A2 */
    /* Выключить D-cache (dc_ctrl bit0 DIS=1) — как у vendor (у него кэш де-факто
     * выключен: ноль обращений к dc_* во всём бинарнике). Иначе RGF 0x880000+
     * (mbox_ctl 0x8802bc, rx-ring 0x880318) кэшируется write-back и host видит мусор. */
    mov r0, 1
    sr  r0, [0x48]          /* dc_ctrl.DIS = 1 → всё uncached, как у vendor */

    /* Обнуляем регистры — детерминированный старт C-кода. */
    mov r0, 0
    mov r1, 0
    mov r2, 0
    mov r3, 0
    mov r4, 0
    mov r5, 0
    mov r6, 0
    mov r7, 0
    mov r8, 0
    mov r9, 0
    mov r10, 0
    mov r11, 0
    mov r12, 0
    mov r13, 0
    mov r14, 0
    mov r15, 0
    mov r16, 0
    mov r17, 0

    /* Стек — верхушка DATA, выровнен по 4. */
    mov sp, __stack_top
    bic sp, sp, 3

    /* Глобальный указатель (как у вендора, см. cpu_reset_init). */
    mov gp, __gp            /* 0x800184 (fw/fw.ld) */
    mov fp, 0

    /* Очистить .bss. */
    mov r0, __bss_start
    mov r1, __bss_end
    mov r2, 0
1:  cmp r0, r1
    bge.d 2f
    st r2, [r0]
    add r0, r0, 4
    b 1b
2:

    /* Очистить PERIPH-регионы, как vendor crt0 (иначе мусор →
     * недетерминизм mbox/лога). Пишем UNCACHED (st.di): обычный st оставляет
     * dirty cache-line, которую ARC вытесняет уже ПОСЛЕ записи host'а по PCIe
     * и затирает команду WMI нулями (буфер 0x820 пуст). Границы — символы fw/fw.ld:
     * 0x840000..0x84e81c, общий с uc блок 0x857000..0x857828, 0x854000..0x8552f4. */
    mov r0, __sram_clr_start
    mov r1, __sram_clr_end
    mov r2, 0
3:  cmp r0, r1
    bge.d 4f
    st.di r2, [r0]
    add r0, r0, 4
    b 3b
4:
    mov r0, __fwsh_clr_start
    mov r1, __fwsh_clr_end
    mov r2, 0
5:  cmp r0, r1
    bge.d 6f
    st.di r2, [r0]
    add r0, r0, 4
    b 5b
6:
    mov r0, __conn_clr_start
    mov r1, __conn_clr_end
    mov r2, 0
7:  cmp r0, r1
    bge.d 8f
    st.di r2, [r0]
    add r0, r0, 4
    b 7b
8:

    /* vendor crt0 0x8c16ec: [gp,146] = 0, затем статические конструкторы (0x8c1d6c →
     * 0x8fc364) — до fw_main. Без них vtable/параметры в bss остаются нулями. */
    mov r0, 0
    stb r0, [unk_800216]    /* vendor: stb r0,[gp,0x92] */
    jl  static_ctors_run

    jl  fw_main

    /* Сюда не должны попасть. */
hang:
    b   hang
    .size _reset, . - _reset

/* ------------------------------------------------------------------------
 * Трамплины прерываний. Каждый vendor-вектор — C-функция с атрибутом прерывания: пролог
 * сохраняет r12, mhi/mlo, r0–r11, lp_count/lp_start/lp_end, blink (плюс callee-saved r13..,
 * которые тело использует — у нас их сохраняет сам C-обработчик), вызывает тело и выходит
 * через j.f [ilinkN]. Здесь — тот же пролог/эпилог (порядок как vendor 0x8c08f0) вокруг
 * вызова C-обработчика. Вектор, ведущий прямо в C-функцию, ломает прерванный код:
 * регистры не сохранены, возврат — по его blink. Диагностики в память здесь нет:
 * 0x88031c..0x880334 — слоты кольца событий fw→host, 0x800144 — vendor [gp,-0x40].
 */
    .macro IRQ_SAVE
    push_s r12
    st.a mhi,[sp,-4]        /* multiply-high */
    st.a mlo,[sp,-4]        /* multiply-low */
    push_s r0
    push_s r1
    push_s r2
    push_s r3
    st.a r4,[sp,-4]
    st.a r5,[sp,-4]
    st.a r6,[sp,-4]
    st.a r7,[sp,-4]
    st.a r8,[sp,-4]
    st.a r9,[sp,-4]
    st.a r10,[sp,-4]
    st.a r11,[sp,-4]
    st.a lp_count,[sp,-4]
    lr r12,[0x2]            /* lp_start */
    push_s r12
    lr r12,[0x3]            /* lp_end */
    push_s r12
    push_s blink
    .endm

    .macro IRQ_RESTORE
    pop_s blink
    pop_s r12
    sr r12,[0x3]            /* lp_end */
    pop_s r12
    sr r12,[0x2]            /* lp_start */
    pop_s r12
    mov_s lp_count,r12
    ld.ab r11,[sp,4]
    ld.ab r10,[sp,4]
    ld.ab r9,[sp,4]
    ld.ab r8,[sp,4]
    ld.ab r7,[sp,4]
    ld.ab r6,[sp,4]
    ld.ab r5,[sp,4]
    ld.ab r4,[sp,4]
    pop_s r3
    pop_s r2
    pop_s r1
    pop_s r0
    pop_s r12
    mulu64 r12,0x1          /* mlo = r12 (как vendor: mulu64 0,r12,1) */
    mov 0x0,mlo
    pop_s r12
    sr r12,[0x12]           /* mulhi */
    pop_s r12
    .endm

/* IRQ_TRAMPOLINE имя, обработчик[, ilink1|ilink2] — вектор-обёртка над C-обработчиком.
 * Прежняя версия перед сохранением проверяла ilink1 == 0 → _reset: костыль отладочных
 * раундов (так «обрабатывался» вектор 7 уровня 2, у которого ilink1 не взводится); у vendor
 * его нет, на входе уровня 1 аппаратура всегда пишет ilink1 = адрес возврата — убран. */
    .macro IRQ_TRAMPOLINE name, handler, ilink=ilink1
    .globl \name
    .type \name,@function
\name:
    IRQ_SAVE
    jl  \handler
    IRQ_RESTORE
    j.f [\ilink]
    .size \name, . - \name
    .endm

/* Вектор 3 — TIMER0 (vendor 0x8da014): подтвердить прерывание таймера записью
 * сохранённого CONTROL (таблица таймеров 0x800948: +4 — aux CONTROL0, +0xc — значение)
 * и обнулить счётчик по aux-адресу из [0x800958]. Без него TIMER0, запущенный
 * u_schd_timer_init, давал непрерывное прерывание. */
    .globl _irq_timer0
    .type _irq_timer0,@function
_irq_timer0:
    /* Не vendor (диагностика): последний прерванный PC — в DBG_TIMER0_PC (0x806a28). */
    st ilink1, [DBG_TIMER0_PC]
    push_s r0
    push_s r1
    push_s r2
    mov_s r1, arc_timer_cfg
    ld_s r2, [r1, 0xc]
    ld_s r0, [r1, 0x4]
    sr r2, [r0]
    ld_s r0, [r1, 0x10]
    sr 0, [r0]
    pop_s r2
    pop_s r1
    pop_s r0
    j.f [ilink1]

/* Вектор 7 — сторож TIMER1, прерывание уровня 2 (vendor 0x8da03c: фатальный ассерт 0x11ad,
 * выход j.f [ilink2]). TIMER1 (0x1f78a40 тактов) сбрасывается обработчиком TIMER0 — его
 * срабатывание значит, что прерывания уровня 1 долго не обслуживались. Вместо краха:
 * первый прерванный PC и счётчик (include/dbg.h), подтверждение TIMER1, возврат. Прежде
 * вектор вёл в общий трамплин: ilink1 = 0 → _reset → перезапуск fw. */
    .globl _irq_timer1_wd
    .type _irq_timer1_wd,@function
_irq_timer1_wd:
    push_s r0
    push_s r1
    ld r0, [DBG_WD_PC]
    cmp r0, 0
    bne 1f
    st ilink2, [DBG_WD_PC]
1:  ld r0, [DBG_WD_COUNT]
    add r0, r0, 1
    st r0, [DBG_WD_COUNT]
    mov_s r1, arc_timer_cfg     /* таблица таймеров, запись 1 (+0x10) */
    ld_s r0, [r1, 0x1c]         /* сохранённый CONTROL1 */
    ld_s r1, [r1, 0x14]         /* aux CONTROL1 */
    sr r0, [r1]                 /* подтвердить (сбросить IP) */
    pop_s r1
    pop_s r0
    j.f [ilink2]

/* Вектор 4 — user-ICR 0x880b50 (vendor 0x8c1064 → isr_880b50__dispatch_causes 0x8c161c). */
    IRQ_TRAMPOLINE _irq_entry, isr_880b50_dispatch_causes

/* Вектор 5 — RX/TX-DMA (vendor 0x8c10fc → txrx_mgr__handle_dma_irq 0x8c9604). */
    IRQ_TRAMPOLINE _irq_txrx_dma, txrx_mgr_handle_dma_irq

/* Вектор 6 — ICR MAC 0x886e40: awake-TSF / сбой ucode (vendor 0x8c1194). */
    IRQ_TRAMPOLINE _irq_mac_icr_886e40, isr_mac_icr_886e40

/* Вектор 8 — DMA pring (vendor 0x8c12b8 → pring__isr_dispatch 0x8ebf00). */
    IRQ_TRAMPOLINE _irq_pring_dma, pring_isr_dispatch

/* Вектор 9 — DMA/VRING (vendor 0x8c1350 → hwd_dma__bad_cause + vring_schdlr__isr_dispatch). */
    IRQ_TRAMPOLINE _irq_entry_vring, isr_vring_dma_fw

/* Векторы 10/11 — квитирование ICR MAC 0x887010 / 0x88702c (vendor 0x8c08f0 / 0x8c0990). */
    IRQ_TRAMPOLINE _irq_mac_icr_887010, isr_mac_icr_887010
    IRQ_TRAMPOLINE _irq_mac_icr_88702c, isr_mac_icr_88702c

/* Вектор 12 — MAC/PHY (vendor 0x8c0a30). */
    IRQ_TRAMPOLINE _irq_mac_886028, isr_mac_886028

/* Вектор 13 — RGF_CAF_ICR 0x889470: срыв PLL5/FS8 (vendor 0x8c0aec). */
    IRQ_TRAMPOLINE _irq_caf_icr_889470, isr_caf_icr_889470

/* Векторы 15/16/18 — PCIe: debug, PERST/D3, L1 (vendor 0x8c0be4 / 0x8c0cf4 / 0x8c0f64). */
    IRQ_TRAMPOLINE _irq_pcie_debug, isr_pcie_debug
    IRQ_TRAMPOLINE _irq_pcie_main, isr_pcie_main
    IRQ_TRAMPOLINE _irq_pcie_ltssm, isr_pcie_ltssm

/* Векторы 14/17 — пустые (vendor 0x8c0be0 / 0x8c0f60: только j.f [ilink1]). */
    .globl _irq_ret_l1
    .type _irq_ret_l1,@function
_irq_ret_l1:
    j.f [ilink1]
    .size _irq_ret_l1, . - _irq_ret_l1

/* Вектор 19 — vendor 0x8edcf4: восемь nop и нулевое слово (b .) в 0x8edd14 — зависание
 * (docs/VERSION-DIFF.md §8). Линия 19 у vendor не используется. */
    .globl _irq_vec19_hang
    .type _irq_vec19_hang,@function
_irq_vec19_hang:
    b   _irq_vec19_hang
    .size _irq_vec19_hang, . - _irq_vec19_hang

/* ------------------------------------------------------------------------
 * Исключения (векторы 1, 2). На ARC600 это прерывания уровня 2: адрес сбоя — в ilink2,
 * ilink1 — от последнего прерывания уровня 1. Vendor журналирует, зовёт fw_sysassert_fatal
 * (0x8c9b28), которая в конце останавливает ядро (flag 1 в 0x8c9c44), и только формально
 * выходит через j.f [ilink1] — в чужой, устаревший контекст уровня 1. Наш
 * fw_sysassert_fatal (fw/sysassert.c) тоже останавливает ядро; вернуться он может лишь
 * при повторном ассерте или после возобновления из отладчика — тогда здесь снова
 * останов (цикл flag 1, как crt0 0x8c01a0); возврат vendor не портирован.
 */
    .globl _fw_exception_halt
    .type _fw_exception_halt,@function
_fw_exception_halt:
    flag 1
    nop
    nop
    nop
    b   _fw_exception_halt
    .size _fw_exception_halt, . - _fw_exception_halt

/* Вектор 1 — исключение памяти (vendor 0x8c13ec): пролог как у вектора уровня 1, затем
 * isr_memory_error(blink, sp, ilink1, ilink2) — blink прерванного кода (до вызовов),
 * sp после сохранения (как vendor 0x8c144a). */
    .globl _irq_mem_error
    .type _irq_mem_error,@function
_irq_mem_error:
    IRQ_SAVE
    mov r0, blink
    mov r1, sp
    mov r2, ilink1
    mov r3, ilink2
    jl  isr_memory_error
    b   _fw_exception_halt
    .size _irq_mem_error, . - _irq_mem_error

/* Вектор 2 — ошибка инструкции / action point (vendor 0x8c0774): кадр 32 слов для
 * журнала «regsN» — r0..r25, gp, fp, sp, ilink1, ilink2, blink (vendor 0x8c07e6..0x8c0854),
 * затем isr_instruction_error(blink, ilink2, кадр). Отличия от vendor (только содержимое
 * журнала): кадр строится до порчи r12 (у vendor в слоте r12 — lp_end, т. к. пролог
 * уже сделал lr r12,[lp_end]), в слоте 27 — fp, в слоте 28 — sp прерванного кода
 * (у vendor оба слота — sp после пролога). Сохранение для возврата не нужно — останов. */
    .globl _irq_instr_error
    .type _irq_instr_error,@function
_irq_instr_error:
    sub sp, sp, 128
    st r0, [sp, 0]
    st r1, [sp, 4]
    st r2, [sp, 8]
    st r3, [sp, 12]
    st r4, [sp, 16]
    st r5, [sp, 20]
    st r6, [sp, 24]
    st r7, [sp, 28]
    st r8, [sp, 32]
    st r9, [sp, 36]
    st r10, [sp, 40]
    st r11, [sp, 44]
    st r12, [sp, 48]
    st r13, [sp, 52]
    st r14, [sp, 56]
    st r15, [sp, 60]
    st r16, [sp, 64]
    st r17, [sp, 68]
    st r18, [sp, 72]
    st r19, [sp, 76]
    st r20, [sp, 80]
    st r21, [sp, 84]
    st r22, [sp, 88]
    st r23, [sp, 92]
    st r24, [sp, 96]
    st r25, [sp, 100]
    st gp, [sp, 104]
    st fp, [sp, 108]
    add r0, sp, 128
    st r0, [sp, 112]
    st ilink1, [sp, 116]
    st ilink2, [sp, 120]
    st blink, [sp, 124]
    mov r0, blink
    mov r1, ilink2
    mov r2, sp
    jl  isr_instruction_error
    b   _fw_exception_halt
    .size _irq_instr_error, . - _irq_instr_error
