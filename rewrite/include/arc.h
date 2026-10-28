// SPDX-License-Identifier: AGPL-3.0-or-later
/* Интринсики ARC600: вспомогательные регистры, STATUS32, барьеры.
 * Всё, что не выражается на C, живёт здесь — и больше нигде. */
#ifndef REWRITE_ARC_H
#define REWRITE_ARC_H

#include "types.h"

/* STATUS32 — вспомогательный регистр 0xa (бит 1 — E1, разрешение прерываний). */
#define ARC_STATUS32 0xa

static inline u32 arc_lr(u32 reg)
{
    u32 v;
    __asm__ volatile("lr %0,[%1]" : "=r"(v) : "r"(reg) : "memory");
    return v;
}

static inline void arc_sr(u32 v, u32 reg)
{
    __asm__ volatile("sr %0,[%1]" :: "r"(v), "r"(reg) : "memory");
}

/* flag — единственный способ записать STATUS32 на ARC600 (E1/E2, Z/N/C/V, H).
 * SR в STATUS32 не пишет: vendor fw/uc нигде не используют sr [status32],
 * всегда lr [status32] + flag. */
static inline void arc_flag(u32 v)
{
    __asm__ volatile("flag %0" :: "r"(v) : "memory");   /* барьер: окно IRQ-off */
}

/* sync — барьер записи/чтения в периферию. */
static inline void arc_sync(void)
{
    __asm__ volatile("sync" ::: "memory");
}

/* ---- Тайминг-примитивы: nop-паддинг и задержки ----------------------------------------
 * Зачем: задержки в инструкциях — срок до чтения/записи регистров MAC/PHY/RF после
 * команды (MAC/PHY не успевают защёлкнуть значение раньше), паддинг перед flag/sleep,
 * выравнивание. Эмулятор (eqcheck) задержку железа не моделирует, поэтому число и вид
 * nop здесь — копия vendor и НЕ подстраивается («короче vendor» нельзя). Причина каждой
 * задержки — комментарий у места вызова (там же ХРУПКО:, если срок жёсткий).
 *
 * Кодировки ARC600 (gas 2021.03, -mcpu=arc600):
 *   nop_s   — 16 бит, 0x78e0;
 *   nop     — 32 бита, 0x264a7000; «mov 0,0» ассемблируется в ТЕ ЖЕ байты, а
 *             дизассемблер vendor-листингов (6.2/src/asm) печатает их как «mov 0x0,0x0».
 * Каждая инструкция — 1 такт выдачи на конвейере ARC600 (без кэш-промахов ICCM/I$).
 * 32-битный nop отличается от nop_s размером (4 байта против 2) при том же такте: от
 * него зависят адреса/выравнивание всего, что идёт следом (метки, lp, цели ветвлений),
 * поэтому вид nop копируется с vendor; 2×nop_s — те же 4 байта, но +1 такт.
 *
 * Правила (сохраняют код байт-в-байт, сверка tools/codecmp.py):
 *   - вся последовательность — ОДИН asm-оператор: gcc оценивает длину asm по числу строк
 *     (выбор коротких/длинных ветвлений, заполнение delay-слотов); строки ARC_NOPS_<n>
 *     дают ровно n строк, как прежние «nop_s\n\tnop_s…» (не .rept — та даёт 3 строки);
 *   - варианты _mb добавляют клоббер "memory" (барьер компилятора: gcc не переносит
 *     обращения к памяти через задержку) — ставить там, где он был у исходной вставки;
 *     без _mb — без барьера (как vendor-порт горячих путей: барьер меняет кодоген);
 *   - n — десятичный литерал 1..16 (склеивается в имя ARC_NOPS_<n>). */
#define ARC_NOPS_1  "nop_s"
#define ARC_NOPS_2  ARC_NOPS_1 "\n\tnop_s"
#define ARC_NOPS_3  ARC_NOPS_2 "\n\tnop_s"
#define ARC_NOPS_4  ARC_NOPS_3 "\n\tnop_s"
#define ARC_NOPS_5  ARC_NOPS_4 "\n\tnop_s"
#define ARC_NOPS_6  ARC_NOPS_5 "\n\tnop_s"
#define ARC_NOPS_7  ARC_NOPS_6 "\n\tnop_s"
#define ARC_NOPS_8  ARC_NOPS_7 "\n\tnop_s"
#define ARC_NOPS_9  ARC_NOPS_8 "\n\tnop_s"
#define ARC_NOPS_10 ARC_NOPS_9 "\n\tnop_s"
#define ARC_NOPS_11 ARC_NOPS_10 "\n\tnop_s"
#define ARC_NOPS_12 ARC_NOPS_11 "\n\tnop_s"
#define ARC_NOPS_13 ARC_NOPS_12 "\n\tnop_s"
#define ARC_NOPS_14 ARC_NOPS_13 "\n\tnop_s"
#define ARC_NOPS_15 ARC_NOPS_14 "\n\tnop_s"
#define ARC_NOPS_16 ARC_NOPS_15 "\n\tnop_s"

/* n × nop_s: 2n байт, n тактов. */
#define arc_nops(n)        __asm__ volatile(ARC_NOPS_##n)
/* n × nop_s + барьер компилятора. */
#define arc_nops_mb(n)     __asm__ volatile(ARC_NOPS_##n ::: "memory")
/* n × nop_s + 32-битный nop (vendor: «nop_s…; mov 0x0,0x0»): 2n+4 байт, n+1 тактов.
 * Типичная группа после MAC-команды в uc: arc_nops_nop(2) — 3 такта, 8 байт. */
#define arc_nops_nop(n)    __asm__ volatile(ARC_NOPS_##n "\n\tnop")

/* Один nop_s: 2 байта, 1 такт. */
static inline __attribute__((always_inline)) void arc_nop_s(void)
{
    arc_nops(1);
}

/* Один 32-битный nop (= «mov 0,0»): 4 байта, 1 такт. */
static inline __attribute__((always_inline)) void arc_nop(void)
{
    __asm__ volatile("nop");
}

/* То же + барьер компилятора. */
static inline __attribute__((always_inline)) void arc_nop_mb(void)
{
    __asm__ volatile("nop" ::: "memory");
}

/* Задержка циклом нулевых накладных (zero-overhead loop) — единственная форма пустой
 * выдержки vendor (все 48 мест fw 6.2 и все места uc 6.2 одинаковы):
 *     mov rX,n          ; (у vendor: mov_s/mov r0,K, или mov_s+asl_s, или ldb+asl+add2)
 *     mov lp_count,rX
 *     nop_s             ; развязка записи lp_count и lp (ARC600)
 *     lp 1f
 *     nop_s
 *     nop_s
 *   1:
 * Тело — 2×nop_s, итераций n: 2n тактов цикла + 3 на mov lp_count/nop_s/lp (без промахов
 * I$) + 1 на загрузку n в регистр (у vendor — всегда отдельная инструкция перед mov lp_count).
 *
 * arc_zol_nops2(n): n — константа → загрузка «mov rX,K» внутри asm (gcc не может вынести её
 * из цикла или переиспользовать регистр с K от прошлой выдержки — иначе выдержка на 1–2 такта
 * короче vendor; с формой "r" так и было: IF_GAIN_GAIN, l2mgr, uc vring_disconnect_flush);
 * n — переменная → её вычисляет gcc (как vendor: ldb/asl/add2 в регистр), в asm только
 * mov lp_count (форма arc_zol_nops2_r — для констант не применять).
 * arc_zol_nops2_shl(b, s): константа, которую vendor собирает двумя короткими инструкциями
 * «mov_s rX,b; asl_s rX,rX,s» (0x7d << 6 и т. п.) — они же внутри asm (байт-в-байт vendor;
 * "q" — регистр с короткой кодировкой r0–r3/r12–r15). b — u8, s — 1..31.
 * Сверка мест — по дизасму: перед каждым mov lp_count — загрузка счётчика.
 *
 * n == 0 у vendor не проверяется: ARC600 при LP_COUNT = 0 исполняет тело один раз (PRM
 * «ARC 600 Loop Operation», см. tools/arcemu/cpu.py тест «lp: lp_count = 0»); где vendor
 * обходит цикл при 0 (breq), там и у нас — проверка в C у места вызова.
 *
 * _mb — с клоббером "memory" (барьер компилятора: MMIO-запись до выдержки остаётся до неё);
 * ставить там, где прежняя задержка была arc_nops_mb. Без _mb — без барьера (горячие пути).
 *
 * Этап 7 (диз-сверка): прежние C-циклы «for (i…) arc_nops(2);» gcc в lp не превращал —
 * «nop_s; nop_s; add_s; brne» на итерацию (≥ 4 такта + штраф взятого перехода против 2 у
 * vendor), выдержки были в 2–3 раза длиннее vendor; все переведены сюда. Прежняя форма
 * «mov lp_count,K» (литерал) была на 1 такт короче vendor (нет загрузки в регистр) —
 * заменена этой. Иные точные lp — fw/wmi_cmd.c (своя форма с .balign 4) и копирующие циклы
 * uc/mem.c, uc/phy.c. */
#define ARC_ZOL_NOPS2_BODY "mov lp_count,%0\n\tnop_s\n\tlp 1f\n\tnop_s\n\tnop_s\n1:"
#define arc_zol_nops2_r(n) \
    __asm__ volatile(ARC_ZOL_NOPS2_BODY :: "r"((u32)(n)) : "lp_count")
#define arc_zol_nops2_r_mb(n) \
    __asm__ volatile(ARC_ZOL_NOPS2_BODY :: "r"((u32)(n)) : "lp_count", "memory")
/* Константа: «… ? (n) : 0» — чтобы операнд "i" был константой и в отброшенной ветви. */
#define ARC_ZOL_K_(n) "i"((u32)(__builtin_constant_p(n) ? (n) : 0))
#define arc_zol_nops2(n) do { \
        u32 zol_t_; \
        if (__builtin_constant_p(n)) \
            __asm__ volatile("mov %0,%1\n\t" ARC_ZOL_NOPS2_BODY \
                             : "=&r"(zol_t_) : ARC_ZOL_K_(n) : "lp_count"); \
        else \
            arc_zol_nops2_r(n); \
    } while (0)
#define arc_zol_nops2_mb(n) do { \
        u32 zol_t_; \
        if (__builtin_constant_p(n)) \
            __asm__ volatile("mov %0,%1\n\t" ARC_ZOL_NOPS2_BODY \
                             : "=&r"(zol_t_) : ARC_ZOL_K_(n) : "lp_count", "memory"); \
        else \
            arc_zol_nops2_r_mb(n); \
    } while (0)
#define arc_zol_nops2_shl(b, s) do { \
        u32 zol_t_; \
        __asm__ volatile("mov_s %0,%1\n\tasl_s %0,%0,%2\n\t" ARC_ZOL_NOPS2_BODY \
                         : "=&q"(zol_t_) : "i"((u32)(b)), "i"((u32)(s)) : "lp_count"); \
    } while (0)
#define arc_zol_nops2_shl_mb(b, s) do { \
        u32 zol_t_; \
        __asm__ volatile("mov_s %0,%1\n\tasl_s %0,%0,%2\n\t" ARC_ZOL_NOPS2_BODY \
                         : "=&q"(zol_t_) : "i"((u32)(b)), "i"((u32)(s)) : "lp_count", "memory"); \
    } while (0)

/* Отправка команды uc -> MAC. Реальная доставка — запись ядра ARC в r32
 * (lp_count), аппаратно мапящаяся на порт CORE WRITE 0x886dc8. vendor-идома:
 * `mov r32,rX; st.ab rX,[r25,4]; bclr r25,0xa`:
 *   - mov r32,rX      → команда (порт CORE WRITE 0x886dc8);
 *   - st.ab [r25,4]   → копия в trace-журнал (0x800000..0x8003ff, 256 слов);
 *   - bclr r25,0xa    → заворот журнала (0x800400 → 0x800000).
 * Простое MMIO в 0x886dc8 не триггерит команду — нужна запись r32 из ядра.
 * Журнал — только trace для хоста (blob_uc_data), fw его не читает; здесь
 * опускаем (данные uc в 0x940000 в сборке не проливаются, а держать r25-счётчик
 * в глобальной переменной ненадёжно). */
static inline void mac_cmd_write(u32 value)
{
    __asm__ volatile("mov r32, %0" :: "r"(value) : "lp_count", "memory");
}

/* Прямое (uncached) чтение MMIO — обходит D-cache (ld.di).
 * Нужно для RGF, куда пишет host (напр. mbox sync 0x8802e8): обычный ld
 * читает кэшированную копию (stale), а ld.di — свежее значение. */
static inline u32 arc_ld_di(void *addr)
{
    u32 v;
    __asm__ volatile("ld.di %0, [%1]" : "=r"(v) : "r"(addr) : "memory");
    return v;
}

/* Прямая (uncached) запись — обходит D-cache (st.di), пишет сразу в физическую
 * память. Нужна для «next»-указателей пула команд PERIPH (0x840000..): обычный
 * st оставляет dirty cache-line, которую ARC вытесняет ПОСЛЕ того, как host
 * по PCIe записал команду, и затирает её мусором/нулями (буфер 0x820 пуст). */
static inline void arc_st_di(void *addr, u32 v)
{
    __asm__ volatile("st.di %0, [%1]" :: "r"(v), "r"(addr) : "memory");
}

/* Flush D-cache (write-back dirty lines to RAM) — dc_flsh (aux 0x4b).
 * Карта ARC600 (binutils arc-regs.h / Linux arch/arc):
 *   0x47 dc_ivdc  — invalidate entire D-cache (cmd 0x1)
 *   0x48 dc_ctrl  — control/status (bit0=DIS, bit6=INV_MODE_FLUSH, bit8=FLUSH_STATUS)
 *   0x4a dc_ivdl  — invalidate one line (write line-addr)
 *   0x4b dc_flsh  — flush entire D-cache (cmd 0x1)
 *   0x4c dc_fldl  — flush one line (write line-addr)
 * Прежняя реализация писала в aux 0x405 (это TLBPD0/MMU, НЕ кэш!) — баг.
 * NOTE: когда D-cache выключен (dc_ctrl bit0=1), flush — безвредный no-op. */
static inline void arc_dcache_flush(void)
{
    arc_sr(0x1, 0x4b);   /* dc_flsh: write-back грязных линий в RAM */
    while (arc_lr(0x48) & (1u << 8))   /* poll FLUSH_STATUS (bit8) до завершения */
        ;
}

/* Диагностический маркер прогресса ucode: пишет v в 0x88031c и ждёт ~300мс,
 * чтобы host успел считать значение через debugfs mem_val до возможного падения.
 * 0x100000 nop ≈ 300мс на MAC-такте. Используется только в отладочной цепочке
 * ucode_ready; в штатной сборке маркеры можно убрать. */
static inline void uc_mark_spin(u32 v)
{
    *(volatile u32 *)0x88031c = v;
    for (u32 i = 0; i < 0x100000; i++)
        arc_nop();
}

/* Критическая секция: запретить прерывания (бит 1 STATUS32 = 0).
 * Используем flag (как vendor), НЕ sr [0xa] — sr в STATUS32 мог сбрасывать ilink1. */
static inline u32 arc_irq_disable(void)
{
    u32 s = arc_lr(ARC_STATUS32);
    arc_flag(s & ~(1u << 1));          /* vendor: lr; bclr 1; flag */
    return s;
}

/* Восстановить STATUS32: свой бит 1 из s, остальное — текущее. */
static inline void arc_irq_restore(u32 s)
{
    u32 cur = arc_lr(ARC_STATUS32);
    arc_flag((s & (1u << 1)) | cur);   /* vendor: bic x,x,-3; or; flag */
}

/* Расширенные core-регистры r32..r59 (статусы/порты MAC, mlo/mmid/mhi) и
 * ilink: доступ командой mov (НЕ lr/sr — это aux-пространство, другие регистры).
 * "memory": чтение регистра событий — точка синхронизации с MAC; без барьера gcc
 * выкидывал/переносил записи в DCCM вокруг циклов опроса (маркеры 0x800628 и т. п.). */
/* Горячий путь uc со сроком (SIFS): точечный O2 без millicode-пролога (__st_r13_to_r15) и с
 * 2-инструкционными циклами опроса; no-inline — вызываемые остаются вызовами (размер ICCM, eqcheck). */
#define UC_HOT __attribute__((optimize("O2", "no-inline")))

/* Чтение расширенного регистра со сдвигом одной инструкцией (vendor: `asr r3,r49,0x10`,
 * `lsr r6,r40,0x8`) вместо mov + lsr_s. Номер регистра — через именованные обёртки uc/mac_regs.h. */
#define UC_CORE_LSR(n, sh) ({ u32 _v; __asm__ volatile("lsr %0,r" #n "," #sh : "=r"(_v) :: "memory"); _v; })
/* `st rN,[адрес var]` — расширенный регистр прямо в DCCM (vendor: `st.as r49,[gp,-0x23]`). */
#define UC_CORE_ST(n, var) __asm__ volatile("st r" #n ",[%0]" :: "i"((u32)&(var)) : "memory")
/* `st rX,[адрес var]` одной инструкцией (gcc на -O2 строил mov limm + mov_s + st_s). */
#define UC_ST_ABS(var, v) __asm__ volatile("st %0,[%1]" :: "r"((u32)(v)), "i"((u32)&(var)) : "memory")

/* Горячие пути uc со сроком: адрес возврата и uc_assert без пролога.
 * UC_RA_NOW() — blink в текущей точке; верно только там, где после входа в функцию ещё не было
 * вызовов (иначе blink уже затёрт).
 * UC_ASSERT_LEAF(code) — uc_assert(blink, code) вставкой через uc_assert_keep (uc/misc.c), которая
 * сохраняет r0..r12 и blink: для gcc это не вызов, и функция с uc_assert только на холодной ветке
 * остаётся листовой — без push/pop blink, без копии blink через всю функцию (как с
 * __builtin_return_address) и без callee-saved регистров для значений, живых через assert. Условия
 * те же, что у UC_RA_NOW. Второй uc_assert после первого пуст (assert_active = 1), поэтому blink,
 * затёртый первым, второму не важен. mlo/mhi (mul64) не сохраняются. */
#define UC_RA_NOW() ({ u32 _ra; __asm__ volatile("mov %0,blink" : "=r"(_ra)); _ra; })
#define UC_ASSERT_LEAF(code) __asm__ volatile( \
        "push_s r0\n\tpush_s r1\n\tpush_s blink\n\tmov_s r0,blink\n\t" \
        "bl.d uc_assert_keep\n\tmov r1,%0\n\t" \
        "pop_s blink\n\tpop_s r1\n\tpop_s r0" \
        :: "i"(code) : "lp_count", "cc", "memory")
#define arc_core_rd(n) ({ u32 _v; __asm__ volatile("mov %0,r" #n : "=r"(_v) :: "memory"); _v; })
#define arc_core_wr(n, v) __asm__ volatile("mov r" #n ",%0" :: "r"((u32)(v)) : "memory")

/* norm: число ведущих знаковых битов - 1 (norm(0)=0x1f). 30 - norm(v) — индекс
 * старшего установленного бита для v > 0 (идиома vendor: norm + rsub 0x1e). */
static inline __attribute__((always_inline)) u32 arc_norm(u32 v)
{
    u32 r;
    __asm__("norm %0,%1" : "=r"(r) : "r"(v));
    return r;
}

/* uc: MAC-команда — как vendor: запись в расширенный core-регистр r32 (порт
 * команд MAC) + лог в кольцо DCCM по r25 (1 КБ, заворот bclr бит 10).
 * r25 — глобальный указатель кольца (uc собирается с -ffixed-r25). */
static inline __attribute__((always_inline)) void uc_mac_cmd(u32 v)
{
    __asm__ volatile("mov r32,%0\n\tst.ab %0,[r25,4]\n\tbclr r25,r25,0xa" :: "r"(v) : "memory");
}

/* uc: текущий указатель кольца MAC-команд (r25). */
static inline __attribute__((always_inline)) u32 uc_trace_ptr(void)
{
    u32 v;
    __asm__ volatile("mov %0,r25" : "=r"(v));
    return v;
}

/* Хвост кадра direct-TX (байты p+0x10..0x17) в FIFO — как vendor (0x93b2e0 и др.):
 * три байта «ldb r34,[p,0x10..0x12]», слово в r33 последовательными записями
 * «ldb r33,[p,0x13]; or r33,r33,b<<8; …», байт «ldb r34,[p,0x17]»; счётчик
 * свободного места 0x800514 уменьшается на 3, 4 и 1, как у vendor. */
static inline __attribute__((always_inline)) void uc_fifo_frame_tail(u32 p)
{
    u32 t;
    __asm__ volatile("ldb r34,[%0,0x10]\n\tldb r34,[%0,0x11]\n\tldb r34,[%0,0x12]"
                     :: "r"(p) : "memory");
    *(volatile u32 *)0x800514 -= 3;
    __asm__ volatile("ldb r33,[%1,0x13]\n\t"
                     "ldb_s %0,[%1,0x14]\n\tasl_s %0,%0,0x8\n\tor r33,r33,%0\n\t"
                     "ldb_s %0,[%1,0x15]\n\tasl_s %0,%0,0x10\n\tor r33,r33,%0\n\t"
                     "ldb_s %0,[%1,0x16]\n\tasl_s %0,%0,0x18\n\tor r33,r33,%0"
                     : "=&q"(t) : "q"(p) : "memory");
    *(volatile u32 *)0x800514 -= 4;
    __asm__ volatile("ldb r34,[%0,0x17]" :: "r"(p) : "memory");
    *(volatile u32 *)0x800514 -= 1;
}

/* mac_cca_ok() — uc/mac_regs.h. */

/* Указатель на код, который vendor хранит как 0-базовый адрес (колбэки, таблицы).
 * Символ __vcb_<адрес>: в гибриде = vendor-адрес (0-база, задаёт uc_hybrid.py),
 * в полном образе = наша функция (PROVIDE в uc/uc.ld). */
#define VENDOR_CB(hexaddr) ({ extern char __vcb_##hexaddr[]; (u32)__vcb_##hexaddr; })

#endif
