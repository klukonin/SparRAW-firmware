// SPDX-License-Identifier: AGPL-3.0-or-later
/* Радио-менеджер (объект 0x806214, указатель [gp,-0x40] = [0x800144]) и его автоматы:
 * rm_main_sm (rm_sm, описатель 0x803210: 6 состояний x 12 событий) и вложенный
 * rm_ch_switch_sm (описатель 0x80338c: 3 состояния x 7 событий). Раскладка объектов —
 * include/radio_mgr.h (struct radio_mgr, rm_main_sm, rm_ch_switch_sm, rm_chan, rm_req).
 *
 * Запрос радио — элемент пула rm_req_pool: основной (радио на основном канале, пока
 * держится) или вторичный (на время — на канал запроса). Колбэк cb(req, arg) вызывается
 * задачей u_schd, когда радио выдано; освобождение — метод lock_free, отмена ещё не
 * выданного — release.
 *
 * События rm_sm: 0 PRIMARY_SET, 1 SWITCH_2_PRIMARY, 2 CH_SWITCH_DONE, 3 GET_NEXT_REQ,
 * 4 LOCK_PRIMARY, 5 UNLOCK_PRIMARY, 6 LOCK_SEC, 7 LOCK_FREE, 8 PRIMARY_UNSET, 9 GOTO_IDLE,
 * 10 SEC_TUNE, 11 CALLBCK. Состояния: 0 IDLE, 1 SWITCH_2_PRIM, 2 PRIM_NON_LOCKED,
 * 3 PRIM_LOCKED, 4 SWITCH_2_SEC, 5 SECONDARY.
 * События rm_ch_switch_sm: 0 CH_SWITCH_KICK, 1 FW_TX_CHANNEL_STOPPED, 2 DATA_STOPPED,
 * 3 UCODE_RX_OFF_EVT, 4 START_TUNE, 5 UCODE_RX_ON_EVT, 6 CH_SWITCH_COMPLETED.
 * Состояния: 0 IDLE, 1 TURN_OFF, 2 TURN_ON.
 *
 * Действия автоматов и методы таблицы вызываются только через указатели из fw_data,
 * поэтому они с vendor-адресом в комментарии. */
#include "../include/types.h"
#include "../include/hw.h"
#include "../include/fwdata.h"
#include "../include/fwq_tx.h"
#include "../include/rf_obj.h"
#include "../include/radio_mgr.h"
#include "../include/mbox.h"
#include "../include/mid.h"
#include "../include/lmac_cmd.h"

static inline void *caller(void) { return __builtin_return_address(0); }

/* События автоматов (basic_sm_handle_event и sm_defer_call принимают объект указателем). */
static inline void rm_sm_event(struct rm_main_sm *sm, u32 ev, u32 a0, u32 a1, u32 a2)
{
    basic_sm_handle_event(sm, ev, a0, a1, a2);
}

static inline void rm_sm_defer(struct rm_main_sm *sm, u32 ev, u32 a0, u32 a1, u32 a2)
{
    sm_defer_call(sm, ev, a0, a1, a2);
}

static inline void rm_cs_defer(struct rm_ch_switch_sm *cs, u32 ev)
{
    sm_defer_call(cs, ev, 0, 0, 0);
}

/* ======================= объекты DCCM ======================= */

/* 0x806214: объект radio_mgr. В образе нули: таблицу методов ставит статический
 * конструктор radio_mgr_install_vtable, остальное — radio_mgr_init_global. */
FWDATA(806214) struct radio_mgr radio_mgr = { 0 };

/* 0x8062d8: пул запросов (0x10 × 0x24 Б). */
FWDATA(8062d8) struct rm_req rm_req_pool[0x10] = { { 0 } };

/* 0x800144 ([gp,-0x40]): указатель на объект — пишет radio_mgr_init_global. */
FWDATA(800144) struct radio_mgr *volatile radio_mgr_obj = 0;

/* ======================= конструкторы и инициализация ======================= */

/* rm_ch_switch_sm::ctor — field_set_0x08__8d8eb4 (0x8d8eb4, 12 Б): владелец rm_main_sm,
 * описатель 0x80338c. */
void field_set_0x08_8d8eb4(struct rm_ch_switch_sm *cs, struct rm_main_sm *sm)
{
    cs->sm = sm;
    basic_sm_bind_descriptor(cs, &rm_ch_switch_sm_desc);
}

/* obj_vt803210__ctor (0x8d8c1c, 50 Б): rm_main_sm — владелец radio_mgr, очередь
 * запросов, текущий канал 0xffff, вложенный rm_ch_switch_sm, описатель 0x803210. */
void obj_vt803210_ctor(struct rm_main_sm *sm, struct radio_mgr *rm, struct rm_queue *queue)
{
    sm->rm = rm;
    sm->queue = queue;
    sm->cur_ch = 0xffff;
    sm->cur_param = 0;
    field_set_0x08_8d8eb4(&sm->cs, sm);
    basic_sm_bind_descriptor(sm, &rm_main_sm_desc);
}

/* radio_mgr__init_list (0x8d91a0, 20 Б): llist__init + владелец. */
void radio_mgr_init_list(struct rm_queue *q, struct radio_mgr *owner)
{
    llist_init((u32 *)&q->l);
    q->owner = owner;
}

/* radio_mgr__init_pool_and_sm (0x8d8de4, 64 Б). */
static void radio_mgr_init_pool_and_sm(struct radio_mgr *rm)
{
    memset0_words(rm_req_pool, sizeof(rm_req_pool));
    mem_pool_init(&rm->req_pool, rm_req_pool, sizeof(struct rm_req), 0x10);
    radio_mgr_init_list(&rm->queue, rm);
    obj_vt803210_ctor(&rm->sm, rm, &rm->queue);
}

/* (0x8c1a3c) статическая инициализация: таблица методов radio_mgr. У vendor — из списка
 * статических конструкторов (дескриптор 0x80170c, регистрация 0x8fc4xx → 0x8c1cc0, запуск
 * 0x8c1c74/0x8c1ca0); у нас — static_ctors_run (ctors.c) до fw_main. */
void radio_mgr_install_vtable(void)
{
    radio_mgr.vt = &radio_mgr_vtbl;
}

/* (0x8c1c04) статическая инициализация: ид автомата rm_sm в описателе ([0x803210+0x10] =
 * [gp,92] = [0x8001e0]) — только для журнала (basic_sm__error_handler, трасса). */
void rm_sm_desc_set_id(void)
{
    rm_main_sm_desc.id = rm_sm_name_id;
}

/* (0x8c1bf8) статическая инициализация: ид rm_ch_switch_sm ([0x80338c+0x10] = [0x8001e4]). */
void rm_ch_switch_sm_desc_set_id(void)
{
    rm_ch_switch_sm_desc.id = rm_chsw_sm_name_id;
}

/* radio_mgr__init_global (0x8f56b8, 24 Б). Vendor зовёт дважды: из fw_main (0x8f02c6) и из
 * l2_mgr::init (0x8f560e) — оба раза пересоздаёт пул и автомат. Статические инициализации
 * (таблица методов, ид описателей — см. выше) выполняет static_ctors_run (ctors.c) до
 * fw_main, как vendor crt0; прежние повторные вызовы отсюда (не vendor) убраны. */
void radio_mgr_init_global(void)
{
    radio_mgr_init_pool_and_sm(&radio_mgr);
    radio_mgr_obj = &radio_mgr;   /* st.as r13,[gp,-16]: 0x800184 - 0x40 */
}

/* ======================= вспомогательные ======================= */

/* rm__llist_pop_front_thunk (0x8e0bc8) → llist__pop_front; голова очереди без снятия —
 * (0x8cc65c, 4 Б): [list+4]. */
static struct rm_req *rm_queue_peek(struct rm_queue *q)
{
    return (struct rm_req *)q->l.head;
}

/* radio_mgr__free_handle (0x8ddb0c, 10 Б): запрос свободен, вернуть в пул radio_mgr. */
static void radio_mgr_free_handle(struct radio_mgr *rm, struct rm_req *req)
{
    req->state = RM_REQ_FREE;
    mem_pool_free(&rm->req_pool, req);
}

/* vring_schd__prohibit_cids (имя ошибочно; 0x8e1218, 14 Б): GET_NEXT_REQ автомату
 * radio_mgr (владельцу очереди). */
static void radio_mgr_kick(struct radio_mgr *rm)
{
    rm_sm_event(&rm->sm, 3, 0, 0, 0);
}

/* radio_mgr__enqueue_request (0x8e1f70, 20 Б): в конец очереди и разбудить автомат. */
static void radio_mgr_enqueue_request(struct rm_queue *q, struct rm_req *req)
{
    list_find_entry_d((u32 *)&q->l, (u32 *)req);
    radio_mgr_kick(q->owner);
}

/* (0x8e2778, 32 Б): если запрос в этой очереди — снять (llist_remove 0x8e2884), 1; иначе 0. */
static u32 rm_list_remove_if_member(struct rm_queue *q, struct rm_req *req)
{
    if (&q->l != req->list)
        return 0;
    tx_list_remove(&q->l, req);
    return 1;
}

/* (0x8e46e8, 10 Б) задача u_schd: radio_mgr->callback(req) — событие CALLBCK автомату
 * (колбэк запроса вызывается не изнутри перехода, а отдельной задачей). */
void radio_mgr_req_callback_task(u32 req, u32 a1)
{
    struct radio_mgr *rm = radio_mgr_obj;
    (void)a1;
    rm->vt->callback(rm, (struct rm_req *)req);
}

/* rm__channel_matches (0x8da394, 40 Б): совпадают канал, параметр и sta_role. */
static u32 rm_channel_matches(const struct rm_chan *a, const struct rm_chan *b)
{
    if (a->ch != b->ch || a->param != b->param)
        return 0;
    return a->sta_role == b->sta_role;
}

/* rm__load_request_params (0x8eaccc, 28 Б): параметры переключения из вторичного запроса. */
static void rm_load_request_params(struct rm_main_sm *sm, const struct rm_req *req)
{
    sm->cur.ch = req->ch;
    sm->cur.param = req->param;
    sm->cur.tx_chan = 1;
    sm->cur.changed = 0;
    sm->cur.sta_role = 0;
    sm->cur.mid = req->mid;
}

/* rm__store_tune_request (0x8e9ab4, 12 Б): текущий канал после переключения. */
static void rm_store_tune_request(struct rm_main_sm *sm, u32 param, u32 ch, u32 mid)
{
    sm->cur_ch = ch;
    sm->cur_param = param;
    sm->cur_mid = (u8)mid;
}

/* rm_main_sm::kick_channel_switch_sm (0x8da6e4, 76 Б): запустить переключение на
 * параметры cur. Ветка alt_kick != 0 (сразу CH_SWITCH_DONE отложенным событием,
 * 0x8e70c0 = переход на sm__defer_call) у vendor недостижима: +0x94 никто не пишет. */
static void rm_kick_channel_switch_sm(struct rm_main_sm *sm)
{
    if (sm->hdr.trace != 0)
        fw_log_emit1(0x28, 0x1019090, sm->cur.ch);
    if (sm->alt_kick == 0)
        basic_sm_handle_event(&sm->cs, 0, (u32)&sm->cur, 0, 0);
    else if (sm->alt_kick_defer != 0)
        rm_sm_defer(sm, 2, sm->cur.ch, sm->cur.param, sm->cur.mid);
}

/* ======================= методы radio_mgr (таблица 0x800848) ======================= */

/* (0x8e6ca0) set_primary: задать/снять основной канал: set == 0 → PRIMARY_UNSET; иначе
 * параметры канала на стеке → PRIMARY_SET. Слова +0x10/+0x14 vendor не заполняет (мусор
 * стека; +0x14 затем перезаписывается флагом «изменён», +0x10 дальше не читается) — у нас
 * нули. */
void radio_mgr_vt_set_primary(struct radio_mgr *self, u32 set, u32 ch,
                                                u32 rx_on_w0, u32 rx_on_w4, u32 bcn_int,
                                                u32 sta_role, u32 mid)
{
    struct rm_chan req;

    if (set == 0) {
        rm_sm_event(&self->sm, 8, 0, 0, 0);
        return;
    }
    memset0_words(&req, sizeof(req));
    req.ch = ch;
    req.param = 1;
    req.tx_chan = 0;
    req.sta_role = sta_role;
    req.rx_on_w0 = rx_on_w0;
    req.rx_on_w4 = rx_on_w4;
    req.bcn_int = bcn_int;
    req.mid = (u8)mid;
    rm_sm_event(&self->sm, 0, (u32)&req, 0, 0);
}

/* (0x8dc9ec) request_primary: запросить радио на основном канале: cb(req, arg) по
 * готовности. */
struct rm_req *radio_mgr_vt_request_primary(struct radio_mgr *self,
                                                              rm_req_cb cb, u32 arg, u32 mid)
{
    struct rm_req *req = mem_pool_allocate(&self->req_pool);
    if (req == 0)
        fw_sysassert_fatal(caller(), 0x115d);
    req->type = RM_REQ_PRIMARY;
    req->cb = cb;
    req->arg = arg;
    req->state = RM_REQ_QUEUED;
    req->mid = (u8)mid;
    radio_mgr_enqueue_request(&self->queue, req);
    return req;
}

/* (0x8dca9c) request_secondary — radio_mgr__request: запросить радио на канале ch. */
struct rm_req *radio_mgr_vt_request_secondary(struct radio_mgr *self,
                                                                rm_req_cb cb, u32 arg,
                                                                u32 param, u32 ch, u32 mid)
{
    struct rm_req *req = mem_pool_allocate(&self->req_pool);
    if (req == 0)
        fw_sysassert_fatal(caller(), 0x115e);
    req->type = RM_REQ_SECONDARY;
    req->param = param;
    req->ch = ch;
    req->cb = cb;
    req->arg = arg;
    req->state = RM_REQ_QUEUED;
    req->mid = (u8)mid;
    radio_mgr_enqueue_request(&self->queue, req);
    return req;
}

/* (0x8ea7f0) lock_free: освободить радио — LOCK_FREE. */
void radio_mgr_vt_lock_free(struct radio_mgr *self, struct rm_req *req)
{
    rm_sm_event(&self->sm, 7, (u32)req, 0, 0);
}

/* (0x8e4dc8) sec_tune: перестроить удерживаемый вторичный запрос на новый канал —
 * SEC_TUNE. */
void radio_mgr_vt_sec_tune(struct radio_mgr *self, rm_req_cb cb, u32 arg,
                                             struct rm_req *req, u32 param, u32 ch, u32 mid)
{
    if (req == 0)
        fw_sysassert_fatal(caller(), 0x1160);
    req->param = param;
    req->ch = ch;
    req->cb = cb;
    req->arg = arg;
    req->mid = (u8)mid;
    rm_sm_event(&self->sm, 10, (u32)req, 0, 0);
}

/* (0x8e2734) release: отменить запрос — ещё в очереди: снять и освободить; иначе
 * lock_free. */
void radio_mgr_vt_release(struct radio_mgr *self, struct rm_req *req)
{
    if (req == 0)
        fw_sysassert_fatal(caller(), 0x115f);
    if (rm_list_remove_if_member(&self->queue, req)) {
        req->state = RM_REQ_FREE;
        mem_pool_free(&self->req_pool, req);
        return;
    }
    self->vt->lock_free(self, req);
}

/* rm_main_sm (0x8cc104): *out = текущий канал, возврат — его параметр. */
static u32 rm_main_sm_get_channel(const struct rm_main_sm *sm, u32 *out)
{
    *out = sm->cur_ch;
    return sm->cur_param;
}

/* (0x8cc110) get_channel: текущий канал (radio_mgr__get_current_channel 0x8cc130 — вызов
 * метода). */
u32 radio_mgr_vt_get_channel(struct radio_mgr *self, u32 *out)
{
    return rm_main_sm_get_channel(&self->sm, out);
}

/* (0x8ea684) callback: CALLBCK — вызвать колбэк запроса. */
void radio_mgr_vt_callback(struct radio_mgr *self, struct rm_req *req)
{
    rm_sm_event(&self->sm, 11, (u32)req, 0, 0);
}

/* cur_mid (0x8cc150) и inject_lock_evt (0x8ed5e4) — в lmac_evt.c. */

/* 0x800848: таблица методов radio_mgr (на неё указывает radio_mgr.vt). */
FWDATA(800848) const struct radio_mgr_vt radio_mgr_vtbl = {
    .set_primary = radio_mgr_vt_set_primary,                /* 0x8e6ca0 */
    .request_primary = radio_mgr_vt_request_primary,        /* 0x8dc9ec */
    .request_secondary = radio_mgr_vt_request_secondary,    /* 0x8dca9c */
    .lock_free = radio_mgr_vt_lock_free,                    /* 0x8ea7f0 */
    .sec_tune = radio_mgr_vt_sec_tune,                      /* 0x8e4dc8 */
    .release = radio_mgr_vt_release,                        /* 0x8e2734 */
    .get_channel = radio_mgr_vt_get_channel,                /* 0x8cc110 */
    .cur_mid = radio_mgr_vt_cur_mid,                        /* 0x8cc150 */
    .callback = radio_mgr_vt_callback,                      /* 0x8ea684 */
    .inject_lock_evt = radio_mgr_vt_inject_lock_evt,        /* 0x8ed5e4 */
};

/* ======================= действия rm_main_sm (описатель 0x803210) ======================= */

/* rm_sm__action_at_2c (0x8e6d34, 22 Б): запомнить основной канал, «изменён».
 * PRIMARY_SET в SWITCH_2_PRIM / PRIM_LOCKED / SWITCH_2_SEC. */
void rm_sm_store_primary(struct rm_main_sm *sm, const struct rm_chan *req)
{
    memcpy_fw(&sm->primary, req, sizeof(sm->primary));
    sm->primary.changed = 1;
}

/* switch_2_secondary (имя ошибочно; 0x8e83d4, 32 Б): переключиться на основной канал —
 * SWITCH_2_PRIMARY в PRIM_NON_LOCKED / SECONDARY. */
void rm_sm_switch_2_primary(struct rm_main_sm *sm)
{
    memcpy_fw(&sm->cur, &sm->primary, sizeof(sm->cur));
    rm_kick_channel_switch_sm(sm);
    sm->primary.changed = 0;
}

/* rm_sm__action_8e9ad4 (0x8e9ad4, 20 Б): PRIMARY_SET в IDLE / PRIM_NON_LOCKED. */
void rm_sm_set_primary_and_switch(struct rm_main_sm *sm,
                                                    const struct rm_chan *req)
{
    rm_sm_store_primary(sm, req);
    rm_sm_switch_2_primary(sm);
}

/* rm__invalidate_tune_slot (0x8ea8b0, 14 Б): основной канал не задан. PRIMARY_UNSET в
 * IDLE / SWITCH_2_PRIM / PRIM_LOCKED / SWITCH_2_SEC / SECONDARY. */
void rm_invalidate_tune_slot(struct rm_main_sm *sm)
{
    sm->primary.ch = 0xffff;
    sm->primary.param = 0;
}

/* rm_sm__action_8e9ac0 (0x8e9ac0, 18 Б): PRIMARY_UNSET в PRIM_NON_LOCKED. */
void rm_sm_unset_primary_and_switch(struct rm_main_sm *sm)
{
    rm_invalidate_tune_slot(sm);
    rm_sm_switch_2_primary(sm);
}

/* 0x8023e4: таблица переходов switch vendor rm_main_sm__enter_primary_non_locked (0x8c9950;
 * ldb, цель = 0x8c99ce + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8023e4) const u8 rm_main_sm_enter_primary_non_locked_jt[5] = {
    0x3a, 0x2f, 0x2f, 0x00, 0x00,
};

/* rm_main_sm::enter_primary_non_locked (0x8c9950, 62 Б): UNLOCK_PRIMARY в PRIM_LOCKED.
 * Основной канал менялся (или не тот, на котором стоим) — SWITCH_2_PRIMARY, иначе
 * GET_NEXT_REQ. */
void rm_main_sm_enter_primary_non_locked(struct rm_main_sm *sm)
{
    u32 ev;
    if (rm_channel_matches(&sm->primary, &sm->cur) == 0 || sm->primary.changed != 0) {
        if (sm->hdr.trace != 0)
            fw_log_emit0(0x28, 0x1019140);
        ev = 1;
    } else {
        ev = 3;
    }
    rm_sm_defer(sm, ev, 0, 0, 0);
}

/* rm_sm__action_8e0eb0 (0x8e0eb0, 24 Б): CH_SWITCH_DONE в SWITCH_2_PRIM. */
void rm_sm_primary_tune_done(struct rm_main_sm *sm, u32 ch, u32 param,
                                               u32 mid)
{
    rm_store_tune_request(sm, param, ch, mid);
    rm_main_sm_enter_primary_non_locked(sm);
}

/* rm_main_sm::lock_primary (0x8dc9a4, 70 Б): LOCK_PRIMARY в PRIM_NON_LOCKED — выдать
 * радио первому запросу (колбэк — задачей u_schd 0x8e46e8). */
void rm_main_sm_lock_primary(struct rm_main_sm *sm)
{
    struct rm_req *req = llist_pop_front((u32 *)&sm->queue->l);
    list_find_entry_d((u32 *)&sm->holders, (u32 *)req);
    req->state = RM_REQ_CB_PENDING;
    if (sm->hdr.trace != 0)
        fw_log_emit2(0x28, 0x1019204, (u32)req->cb, (u32)req);
    u_schd_add(radio_mgr_req_callback_task, (u32)req, 0, 1);
}

/* rm_main_sm__get_next_prim_request (0x8cc5a8): GET_NEXT_REQ в PRIM_LOCKED — следующий
 * основной запрос получает радио сразу. */
void rm_main_sm_get_next_prim_request(struct rm_main_sm *sm)
{
    struct rm_req *req = rm_queue_peek(sm->queue);
    if (req == 0)
        return;
    if (sm->hdr.trace != 0)
        fw_log_emit2(0x28, 0x101923c, req->type, (u32)req);
    if (req->type == RM_REQ_PRIMARY)
        rm_main_sm_lock_primary(sm);
}

/* rm_main_sm__get_next_request (0x8cc5e0): GET_NEXT_REQ в IDLE / PRIM_NON_LOCKED.
 * Основной запрос → LOCK_PRIMARY (канал должен быть задан, иначе ассерт 0x1175);
 * вторичный → LOCK_SEC; очередь пуста и основной канал не задан → GOTO_IDLE. */
void rm_main_sm_get_next_request(struct rm_main_sm *sm)
{
    struct rm_req *req = rm_queue_peek(sm->queue);

    if (req != 0) {
        if (sm->hdr.trace != 0)
            fw_log_emit2(0x28, 0x1019184, req->type, (u32)req);
        if (req->type == RM_REQ_PRIMARY) {
            if (sm->primary.param != 1)
                fw_sysassert_fatal(caller(), 0x1175);
            rm_sm_defer(sm, 4, 0, 0, 0);
        } else if (req->type == RM_REQ_SECONDARY) {
            rm_sm_defer(sm, 6, 0, 0, 0);
        }
        return;
    }
    if (sm->primary.param != 0)
        return;
    if (sm->hdr.trace != 0)
        fw_log_emit0(0x28, 0x10191cc);
    rm_sm_defer(sm, 9, 0, 0, 0);
}

/* rm_sm__action_8cd0a0 (0x8cd0a0, 2 Б): GOTO_IDLE в PRIM_NON_LOCKED — ничего. */
void rm_sm_goto_idle(void)
{
}

/* rm_main_sm::switch_2_secondary (0x8e83d4, 32 Б): SWITCH_2_SEC в PRIM_LOCKED / SEC_LOCKED —
 * параметры primary (0x28 Б) в текущие (cur), запустить переключение канала,
 * primary.changed = 0 (st_s в слоте задержки перед выходом). */
void rm_main_sm_switch_2_secondary(struct rm_main_sm *sm)
{
    memcpy_fw(&sm->cur, &sm->primary, sizeof(sm->cur));
    rm_kick_channel_switch_sm(sm);
    sm->primary.changed = 0;
}

/* rm_sm__action_8e83f4 (0x8e83f4, 68 Б): LOCK_SEC в IDLE / PRIM_NON_LOCKED / SECONDARY —
 * взять вторичный запрос и переключиться на его канал. */
void rm_sm_lock_secondary(struct rm_main_sm *sm)
{
    struct rm_req *req = llist_pop_front((u32 *)&sm->queue->l);
    if (sm->hdr.trace != 0)
        fw_log_emit1(0x28, 0x1019288, (u32)req->cb);
    list_find_entry_d((u32 *)&sm->holders, (u32 *)req);
    req->state = RM_REQ_GRANTED;
    rm_load_request_params(sm, req);
    rm_kick_channel_switch_sm(sm);
}

/* rm_main_sm__mark_as_pending_removal (0x8ddcec, 66 Б): LOCK_FREE в SWITCH_2_SEC —
 * освободить после окончания переключения. */
void rm_main_sm_mark_as_pending_removal(struct rm_main_sm *sm,
                                                          struct rm_req *req)
{
    if (sm->hdr.trace != 0)
        fw_log_emit1(0x28, 0x10192f0, (u32)req);
    if (req->list == &sm->holders)
        req->state = RM_REQ_FREE_PENDING;
    else
        fw_sysassert_fatal(caller(), 0x1176);
}

/* rm_main_sm__primary_handle_free (0x8e0e58, 88 Б): LOCK_FREE в PRIM_LOCKED; последний
 * держатель ушёл — UNLOCK_PRIMARY. */
void rm_main_sm_primary_handle_free(struct rm_main_sm *sm, struct rm_req *req)
{
    if (sm->hdr.trace != 0)
        fw_log_emit2(0x28, 0x10192b8, (u32)req, (u32)req->cb);
    tx_list_remove(&sm->holders, req);
    radio_mgr_free_handle(sm->rm, req);
    if (sm->holders.count == 0)
        rm_sm_defer(sm, 5, 0, 0, 0);
}

/* rm_main_sm__secondary_handle_free (0x8e4e48, 110 Б): LOCK_FREE в SECONDARY; следующий
 * вторичный запрос — LOCK_SEC, иначе назад на основной (SWITCH_2_PRIMARY). */
void rm_main_sm_secondary_handle_free(struct rm_main_sm *sm,
                                                        struct rm_req *req)
{
    struct rm_req *next;
    u32 ev = 1;

    if (sm->hdr.trace != 0)
        fw_log_emit2(0x28, 0x1019324, (u32)req, (u32)req->cb);
    tx_list_remove(&sm->holders, req);
    radio_mgr_free_handle(sm->rm, req);
    next = rm_queue_peek(sm->queue);
    if (next != 0) {
        if (sm->hdr.trace != 0)
            fw_log_emit2(0x28, 0x101935c, (u32)next, next->type);
        if (next->type == RM_REQ_SECONDARY)
            ev = 6;
    }
    rm_sm_defer(sm, ev, 0, 0, 0);
}

/* rm_sm__action_8e4ee4 (0x8e4ee4, 52 Б): SEC_TUNE в SECONDARY — перестроить удерживаемый
 * (первый в списке) вторичный запрос. */
void rm_sm_secondary_retune(struct rm_main_sm *sm, struct rm_req *req)
{
    if ((u32)req != sm->holders.head)
        fw_sysassert_fatal(caller(), 0x1177);
    rm_load_request_params(sm, req);
    rm_kick_channel_switch_sm(sm);
}

/* rm_main_sm__secondary_tune_done (0x8e4f18, 172 Б): CH_SWITCH_DONE в SWITCH_2_SEC.
 * Запрос, ставший «к удалению» во время переключения, — LOCK_FREE; иначе канал
 * должен совпасть с запрошенным (ассерты 0x1173/0x1174) и колбэк — задачей u_schd. */
void rm_main_sm_secondary_tune_done(struct rm_main_sm *sm, u32 ch, u32 param,
                                                      u32 mid)
{
    struct rm_req *req;

    if (sm->hdr.trace != 0)
        fw_log_emit2(0x28, 0x10190c4, ch, param);
    rm_store_tune_request(sm, param, ch, mid);
    req = (struct rm_req *)sm->holders.head;
    if (req == 0)
        fw_sysassert_fatal(caller(), 0x1172);
    if (req->state == RM_REQ_FREE_PENDING) {
        rm_sm_defer(sm, 7, (u32)req, 0, 0);
        return;
    }
    if (param != req->param)
        fw_sysassert_fatal(caller(), 0x1173);
    if (param != 0 && req->ch != ch)
        fw_sysassert_fatal(caller(), 0x1174);
    req->state = RM_REQ_CB_PENDING;
    if (sm->hdr.trace != 0)
        fw_log_emit1(0x28, 0x10190fc, (u32)req);
    u_schd_add(radio_mgr_req_callback_task, (u32)req, 0, 1);
}

/* rm_main_sm__call_cb (0x8c59c4, 110 Б): CALLBCK в любом состоянии — колбэк удерживающего
 * запроса (CB_PENDING → GRANTED). Запрос в другом состоянии (отменён до задачи) — только
 * журнал. */
void rm_main_sm_call_cb(struct rm_main_sm *sm, struct rm_req *req)
{
    if (req->state != RM_REQ_CB_PENDING) {
        if (sm->hdr.trace != 0)
            fw_log_emit3(0x28, 0x10193e0, (u32)req, (u32)req->cb, req->state);
        return;
    }
    if (req->list != &sm->holders)
        fw_sysassert_fatal(caller(), 0x1178);
    if (sm->hdr.trace != 0)
        fw_log_emit3(0x28, 0x10193a4, (u32)req, (u32)req->cb, req->arg);
    req->state = RM_REQ_GRANTED;
    req->cb(req, req->arg);
}


/* 0x803224: таблица переходов rm_main_sm [событие][состояние] (событий 12, состояний 6) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(803224) const struct sm_trans rm_main_sm_trans[12][6] = {
    [0] = {   /* RM_EVT_PRIMARY_SET */
        { SM_ACT(rm_sm_set_primary_and_switch), 1 },         /* RM_ST_IDLE → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_sm_store_primary), 1 },                  /* RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_sm_set_primary_and_switch), 1 },         /* RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_sm_store_primary), 3 },                  /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(rm_sm_store_primary), 4 },                  /* RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC */
        { SM_ACT(rm_sm_store_primary), 5 },                  /* RM_ST_SECONDARY → RM_ST_SECONDARY */
    },
    [1] = {   /* RM_EVT_SWITCH_2_PRIMARY */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_main_sm_switch_2_secondary), 1 },        /* RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(basic_sm_error_handler), 3 },               /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(basic_sm_error_handler), 4 },               /* RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC */
        { SM_ACT(rm_main_sm_switch_2_secondary), 1 },        /* RM_ST_SECONDARY → RM_ST_SWITCH_2_PRIM */
    },
    [2] = {   /* RM_EVT_CH_SWITCH_DONE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(rm_sm_primary_tune_done), 2 },              /* RM_ST_SWITCH_2_PRIM → RM_ST_PRIM_NON_LOCKED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_NON_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_LOCKED → RM_ST_IDLE */
        { SM_ACT(rm_main_sm_secondary_tune_done), 5 },       /* RM_ST_SWITCH_2_SEC → RM_ST_SECONDARY */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SECONDARY → RM_ST_IDLE */
    },
    [3] = {   /* RM_EVT_GET_NEXT_REQ */
        { SM_ACT(rm_main_sm_get_next_request), 0 },          /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(sm_action_nop_b), 1 },                      /* RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_main_sm_get_next_request), 2 },          /* RM_ST_PRIM_NON_LOCKED → RM_ST_PRIM_NON_LOCKED */
        { SM_ACT(rm_main_sm_get_next_prim_request), 3 },     /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(sm_action_nop_b), 4 },                      /* RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC */
        { SM_ACT(sm_action_nop_b), 5 },                      /* RM_ST_SECONDARY → RM_ST_SECONDARY */
    },
    [4] = {   /* RM_EVT_LOCK_PRIMARY */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_IDLE */
        { SM_ACT(rm_main_sm_lock_primary), 3 },              /* RM_ST_PRIM_NON_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_SEC → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SECONDARY → RM_ST_IDLE */
    },
    [5] = {   /* RM_EVT_UNLOCK_PRIMARY */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_NON_LOCKED → RM_ST_IDLE */
        { SM_ACT(rm_main_sm_enter_primary_non_locked), 2 },  /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_NON_LOCKED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_SEC → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SECONDARY → RM_ST_IDLE */
    },
    [6] = {   /* RM_EVT_LOCK_SEC */
        { SM_ACT(rm_sm_lock_secondary), 4 },                 /* RM_ST_IDLE → RM_ST_SWITCH_2_SEC */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_IDLE */
        { SM_ACT(rm_sm_lock_secondary), 4 },                 /* RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_SEC */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_SEC → RM_ST_IDLE */
        { SM_ACT(rm_sm_lock_secondary), 4 },                 /* RM_ST_SECONDARY → RM_ST_SWITCH_2_SEC */
    },
    [7] = {   /* RM_EVT_LOCK_FREE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_NON_LOCKED → RM_ST_IDLE */
        { SM_ACT(rm_main_sm_primary_handle_free), 3 },       /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(rm_main_sm_mark_as_pending_removal), 4 },   /* RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC */
        { SM_ACT(rm_main_sm_secondary_handle_free), 5 },     /* RM_ST_SECONDARY → RM_ST_SECONDARY */
    },
    [8] = {   /* RM_EVT_PRIMARY_UNSET */
        { SM_ACT(rm_invalidate_tune_slot), 0 },              /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(rm_invalidate_tune_slot), 1 },              /* RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_sm_unset_primary_and_switch), 1 },       /* RM_ST_PRIM_NON_LOCKED → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_invalidate_tune_slot), 3 },              /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(rm_invalidate_tune_slot), 4 },              /* RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC */
        { SM_ACT(rm_invalidate_tune_slot), 5 },              /* RM_ST_SECONDARY → RM_ST_SECONDARY */
    },
    [9] = {   /* RM_EVT_GOTO_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_IDLE */
        { SM_ACT(rm_sm_goto_idle), 0 },                      /* RM_ST_PRIM_NON_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_SEC → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SECONDARY → RM_ST_IDLE */
    },
    [10] = {   /* RM_EVT_SEC_TUNE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_PRIM → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_NON_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_PRIM_LOCKED → RM_ST_IDLE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* RM_ST_SWITCH_2_SEC → RM_ST_IDLE */
        { SM_ACT(rm_sm_secondary_retune), 4 },               /* RM_ST_SECONDARY → RM_ST_SWITCH_2_SEC */
    },
    [11] = {   /* RM_EVT_CALLBCK */
        { SM_ACT(rm_main_sm_call_cb), 0 },                   /* RM_ST_IDLE → RM_ST_IDLE */
        { SM_ACT(rm_main_sm_call_cb), 1 },                   /* RM_ST_SWITCH_2_PRIM → RM_ST_SWITCH_2_PRIM */
        { SM_ACT(rm_main_sm_call_cb), 2 },                   /* RM_ST_PRIM_NON_LOCKED → RM_ST_PRIM_NON_LOCKED */
        { SM_ACT(rm_main_sm_call_cb), 3 },                   /* RM_ST_PRIM_LOCKED → RM_ST_PRIM_LOCKED */
        { SM_ACT(rm_main_sm_call_cb), 4 },                   /* RM_ST_SWITCH_2_SEC → RM_ST_SWITCH_2_SEC */
        { SM_ACT(rm_main_sm_call_cb), 5 },                   /* RM_ST_SECONDARY → RM_ST_SECONDARY */
    },
};
/* 0x803210: описатель rm_main_sm (состояний 6, событий 12, старт RM_ST_IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 rm_sm_state_names[6];   /* определение ниже */
extern const u32 rm_sm_event_names[12];   /* определение ниже */
FWDATA(803210) struct sm_desc rm_main_sm_desc = {
    .n_events = 12, .n_states = 6, .init_state = 0,
    .table = &rm_main_sm_trans[0][0],
    .state_names = rm_sm_state_names,   /* {RM_ST_IDLE, RM_ST_SWITCH_2_PRIM, RM_ST_PRIM_NON_LOCKED, RM_ST_PRIM_LOCKED, RM_ST_SWITCH_2_SEC, RM_ST_SECONDARY} */
    .event_names = rm_sm_event_names,
};

/* ======================= TX на время смены канала ======================= */

/* tx_api__check_state_2 (0x8e7ec4, 56 Б): остановить TX_API; пустой — сразу «остановлен»
 * (sm__null_handler), иначе [api+8] = 2 (ждёт опустошения). */
static void tx_api_check_state_2(struct fwq_tx *api)
{
    if (api->state == 2)
        fw_sysassert_fatal(caller(), 0x120e);
    if (api->sent.count == 0)
        sm_null_handler(api);
    else
        api->state = 2;
}

/* tx_api__pause_for_ch_switch (0x8e7f2c, 62 Б): [0x800168] = 1 и остановить три TX_API.
 * Аргумент (5 — маска ожидаемых событий в r0 из слота задержки) vendor не читает. */
static void tx_api_pause_for_ch_switch(void)
{
    if (tx_ch_switch_paused != 0)              /* [gp,-28] */
        fw_sysassert_fatal(caller(), 0x1223);
    tx_ch_switch_paused = 1;
    tx_api_check_state_2(&tx_api_mgmt);
    tx_api_check_state_2(&tx_api_data);
    tx_api_check_state_2(&tx_api_2);        /* add3 r0,r13,0x12: tx_api_mgmt + 0x90 */
}

/* rm_ch_switch__resume_tx_queue (0x8e7948, 48 Б). */
static void rm_ch_switch_resume_tx_queue(u32 ch)
{
    fwq_tx_enable_queue(&tx_api_mgmt, ch);
    fwq_tx_enable_queue(&tx_api_data, ch);
    fwq_tx_enable_queue(&tx_api_2, ch);
}

/* rm_ch_switch__program_mac (0x8c3ac0, 48 Б): MAC-адреса записи mid в регистры MAC:
 * BSSID (bss.bssid, mid+0x54) — свой адрес, свой MAC записи — групповой фильтр. */
static void rm_ch_switch_program_mac(const struct mid *mid)
{
    const u8 *own = mid->bss.bssid;             /* add2 r14,r0,0x15 */
    const u8 *peer = mid->mac;
    mac_parser_set_addr_886020(own);
    mac_set_own_addr(own);
    l2_offload_set_own_mac_addr(own);
    mac_parser_set_addr_886018(peer);
    mac_set_mcast_addr(peer);
}

/* ======================= LMAC-команды смены канала ======================= */

/* lmac_cmd__fill_rx_on_fields (0x8dc25c, 48 Б). */
static void lmac_cmd_fill_rx_on_fields(struct lmac_cmd_rx_on *buf, u32 w18, u32 w0, u32 w4, u32 b1c, u32 b10)
{
    u32 v;
    buf->start_lo = w0;
    buf->start_hi = w4;
    buf->flags = (buf->flags & ~1u) | (b10 & 1);
    buf->bi_len_us = w18;
    v = (buf->role_bits & ~1u) | (b1c & 1);
    v = (v & ~2u) | ((b1c & 1) << 1);
    buf->role_bits = v & ~4u;
}

/* lmac_if__build_rx_on_cmd (0x8dbcdc, 80 Б): тело команды 0x01 (0x28 Б). После поля
 * role_bits — st.aw r0,[r13,32]: rx_mode = 1 и r13 = buf+0x20, дальше байты +0x24..+0x26. */
static void lmac_if_build_rx_on_cmd(struct lmac_cmd_rx_on *buf, u32 a1, u32 a2, u32 a3, u32 a4, u32 a5)
{
    u32 mask;
    lmac_cmd_fill_rx_on_fields(buf, a3 << 10, a1, a2, a4, a5);
    buf->rx_mode = 1;
    mask = rf_cfg_get_rf_mask_45e(&rf_obj);
    buf->rf_mask = (u8)mask;
    buf->omni_rf_mask = rf_obj.omni_rf_mask;
    buf->rf_sets_mask = (rf_obj.sets_mode == 3) ? (u8)mask : 0;
}

/* lmac_if_send_cmd_0x01 (0x8dbd2c, 72 Б): ucode — включить RX на канале. */
static void lmac_if_send_cmd_0x01(u32 a0, u32 a1, u32 a2, u32 a3, u32 a4)
{
    struct lmac_cmd_rx_on *buf = mem_pool_alloc_locked(&lmac_mbox.mb);
    if (buf == 0)
        return;
    lmac_if_build_rx_on_cmd(buf, a0, a1, a2, a3, a4);
    lmac_if_post_cmd(buf, 1, 0x28, 0);
}

/* lmac_if_send_cmd_0x03 (0x8dbcb8, 34 Б): ucode — выключить RX. Буфер vendor не
 * проверяет (field_set_0x00__8dbcb0 пишет 1 в mode). */
static void lmac_if_send_cmd_0x03(void)
{
    struct lmac_cmd_rx_off *buf = mem_pool_alloc_locked(&lmac_mbox.mb);
    buf->mode = 1;
    lmac_if_post_cmd(buf, 3, 4, 0);
}

/* ======================= CALIB_MNGR: смена системного состояния ======================= */

/* Движок калибровки — fw/calib_engine.c. */

/* calib_mngr__restart_scheme (0x8e4a94, 40 Б): при включённой калибровке ([gp,202] =
 * 0x80024e) — прервать (abort != 0) и запустить схему для состояния st (start != 0). */
static void calib_mngr_restart_scheme(u32 abort, u32 start, u32 st)
{
    if (calib_scheme_enabled == 0)
        return;
    if (abort != 0)
        calib_engine_abort_all();
    if (start == 0)
        return;
    calib_mngr_start_scheme(calib_cfg_get_scheme(chsw_pcp_ap_mode, st));
}

/* 0x8021e8: таблица переходов switch vendor CALIB_MNGR__update_sys_state (0x8ead00;
 * ldw, цель = 0x8ead16 + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(8021e8) const u16 calib_mngr_set_state_jt[17] = {
    0x0007, 0x0017, 0x0017, 0x0017, 0x0017, 0x0017, 0x0000, 0x0007,
    0x0017, 0x0017, 0x0017, 0x0017, 0x0007, 0x000e, 0x000e, 0x000e,
    0x0007,
};

/* CALIB_MNGR (0x8ead00, 72 Б): состояние калибровки [gp,-20] = 0x800170 по системному
 * состоянию (таблица полуслов 0x8021e8): 0,7,12,16 → 3; 6 → 2; 13..15 → 4; прочие (в т. ч.
 * 1 — смена канала: запись [1] = 0x17 ведёт на выход) — без изменений. Прежний порт ставил
 * 2 (ASSOCIATED) и при st == 1: после первого же переключения канала скан шёл в состоянии
 * «ассоциирован» (на стенде 0x800170 = 2 против 3 у vendor). */
static void calib_mngr_set_state(u32 st)
{
    u32 v, msg;
    switch (st) {
    case 0: case 7: case 12: case 16: v = 3; msg = 0x10091a0; break;
    case 6:                           v = 2; msg = 0x1009154; break;
    case 13: case 14: case 15:        v = 4; msg = 0x10091e8; break;
    default: return;
    }
    calib_sys_state = v;
    fw_log_emit0(0x26, msg);
}

/* CALIB_MNGR::update_pcp_ap (0x8eac58, 54 Б): режим PCP/AP ([gp,206] = 0x800252):
 * состояние 10 → 1, 12 → 0. */
static void calib_mngr_update_pcp_ap(u32 st)
{
    if (st == 10) {
        chsw_pcp_ap_mode = 1;
        fw_log_emit0(0x26, 0x1009244);
    }
    if (st == 12) {
        chsw_pcp_ap_mode = 0;
        fw_log_emit0(0x26, 0x1009270);
    }
}

/* 0x80220c: таблица переходов switch vendor CALIB_MNGR__system_state_evt_handler (0x8e8688;
 * ldb, цель = 0x8e86ba + 2·запись). Наш код её не читает (switch в C) — байты как у vendor. */
FWDATA(80220c) const u8 calib_mngr_system_state_evt_handler_jt[23] = {
    0x4a, 0x0c, 0x3a, 0x4a, 0x5a, 0x3a, 0x4a, 0x47, 0x5a, 0x5a, 0x47, 0x5a,
    0x47, 0x3a, 0x3a, 0x3a, 0x4a, 0x2a, 0x3d, 0x00, 0x2a, 0x3d, 0x5a,
};

/* CALIB_MNGR__system_state_evt_handler (0x8e8688, 236 Б): смена системного состояния st
 * (из sys_state__broadcast 0x8e8a14 и rm_ch_switch_sm::switch_on — st = 1, ch). На не-ASIC
 * ничего. Переход таблицей 0x80220c (23 состояния, иначе ассерт 0x12e9). */
void calib_mngr_system_state_evt_handler(u32 st, u32 ch)
{
    if (platform_is_asic() == 0)
        return;
    calib_mngr_set_state(st);
    calib_mngr_update_pcp_ap(st);

    switch (st) {
    case 19:
        calib_mngr_restart_scheme(1, 1, 0);
        calib_mngr_restart_scheme(0, 1, calib_sys_state);
        return;
    case 1:
        if (channels_switch_sm_switch_to_channel(ch) != 0) {
            fw_log_emit2(0x26, 0x100929c, 1, ch);
            calib_mngr_restart_scheme(0, 1, calib_sys_state == 2);
        }
        if (calib_sys_state == 4)
            calib_mngr_restart_scheme(0, 1, 4);
        return;
    case 2: case 5: case 13: case 14: case 15:
        calib_mngr_restart_scheme(1, 0, calib_sys_state);
        return;
    case 7: case 10: case 12:
        if (calib_sys_state != 3)
            fw_sysassert_fatal(caller(), 0x133c);
        break;
    case 0: case 3: case 6: case 16:
        break;
    case 4: case 8: case 9: case 11: case 22:
        return;
    default:                                    /* у vendor 17/20 и 18/21 (PS) — останов/возобновление
                                                 * калибровки; — вход/выход из сна (PS) — больше не рассылаются: энергосбережение вырезано (см. fw/action.c psc_req_reject) */
        fw_sysassert_fatal(caller(), 0x12e9);
        return;
    }
    calib_mngr_restart_scheme(1, 1, calib_sys_state);
}

/* ======================= действия rm_ch_switch_sm (описатель 0x80338c) ======================= */

/* rm_ch_switch_sm::check_turn_completed (0x8c6484, 78 Б): все ожидаемые события пришли —
 * выключение: есть канал для включения (params->param) → START_TUNE, иначе COMPLETED;
 * включение → COMPLETED. */
static void rm_ch_switch_sm_check_turn_completed(struct rm_ch_switch_sm *cs, u32 on)
{
    if (cs->hdr.trace != 0)
        fw_log_emit2(0x28, 0x101946c, cs->expect, cs->got);
    if (cs->expect != cs->got)
        return;
    cs->expect = 0;
    cs->got = 0;
    if (on == 0 && cs->params->param != 0)
        rm_cs_defer(cs, 4);
    else
        rm_cs_defer(cs, 6);
}

/* rm_ch_switch_sm__action_8c5be8 (0x8c5be8, 56 Б): CH_SWITCH_KICK в IDLE — ждать останова
 * FW TX и RX ucode (маска 5), остановить TX. */
void rm_ch_switch_sm_kick(struct rm_ch_switch_sm *cs, struct rm_chan *params)
{
    if (params == 0)
        fw_sysassert_fatal(caller(), 0x116b);
    cs->ch = 0xffff;
    cs->expect = 0;
    cs->got = 0;
    cs->params = params;
    cs->expect = RM_CS_FWTX_STOPPED | RM_CS_UCODE_RX_OFF;
    tx_api_pause_for_ch_switch();
}

/* rm_ch_switch_sm__fwtx_channel_stopped как действие (0x8cb6e8, 64 Б):
 * FW_TX_CHANNEL_STOPPED в TURN_OFF — выключить RX ucode (LMAC 0x03). Не путать с
 * 0x8cb6a8 (tx_helpers.c), которое это событие порождает. */
void rm_ch_switch_sm_on_fwtx_stopped(struct rm_ch_switch_sm *cs)
{
    u32 tsf;
    if ((cs->expect & RM_CS_FWTX_STOPPED) == 0)
        fw_sysassert_fatal(caller(), 0x116c);
    cs->got |= RM_CS_FWTX_STOPPED;
    tsf = MMIO32(HW_MAC_TIMING_INDIRECT_REG_5);
    if (cs->hdr.trace != 0)
        fw_log_emit1(0x28, 0x1019424, tsf);
    lmac_if_send_cmd_0x03();
}

/* rm_ch_switch_sm__action_8c7f14 (0x8c7f14, 44 Б): DATA_STOPPED в TURN_OFF. */
void rm_ch_switch_sm_on_data_stopped(struct rm_ch_switch_sm *cs)
{
    if ((cs->expect & RM_CS_DATA_STOPPED) == 0)
        fw_sysassert_fatal(caller(), 0x116d);
    cs->got |= RM_CS_DATA_STOPPED;
    rm_ch_switch_sm_check_turn_completed(cs, 0);
}

/* rm_ch_switch_sm__action_8e3a9c (0x8e3a9c, 44 Б): UCODE_RX_OFF_EVT в TURN_OFF. */
void rm_ch_switch_sm_on_ucode_rx_off(struct rm_ch_switch_sm *cs)
{
    if ((cs->expect & RM_CS_UCODE_RX_OFF) == 0)
        fw_sysassert_fatal(caller(), 0x116e);
    cs->got |= RM_CS_UCODE_RX_OFF;
    rm_ch_switch_sm_check_turn_completed(cs, 0);
}

/* rm_ch_switch_sm__action_8e3ac8 (0x8e3ac8, 44 Б): UCODE_RX_ON_EVT в TURN_ON. */
void rm_ch_switch_sm_on_ucode_rx_on(struct rm_ch_switch_sm *cs)
{
    if ((cs->expect & RM_CS_UCODE_RX_ON) == 0)
        fw_sysassert_fatal(caller(), 0x116f);
    cs->got |= RM_CS_UCODE_RX_ON;
    rm_ch_switch_sm_check_turn_completed(cs, 1);
}

/* rm_ch_switch_sm__switch_on (0x8e84c0, 136 Б): START_TUNE в TURN_OFF — канал (CALIB_MNGR,
 * системное состояние 1, если [gp,376] = 0x8002fc == 0), MAC-адреса mid, RX ucode (LMAC
 * 0x01), возобновить TX. Ждёт UCODE_RX_ON (маска 0x18, бит 3 — сразу). Параметры
 * перечитываются после каждого вызова, как у vendor. */
void rm_ch_switch_sm_switch_on(struct rm_ch_switch_sm *cs)
{
    const struct rm_chan *p;
    u32 tsf;

    cs->expect |= RM_CS_MAC_SET | RM_CS_UCODE_RX_ON;
    p = cs->params;
    if (cs->hdr.trace != 0)
        fw_log_emit1(0x28, 0x10194bc, p->ch);
    if (chsw_skip_calib_state == 0)
        calib_mngr_system_state_evt_handler(1, p->ch);
    cs->got |= RM_CS_MAC_SET;
    tsf = MMIO32(HW_MAC_TIMING_INDIRECT_REG_5);
    p = cs->params;
    if (cs->hdr.trace != 0)
        fw_log_emit3(0x28, 0x10194fc, p->changed, p->sta_role, tsf);
    cs->ch = p->ch;
    rm_ch_switch_program_mac(mid_list_by_mid_fw(p->mid));
    p = cs->params;
    lmac_if_send_cmd_0x01(p->rx_on_w0, p->rx_on_w4, p->bcn_int, p->sta_role, p->changed);
    rm_ch_switch_resume_tx_queue(cs->params->tx_chan);
}

/* (0x8c5bb8, 46 Б) rm_ch_switch_sm__notify_ch_switch_done: CH_SWITCH_COMPLETED в
 * TURN_OFF / TURN_ON — CH_SWITCH_DONE автомату rm_main_sm (канал, params->param, mid).
 * Имя rm_ch_switch_sm_notify_ch_switch_done занято в vring.c функцией 0x8c5b44. */
void rm_ch_switch_sm_ch_switch_completed(struct rm_ch_switch_sm *cs)
{
    const struct rm_chan *p;
    if (cs->hdr.trace != 0)
        fw_log_emit1(0x28, 0x1019558, cs->ch);
    p = cs->params;
    rm_sm_event(cs->sm, 2, cs->ch, p->param, p->mid);
}

/* 0x8033a0: таблица переходов rm_ch_switch_sm [событие][состояние] (событий 7, состояний 3) —
 * {действие, следующее состояние}; комментарий — «состояние → следующее» по vendor-именам. */
FWDATA(8033a0) const struct sm_trans rm_ch_switch_sm_trans[7][3] = {
    [0] = {   /* CH_SWITCH_KICK */
        { SM_ACT(rm_ch_switch_sm_kick), 1 },                 /* IDLE → TURN_OFF */
        { SM_ACT(basic_sm_error_handler), 1 },               /* TURN_OFF → TURN_OFF */
        { SM_ACT(basic_sm_error_handler), 2 },               /* TURN_ON → TURN_ON */
    },
    [1] = {   /* FW_TX_CHANNEL_STOPPED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* IDLE → IDLE */
        { SM_ACT(rm_ch_switch_sm_on_fwtx_stopped), 1 },      /* TURN_OFF → TURN_OFF */
        { SM_ACT(basic_sm_error_handler), 2 },               /* TURN_ON → TURN_ON */
    },
    [2] = {   /* DATA_STOPPED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* IDLE → IDLE */
        { SM_ACT(rm_ch_switch_sm_on_data_stopped), 1 },      /* TURN_OFF → TURN_OFF */
        { SM_ACT(basic_sm_error_handler), 2 },               /* TURN_ON → TURN_ON */
    },
    [3] = {   /* UCODE_RX_OFF_EVT */
        { SM_ACT(basic_sm_error_handler), 0 },               /* IDLE → IDLE */
        { SM_ACT(rm_ch_switch_sm_on_ucode_rx_off), 1 },      /* TURN_OFF → TURN_OFF */
        { SM_ACT(basic_sm_error_handler), 2 },               /* TURN_ON → TURN_ON */
    },
    [4] = {   /* START_TUNE */
        { SM_ACT(basic_sm_error_handler), 0 },               /* IDLE → IDLE */
        { SM_ACT(rm_ch_switch_sm_switch_on), 2 },            /* TURN_OFF → TURN_ON */
        { SM_ACT(basic_sm_error_handler), 2 },               /* TURN_ON → TURN_ON */
    },
    [5] = {   /* UCODE_RX_ON_EVT */
        { SM_ACT(basic_sm_error_handler), 0 },               /* IDLE → IDLE */
        { SM_ACT(basic_sm_error_handler), 1 },               /* TURN_OFF → TURN_OFF */
        { SM_ACT(rm_ch_switch_sm_on_ucode_rx_on), 2 },       /* TURN_ON → TURN_ON */
    },
    [6] = {   /* CH_SWITCH_COMPLETED */
        { SM_ACT(basic_sm_error_handler), 0 },               /* IDLE → IDLE */
        { SM_ACT(rm_ch_switch_sm_ch_switch_completed), 0 },  /* TURN_OFF → IDLE */
        { SM_ACT(rm_ch_switch_sm_ch_switch_completed), 0 },  /* TURN_ON → IDLE */
    },
};
/* 0x80338c: описатель rm_ch_switch_sm (состояний 3, событий 7, старт IDLE); ид [0x10] пишет
 * статический конструктор. Имена — массивы ид строк журнала в fw_data. */
extern const u32 rm_ch_switch_sm_state_names[3];   /* определение ниже */
extern const u32 rm_ch_switch_sm_event_names[7];   /* определение ниже */
FWDATA(80338c) struct sm_desc rm_ch_switch_sm_desc = {
    .n_events = 7, .n_states = 3, .init_state = 0,
    .table = &rm_ch_switch_sm_trans[0][0],
    .state_names = rm_ch_switch_sm_state_names,   /* {IDLE, TURN_OFF, TURN_ON} */
    .event_names = rm_ch_switch_sm_event_names,
};

/* ======================= имена состояний и событий автоматов (fw_data) ======================= */

/* 0x801714: имена состояний rm_sm (описатель 0x803210). */
FWDATA(801714) const u32 rm_sm_state_names[6] = {
    0x0102084c,   /* RM_ST_IDLE */
    0x01020857,   /* RM_ST_SWITCH_2_PRIM */
    0x0102086b,   /* RM_ST_PRIM_NON_LOCKED */
    0x01020881,   /* RM_ST_PRIM_LOCKED */
    0x01020893,   /* RM_ST_SWITCH_2_SEC */
    0x010208a6,   /* RM_ST_SECONDARY */
};

/* 0x80172c: имена событий rm_sm (описатель 0x803210). */
FWDATA(80172c) const u32 rm_sm_event_names[12] = {
    0x010208b6,   /* RM_EVT_PRIMARY_SET */
    0x010208c9,   /* RM_EVT_SWITCH_2_PRIMARY */
    0x010208e1,   /* RM_EVT_CH_SWITCH_DONE */
    0x010208f7,   /* RM_EVT_GET_NEXT_REQ */
    0x0102090b,   /* RM_EVT_LOCK_PRIMARY */
    0x0102091f,   /* RM_EVT_UNLOCK_PRIMARY */
    0x01020935,   /* RM_EVT_LOCK_SEC */
    0x01020945,   /* RM_EVT_LOCK_FREE */
    0x01020956,   /* RM_EVT_PRIMARY_UNSET */
    0x0102096b,   /* RM_EVT_GOTO_IDLE */
    0x0102097c,   /* RM_EVT_SEC_TUNE */
    0x0102098c,   /* RM_EVT_CALLBCK */
};

/* 0x801768: имена состояний rm_ch_switch_sm (описатель 0x80338c). */
FWDATA(801768) const u32 rm_ch_switch_sm_state_names[3] = {
    0x010209b4,   /* IDLE */
    0x010209b9,   /* TURN_OFF */
    0x010209c2,   /* TURN_ON */
};

/* 0x801774: имена событий rm_ch_switch_sm (описатель 0x80338c). */
FWDATA(801774) const u32 rm_ch_switch_sm_event_names[7] = {
    0x010209ca,   /* CH_SWITCH_KICK */
    0x010209d9,   /* FW_TX_CHANNEL_STOPPED */
    0x010209ef,   /* DATA_STOPPED */
    0x010209fc,   /* UCODE_RX_OFF_EVT */
    0x01020a0d,   /* START_TUNE */
    0x01020a18,   /* UCODE_RX_ON_EVT */
    0x01020a28,   /* CH_SWITCH_COMPLETED */
};
