/* SPDX-License-Identifier: AGPL-3.0-or-later */
/* Микротесты цены инструкций и обращений uc на железе — эталон модели стоимости эмулятора (tests/unit/costmodel.py,
 * проверка — tests/unit/test_cost_model.py). Только в отладочной сборке для стенда:
 *     UC_DBG="-DUC_BENCH -DUC_STAMP_MASK=0x20000"
 * В рабочей сборке файл пуст.
 *
 * Тест — цикл lp из 16 одинаковых групп операций и nop (конец цикла не должен быть целью перехода), повторённый
 * n раз, между двумя чтениями COUNT1 с запрещёнными L1. Начало цикла выровнено на 4, группы — кратны 4 байтам: цена
 * переходов не зависит от раскладки кода (кроме BR_MIS, где невыровненная цель — предмет теста).
 * uc_bench_tick (простой главного цикла) прогоняет по одному тесту за раз, n = BENCH_N1 и BENCH_N2, и пишет каждый
 * замер меткой STAMP_BENCH: a0 = номер теста | n << 8 | TSF[25:10] << 16,
 * a1 = такты. Цена операции сверх nop =
 * (ΔT − ΔT_nop) / (16 (n2 − n1)), ΔT = T(n2) − T(n1): постоянная часть (выбор теста, вход в цикл) и замыкающий nop
 * вычитаются. Переходы — через одну инструкцию (переход на следующую эмулятор не отличает от невыполненного).
 * Разбор — tools/hwdbg/bench.py.
 *
 * Записи только туда, где запись того же значения ничего не меняет: своё слово на стеке, ctl->head кольца событий
 * (пишет только uc), маска пробуждения uc (текущее значение), RGF ICS = 0 (ни одного бита). */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"
#include "dbg.h"

#ifdef UC_BENCH

#define BENCH_N1 2
#define BENCH_N2 6

/* Тесты не помещаются в память кода все сразу — наборы 1–3, сборка — один (UC_BENCH_SET, по умолчанию 1): тело теста
 * чужого набора — пустая заглушка, uc_bench_tick её пропускает. NOP (база) — в обоих. */
#ifndef UC_BENCH_SET
#define UC_BENCH_SET 1
#endif
#define BENCH_ON (BENCH_SET == 0 || BENCH_SET == UC_BENCH_SET)
/* выбор функции теста: чужой набор — bench_nop, заглушка без ссылок выбрасывается (память кода) */
#define SET1(fn) (UC_BENCH_SET == 1 ? (fn) : bench_nop)
#define SET2(fn) (UC_BENCH_SET == 2 ? (fn) : bench_nop)
#define SET3(fn) (UC_BENCH_SET == 3 ? (fn) : bench_nop)
#define MAC_CMD_LOG_ADDR 0x800000u   /* uc/uc.ld mac_cmd_log — адрес-константа в ST_LIMM / STW_LIMM */

#define BENCH_LOOP(op) \
        ".balign 4\n\tmov lp_count,%[n]\n\tnop\n\tlp 9f\n\t.rept 16\n\t" op "\n\t.endr\n\tnop\n9:\n\t"
/* Каждый тест — своя функция: gcc считает длину asm по строкам, а .rept разворачивается ассемблером, поэтому общий
 * switch с вставками получал короткие переходы за пределами дальности. */
#define BENCH_FN_CL(name, op, ...) \
static __attribute__((noinline)) u32 name(u32 n, u32 a, u32 v, u32 b) \
{ \
    if (!BENCH_ON) \
        return 0; \
    u32 t; \
    u32 t0 = arc_lr(0x100); \
    __asm__ volatile(BENCH_LOOP(op) : [t] "=&r"(t), [v] "+r"(v) : [n] "r"(n), [a] "r"(a), [b] "r"(b) \
                     : "lp_count", "memory", ##__VA_ARGS__); \
    return arc_lr(0x100) - t0; \
}
#define BENCH_FN(name, op) BENCH_FN_CL(name, op)
#define BENCH_SET 0
BENCH_FN(bench_nop, "nop")
#undef BENCH_SET
#define BENCH_SET 1
BENCH_FN(bench_ld, "ld %[t],[%[a]]")
BENCH_FN(bench_lduse, "ld %[t],[%[a]]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_st, "st %[v],[%[a]]")
BENCH_FN(bench_stsync, "st %[v],[%[a]]\n\tsync")
BENCH_FN(bench_sync, "sync")
BENCH_FN(bench_lr, "lr %[t],[%[a]]")
BENCH_FN(bench_core_rd, "mov %[t],r40")
BENCH_FN(bench_limm, "mov %[t],0x12345678")
BENCH_FN(bench_br, "b 2f\n\tnop\n2:")
BENCH_FN(bench_br_d, "b.d 2f\n\tnop\n\tnop\n2:")
/* Цель перехода — 32-битная инструкция по адресу ≡ 2 (mod 4): пересекает слово выборки. */
BENCH_FN(bench_br_mis, "b 2f\n\tnop_s\n2:\n\tnop\n\tnop_s")
/* Шина периферии: запись, затем k инструкций до следующего обращения; чтение после записи. */
#define NOP3 "\n\tnop\n\tnop\n\tnop"
#define NOP7 NOP3 NOP3 "\n\tnop"
BENCH_FN(bench_st_n1, "st %[v],[%[a]]\n\tnop")
BENCH_FN(bench_st_n3, "st %[v],[%[a]]" NOP3)
BENCH_FN(bench_st_n7, "st %[v],[%[a]]" NOP7)
BENCH_FN(bench_st_n11, "st %[v],[%[a]]" NOP7 NOP3 "\n\tnop")
BENCH_FN(bench_st_n7_sync, "st %[v],[%[a]]" NOP7 "\n\tsync")
BENCH_FN(bench_st_ld, "st %[v],[%[a]]\n\tld %[t],[%[b]]")
BENCH_FN(bench_ld_n3, "ld %[t],[%[a]]" NOP3)
BENCH_FN(bench_ld_n7, "ld %[t],[%[a]]" NOP7)
BENCH_FN(bench_ld_n11, "ld %[t],[%[a]]" NOP7 NOP3 "\n\tnop")
/* Выборка команд: limm (8 Б) подряд, вперемешку с 16- и 32-битными. */
BENCH_FN(bench_limm_nops2, "mov %[t],0x12345678\n\tnop_s\n\tnop_s")
BENCH_FN(bench_limm_nop, "mov %[t],0x12345678\n\tnop")
BENCH_FN(bench_nop_s, "nop_s")
/* Загрузка без зависимости: следом независимая инструкция / запись в память. */
BENCH_FN(bench_ld_nop, "ld %[t],[%[a]]\n\tnop")
BENCH_FN(bench_ld_st, "ld %[t],[%[a]]\n\tst %[v],[%[b]]")
/* Вызов и возврат: bl на лист из одного j_s [blink] (с delay-слотом и без), обход листа переходом. */
BENCH_FN_CL(bench_callret, "bl 3f\n\tb 4f\n\t.balign 4\n3:\n\tj_s [blink]\n\tnop_s\n4:", "blink")
BENCH_FN_CL(bench_callret_d, "bl 3f\n\tb 4f\n\t.balign 4\n3:\n\tj_s.d [blink]\n\tnop_s\n4:", "blink")
BENCH_FN(bench_brne, "brne %[a],0,2f\n\tnop\n2:")
BENCH_FN_CL(bench_pushpop, "push_s r13\n\tpop_s r13", "r13")
/* Условные переходы: сравнение с переходом (brcc) без перехода и с delay-слотом; cmp + bcc. */
BENCH_FN(bench_breq_nt, "breq %[a],0,2f\n\tnop\n2:")
BENCH_FN(bench_brne_d, "brne.d %[a],0,2f\n\tnop\n\tnop\n2:")
BENCH_FN_CL(bench_cmp_bne, "cmp %[a],0\n\tbne 2f\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_cmp_beq_nt, "cmp %[a],0\n\tbeq 2f\n\tnop\n2:", "cc")
/* Готовность флагов: инструкции между cmp и условной. */
BENCH_FN_CL(bench_cmp_n1_bne, "cmp %[a],0\n\tnop\n\tbne 2f\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_cmp_n2_bne, "cmp %[a],0\n\tnop\n\tnop\n\tbne 2f\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_cmp_movne, "cmp %[a],0\n\tmov.ne %[t],%[a]", "cc")
/* Умножение mul64 (результат — r57 mlo): поток без чтения результата и чтение через 0/1/3 инструкции; операнд —
 * номер станции (как индекс массива в коде) и большой (зависит ли время от величины). */
BENCH_FN(bench_mul, "mul64 0,%[a],0x14")
BENCH_FN(bench_mul_use, "mul64 0,%[a],0x14\n\tmov %[t],r57")
BENCH_FN(bench_mul_n1_use, "mul64 0,%[a],0x14\n\tnop\n\tmov %[t],r57")
BENCH_FN(bench_mul_n3_use, "mul64 0,%[a],0x14" NOP3 "\n\tmov %[t],r57")
/* flag (запись STATUS32; L1 и так запрещены — значение 0 ничего не меняет). */
BENCH_FN_CL(bench_flag, "flag 0", "cc")
/* Косвенный вызов jl [reg] (колбэки), сдвиг на величину из регистра, загрузка по адресу-константе (limm). */
BENCH_FN_CL(bench_jl, "mov %[t],3f\n\tjl [%[t]]\n\tb 4f\n\t.balign 4\n3:\n\tj_s [blink]\n\tnop_s\n4:", "blink")
BENCH_FN(bench_asl_reg, "asl %[t],%[v],%[a]")
BENCH_FN(bench_ld_limm, "ld %[t],[0x803234]")
/* Установка zero-overhead loop (lp) — внутри lp не вкладывается, поэтому внешний цикл здесь — счётчик и bne, и
 * парный тест LOOP2_NOP с той же обвязкой: цена «mov lp_count,1; nop; lp; nop» = LOOP2_LP − LOOP2_NOP + 4. */
#define BENCH_LOOP2(op) \
        ".balign 4\n\tmov %[t],%[n]\n1:\n\t.rept 16\n\t" op "\n\t.endr\n\tsub.f %[t],%[t],1\n\tbne 1b\n\t"
#define BENCH_FN2(name, op) \
static __attribute__((noinline)) u32 name(u32 n, u32 a, u32 v, u32 b) \
{ \
    if (!BENCH_ON) \
        return 0; \
    u32 t; \
    u32 t0 = arc_lr(0x100); \
    __asm__ volatile(BENCH_LOOP2(op) : [t] "=&r"(t), [v] "+r"(v) : [n] "r"(n), [a] "r"(a), [b] "r"(b) \
                     : "lp_count", "memory", "cc"); \
    return arc_lr(0x100) - t0; \
}
BENCH_FN2(bench_loop2_nop, "nop\n\tnop\n\tnop\n\tnop")
BENCH_FN2(bench_loop2_lp, "mov lp_count,1\n\tnop\n\tlp 2f\n\tnop\n2:")
#undef BENCH_SET
#define BENCH_SET 2
/* короткие циклы lp (memset): 3 прохода тела из 1 / 2 / 4 инструкций, 1 проход тела из 2 */
BENCH_FN2(bench_lp3_1, "mov lp_count,3\n\tnop\n\tlp 2f\n\tnop\n2:")
BENCH_FN2(bench_lp3_2, "mov lp_count,3\n\tnop\n\tlp 2f\n\tnop_s\n\tnop_s\n2:")
BENCH_FN2(bench_lp3_4, "mov lp_count,3\n\tnop\n\tlp 2f\n\tnop_s\n\tnop_s\n\tnop_s\n\tnop_s\n2:")
BENCH_FN2(bench_lp1_2, "mov lp_count,1\n\tnop\n\tlp 2f\n\tnop_s\n\tnop_s\n2:")
/* тело из одной инструкции (LP3_1 +1): на цикл или на проход */
BENCH_FN2(bench_lp1_1, "mov lp_count,1\n\tnop\n\tlp 2f\n\tnop\n2:")
BENCH_FN2(bench_lp5_1, "mov lp_count,5\n\tnop\n\tlp 2f\n\tnop\n2:")
#undef BENCH_SET
#define BENCH_SET 1

/* Набор 2 (UC_BENCH_SET=2): шаблоны пути завершения BF, не покрытые набором 1. */
#undef BENCH_SET
#define BENCH_SET 2
/* флаги от mov.f / and.f / tst (не cmp) для bcc, 16-битные bcc_s и jcc_s, bcc.d без перехода, условный bl */
BENCH_FN_CL(bench_movf_beq_nt, "mov.f %[t],%[a]\n\tbeq 2f\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_andf_bne, "and.f %[t],%[a],7\n\tbne 2f\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_tst_bne, "tst %[a],3\n\tbne 2f\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_cmp_bnes, "cmp %[a],0\n\tbne_s 2f\n\tnop_s\n2:", "cc")
BENCH_FN_CL(bench_cmp_beqs_nt, "cmp %[a],0\n\tbeq_s 2f\n\tnop_s\n2:", "cc")
BENCH_FN_CL(bench_cmp_beqd_nt, "cmp %[a],0\n\tbeq.d 2f\n\tnop\n\tnop\n2:", "cc")
BENCH_FN_CL(bench_cmp_jeqs_nt, "cmp %[a],0\n\tjeq_s [blink]\n\tnop_s", "cc")
BENCH_FN_CL(bench_cmp_n3_bleq_nt, "cmp %[a],0" NOP3 "\n\tbleq 2f\n\tnop\n2:", "cc", "blink")
/* готовность результата загрузки с limm (адрес или смещение), загрузка → brcc */
BENCH_FN(bench_ld_limm_use, "ld %[t],[0x803234]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_ldoff_limm_use, "ld %[t],[%[a],0x800000]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_ld_brne_nt, "ld %[t],[%[a]]\n\tbrne %[t],0,2f\n\tnop\n2:")
/* чтение регистра MAC по limm, чтение с немедленным использованием, два чтения подряд (TSF как в журнале uc) */
BENCH_FN(bench_ld_mac_limm, "ld %[t],[0x886ebc]")
BENCH_FN(bench_lduse_mac, "ld %[t],[%[a]]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_ld_mac_ld_limm, "ld %[t],[%[a]]\n\tld %[v],[0x886eb8]")
/* 16-битные brcc_s — операнд из r0–r3/r12–r15 */
#define BENCH_FN_Q(name, op) \
static __attribute__((noinline)) u32 name(u32 n, u32 a, u32 v, u32 b) \
{ \
    if (!BENCH_ON) \
        return 0; \
    u32 t0 = arc_lr(0x100); \
    (void)v; (void)b; \
    __asm__ volatile(BENCH_LOOP(op) : : [n] "r"(n), [a] "q"(a) : "lp_count", "memory"); \
    return arc_lr(0x100) - t0; \
}
BENCH_FN_Q(bench_breqs_nt, "breq_s %[a],0,2f\n\tnop_s\n2:")
BENCH_FN_Q(bench_brnes, "brne_s %[a],0,2f\n\tnop_s\n2:")
/* brcc без перехода вдали от конца цикла (BREQ_NT: +0,19 — конец lp?), jcc через такт после cmp и 32-битный jcc */
BENCH_FN(bench_breq_nt_n3, "breq %[a],0,2f\n\tnop\n2:" NOP3)
BENCH_FN_CL(bench_cmp_n1_jeqs_nt, "cmp %[a],0\n\tnop\n\tjeq_s [blink]\n\tnop_s", "cc")
BENCH_FN_CL(bench_cmp_jeq_nt, "cmp %[a],0\n\tjeq [%[b]]\n\tnop", "cc")
/* чтения регистров подряд: разные адреса (TSF hi + lo — 16, не 24), разные блоки, тройка hi, lo, hi журнала uc */
BENCH_FN(bench_ld2, "ld %[t],[%[a]]")
BENCH_FN(bench_ld_ld, "ld %[t],[%[a]]\n\tld %[v],[%[b]]")
BENCH_FN(bench_ld_ld_use, "ld %[t],[%[a]]\n\tld %[v],[%[b]]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_ld_ld_ld, "ld %[t],[%[a]]\n\tld %[v],[%[b]]\n\tld %[t],[%[a]]")
/* перекрытие чтений: интервал между началами, готовность результата второго, использование первого */
BENCH_FN(bench_ld_ld_use1, "ld %[t],[%[a]]\n\tld %[v],[%[b]]\n\tadd %[t],%[t],%[t]")
BENCH_FN(bench_ld_nop_ld, "ld %[t],[%[a]]\n\tnop\n\tld %[v],[%[b]]")
BENCH_FN(bench_ld_n4_ld, "ld %[t],[%[a]]" NOP3 "\n\tnop\n\tld %[v],[%[b]]")
/* байтовые / полусловные загрузки с использованием, записи: две подряд, по адресу-константе (первое слово журнала
 * команд MAC, то же значение — запись ничего не меняет); вызов с push_s blink */
BENCH_FN(bench_ldb_use, "ldb %[t],[%[a]]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_ldw_use, "ldw %[t],[%[a]]\n\tadd %[v],%[v],%[t]")
BENCH_FN(bench_st_st2, "st %[v],[%[a]]\n\tst %[v],[%[a],4]")
BENCH_FN(bench_st_limm, "st %[v],[0x800000]")
BENCH_FN(bench_stw_limm, "stw %[v],[0x800000]")
BENCH_FN_CL(bench_bl_push, "bl 3f\n\tb 4f\n\t.balign 4\n3:\n\tpush_s blink\n\tpop_s blink\n\tj_s [blink]\n\tnop_s\n4:",
            "blink")
/* BL_PUSH (11, модель 10): лишний такт — push_s blink сразу после bl или j_s [blink] сразу после pop_s blink */
BENCH_FN_CL(bench_bl_nop_push, "bl 3f\n\tb 4f\n\t.balign 4\n3:\n\t"
            "nop\n\tpush_s blink\n\tpop_s blink\n\tj_s [blink]\n\tnop_s\n4:",
            "blink")
BENCH_FN_CL(bench_bl_pop_nop_j, "bl 3f\n\tb 4f\n\t.balign 4\n3:\n\t"
            "push_s blink\n\tpop_s blink\n\tnop\n\tj_s [blink]\n\tnop_s\n4:",
            "blink")
/* BL_PUSH и оба варианта с nop — +1: дорог push_s/pop_s blink, загрузка в blink или переход по загруженному blink */
BENCH_FN_CL(bench_pushpop_blink, "push_s blink\n\tpop_s blink", "blink")
BENCH_FN_CL(bench_push_blink, "push_s blink\n\tadd_s sp,sp,4", "blink")
BENCH_FN_CL(bench_ld_blink, "ld blink,[sp]", "blink")
BENCH_FN_CL(bench_ld_r13_sp, "ld r13,[sp]", "r13")
BENCH_FN_CL(bench_bl_movj, "bl 3f\n\tb 4f\n\t.balign 4\n3:\n\t"
            "mov_s r12,blink\n\tmov_s blink,r12\n\tj_s [blink]\n\tnop_s\n4:",
            "blink", "r12")
/* 44→2f пути BF: brcc назад без перехода, база загрузки из r57 через mov, btst → mov.eq */
BENCH_FN(bench_breq_nt_back, "nop\n2:\n\tbreq %[a],0,2b")
BENCH_FN_Q(bench_breqs_nt_back, "nop_s\n2:\n\tbreq_s %[a],0,2b")
BENCH_FN(bench_mul_mov_ld, "mul64 0,%[a],1\n\tmov %[t],r57\n\tld %[t],[%[t],0x800000]")
BENCH_FN_CL(bench_btst_moveq, "btst %[a],0\n\tmov.eq %[t],0", "cc")
/* Набор 3 (UC_BENCH_SET=3). */
#undef BENCH_SET
#define BENCH_SET 3
/* brcc / bcc назад без перехода с настоящим отрицательным смещением (в BREQ_NT_BACK цель — сам brcc, смещение 0) */
BENCH_FN(bench_breq_nt_bk8, "2:\n\tnop\n\tnop\n\tbreq %[a],0,2b\n\tnop")
BENCH_FN_Q(bench_breqs_nt_bk4, "2:\n\tnop_s\n\tnop_s\n\tbreq_s %[a],0,2b\n\tnop_s")
BENCH_FN_CL(bench_cmp_bne_nt_bk, "2:\n\tnop\n\tcmp %[a],3\n\tnop\n\tnop\n\tbne 2b\n\tnop", "cc")
BENCH_FN(bench_breq_nt_fw8, "breq %[a],0,2f\n\tnop\n\tnop\n\tnop\n2:")
/* цикл на brcc назад: 1 / 2 перехода и выход (без перехода сразу после выполненного) */
BENCH_FN(bench_brcc_loop2, "mov %[t],2\n2:\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b")
BENCH_FN(bench_brcc_loop3, "mov %[t],3\n2:\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b")
/* зависимость от смещения: brcc назад без перехода на −16 / −32, цикл с телом из 3 / 7 инструкций */
BENCH_FN(bench_breq_nt_bk16, "2:" NOP3 "\n\tnop\n\tbreq %[a],0,2b")
BENCH_FN(bench_breq_nt_bk32, "2:" NOP7 "\n\tnop\n\tbreq %[a],0,2b")
BENCH_FN(bench_brcc_loop2_n2, "mov %[t],2\n2:" "\n\tnop\n\tnop"
         "\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b\n\tnop")
BENCH_FN(bench_brcc_loop2_n6, "mov %[t],2\n2:" NOP3 NOP3
         "\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b\n\tnop")
BENCH_FN(bench_brcc_loop3_n2, "mov %[t],3\n2:" "\n\tnop\n\tnop"
         "\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b\n\tnop")
BENCH_FN(bench_brcc_loop3_n6, "mov %[t],3\n2:" NOP3 NOP3
         "\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b\n\tnop")
BENCH_FN(bench_brcc_loop3_n12, "mov %[t],3\n2:" NOP7 NOP3 "\n\tnop\n\tnop"
         "\n\tsub %[t],%[t],1\n\tbrne %[t],0,2b\n\tnop")
/* команда MAC (запись r32): «выбрать регистр R40» с текущей тенью mac_sel_shadow — состояние MAC не меняется */
BENCH_FN(bench_mac_cmd, "mov r32,%[v]")
BENCH_FN(bench_mac_cmd_n3, "mov r32,%[v]" NOP3)
BENCH_FN(bench_mac_cmd_r40, "mov r32,%[v]\n\tmov %[t],r40")
BENCH_FN(bench_mac_cmd_ld_mac, "mov r32,%[v]\n\tld %[t],[%[a]]")
/* 16-битная инструкция с limm (6 Б): add_s b,b,limm — операнд из r0–r3/r12–r15 */
#define BENCH_FN_QIO(name, op) \
static __attribute__((noinline)) u32 name(u32 n, u32 a, u32 v, u32 b) \
{ \
    if (!BENCH_ON) \
        return 0; \
    u32 t0 = arc_lr(0x100); \
    (void)v; (void)b; \
    __asm__ volatile(BENCH_LOOP(op) : [a] "+q"(a) : [n] "r"(n) : "lp_count", "memory"); \
    return arc_lr(0x100) - t0; \
}
BENCH_FN_QIO(bench_limm_s, "add_s %[a],%[a],0x10000\n\tnop_s")
BENCH_FN_QIO(bench_limm_s2, "add_s %[a],%[a],0x10000\n\tadd_s %[a],%[a],0x10000")
#undef BENCH_SET
#define BENCH_SET 2
BENCH_FN(bench_ld_ld_use_n4, "ld %[t],[%[a]]\n\tld %[v],[%[b]]\n\tadd %[v],%[v],%[t]" NOP3 "\n\tnop")

enum {
    B_NOP, B_LD_DCCM, B_LDUSE_DCCM, B_ST_DCCM, B_LD_FW, B_LDUSE_FW, B_ST_FW, B_LD_MAC, B_LD_RGF, B_ST_MAC, B_ST_RGF,
    B_STSYNC_MAC, B_SYNC, B_LR_AUX, B_CORE_RD, B_LIMM, B_BR, B_BR_D,
    B_LD_PHY, B_ST_MAC_N1, B_ST_MAC_N3, B_ST_MAC_N7, B_ST_MAC_N11, B_ST_MAC_N7_SYNC, B_ST_MAC_LD_MAC, B_ST_MAC_LD_FW,
    B_ST_MAC_LD_DCCM, B_LD_MAC_N3, B_LD_MAC_N7, B_LD_MAC_N11, B_LD_FW_N3, B_LIMM_NOPS2, B_LIMM_NOP, B_NOP_S,
    B_LD_DCCM_NOP, B_LD_DCCM_ST, B_LD_FW_NOP, B_CALLRET, B_CALLRET_D, B_BRNE, B_STSYNC_RGF, B_PUSHPOP,
    B_BREQ_NT, B_BRNE_D, B_CMP_BNE, B_CMP_BEQ_NT, B_CMP_N1_BNE, B_CMP_N2_BNE, B_CMP_MOVNE, B_BR_MIS,
    B_MUL, B_MUL_USE, B_MUL_N1_USE, B_MUL_N3_USE, B_MUL_USE_BIG, B_FLAG, B_JL, B_ASL_REG, B_LD_LIMM, B_LOOP2_NOP,
    B_LOOP2_LP, B_MOVF_BEQ_NT, B_ANDF_BNE, B_TST_BNE, B_CMP_BNES, B_CMP_BEQS_NT, B_CMP_BEQD_NT, B_CMP_JEQS_NT,
    B_CMP_N3_BLEQ_NT, B_LD_LIMM_USE, B_LDOFF_LIMM_USE, B_LD_BRNE_NT, B_LD_MAC_LIMM, B_LDUSE_MAC, B_LD_MAC_LD_LIMM,
    B_BREQS_NT, B_BRNES, B_BREQ_NT_N3, B_CMP_N1_JEQS_NT, B_CMP_JEQ_NT, B_LD_TSFLO, B_LD_MAC_LD_MAC2, B_LD_MAC_LD_RGF,
    B_LD_RGF_LD_MAC, B_LD_TSF2_USE, B_LD_TSF3, B_LD_RGF_LD_RGF2, B_LD_TSF2_USE1, B_LD_TSF_NOP_LD, B_LD_TSF_N4_LD,
    B_LD_TSF2_USE_N4, B_LD_RGF_LD_MAC_USE, B_LDB_USE_DCCM, B_LDW_USE_DCCM, B_LDB_USE_FW, B_ST_ST2, B_ST_LIMM,
    B_STW_LIMM, B_BL_PUSH, B_LP3_1, B_LP3_2, B_LP3_4, B_LP1_2, B_BL_NOP_PUSH, B_BL_POP_NOP_J,
    B_LP1_1, B_LP5_1, B_PUSHPOP_BLINK, B_PUSH_BLINK, B_LD_BLINK, B_LD_R13_SP, B_BL_MOVJ,
    B_BREQ_NT_BACK, B_BREQS_NT_BACK, B_MUL_MOV_LD, B_BTST_MOVEQ,
    B_BREQ_NT_BK8, B_BREQS_NT_BK4, B_CMP_BNE_NT_BK, B_BREQ_NT_FW8, B_BRCC_LOOP2,
    B_BRCC_LOOP3, B_BREQ_NT_BK16, B_BREQ_NT_BK32, B_BRCC_LOOP2_N2, B_BRCC_LOOP2_N6, B_BRCC_LOOP3_N2,
    B_BRCC_LOOP3_N6, B_BRCC_LOOP3_N12, B_LIMM_S, B_LIMM_S2, B_MAC_CMD,
    B_MAC_CMD_N3, B_MAC_CMD_R40, B_MAC_CMD_LD_MAC, B_COUNT
};
#define B_SET2_FIRST B_MOVF_BEQ_NT
#define B_SET3_FIRST B_BREQ_NT_BK8

static u32 bench_in_set(u32 id)
{
    return id == B_NOP || (id < B_SET2_FIRST ? 1 : id < B_SET3_FIRST ? 2 : 3) == UC_BENCH_SET;
}

u32 uc_bench_one(u32 id, u32 n)
{
    volatile u32 local = 0;
    volatile u32 local2[2] = {0, 0};
    struct mbox_ring_ctl *ctl = uc_mbox.evt.ctl;
    u32 a = 0, v = 0, b = 0;
    switch (id) {
    case B_LD_DCCM: case B_LDUSE_DCCM: case B_ST_DCCM: case B_LD_DCCM_NOP: case B_BRNE:
    case B_BREQ_NT: case B_BRNE_D: case B_CMP_BNE: case B_CMP_BEQ_NT: case B_CMP_N1_BNE: case B_CMP_N2_BNE:
    case B_CMP_MOVNE: a = (u32)&local; break;
    case B_LD_DCCM_ST: a = (u32)&local; b = (u32)&local; break;
    case B_LD_FW_NOP: a = (u32)&ctl->tail; break;
    case B_LD_FW: case B_LDUSE_FW: a = (u32)&ctl->tail; break;
    case B_ST_FW: a = (u32)&ctl->head; v = ctl->head; break;
    case B_LD_MAC: a = HW_MAC_TSF_HI; break;
    case B_LD_RGF: a = HW_RGF_USER_USAGE_3; break;
    case B_ST_MAC: case B_STSYNC_MAC: case B_ST_MAC_N1: case B_ST_MAC_N3: case B_ST_MAC_N7: case B_ST_MAC_N11:
    case B_ST_MAC_N7_SYNC: case B_ST_MAC_LD_MAC: case B_ST_MAC_LD_FW: case B_ST_MAC_LD_DCCM:
        a = HW_UC_SLEEP_WAKE_MASK; v = MMIO32(a);
        b = id == B_ST_MAC_LD_MAC ? HW_MAC_TSF_HI : id == B_ST_MAC_LD_FW ? (u32)&ctl->tail : (u32)&local;
        break;
    case B_LD_MAC_N3: case B_LD_MAC_N7: case B_LD_MAC_N11: a = HW_MAC_TSF_HI; break;
    case B_LD_FW_N3: a = (u32)&ctl->tail; break;
    case B_LD_PHY: a = HW_PHY_RX_CTL; break;
    case B_ST_RGF: case B_STSYNC_RGF: a = HW_RGF_USER_USER_ICR_ICS; break;
    case B_LR_AUX: a = 0x100; break;
    case B_MUL: case B_MUL_USE: case B_MUL_N1_USE: case B_MUL_N3_USE: a = 3; break;
    case B_MUL_USE_BIG: a = 0x12345678; break;
    case B_ASL_REG: a = 5; v = 0x1234; break;
    case B_MOVF_BEQ_NT: case B_ANDF_BNE: case B_TST_BNE: case B_CMP_BNES: case B_CMP_BEQS_NT: case B_CMP_BEQD_NT:
    case B_CMP_JEQS_NT: case B_CMP_N3_BLEQ_NT: case B_BREQS_NT: case B_BRNES: case B_BREQ_NT_N3: case B_CMP_N1_JEQS_NT:
    case B_CMP_JEQ_NT: a = 3; break;
    case B_LD_TSFLO: a = HW_MAC_TIMING_INDIRECT_REG_5; break;
    case B_LD_MAC_LD_MAC2: a = HW_MAC_TSF_HI; b = HW_UC_SLEEP_WAKE_MASK; break;
    case B_LD_MAC_LD_RGF: a = HW_MAC_TSF_HI; b = HW_RGF_USER_USAGE_3; break;
    case B_LD_RGF_LD_MAC: a = HW_RGF_USER_USAGE_3; b = HW_MAC_TSF_HI; break;
    case B_LD_TSF2_USE: case B_LD_TSF3: case B_LD_TSF2_USE1: case B_LD_TSF_NOP_LD: case B_LD_TSF_N4_LD:
    case B_LD_TSF2_USE_N4: a = HW_MAC_TSF_HI; b = HW_MAC_TIMING_INDIRECT_REG_5; break;
    case B_LD_RGF_LD_RGF2: a = HW_RGF_USER_USAGE_3; b = HW_RGF_USER_USAGE_4; break;
    case B_LD_RGF_LD_MAC_USE: a = HW_RGF_USER_USAGE_3; b = HW_MAC_TSF_HI; break;
    case B_BREQ_NT_BACK: case B_BREQS_NT_BACK: case B_BTST_MOVEQ: case B_BREQ_NT_BK8: case B_BREQS_NT_BK4:
    case B_CMP_BNE_NT_BK: case B_BREQ_NT_FW8: case B_BREQ_NT_BK16: case B_BREQ_NT_BK32: a = 3; break;
    case B_MUL_MOV_LD: a = (u32)&local - 0x800000; break;
    case B_MAC_CMD: case B_MAC_CMD_N3: case B_MAC_CMD_R40: case B_MAC_CMD_LD_MAC:
        a = HW_MAC_TSF_HI; v = MAC_CMD_STATUS_SEL | mac_sel_shadow; break;
    case B_LDB_USE_DCCM: case B_LDW_USE_DCCM: a = (u32)&local; break;
    case B_LDB_USE_FW: a = (u32)&ctl->tail; break;
    case B_ST_ST2: a = (u32)local2; break;
    case B_ST_LIMM: case B_STW_LIMM: v = *(volatile u32 *)MAC_CMD_LOG_ADDR; break;
    case B_LDOFF_LIMM_USE: a = (u32)&local - 0x800000; break;
    case B_LD_BRNE_NT: a = (u32)&local; break;
    case B_LDUSE_MAC: case B_LD_MAC_LD_LIMM: a = HW_MAC_TSF_HI; break;
    }
    u32 (*f)(u32, u32, u32, u32) = bench_nop;
    switch (id) {
    case B_LD_DCCM: case B_LD_FW: case B_LD_MAC: case B_LD_RGF: case B_LD_PHY: f = SET1(bench_ld); break;
    case B_LDUSE_DCCM: case B_LDUSE_FW: f = SET1(bench_lduse); break;
    case B_ST_DCCM: case B_ST_FW: case B_ST_MAC: case B_ST_RGF: f = SET1(bench_st); break;
    case B_STSYNC_MAC: f = SET1(bench_stsync); break;
    case B_SYNC: f = SET1(bench_sync); break;
    case B_LR_AUX: f = SET1(bench_lr); break;
    case B_CORE_RD: f = SET1(bench_core_rd); break;
    case B_LIMM: f = SET1(bench_limm); break;
    case B_BR: f = SET1(bench_br); break;
    case B_BR_D: f = SET1(bench_br_d); break;
    case B_ST_MAC_N1: f = SET1(bench_st_n1); break;
    case B_ST_MAC_N3: f = SET1(bench_st_n3); break;
    case B_ST_MAC_N7: f = SET1(bench_st_n7); break;
    case B_ST_MAC_N11: f = SET1(bench_st_n11); break;
    case B_ST_MAC_N7_SYNC: f = SET1(bench_st_n7_sync); break;
    case B_ST_MAC_LD_MAC: case B_ST_MAC_LD_FW: case B_ST_MAC_LD_DCCM: f = SET1(bench_st_ld); break;
    case B_LD_MAC_N3: case B_LD_FW_N3: f = SET1(bench_ld_n3); break;
    case B_LD_MAC_N7: f = SET1(bench_ld_n7); break;
    case B_LD_MAC_N11: f = SET1(bench_ld_n11); break;
    case B_LIMM_NOPS2: f = SET1(bench_limm_nops2); break;
    case B_LIMM_NOP: f = SET1(bench_limm_nop); break;
    case B_NOP_S: f = SET1(bench_nop_s); break;
    case B_LD_DCCM_NOP: case B_LD_FW_NOP: f = SET1(bench_ld_nop); break;
    case B_LD_DCCM_ST: f = SET1(bench_ld_st); break;
    case B_CALLRET: f = SET1(bench_callret); break;
    case B_CALLRET_D: f = SET1(bench_callret_d); break;
    case B_BRNE: f = SET1(bench_brne); break;
    case B_STSYNC_RGF: f = SET1(bench_stsync); break;
    case B_PUSHPOP: f = SET1(bench_pushpop); break;
    case B_BREQ_NT: f = SET1(bench_breq_nt); break;
    case B_BRNE_D: f = SET1(bench_brne_d); break;
    case B_CMP_BNE: f = SET1(bench_cmp_bne); break;
    case B_CMP_BEQ_NT: f = SET1(bench_cmp_beq_nt); break;
    case B_CMP_N1_BNE: f = SET1(bench_cmp_n1_bne); break;
    case B_CMP_N2_BNE: f = SET1(bench_cmp_n2_bne); break;
    case B_CMP_MOVNE: f = SET1(bench_cmp_movne); break;
    case B_BR_MIS: f = SET1(bench_br_mis); break;
    case B_MUL: f = SET1(bench_mul); break;
    case B_MUL_USE: case B_MUL_USE_BIG: f = SET1(bench_mul_use); break;
    case B_MUL_N1_USE: f = SET1(bench_mul_n1_use); break;
    case B_MUL_N3_USE: f = SET1(bench_mul_n3_use); break;
    case B_FLAG: f = SET1(bench_flag); break;
    case B_JL: f = SET1(bench_jl); break;
    case B_ASL_REG: f = SET1(bench_asl_reg); break;
    case B_LD_LIMM: f = SET1(bench_ld_limm); break;
    case B_LOOP2_NOP: f = SET1(bench_loop2_nop); break;
    case B_LOOP2_LP: f = SET1(bench_loop2_lp); break;
    case B_MOVF_BEQ_NT: f = SET2(bench_movf_beq_nt); break;
    case B_ANDF_BNE: f = SET2(bench_andf_bne); break;
    case B_TST_BNE: f = SET2(bench_tst_bne); break;
    case B_CMP_BNES: f = SET2(bench_cmp_bnes); break;
    case B_CMP_BEQS_NT: f = SET2(bench_cmp_beqs_nt); break;
    case B_CMP_BEQD_NT: f = SET2(bench_cmp_beqd_nt); break;
    case B_CMP_JEQS_NT: f = SET2(bench_cmp_jeqs_nt); break;
    case B_CMP_N3_BLEQ_NT: f = SET2(bench_cmp_n3_bleq_nt); break;
    case B_LD_LIMM_USE: f = SET2(bench_ld_limm_use); break;
    case B_LDOFF_LIMM_USE: f = SET2(bench_ldoff_limm_use); break;
    case B_LD_BRNE_NT: f = SET2(bench_ld_brne_nt); break;
    case B_LD_MAC_LIMM: f = SET2(bench_ld_mac_limm); break;
    case B_LDUSE_MAC: f = SET2(bench_lduse_mac); break;
    case B_LD_MAC_LD_LIMM: f = SET2(bench_ld_mac_ld_limm); break;
    case B_BREQS_NT: f = SET2(bench_breqs_nt); break;
    case B_BRNES: f = SET2(bench_brnes); break;
    case B_BREQ_NT_N3: f = SET2(bench_breq_nt_n3); break;
    case B_CMP_N1_JEQS_NT: f = SET2(bench_cmp_n1_jeqs_nt); break;
    case B_CMP_JEQ_NT: f = SET2(bench_cmp_jeq_nt); break;
    case B_LD_TSFLO: f = SET2(bench_ld2); break;
    case B_LD_MAC_LD_MAC2: case B_LD_MAC_LD_RGF: case B_LD_RGF_LD_MAC: f = SET2(bench_ld_ld); break;
    case B_LD_TSF2_USE: f = SET2(bench_ld_ld_use); break;
    case B_LD_TSF3: f = SET2(bench_ld_ld_ld); break;
    case B_LD_RGF_LD_RGF2: f = SET2(bench_ld_ld); break;
    case B_LD_TSF2_USE1: f = SET2(bench_ld_ld_use1); break;
    case B_LD_TSF_NOP_LD: f = SET2(bench_ld_nop_ld); break;
    case B_LD_TSF_N4_LD: f = SET2(bench_ld_n4_ld); break;
    case B_LD_TSF2_USE_N4: f = SET2(bench_ld_ld_use_n4); break;
    case B_LD_RGF_LD_MAC_USE: f = SET2(bench_ld_ld_use); break;
    case B_LDB_USE_DCCM: case B_LDB_USE_FW: f = SET2(bench_ldb_use); break;
    case B_LDW_USE_DCCM: f = SET2(bench_ldw_use); break;
    case B_ST_ST2: f = SET2(bench_st_st2); break;
    case B_ST_LIMM: f = SET2(bench_st_limm); break;
    case B_STW_LIMM: f = SET2(bench_stw_limm); break;
    case B_BL_PUSH: f = SET2(bench_bl_push); break;
    case B_LP3_1: f = SET2(bench_lp3_1); break;
    case B_LP3_2: f = SET2(bench_lp3_2); break;
    case B_LP3_4: f = SET2(bench_lp3_4); break;
    case B_LP1_2: f = SET2(bench_lp1_2); break;
    case B_BL_NOP_PUSH: f = SET2(bench_bl_nop_push); break;
    case B_BL_POP_NOP_J: f = SET2(bench_bl_pop_nop_j); break;
    case B_LP1_1: f = SET2(bench_lp1_1); break;
    case B_LP5_1: f = SET2(bench_lp5_1); break;
    case B_PUSHPOP_BLINK: f = SET2(bench_pushpop_blink); break;
    case B_PUSH_BLINK: f = SET2(bench_push_blink); break;
    case B_LD_BLINK: f = SET2(bench_ld_blink); break;
    case B_LD_R13_SP: f = SET2(bench_ld_r13_sp); break;
    case B_BL_MOVJ: f = SET2(bench_bl_movj); break;
    case B_BREQ_NT_BACK: f = SET2(bench_breq_nt_back); break;
    case B_BREQS_NT_BACK: f = SET2(bench_breqs_nt_back); break;
    case B_MUL_MOV_LD: f = SET2(bench_mul_mov_ld); break;
    case B_BTST_MOVEQ: f = SET2(bench_btst_moveq); break;
    case B_BREQ_NT_BK8: f = SET3(bench_breq_nt_bk8); break;
    case B_BREQS_NT_BK4: f = SET3(bench_breqs_nt_bk4); break;
    case B_CMP_BNE_NT_BK: f = SET3(bench_cmp_bne_nt_bk); break;
    case B_BREQ_NT_FW8: f = SET3(bench_breq_nt_fw8); break;
    case B_BRCC_LOOP2: f = SET3(bench_brcc_loop2); break;
    case B_BRCC_LOOP3: f = SET3(bench_brcc_loop3); break;
    case B_BREQ_NT_BK16: f = SET3(bench_breq_nt_bk16); break;
    case B_BREQ_NT_BK32: f = SET3(bench_breq_nt_bk32); break;
    case B_BRCC_LOOP2_N2: f = SET3(bench_brcc_loop2_n2); break;
    case B_BRCC_LOOP2_N6: f = SET3(bench_brcc_loop2_n6); break;
    case B_BRCC_LOOP3_N2: f = SET3(bench_brcc_loop3_n2); break;
    case B_BRCC_LOOP3_N6: f = SET3(bench_brcc_loop3_n6); break;
    case B_BRCC_LOOP3_N12: f = SET3(bench_brcc_loop3_n12); break;
    case B_LIMM_S: f = SET3(bench_limm_s); break;
    case B_LIMM_S2: f = SET3(bench_limm_s2); break;
    case B_MAC_CMD: f = SET3(bench_mac_cmd); break;
    case B_MAC_CMD_N3: f = SET3(bench_mac_cmd_n3); break;
    case B_MAC_CMD_R40: f = SET3(bench_mac_cmd_r40); break;
    case B_MAC_CMD_LD_MAC: f = SET3(bench_mac_cmd_ld_mac); break;
    }
    u32 s = arc_irq_disable();
    u32 r = f(n, a, v, b);
    arc_irq_restore(s);
    return r;
}

/* Состояние — в самом журнале (у uc нет .bss, а слова DCCM под отладку не выделены): последняя запись теста — запись
 * метки STAMP_BENCH с наименьшим возрастом. Возраст — по TSF (мл. слово >> 10, ~1 мс, поле a0[31:16]): COUNT1 для
 * этого не годится, его сбрасывает тик L1 (на стенде чаще чем раз в 2,1 мс). Нет записи (журнал перезаписан) —
 * тест с номером по времени. */
#define BENCH_PERIOD_MS 20
#define BENCH_HDR (0xa8000000u | 0xfff00u | STAMP_BENCH)

void uc_bench_tick(void)
{
    u32 ms = (MMIO32(HW_MAC_TIMING_INDIRECT_REG_5) >> 10) & 0xffff;
    u32 best = ~0u, id = ms % B_COUNT;
    for (u32 i = 0; i < 256; i++) {
        if (uc_log.ring[i] != BENCH_HDR)
            continue;
        u32 a0 = uc_log.ring[(u8)(i + 2)];
        u32 age = (ms - (a0 >> 16)) & 0xffff;
        if (age < best) {
            best = age;
            id = (a0 & 0xff) + 1;
        }
    }
    if (best < BENCH_PERIOD_MS)
        return;
    while (id < B_COUNT && !bench_in_set(id))
        id++;
    if (id >= B_COUNT)
        id = 0;
    u32 tag = id | ms << 16;
    UC_STAMP(STAMP_BENCH, tag | BENCH_N1 << 8, uc_bench_one(id, BENCH_N1));
    UC_STAMP(STAMP_BENCH, tag | BENCH_N2 << 8, uc_bench_one(id, BENCH_N2));
}

#endif
