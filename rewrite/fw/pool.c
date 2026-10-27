// SPDX-License-Identifier: AGPL-3.0-or-later
/* Пулы памяти и кольцевые дескрипторы — базовые структуры прошивки. */
#include "../include/types.h"
#include "../include/dbg.h"
#include "../include/fwq_tx.h"
#include "../include/arc.h"
#include "../include/fwdata.h"
#include "../include/mem_pool.h"
#include "../include/mbox.h"
#include "../include/rx_ring.h"
#include "../include/basic_sm.h"
#include "../include/sched.h"

/* Пулы по фиксированным адресам DCCM (в образе нули; инициализируют владельцы). */
FWDATA(803cbc) struct mem_pool sm_defer_pool = { 0 };                /* sm__init_defer_pool */
FWDATA(803cd0) struct sm_defer_node sm_defer_nodes[SM_DEFER_NODES] = { { 0 } };
FWDATA(805a98) struct mem_pool bcon_info_pool = { 0 };               /* add_bcon (лениво) */
FWDATA(805aac) struct bcon_post_info bcon_info_static = { 0 };       /* add_bcon: пул пуст */
FWDATA(8059f8) struct bcon_post_info bcon_info_mem[8] = { 0 };       /* память bcon_info_pool */

/* Связать свободные блоки пула в список. */
void mem_pool_link_free_list(struct mem_pool *p, u8 *base, u32 count)
{
    u32 i;
    for (i = 0; i < count; i++) {
        /* Обычный st (как vendor 0x8c53f8). Прежний arc_st_di ЛОМАЛ free-list:
         * memset0_words пишет блоки обычным st (dirty-линии в D-cache), а st.di
         * пишет «next» напрямую в RAM; при вытеснении dirty-линий они затирали
         * «next» нулями → мусорные блоки → NULL-колбэк в wmi_evt_walk_list. */
        *(void **)base = p->free_head;
        u32 step = p->elem_size;
        p->free_head = base;           /* новый голова — этот блок */
        base += step;
    }
}

/* Выделить RAW-ячейку из пула (адрес ячейки, БЕЗ +0x10 заголовка) — vendor
 * mem_pool__allocate (0x8c354c). Ячейка: [0] = next свободного списка,
 * [4..0xf] = служебные, [0x10..] = данные. */
void *mem_pool_alloc_raw(struct mem_pool *p)
{
    void *b;
    /* 8c3558: все ячейки заняты — журнал и 0 */
    if (p->used == p->count) {   /* vendor 0x1001b90 — только used, без пула */
        fw_log_emit3(0, LS_FW(POOL_EXHAUSTED), (u32)p, p->used, p->elem_size);
        return 0;
    }
    b = p->free_head;
    if (!b) {   /* список свободных пуст при used < count — счётчик и список разошлись */
        fw_log_emit3(0, LS_FW(POOL_LIST_EMPTY), (u32)p, p->used, p->count);
        return 0;
    }
    p->free_head = *(void **)b; /* следующий свободный (обычный ld, как vendor) */
    p->used++;                         /* счётчик занятых */
    /* 8c35ca/8c36aa: выдана последняя ячейка — журнал (как в vendor-логе во время BF:
     * «MEM POOL (0x806000) just allocted it's last cell»). Проверки целостности
     * 0xe2..0xe6 vendor здесь же — не перенесены. */
    if (p->free_head == 0)
        fw_log_emit1(0x10, 0x1001dac, (u32)p);
    return b;
}

/* mem_pool__allocate (0x8c354c): элемент пула целиком (без заголовка: vendor возвращает
 * сам элемент; заголовок 0x10 — только у mem_pool__alloc_locked для ящиков). Прежний +0x10
 * при размере элемента 0x1c (задачи u_schd) залезал на соседний элемент: освобождение одной
 * задачи писало указатель свободного списка в поле cb другой. */
void *mem_pool_allocate(struct mem_pool *p)
{
    return mem_pool_alloc_raw(p);
}

/* Диспетчер пула (vendor mem_pool__alloc_cell, 0x8c34b8): кольцо с пулом (pooled == 1) →
 * alloc_raw из его пула; иначе — буфер текущей записи кольца. Возвращает RAW. */
void *mem_pool_alloc_cell(struct mbox_ring *r)
{
    if (r->pooled == 1)
        return mem_pool_alloc_raw(r->pool);
    return (void *)r->cur->addr;
}

/* mem_pool__free (0x8caed0): вернуть элемент (как его отдал mem_pool_allocate). */
void mem_pool_free(struct mem_pool *p, void *data)
{
    if (p->used == 0)
        fw_sysassert_fatal((void *)0, 0xe7);
    *(void **)data = p->free_head;
    p->free_head = data;
    p->used--;
}

/* Выделение с критической секцией (IRQ запрещены) через диспетчер пула —
 * vendor mem_pool__alloc_locked (0x8c33d0): alloc_cell(&mbox->tx) + 0x10 (заголовок
 * struct mbox_hdr). Аргумент — ящик (struct fw_mailbox, include/mbox.h; напр. lmac_mbox
 * для LMAC-команд). Так выделяются все буферы событий хосту (WMI, UT, отладочный ящик) и
 * LMAC-команд (у всех ящиков tx-кольцо с пулом, pooled == 1).
 * Сознательное отличие: тело элемента (elem_size − 0x10) обнуляется. vendor его не чистит,
 * и байты, которые сборщик не пишет (резерв, хвосты, поля «не для этого op»), уходят хосту/
 * ucode с содержимым прошлого сообщения. Единое правило для всех сборщиков — те же, что для
 * стековых буферов: в железо/хосту прежняя память не уходит. Комментарии «у vendor —
 * остаток слота пула» у сборщиков отмечают байты, где поведение отличается. */
void *mem_pool_alloc_locked(struct fw_mailbox *mbox)
{
    u32 saved = arc_irq_disable();
    u8 *cell = mem_pool_alloc_cell(&mbox->tx);
    arc_irq_restore(saved);
    if (!cell) {
        fw_sysassert_fatal(__builtin_return_address(0), 0xc1);   /* caller — кто просил буфер (vendor 0) */
        return 0;
    }
    u8 *body = cell + sizeof(struct mbox_hdr);
    memset0_words(body, mbox->tx.pool->elem_size - sizeof(struct mbox_hdr));
    return body;
}

void mem_pool_free_locked(struct mem_pool *p, void *data)
{
    u32 saved = arc_irq_disable();
    mem_pool_free(p, data);
    arc_irq_restore(saved);
}

/* mem_pool__init (0x8c7cf8): count блоков по elem_size байт с base. */
void mem_pool_init(struct mem_pool *p, void *base, u32 elem_size, u32 count)
{
    if (base == 0)
        fw_sysassert_fatal((void *)0, 0xdf);
    if (elem_size == 0)
        fw_sysassert_fatal((void *)0, 0xe0);
    if (count == 0)
        fw_sysassert_fatal((void *)0, 0xe1);
    p->base = base;
    p->elem_size = elem_size;
    p->count = count;
    p->used = 0;
    p->free_head = 0;
    mem_pool_link_free_list(p, base, count);
}

/* ring__init_desc (0x8d8b00): кольцо ящика r — записи base..base+len, описатель hw второй
 * стороны, пул буферов; при pooled == 1 записи готовятся (alloc — сразу с буферами). */
void ring_init_desc(struct mbox_ring *r, struct mbox_entry *base, u32 len, struct mbox_ring_hw *hw,
                    struct mem_pool *pool, u32 alloc, u32 pooled)
{
    r->cur = base;
    r->base = base;
    r->end = (struct mbox_entry *)((u8 *)base + len);
    r->hw = hw;
    r->pool = pool;
    r->free_cb = 0;
    r->free_cb2 = 0;
    r->pooled = pooled;
    if (pooled == 1)
        ba_sm_prepare_ba_td(r, alloc);
}

/* Флаг «снятие остановлено» RX-кольца (+0x14; mem_pool__put_block). */
u32 mem_pool_get_field14(const struct rx_dma_ring *r)
{
    return r->pended;
}

/* Инициализация пула задач планировщика и очередей таймеров (l2mgr__init_frame_pool, 0x8f5a00).
 * Указатели очередей таймеров u_schd.tq[0]/[1] (0x803c54/0x803c58) — на объекты 0x803ca8/0x803c94
 * за пулом 0x803c80 (struct u_schd, include/sched.h). Прежние 0x803c7e/0x803c74 (неверно
 * прочитанные add2/add3) попадали внутрь ready-очередей 0x803c5c..0x803c80, и
 * u_schd_init_queue портил очередь приоритета 1. */
void l2mgr_init_frame_pool(void)
{
    memset0_words(u_schd_tasks, sizeof(u_schd_tasks));   /* vendor: 0x69 << 5 = 0x78 × 0x1c */
    mem_pool_init(&u_schd.task_pool, u_schd_tasks, sizeof(struct u_schd_task), U_SCHD_NTASKS);
    u_schd.tq[1] = &u_schd.tq_obj[0];               /* add3 r0,r13,8 = 0x803c94 */
    u_schd.tq[0] = &u_schd.tq_obj[1];               /* add2 r0,r13,0x15 = 0x803ca8 */
    sched_hw_timer_queue = 2;                            /* stb [gp,0xd8] */
    u_schd_install_timer_vtables();                 /* vendor ставит при загрузке (0x8c1934) */
}

/* Установить поле + запустить аппаратный таймер (0x8d8db8). */
void field_set_0x00_8d8db8(u32 *a, u32 b)
{
    *a = b;
    u_schd_hw_timer_load_start(b);
}

/* Освободить задачу планировщика в пул u_schd.task_pool (mem_pool__free_locked 0x8cb028;
 * vendor зовёт проверяющий mem_pool__free 0x8caed0 — у нас stream_mgr_check_vring). */

void mem_pool_free_locked_evt(struct u_schd_task *evt)
{
    struct u_schd_task *data = field_set_0x19_8caf4c(evt);
    u32 saved = arc_irq_disable();
    mem_pool_free(&u_schd.task_pool, data);
    arc_irq_restore(saved);
}

/* Подготовка записей кольца ящика (0x8e0d6c; имя по историческим причинам): каждая запись
 * свободна (sync = 0), буфер — элемент пула (alloc == 1) или 0. */
void ba_sm_prepare_ba_td(struct mbox_ring *r, u32 alloc)
{
    struct mbox_entry *e = r->base;
    u32 cnt = 0;
    while (e < r->end) {
        if (alloc == 1) {
            void *data = mem_pool_allocate(r->pool);
            e->addr = (u32)data;   /* vendor: сам элемент пула */
        } else {
            e->addr = 0;
        }
        e->sync = 0;
        cnt++;
        e++;
    }
}

/* mem_pool__free с проверками (0x8caed0; имя у нас историческое): блок b — из пула p
 * (кратен elem_size от base, внутри пула), затем в голову списка свободных. */
void stream_mgr_check_vring(struct mem_pool *p, void *blk)
{
    u32 b = (u32)blk;   /* проверки — арифметика адресов */
    if (p->used == 0)
        fw_sysassert_fatal((void *)0, 0xe7);

    u32 base = (u32)p->base;
    u32 elem = p->elem_size;
    if ((b - base) % elem != 0)
        fw_sysassert_fatal((void *)0, 0xe8);
    if (b < base)
        fw_sysassert_fatal((void *)0, 0xe9);

    u32 end = base + elem * p->count;
    if (b >= end)
        fw_sysassert_fatal((void *)0, 0xe9);

    *(void **)blk = p->free_head;
    p->free_head = blk;
    p->used -= 1;
}

/* Беззнаковое деление (0x8c02d4). */
u32 fw_divmod_unsigned(u32 a, u32 b)
{
    return a / b;
}

/* Освобождение TX-памяти (0x8cb10c). */
void tx_api_free_memory(u32 tx)
{
    if (tx == 0)
        fw_sysassert_fatal((void *)0, 0x11e9);
    struct tx_pkt *pkt = TX_PKT_OF(tx);
    if (pkt->status != 0xfd)
        stream_mgr_check_vring(&tx_pkt_pool, pkt);
    else
        fw_log_emit0(0x27, 0x10181d8);
}

/* Запись в кольцо событий (0x8e0b2c). */
void evt_ring_push_1c(u32 type, u32 code, u32 data)
{
    (void)code;
    u32 idx = evt_ring.idx;
    evt_ring.data[idx] = data;
    evt_ring.type[idx] = (u8)type;
    evt_ring.idx = (idx + 1) & (EVT_RING_N - 1);
}

/* Знаковое деление (0x8c02dc). */
s32 fw_divmod_signed(s32 a, s32 b)
{
    return a / b;
}
