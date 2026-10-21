/* SPDX-License-Identifier: AGPL-3.0-or-later
 * Векторы прерываний, сброс и ISR-обвязка uCode (второй CPU) — как vendor 6.2.
 *
 * Таблица 20 векторов по 8 байт (0x920000 .. 0x9200a0), vendor uc_vector_table:
 *   0 сброс; 1 — assert 0x22; 2 — исключение (дамп, assert 0x23);
 *   3/8/9/12 — L1-задачи: l1_task_entry(3/0/1/2), возврат j.f [ilink1];
 *   7/10/14 — L2-задачи: l2_task_entry(3/1/2), возврат j.f [ilink2];
 *   6 — переход в l2_task_entry(0); прочие — j_s [blink].
 * Сохранение контекста в ISR — дословно как vendor 0x9207c0 (r12, mulhi/mlo,
 * r0..r11, lp_count/lp_start/lp_end, blink).
 */
    .section .vectors,"ax",@progbits
    .p2align 2

    .globl _uc_vectors
_uc_vectors:
    j   _uc_reset           /* 0 */
    .align 8
    j   _uc_vec_assert22    /* 1 */
    .align 8
    j   _uc_vec_exception   /* 2 */
    .align 8
    j   _uc_isr_l1_3        /* 3 */
    .align 8
    j   _uc_vec_ret         /* 4 */
    .align 8
    j   _uc_vec_ret         /* 5 */
    .align 8
    j   _uc_vec_l2_0        /* 6 */
    .align 8
    j   _uc_isr_l2_3        /* 7 */
    .align 8
    j   _uc_isr_l1_0        /* 8 */
    .align 8
    j   _uc_isr_l1_1        /* 9 */
    .align 8
    j   _uc_isr_l2_1        /* 10 */
    .align 8
    j   _uc_vec_ret         /* 11 */
    .align 8
    j   _uc_isr_l1_2        /* 12 */
    .align 8
    j   _uc_vec_ret         /* 13 */
    .align 8
    j   _uc_isr_l2_2        /* 14 */
    .align 8
    j   _uc_vec_ret         /* 15 */
    .align 8
    j   _uc_vec_ret         /* 16 */
    .align 8
    j   _uc_vec_ret         /* 17 */
    .align 8
    j   _uc_vec_ret         /* 18 */
    .align 8
    j   _uc_vec_ret         /* 19 (vendor: nop-цепочка) */
    .align 8

/* ------------------------------------------------------------------------ */

    .section .text.startup,"ax",@progbits
    .p2align 2

    .globl _uc_reset
    .type _uc_reset,@function
_uc_reset:                  /* 0x920160 */
    flag 0
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
    mov r1, 0
    mov r0, 0
    jl  uc_init             /* vendor: jl 0x1e2c0 — до установки sp */
    mov sp, __stack_top     /* 0x803a48 (uc/uc.ld) */
    lsr sp, sp, 2
    asl sp, sp, 2
    mov r25, mac_cmd_log    /* указатель кольца MAC-команд (uc/uc.ld) */
    lsr r25, r25, 2
    asl r25, r25, 2
    mov gp, __gp            /* 0x800528 (uc/uc.ld) */
    mov fp, 0
    jl  uc_main
    b   2f
1:  flag 1
    nop
    nop
    nop
2:  b   1b
    .size _uc_reset, . - _uc_reset

/* ------------------------------------------------------------------------ */

    .section .text.uc_isr,"ax",@progbits
    .p2align 2

/* СРОК: вход в обработчик L1/L2 (TBTT bi1_event, GP-таймеры r54, таймеры ARC 0/1) до вызова
 * l1_task_entry/l2_task_entry от прерывания (аппаратный: от этих событий отсчитываются окна
 * BTI/A-BFT/DTI). Путь ~21 инструкция до bl.d (сохранение 17 регистров), выход ~27; vendor
 * 0x9207c0 — дословно то же; запас задаёт не пролог, а l1_task_entry (l1.c) и самые длинные секции
 * с запрещёнными прерываниями (ucode_cmd_0x01_handler: ожидание в mac_rf_switch_cmd1f).
 * Удлинение пролога сдвигает все L1-сроки. */
/* ISR: сохранить контекст, вызвать fn(arg), восстановить, j.f [ret]. */
.macro UC_ISR name, fn, arg, ret
    .globl \name
    .type \name,@function
\name:
    push_s  r12
    st.aw   r59,[sp,-4]
    st.aw   r57,[sp,-4]
    push_s  r0
    push_s  r1
    push_s  r2
    push_s  r3
    st.aw   r4,[sp,-4]
    st.aw   r5,[sp,-4]
    st.aw   r6,[sp,-4]
    st.aw   r7,[sp,-4]
    st.aw   r8,[sp,-4]
    st.aw   r9,[sp,-4]
    st.aw   r10,[sp,-4]
    st.aw   r11,[sp,-4]
    st.aw   lp_count,[sp,-4]
    lr      r12,[lp_start]
    push_s  r12
    lr      r12,[lp_end]
    push_s  r12
    push_s  blink
    bl.d    \fn
    mov_s   r0,\arg
    pop_s   blink
    pop_s   r12
    sr      r12,[lp_end]
    pop_s   r12
    sr      r12,[lp_start]
    pop_s   r12
    mov_s   lp_count,r12
    ld.ab   r11,[sp,4]
    ld.ab   r10,[sp,4]
    ld.ab   r9,[sp,4]
    ld.ab   r8,[sp,4]
    ld.ab   r7,[sp,4]
    ld.ab   r6,[sp,4]
    ld.ab   r5,[sp,4]
    ld.ab   r4,[sp,4]
    pop_s   r3
    pop_s   r2
    pop_s   r1
    pop_s   r0
    pop_s   r12
    mulu64  0,r12,0x1           /* восстановить mlo (r57) */
    mov     0,r57
    pop_s   r12
    sr      r12,[mulhi]
    pop_s   r12
    j.f     [\ret]
    .size \name, . - \name
.endm

    UC_ISR _uc_isr_l1_0, l1_task_entry, 0, ilink1    /* вектор 8  (0x9207c0) */
    UC_ISR _uc_isr_l1_1, l1_task_entry, 1, ilink1    /* вектор 9  (0x92085c) */
    UC_ISR _uc_isr_l1_2, l1_task_entry, 2, ilink1    /* вектор 12 (0x920664) */
    UC_ISR _uc_isr_l1_3, l1_task_entry, 3, ilink1    /* вектор 3  (0x92b89c) */
    UC_ISR _uc_isr_l2_1, l2_task_entry, 1, ilink2    /* вектор 10 (0x9205c4) */
    UC_ISR _uc_isr_l2_2, l2_task_entry, 2, ilink2    /* вектор 14 (0x920704) */
    UC_ISR _uc_isr_l2_3, l2_task_entry, 3, ilink2    /* вектор 7  (0x92b938) */

    .globl _uc_vec_ret
_uc_vec_ret:                /* векторы 4,5,11,13,15..19 (vendor: j_s [blink]) */
    j_s     [blink]

    .globl _uc_vec_l2_0
_uc_vec_l2_0:               /* вектор 6 (0x9207b8): b.d l2_task_entry, r0 = 0 */
    b.d     l2_task_entry
    mov_s   r0,0

    .globl _uc_vec_assert22
_uc_vec_assert22:           /* вектор 1 (0x9208f8) */
    mov_s   r0,blink
    b.d     uc_assert
    mov_s   r1,0x22

    .globl _uc_vec_exception
_uc_vec_exception:          /* вектор 2 (0x9204bc): дамп регистров + assert 0x23 (упрощённо) */
    mov_s   r0,blink
    b.d     uc_assert
    mov_s   r1,0x23
