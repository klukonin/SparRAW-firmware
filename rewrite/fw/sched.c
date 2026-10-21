// SPDX-License-Identifier: AGPL-3.0-or-later
/* Планировщик (главный цикл прошивки) — u_schd__run (0x8e76a8).
 * Инициализирует две очереди и крутит цикл: вытащить готовое событие,
 * вызвать его обработчик, освободить событие; нет событий — спать.
 * Объект планировщика, задачи, очереди таймеров — include/sched.h. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/hw.h"
#include "../include/fwdata.h"
#include "../include/sched.h"

/* Объект планировщика (0x803c54, 0x68 Б): в образе нули (vendor .bss); указатели очередей и
 * пул ставит l2mgr_init_frame_pool, таблицы методов очередей — u_schd_install_timer_vtables. */
FWDATA(803c54) struct u_schd u_schd = { 0 };

/* Описатели таймеров ARC TIMER0/TIMER1 (0x800948): номера aux-регистров — из vendor-образа. */
FWDATA(800948) struct arc_timer_cfg arc_timer_cfg[2] = {
    { 0x21, 0x22, 0x23, 0 },
    { 0x100, 0x101, 0x102, 0 },
};


/* --- внутренности планировщика --- */

/* Узел списка llist (include/llist.h): [0] = next, [1] = owner. Список и узел — void *: так
 * их передают и типизированные модули, и старые с (u32 *). */

/* Односвязный список: [0]=count, [1]=head, [2]=tail. */
void llist_init(void *list)
{
    u32 *l = list;
    l[0] = 0;
    l[1] = 0;
    l[2] = 0;
}

void *llist_pop_front(void *list)
{
    u32 *l = list;
    if (l[0] == 0)
        return 0;
    void *head = (void *)l[1];
    void *tail = (void *)l[2];
    if (head == tail)
        l[2] = 0;
    l[1] = *(u32 *)head;   /* next */
    l[0] -= 1;
    ((u32 *)head)[0] = 0;     /* next = 0, prev = 0 — как vendor 0x8e2674: иначе повторный */
    ((u32 *)head)[1] = 0;     /* list_find_entry_d того же узла → assert 0xd4 */
    return head;
}

u32 sys_timer_read_now(void)
{
    return MMIO32(HW_SYS_TIMER_NOW);
}


/* Двусвязный список: list[0]=count, [1]=head, [2]=tail;
 * узел: [0]=next, [1]=prev. list_find_entry_d = добавить узел в конец. */
void list_find_entry_d(void *list_obj, void *node)
{
    u32 *list = list_obj, *entry = node;
    if (!entry)
        fw_sysassert_fatal((void *)0, 0xd3);
    if (entry[1] != 0)
        fw_sysassert_fatal((void *)0, 0xd4);   /* уже в списке */
    if (list[0] != 0)
        *(u32 *)list[2] = (u32)entry;          /* tail->next = entry */
    else
        list[1] = (u32)entry;                  /* head = entry */
    list[2] = (u32)entry;                      /* tail = entry */
    entry[0] = 0;                              /* next = 0 */
    list[0]++;
    entry[1] = (u32)list;                      /* prev = list */
}

/* u_schd__alloc_task (0x8c32f8): задача из пула 0x803c80, обнулённая. */
struct u_schd_task *u_schd_alloc_task(void)
{
    u32 saved = arc_irq_disable();
    struct u_schd_task *task = mem_pool_allocate(&u_schd.task_pool);
    arc_irq_restore(saved);
    if (!task)
        fw_sysassert_fatal((void *)0, 0x1063);
    memset0_words(task, sizeof(*task));
    return task;
}

/* Ready-очереди по приоритетам: u_schd.ready[prio] (vendor 0x8e0bcc/0x8cc55e: prio*12 +
 * 0x803c5c), сразу за ними пул задач 0x803c80. */

void u_schd_enqueue_ready(struct u_schd_task *task, u32 prio)
{
    u32 saved = arc_irq_disable();
    sched_ready_mask |= (1u << prio);              /* [gp,0x18] бит готовности */
    list_find_entry_d(&u_schd.ready[prio], task);
    arc_irq_restore(saved);
}

void u_schd_add(u_schd_fn cb, u32 a1, u32 a2, u32 priority)
{
    if (priority >= U_SCHD_NPRIO)
        fw_sysassert_fatal((void *)0, 0x1065);
    struct u_schd_task *task = u_schd_alloc_task();
    task->cb = cb;
    task->a0 = a1;
    task->a1 = a2;
    u_schd_enqueue_ready(task, priority);
}

void u_schd_timer_init(void)
{
    field_set_0x00_8d8db8(&u_schd_hw_timer_limit, 0xa50);
    power_start_two_timers();
    u_schd_hw_timer_a_start(1);
}

/* u_schd__init_queue (0x8d9118): llist__init (0x8e293c: только head/tail) и текущее время
 * базы очереди q->now = vt[1](q, 0). */
void u_schd_init_queue(struct u_schd_tq *q)
{
    q->list.head = 0;
    q->list.tail = 0;
    q->now = q->vt->time_base(q, 0);
}

/* Базы времени очередей таймеров — vt[1] таблиц 0x8008d8/0x8008e0. Очередь 1 (0x803c94):
 * время u_schd как есть. */
/* u_schd__time_base_identity (0x8ed5e0): x. */
u32 u_schd_time_base_identity(struct u_schd_tq *q, u32 x)
{
    (void)q;
    return x;
}

/* u_schd__time_base_tsf (0x8cc228): перевод момента x (время u_schd) в базу TSF/16:
 * (tsf64 >> 4) + (x - now). */
u32 u_schd_time_base_tsf(struct u_schd_tq *q, u32 x)
{
    (void)q;
    u32 tsf[2];
    mac_read_tsf64(0, tsf, 0);
    u32 t = (tsf[0] >> 4) | (tsf[1] << 28);
    return t + (x - u_schd_now());
}

/* Таблицы методов очередей таймеров (vendor 0x8008d8 — время u_schd, 0x8008e0 — TSF/16). */
FWDATA(8008d8) const struct u_schd_tq_vt u_schd_tq_local_vtbl = {
    .time_base = u_schd_time_base_identity,
};
FWDATA(8008e0) const struct u_schd_tq_vt u_schd_tq_tsf_vtbl = {
    .time_base = u_schd_time_base_tsf,
};

/* Часть boot__install_handler_ptrs (vendor 0x8c1934): таблицы методов очередей таймеров. */
void u_schd_install_timer_vtables(void)
{
    u_schd.tq_obj[0].vt = &u_schd_tq_local_vtbl;
    u_schd.tq_obj[1].vt = &u_schd_tq_tsf_vtbl;   /* очередь 0 */
}

u32 u_schd_now(void)
{
    return sys_timer_read_now();
}

/* Вытащить готовое событие высшего приоритета. */
struct u_schd_task *u_schd_pop_ready(void)
{
    u32 saved = arc_irq_disable();
    struct u_schd_task *evt = 0;
    u32 ready = sched_ready_mask;       /* [gp,0x18] — битовая маска готовности */
    if (ready != 0) {
        u32 idx = 31 - __builtin_clz(ready);   /* старший установленный бит = приоритет */
        if (idx >= U_SCHD_NPRIO)
            fw_sysassert_fatal((void *)0, 0x1064);
        evt = llist_pop_front(&u_schd.ready[idx]);
        if (u_schd.ready[idx].count == 0)
            sched_ready_mask = ready & ~(1u << idx);
    }
    arc_irq_restore(saved);
    return evt;
}

/* u_schd__run (0x8e76a8) — главный цикл. Запуск аппаратного таймера (0x8e9508) и
 * инициализация двух очередей таймеров (0x8d9118). Ready-очереди 0x803c5c.. и маска
 * 0x80019c не инициализируются: они в vendor .bss, нулевом в образе fw_data (у нас — тот
 * же образ), а задачи, поставленные из ISR до входа сюда (UCODE_READY), должны выжить.
 * Цикл: вытащить задачу высшего приоритета (0x8cc534), вызвать cb(a0, a1) с замером
 * длительности (u_schd_now — 0x880254; ×16, |…| > [0x8004a0] — лог LARGE TASK в мс),
 * освободить (0x8cb028). Очередь пуста — у vendor хук простоя/deep-sleep power-менеджера
 * (0x8c87c0; энергосбережение вырезано, хука нет),
 * затем под запретом прерываний: если ready-маска всё ещё 0 — разрешить прерывания и
 * sleep; восстановить свой бит E1.
 * Прежде цикл был свой: опрос RX-DMA 0x881c10 с прямым вызовом txrx_mgr_handle_dma_irq,
 * задержка 0x2000 nop вместо sleep, без хука 0x8c87c0 и без LARGE TASK. */
void u_schd_run(void)
{
    u_schd_timer_init();
    u_schd_init_queue(u_schd.tq[0]);
    u_schd_init_queue(u_schd.tq[1]);

    for (;;) {
        struct u_schd_task *t;
        while ((t = u_schd_pop_ready()) != 0) {
            u_schd_fn cb = t->cb;
            u32 t0 = u_schd_now();
            cb(t->a0, t->a1);
            s32 d = (s32)((u_schd_now() - t0) << 4);
            if (d < 0)
                d = -d;                                   /* abs_s */
            if (sched_large_task_thr < (u32)d)       /* brhs r1,r0 — пропуск при ≥ */
                fw_log_emit2(0x10, 0x10016d4, (u32)cb, fw_divmod_unsigned((u32)d, 1000));
            mem_pool_free_locked_evt(t);
        }
        /* deep_sleep_enter (сон чипа по политике PS) — энергосбережение вырезано, см. psc_req_reject. */
        u32 st = arc_lr(ARC_STATUS32);
        arc_flag(st & ~(1u << 1));
        if (sched_ready_mask == 0) {
            arc_flag(arc_lr(ARC_STATUS32) | 0x6);
            __asm__ volatile("sleep 0" ::: "memory");
        }
        arc_flag((st & (1u << 1)) | arc_lr(ARC_STATUS32));
    }
}

/* Планирование задачи через таймер (0x8e0c0c). Возвращает описатель таймера (адрес задачи)
 * для u_schd_cancel. */

u32 u_schd_schedule(u_schd_fn cb, u32 a0, u32 a1, u32 a2, u32 delay, u32 a4, u32 a5)
{
    if (delay < 0x11)
        fw_sysassert_fatal((void *)0, 0x1068);   /* 8e0c6a: 0x68 + bset_s 0xc */

    u32 saved = arc_irq_disable();
    u32 deadline = (delay >> 4) + u_schd_now();
    struct u_schd_task *r = u_schd_insert_timer(1, cb, a0, a1, a2, deadline, a4, a5);
    arc_irq_restore(saved);
    return (u32)r;
}

/* Аппаратный таймер A: старт со значением v. */
void u_schd_hw_timer_a_start(u32 v)
{
    MMIO32(HW_SYS_TIMER_A_LOAD) = v;
    MMIO32(HW_SYS_TIMER_A_CTL) = 0x65;
    arc_sync();
}

/* Thunk обработки истёкших таймеров (0x8e952c). */
__attribute__((section(".textlate"))) void u_schd_expire_timers_thunk(void)
{
    u_schd_expire_timers();
}

/* Проверка, ожидает ли таймер-прерывание (0x8da00c; таймер — объект [gp,0x74] = 0x8001f8). */
u32 user_icr_timer_bit(const u32 *timer, u32 v)
{
    (void)timer;
    return (v >> 2) & 1;
}

/* u_schd__timer_irq_pending (0x8e94f8). */
u32 u_schd_timer_irq_pending(u32 v)
{
    return user_icr_timer_bit(&u_schd_hw_timer_limit, v);
}

/* Отмена запланированной задачи (0x8c8de0); task — описатель из u_schd_schedule. */

__attribute__((section(".textlate"))) void u_schd_cancel(u32 task)
{
    struct u_schd_task *t = (struct u_schd_task *)task;
    if (t == 0)
        fw_sysassert_fatal((void *)0, 0x1069);   /* 8c8e5e: 0x69 + bset_s 0xc */
    if (t->armed == 0)
        fw_sysassert_fatal((void *)0, 0x106a);   /* 8c8e6a: 0x6a + bset_s 0xc */

    u32 saved = arc_irq_disable();
    u32 found = 0;
    u32 i;
    for (i = 0; i < U_SCHD_NTQ; i++) {
        struct u_schd_tq *q = u_schd.tq[i];
        if (t->owner == &q->list) {
            u32 next = q->list.head;
            tx_list_remove(&q->list, t);
            if (i == sched_hw_timer_queue && q->list.head != next)
                u_schd_arm_timer();
            found = 1;
        }
    }
    if (!found)
        tx_list_remove(t->owner, t);

    arc_irq_restore(saved);
    mem_pool_free_locked_evt(t);
}

/* Обработка истёкших таймеров (0x8da674). */

__attribute__((section(".textlate"))) void u_schd_expire_timers(void)
{
    u32 r13;
    for (r13 = 0; r13 < U_SCHD_NTQ; r13++) {
        for (;;) {
            if (u_schd.tq[r13]->list.count == 0)
                break;
            if (u_schd_pop_expired(r13) == 0)
                break;
        }
    }
    u_schd_arm_timer();
}

/* Извлечь истёкший таймер из очереди q (0x8c62c8). */

u32 u_schd_pop_expired(u32 q)
{
    u32 now = u_schd_now();
    struct u_schd_tq *head = u_schd.tq[q];
    u32 deadline;
    if (!u_schd_deadline_less(head, &deadline))
        return 0;
    if (time_cmp(now, deadline) == -1)
        return 0;
    struct u_schd_task *evt = llist_pop_front(head);   /* сам объект очереди (vendor ld r0,[r13]) */
    u_schd_enqueue_ready(evt, evt->prio);
    return 1;
}

/* Сравнение времени: 1 если a1 <= a0 (с учётом переполнения), иначе -1. */
s32 time_cmp(u32 a0, u32 a1)
{
    u32 d = a1 - a0;
    return (d == 0 || d >= 0x80000000u) ? 1 : -1;
}

/* Получить deadline головы очереди в базе очереди (0x8cc28c). */
u32 u_schd_deadline_less(struct u_schd_tq *q, u32 *out)
{
    const struct u_schd_task *head = (const struct u_schd_task *)q->list.head;
    if (head == 0)
        return 0;
    *out = q->vt->time_base(q, head->deadline);   /* vendor 0x8cc28c: r0 = очередь */
    return 1;
}

/* Пере-взвести аппаратный таймер (0x8e249c). */

u32 u_schd_arm_timer(void)
{
    u32 deadline, q;
    u32 r13 = u_schd_calc_next_deadline(&deadline, &q);
    if (r13 == 0) {
        u_schd_irq_ack_thunk(0);
        sched_hw_timer_queue = 2;
        return 0;
    }
    u_schd_program_hw_timer(deadline);
    u_schd_irq_ack_thunk(1);
    u_schd_program_hw_timer(deadline);
    sched_hw_deadline = deadline;
    sched_hw_timer_queue = (u8)q;
    return r13;
}

/* Установить порог сравнения аппаратного таймера (0x8e9160). */
void u_schd_hw_timer_set_compare(u32 v)
{
    MMIO32(HW_SYS_TIMER_B_COMPARE) = v;
}

void u_schd_program_hw_timer(u32 v)
{
    u_schd_hw_timer_set_compare(v);
}

/* Подтверждение IRQ таймера (0x8e9190). */
void irq_ack_880b00(u32 a)
{
    if (a == 0) {
        MMIO32(HW_RGF_USER_USER_ICR_IMS) = 0x4;
    } else {
        MMIO32(HW_RGF_USER_USER_ICR_ICR) = 0x4;
        MMIO32(HW_RGF_USER_USER_ICR_IMC) = 0x4;
    }
}

void u_schd_irq_ack_thunk(u32 a)
{
    irq_ack_880b00(a);
}

/* Вычислить ближайший deadline по 2 очередям (0x8cc4c8). */
u32 u_schd_calc_next_deadline(u32 *out_deadline, u32 *out_q)
{
    u32 found = 0;
    u32 q;
    for (q = 0; q < U_SCHD_NTQ; q++) {
        struct u_schd_tq *head = u_schd.tq[q];
        u32 deadline;
        u32 has = u_schd_deadline_less(head, &deadline);
        head->now = head->vt->time_base(head, 0);
        if (has == 0)
            continue;
        if (found == 0) {
            *out_deadline = deadline;
            *out_q = q;
            found = 1;
        } else if (time_cmp(*out_deadline, deadline) == 1) {
            *out_deadline = deadline;
            *out_q = q;
        }
    }
    return found;
}

/* Старт аппаратного таймера загрузки (0x8e9178). */
void u_schd_hw_timer_load_start(u32 a)
{
    MMIO32(HW_SYS_TIMER_B_LOAD) = a;
    MMIO32(HW_SYS_TIMER_B_CTL) = 0x65;
    arc_sync();
    irq_ack_880b00(1);
}

/* Старт аппаратного таймера ARC a (timer__start 0x8e94a0): режим d (0 — без прерывания,
 * 1/2 — прерывание уровня 1/2, 3 — …), предел c, начальное значение b. */
__attribute__((section(".textlate"))) void timer_start(u32 a, u32 b, u32 c, u32 d)
{
    struct arc_timer_cfg *t = &arc_timer_cfg[a];
    arc_sr(0, t->ctrl_aux);
    arc_sr(c, t->limit_aux);
    u32 r15;
    if (d == 3)
        r15 = 4;
    else if (d == 0)
        r15 = 2;
    else {
        r15 = 3;
        irq_set_level((a << 2) + 3, (d == 2) ? 1 : 0);   /* vendor 0x8e94d0: уровень 2 только при d == 2 */
    }
    t->mode = r15;
    arc_sr(r15, t->ctrl_aux);
    arc_sr(b, t->count_aux);
}

/* Вставка таймера в очередь (0x8e0c74). */

struct u_schd_task *u_schd_insert_timer(u32 q, u_schd_fn cb, u32 a0, u32 a1, u32 a2,
                                        u32 deadline, u32 a4, u32 a5)
{
    /* gcc встраивает fill_task_b/timer_set_fields и меняет порядок записей в поля задачи —
     * безопасно: задача ещё не в очереди, прерывания запрещены (u_schd_schedule). */
    struct u_schd_task *task = u_schd_alloc_task();
    u_schd_fill_task_b(task, cb, a0, a1);
    u_schd_timer_set_fields(task, deadline, a4, a5, a2);

    struct u_schd_tq **queue = &u_schd.tq[q];
    u32 old_next = (*queue)->list.head;
    list_find_entry(*queue, task, time_cmp);
    u32 new_next = (*queue)->list.head;
    if (old_next != new_next) {
        if (u_schd_arm_timer() == 0)
            fw_sysassert_fatal((void *)0, 0x1067);   /* 8e0cdc: 0x67 + bset_s 0xc */
    }
    return task;
}

/* Заполнение задачи (0x8e6f88). */
__attribute__((section(".textlate"))) void u_schd_fill_task_b(struct u_schd_task *t, u_schd_fn cb,
                                                              u32 a0, u32 a1)
{
    t->cb = cb;
    t->a0 = a0;
    t->a1 = a1;
    t->next = 0;
}

/* Установка полей таймера (0x8e6114). */
void u_schd_timer_set_fields(struct u_schd_task *t, u32 deadline, u32 a4, u32 a5, u32 a2)
{
    (void)a4; (void)a5;
    t->deadline = deadline;
    t->armed = 1;
    t->prio = (u8)a2;
}

/* Вставка в сортированный список (list__find_entry 0x8c2638): узлы по возрастанию deadline,
 * cmp(узел, новый) != -1 — новый встаёт перед узлом. Единственный пользователь — очереди
 * таймеров (u_schd_insert_timer, cmp = time_cmp). */

__attribute__((section(".textlate"))) void list_find_entry(struct u_schd_tq *q, struct u_schd_task *entry,
                                                           u_schd_cmp_fn cmp)
{
    if (entry == 0)
        fw_sysassert_fatal((void *)0, 0xf2);
    if (cmp == 0)
        fw_sysassert_fatal((void *)0, 0xf3);

    if (q->list.count == 0) {
        list_find_entry_c(q, entry);
        return;
    }

    struct u_schd_task *cur = (struct u_schd_task *)q->list.head;
    struct u_schd_task *prev = 0;
    while (cur != 0) {
        s32 r = cmp(cur->deadline, entry->deadline);
        if (r != -1)
            break;
        prev = cur;
        cur = cur->next;
    }
    if (cur == 0)
        list_find_entry_d(q, entry);
    else if (prev != 0)
        list_find_entry_b(q, entry, prev);
    else
        list_find_entry_c(q, entry);
}

/* Вставка в начало списка (0x8c25b0). Список {count, head, tail}, узел {next, prev}.
 * Прежний порт считал смещения в словах (u32* + 4 = +16 Б): проверка prev смотрела в поле
 * аргумента задачи (ассерт 0xd2 при таймерах с аргументом), head/tail писались мимо. */
__attribute__((section(".textlate"))) void list_find_entry_c(void *list_obj, void *node)
{
    u32 *list = list_obj, *entry = node;
    if (entry == 0)
        fw_sysassert_fatal((void *)0, 0xd1);
    if (entry[1] != 0)
        fw_sysassert_fatal((void *)0, 0xd2);
    if (list[0] == 0) {
        list[2] = (u32)entry;          /* tail */
        entry[0] = 0;
    } else {
        entry[0] = list[1];
    }
    list[1] = (u32)entry;              /* head */
    list[0]++;
    entry[1] = (u32)list;
}

/* Вставка после prev (0x8c26b4). */
__attribute__((section(".textlate"))) void list_find_entry_b(void *list_obj, void *node, void *prev)
{
    u32 *list = list_obj, *entry = node;
    u32 *p = prev;
    if (entry == 0)
        fw_sysassert_fatal((void *)0, 0xd5);
    if (entry[1] != 0)
        fw_sysassert_fatal((void *)0, 0xd6);
    if (p == 0)
        fw_sysassert_fatal((void *)0, 0xd7);
    if (p[1] != (u32)list)
        fw_sysassert_fatal((void *)0, 0xd8);
    if (list[0] == 0)
        fw_sysassert_fatal((void *)0, 0xd9);

    u32 next = p[0];
    p[0] = (u32)entry;
    entry[0] = next;
    if ((u32)prev == list[2])
        list[2] = (u32)entry;
    list[0]++;
    entry[1] = (u32)list;
}
