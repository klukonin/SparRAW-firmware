// SPDX-License-Identifier: AGPL-3.0-or-later
/* Статические конструкторы vendor (C++ global ctors).
 *
 * vendor crt0 (0x8c168c) после обнуления bss/periph-областей вызывает 0x8c1d6c →
 * 0x8fc364: 49 объектов-регистраций {prio, ctor, list} (0x8009a8..0x801b2c в fw_data)
 * вставляются в список 0x801b1c (0x8e1174, по возрастанию prio, равные — в порядке
 * регистрации), затем 0x8c1ca0 вызывает ctor каждого — и только потом fw_main.
 * Конструкторы ставят таблицы методов в объекты bss/periph и выводят параметры из
 * переменных fw_data (например, таймаут скана [0x800488] = 4·[0x800484]). Без них
 * эти поля остаются нулями: таймер скана с задержкой 0, вызовы по нулевой vtable.
 *
 * Здесь — те же конструкторы, в том же порядке. Указатели на таблицы методов —
 * адреса в fw_data (их содержимое переносит tools/fw_ptrmap.py), не на код.
 */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/mid.h"
#include "../include/fwq_tx.h"
#include "../include/sysapi_mgr.h"
#include "../include/rf_obj.h"
#include "../include/rf_sets.h"
#include "../include/vring_schd.h"
#include "../include/mbox.h"
#include "../include/rx_ring.h"
#include "../include/calib_engine.h"
#include "../include/stream.h"
#include "../include/link_sm.h"
#include "../include/link_loss.h"
#include "../include/phy_monitor.h"
#include "../include/sched_scheme.h"
#include "../include/conn.h"
#include "../include/rf_kill.h"
#include "../include/fwdata.h"
#include "../include/ieee80211.h"
#include "../include/ctor_reg.h"
#include "../include/fwdata.h"



/* cxx::vec_new (0x8c1700) с флагами 0x402 и готовым буфером: ctor(elem, 0) для каждого. */
static void vec_construct(void *buf, u32 n, u32 stride, void (*ctor)(void *))
{
    for (u32 i = 0; i < n; i++)
        ctor((u8 *)buf + i * stride);
}

/* (0x8c1838) результат оценки калибровки {0, маска 0, число фрагментов -1}. */
static void calib_est_reset(struct calib_est *o)
{
    o->verdict = 0;
    o->rf_mask = 0;
    o->nfrag = 0xffffffffu;
}

/* (0x8ed154) автомат движка калибровки calib_mngr.eng[i]: поле est. */
static void elem_804944_ctor(void *e)
{
    struct calib_engine *eng = e;

    calib_est_reset(&eng->est);
}

/* (0x8ed15c) элемент ll_detectors (8 × 0xa4): детекторы старения TX (таблица методов
 * 0x8008c4) и keep-alive (0x80075c) не привязаны (cid 0xff, ctx 0); детектор биконов —
 * cid 0xff, ctx 0, armed 0 (vendor: stb.a r13,[r0,0x98] сдвигает r0 на +0x98 до двух
 * последних st_s). */
static void elem_854dd4_ctor(void *a)
{
    /* порядок записей — vendor (cid, ctx, vt): volatile, иначе gcc переставляет */
    volatile struct ll_detectors *e = a;
    e->ageing.cid = 0xff;
    e->ageing.ctx = 0;
    e->ageing.svc.vt = &ll_ageing_det_vtbl;
    e->ka.cid = 0xff;
    e->ka.ctx = 0;
    e->ka.svc.vt = &ll_ka_det_vtbl;
    e->bcn.cid = 0xff;
    e->bcn.ctx = 0;
    e->bcn.armed = 0;
}

/* (0x8ed190) элемент массива stream_ctxs 0x847b48 (9 × 0x78): таблица методов 0x800888. */
static void elem_847b48_ctor(void *e)
{
    struct stream_ctx *c = e;

    c->vt = &stream_ctx_vtbl;
}

/* (0x8c187c) базовый ctor brd_if (include/brd_if.h): таблица brd_if_base_vtbl (0x8005c4),
 * список TX-секторов = 0xff, их число 0. Записи — через volatile (как в rf_obj_ctor: иначе
 * gcc переносит их за записи полей rf_obj). */
static void brd_if_base_ctor(volatile struct brd_if *o)
{
    o->vt = &brd_if_base_vtbl;
    memset_fw((void *)o->tx_sectors, 0xff, 0x40);
    o->num_tx_sectors = 0;
}

/* (0x8c180c) brd_if_multi_array: базовый ctor, board-файла нет, таблица brd_if_vtbl (0x8005e4). */
static void brd_if_ctor(volatile struct brd_if *o)
{
    brd_if_base_ctor(o);
    o->data = 0;
    o->size = 0;
    o->valid = 0;
    o->vt = &brd_if_vtbl;
}

/* (0x8c17c0) объект RF rf_obj (include/rf_obj.h): вложенный brd_if, начальные поля.
 * Записи — через volatile (порядок и ширина как у vendor). */
static void rf_obj_ctor(volatile struct rf_obj *o)
{
    brd_if_ctor(&o->brd);
    o->brd_if = 0;
    o->tx_mask = 0;
    o->rx_mask = 0;
    o->rf_mask = 1;
    o->channel = 1;
    o->sector_cfg_idx = 0;
    o->sector_cfg_cnt = 1;
    o->sets_mode = 0;
    o->role_pwr_flag = 0;
    o->omni_rf_mask = 0;
    ((volatile struct fwsh_sets *)&fwsh_sets)->set_ranges = rf_set_ranges;   /* 0x8577b0 */
}

/* (0x8c1864 / 0x8c1870) запрос rf_sector_sel (include/mbox.h): ящика нет, тело — нули. */
static void pair_reset(struct rf_sector_sel_req *o)
{
    o->mbox = 0;
    memset0_words(o->req, 4);
}

/* (0x8f5368 ← 0x8f0000) fw_sysapi_mgr: 0x8f7ffc обнуляет +0..+0x34 кроме +0x14
 * (ampdu_mcs), затем energy (0x2c байт) и plcp_rsp (0x20 байт). Прежний порт не обнулял
 * completion_cb (+0x34) — у vendor st_s r14,[r13,0x34] в 0x8f7ffc есть. */
static void fw_sysapi_mgr_ctor(struct fw_sysapi_mgr *o)
{
    o->request_type = 0;
    memset0_words((void *)&o->ut, 8);
    o->timeout = 0;
    o->timer = 0;
    o->active = 0;
    o->stopped = 0;
    o->status = 0;
    o->tsf_start[0] = 0;
    o->tsf_start[1] = 0;
    o->tsf_stop[0] = 0;
    o->tsf_stop[1] = 0;
    o->completion_cb = 0;
    memset0_words((void *)&o->energy, 0x2c);
    memset0_words(o->plcp_rsp, 0x20);
}

/* (0x8c18bc) */
static void obj_805234_ctor(volatile struct sched_scheme *o)
{
    o->ese = 0;
    o->seq = 0;
    o->built = 0;
    o->mid = 0;
    o->start_acc = 0;
    o->same_cnt = 0;
}

/* (0x8c18a0) */
static void obj_8052e4_ctor(volatile struct ese_sched *o)
{
    o->tbl = &ese_slot_tbl;
    o->cur = 0;
    *(volatile u8 *)&ese_slot_tbl.mode = 0;
    ((volatile struct ese_slot_tbl *)o->tbl)->count = 0;
    ((volatile struct ese_slot_tbl *)o->tbl)->uc_alloc_end = 0;
}

/* Описатели автоматов: ид (переменная fw_data *_sm_name_id) в +off (ctor 0x8c1b20..0x8c1c1c). */
/* То же для описателя-объекта (struct sm_desc в fw_data): ид [0x10] = [var]. */
static void sm_set_id(struct sm_desc *d, const u32 *id)
{
    *(volatile u32 *)&d->id = *(const volatile u32 *)id;   /* volatile: порядок — как у vendor */
}

/* Ниже — сами конструкторы, по одному на vendor-функцию: их адреса стоят в объектах-
 * регистрациях fw_data (поле ctor), fw_ptrmap.py переносит туда наши порты. Список
 * регистраций (0x8c1cc0 / 0x8c1ca0) у нас не исполняется — их по порядку зовёт
 * static_ctors_run. Адреса gp-переменных: короткая форма `ld_s r0,[gp,N]` — смещение в
 * байтах, `.as` — в словах (gp = 0x800184). */

/* (0x8c1934) таблицы методов очередей таймеров u_schd (sched.c). */
void ctor_u_schd_timer_vtables(void)
{
    u_schd_install_timer_vtables();
}

/* (0x8c1ae8) таблица методов операционного ящика 0x8041f0 (+0x44). */
void ctor_operational_mbox_vtable(void)
{
    operational_mbox.wm.vt = &operational_mbox_vtbl;
}

/* (0x8c1aac) таблица методов отладочного ящика 0x843040 (+0x44). */
void ctor_debug_mbox_vtable(void)
{
    debug_mbox.vt = &debug_mbox_vtbl;
}

/* Регистрации конструкторов выше (include/ctor_reg.h; образ vendor — prio 0, список 0;
 * регистрирует 0x8fc364 по адресам ниже). Остальные 39 — дальше в fw_data. */
/* 0x8009a8 */
FWDATA(8009a8) struct ctor_reg ctor_reg_u_schd_timer_vtables = { .ctor = ctor_u_schd_timer_vtables };
/* 0x800bc4 */
FWDATA(800bc4) struct ctor_reg ctor_reg_operational_mbox_vtable = { .ctor = ctor_operational_mbox_vtable };
/* 0x800bd0 */
FWDATA(800bd0) struct ctor_reg ctor_reg_debug_mbox_vtable = { .ctor = ctor_debug_mbox_vtable };

/* (0x8c1a2c) таблица методов ящика ucode lmac_mbox 0x804280 (+0x44; vendor адресует
 * как 0x80426c + 0x58). */
void ctor_obj_80426c_vtable(void)
{
    lmac_mbox.vt = &lmac_mbox_vtbl;
}

/* (0x8c199c) объект RF 0x8042c8 (0x8c17c0, второй аргумент 0). */
void ctor_obj_8042c8(void)
{
    rf_obj_ctor(&rf_obj);
}

/* (0x8c1a0c) два запроса rf_sector_sel: 0x804914 (0x8c1864) и 0x80491c (0x8c1870). */
void ctor_pairs_804914(void)
{
    pair_reset(&rf_sector_sel[RF_SECTOR_SEL_GET]);
    pair_reset(&rf_sector_sel[RF_SECTOR_SEL_SET]);
}

/* (0x8c1a5c) массив движков калибровки calib_mngr.eng (0x804944, 6 × 0x44, ctor 0x8ed154,
 * флаги 0x402). */
void ctor_calib_engines(void)
{
    vec_construct(calib_mngr.eng, CALIB_ENG_NUM, sizeof(struct calib_engine),
                  elem_804944_ctor);
}

/* (0x8c18d4) таблицы методов классов калибровки (в NAMES-EXTRA — boot__install_handler_ptrs):
 * SAR 0x8430b8, VGA 0x8430e0, IF gain 0x843108, LO leakage 0x843130, ctor silent_rssi 0x804b5c
 * (0x8f0004, второй аргумент 0), LO power 0x847ae4. */
void ctor_calib_classes(void)
{
    calib_sar_obj.vt = &calib_sar_vtbl;
    calib_vga_obj.vt = &calib_vga_vtbl;
    calib_if_gain_obj.vt = &calib_if_gain_vtbl;
    calib_lo_leakage_obj.vt = &calib_lo_leakage_vtbl;
    calib_silent_rssi_ctor(&calib_silent_rssi_obj);
    calib_lo_power_obj.base.vt = &calib_lo_power_vtbl;
}

/* (0x8c1b44) ид автомата движка калибровки 0x802234 ([gp,-44] = 0x800158). */
void ctor_sm_802234_id(void)
{
    sm_set_id(&calib_engine_sm_desc, &calib_engine_sm_name_id);
}

/* (0x8c1bec) ид автомата rf_mgmt_sm 0x802338 ([gp,52] = 0x8001b8). */
void ctor_sm_802338_id(void)
{
    sm_set_id(&rf_mgmt_sm_desc, &rf_kill_sm_name_id);
}

/* (0x8c19ec) таблицы методов vring_schd (0x804dbc) и его варианта (0x804e64). */
void ctor_obj_804dbc_vtables(void)
{
    vring_schd.base.vt = &vring_schd_vtbl;
    vring_schd_alt.base.vt = &vring_schd_alt_vtbl;
}

/* (0x8c1abc) массив 0x854dd4 (8 × 0xa4, ctor 0x8ed15c, флаги 0x402). */
void ctor_array_854dd4(void)
{
    vec_construct(ll_detectors, 8, sizeof(struct ll_detectors), elem_854dd4_ctor);
}

/* (0x8c1ad4) таблица методов объекта discovery записи mid 0x804e90 (+0x234, st.as [r1,141]). */
void ctor_obj_804e90_vtable(void)
{
    ((volatile struct mid_disc *)&mid_recs[0].disc)->vt = &mid_disc_vtbl;
}

/* (0x8c1c28) массив 0x847b48 (9 × 0x78, ctor 0x8ed190, флаги 0x402). */
void ctor_array_847b48(void)
{
    vec_construct(stream_ctxs, STREAM_CTX_N, sizeof(struct stream_ctx), elem_847b48_ctor);
}

/* (0x8c1ba4) ид автомата mlme_sm 0x802458 ([gp,56] = 0x8001bc). */
void ctor_sm_802458_id(void)
{
    sm_set_id(&mlme_sm_desc, &mlme_sm_name_id);
}

/* (0x8c1b5c) ид автомата conn_main_sm 0x802744 (vendor: 0x802754 + 0, [gp,60] = 0x8001c0). */
void ctor_sm_802754_id(void)
{
    sm_set_id(&conn_msm_desc, &conn_msm_name_id);
}

/* (0x8c1b50) ид автомата разрыва conn_disc_sm 0x8027a0 (vendor: таблица 0x802758 + 0x58, [gp,64] = 0x8001c4). */
void ctor_sm_802758_id(void)
{
    sm_set_id(&conn_disc_sm_desc, &disconn_sm_name_id);
}

/* (0x8c196c) fw_sysapi_mgr 0x805170 (0x8f0000) и obj::store3 (0x8c17b4 → 0x8d8fdc):
 * LUT RSSI → SNR (0x8051f8) = {ключи 0x801170, значения 0x801230, 0x30}
 * (rssi_snr_lut_keys / rssi_snr_lut_vals). */
void ctor_obj_805170(void)
{
    struct sysapi_lut *l = &fw_sysapi_mgr.rssi_snr_lut;

    fw_sysapi_mgr_ctor(&fw_sysapi_mgr);
    l->keys = rssi_snr_lut_keys;
    l->vals = (const u32 *)rssi_snr_lut_vals;
    l->n = RSSI_SNR_LUT_N;
}

/* (0x8c1b2c) ид автомата 0x802940 (поле +0x3c, [gp,68] = 0x8001c8). */
void ctor_sm_802940_id(void)
{
    sm_set_id(&stream_sm_desc, &ba_sm_name_id);
}

/* (0x8c1b20) ид автомата 0x802b08 (поле +0x58, [gp,72] = 0x8001cc). */
void ctor_sm_802b08_id(void)
{
    sm_set_id(&ba_setup_sm_desc, &ba_setup_sm_name_id);
}

/* (0x8c1b38) ид автомата 0x802b64 (поле +0x4c, [gp,76] = 0x8001d0). */
void ctor_sm_802b64_id(void)
{
    sm_set_id(&wait_sm_desc, &wait_sm_name_id);
}

/* (0x8c19b8) таблицы методов 0x842840 / 0x842844. */
void ctor_obj_842840_vtables(void)
{
    /* volatile: две записи подряд — порядок и ширина как у vendor */
    ((volatile struct rx_pkt_srvs *)&rx_pkt_srvs)->vt = &rx_pkt_srvs_vtbl;
    ((volatile struct rx_pkt_srvs *)&rx_pkt_srvs)->vt2 = &rx_pkt_srvs_vtbl2;
}

/* (0x8c1928) [0x8002f0] = 0x8006f4 (st.as [gp,91]). */
void ctor_g8002f0_vtable(void)
{
    eapol_builder_obj = (u32)&eapol_builder_vtbl;
}

/* (0x8c1c5c) объект 0x805234 (0x8c18bc). */
void ctor_obj_805234(void)
{
    obj_805234_ctor(&sched_scheme);
}

/* (0x8c1b98) ид автомата 0x802cc4 ([gp,-40] = 0x80015c). */
void ctor_sm_802cc4_id(void)
{
    sm_set_id(&maintain_sm_desc, &maintain_sm_name_id);
}

/* (0x8c1b8c) ид автомата 0x802da0 ([gp,-36] = 0x800160). */
void ctor_sm_802da0_id(void)
{
    sm_set_id(&lm_sm_desc, &lm_sm_name_id);
}

/* (0x8c1b80) ид автомата 0x802f58 ([gp,-32] = 0x800164). */
void ctor_sm_802f58_id(void)
{
    sm_set_id(&link_stats_sm_desc, &link_stats_sm_name_id);
}

/* (0x8c1c40) объект 0x8052e4 (0x8c18a0). */
void ctor_obj_8052e4(void)
{
    obj_8052e4_ctor(&ese_sched);
}

/* (0x8c1c68) swc_psc_sm 0x8054bc = scan_mngr записи mid 0 + 0x1d0 (0x8c179c, scan.c). */
void ctor_swc_psc_sm(void)
{
    swc_psc_sm_ctor(&scan_mngrs[0].swc);
}

/* (0x8c19d0) таймаут скана [0x800488] = 4·[0x800484] (add1 + add_s) и ид автомата
 * channels_switch_sm 0x802fb4 ([gp,20] .as = 0x8001d4). */
void ctor_scan_timeout_and_sm_802fb4(void)
{
    scan_timeout = scan_alloc_timeout * 4;
    sm_set_id(&channels_switch_sm_desc, &channels_switch_sm_name_id);
}

/* (0x8c1c1c) ид автомата 0x8030e0 ([gp,84] = 0x8001d8). */
void ctor_sm_8030e0_id(void)
{
    sm_set_id(&swc_psc_sm_desc, &swc_psc_sm_name_id);
}

/* (0x8c1b68) ид автомата 0x8030f4 ([gp,88] = 0x8001dc). */
void ctor_sm_8030f4_id(void)
{
    sm_set_id(&find_sm_desc, &find_main_sm_name_id);
}

/* (0x8c1a74) таблицы методов трёх очередей TX_API (кольцо, повторы, сама очередь). Vendor
 * адресует tx_api_mgmt и tx_api_2 от списка ждущих 0x842148 (+0xc и +0x9c), порядок записей
 * — как у vendor. */
void ctor_fwq_tx_vtables(void)
{
    tx_api_data.ring.vt = &tx_ring_vtbl;
    tx_api_data.retry_obj.vt = &tx_retry_vtbl;
    tx_api_data.vt = &fwq_tx_vtbl;
    tx_api_2.ring.vt = &tx_ring_vtbl;
    tx_api_2.retry_obj.vt = &tx_retry_vtbl;
    tx_api_2.vt = &fwq_tx_vtbl;
    tx_api_mgmt.ring.vt = &tx_ring_vtbl;
    tx_api_mgmt.retry_obj.vt = &tx_retry_vtbl;
    tx_api_mgmt.vt = &fwq_tx_vtbl;
}

/* (0x8c1a4c) таблица методов RX-кольца rx_ring 0x805fe4 (include/rx_ring.h). */
void ctor_obj_805fe4_vtable(void)
{
    rx_ring.vt = &rx_ring_vtbl;
}

/* (0x8c19a8) таблица методов монитора PHY 0x84e7e0 (0x8007a0). */
void ctor_obj_84e7e0_vtable(void)
{
    phy_monitor.svc.vt = &phy_monitor_vtbl.psvc;
}



/* (0x8c1c4c) таблица методов объекта LO power полной калибровки (0x80676c + 0x24). */
void ctor_obj_80676c_vtable(void)
{
    calib_all_lo_power_obj.base.vt = &calib_lo_power_vtbl;
}

/* (0x8c191c) пустой (r0 = 0x8005b8, переход на j_s [blink] 0x8c1d68), prio 0x80. */
void ctor_empty_8005b8(void)
{
}

/* radio_mgr.c: (0x8c1a3c), (0x8c1c04), (0x8c1bf8). */

/* (0x8fc364 + 0x8c1ca0) все конструкторы в порядке vendor-регистрации. */
void static_ctors_run(void)
{
    ctor_u_schd_timer_vtables();
    /* ctor_sm_801ca8_id (ид автомата питания PCIe) — автомат вырезан */
    ctor_operational_mbox_vtable();
    ctor_debug_mbox_vtable();
    ctor_obj_80426c_vtable();
    ctor_obj_8042c8();
    ctor_pairs_804914();
    ctor_calib_engines();
    ctor_calib_classes();
    ctor_sm_802234_id();
    ctor_sm_802338_id();
    ctor_obj_804dbc_vtables();
    ctor_array_854dd4();
    ctor_obj_804e90_vtable();
    ctor_array_847b48();
    ctor_sm_802458_id();
    ctor_sm_802754_id();
    ctor_sm_802758_id();
    ctor_obj_805170();
    ctor_sm_802940_id();
    ctor_sm_802b08_id();
    ctor_sm_802b64_id();
    ctor_obj_842840_vtables();
    ctor_g8002f0_vtable();
    ctor_obj_805234();
    ctor_sm_802cc4_id();
    ctor_sm_802da0_id();
    ctor_sm_802f58_id();
    ctor_obj_8052e4();
    ctor_swc_psc_sm();
    ctor_scan_timeout_and_sm_802fb4();
    ctor_sm_8030e0_id();
    ctor_sm_8030f4_id();
    ctor_fwq_tx_vtables();
    ctor_obj_805fe4_vtable();
    radio_mgr_install_vtable();
    rm_sm_desc_set_id();
    rm_ch_switch_sm_desc_set_id();
    ctor_obj_84e7e0_vtable();
    ctor_obj_80676c_vtable();
    ctor_empty_8005b8();
}

/* ======================= регистрации конструкторов (fw_data) ======================= */

/* Объект-регистрация статического конструктора vendor (0xc Б): crt0 → 0x8fc364 передаёт
 * адрес каждой в list__insert_obj (0x8c1cc0): номер списка — байт [+8] (в образе 0),
 * вставка по возрастанию prio в список 0x801b1c (0x8e1174) пишет в [+8] следующую
 * регистрацию; 0x8c1ca0 зовёт ctor каждой. У нас список не строится (static_ctors_run
 * зовёт конструкторы по порядку) — регистрации остаются данными образа, как у vendor. */
/* struct ctor_reg — include/ctor_reg.h. */
#define CTOR_REG(addr, prio, fn) FWDATA(addr) const struct ctor_reg creg_##fn = { prio, fn, 0 }

/* 0x800c10..0x801b2c: регистрации в порядке вызовов 0x8fc364 (хвост списка из 49). */
CTOR_REG(800c10, 0x0, ctor_obj_80426c_vtable);                  /* vendor 0x8c1a2c */
CTOR_REG(800c1c, 0x0, ctor_obj_8042c8);                         /* vendor 0x8c199c */
CTOR_REG(800c28, 0x0, ctor_pairs_804914);                       /* vendor 0x8c1a0c */
CTOR_REG(800c58, 0x0, ctor_calib_engines);                      /* vendor 0x8c1a5c */
CTOR_REG(800dbc, 0x0, ctor_calib_classes);                      /* vendor 0x8c18d4 */
CTOR_REG(800e20, 0x0, ctor_sm_802234_id);                       /* vendor 0x8c1b44 */
CTOR_REG(80100c, 0x0, ctor_sm_802338_id);                       /* vendor 0x8c1bec */
CTOR_REG(801018, 0x0, ctor_obj_804dbc_vtables);                 /* vendor 0x8c19ec */
CTOR_REG(801024, 0x0, ctor_array_854dd4);                       /* vendor 0x8c1abc */
CTOR_REG(801030, 0x0, ctor_obj_804e90_vtable);                  /* vendor 0x8c1ad4 */
CTOR_REG(80106c, 0x0, ctor_array_847b48);                       /* vendor 0x8c1c28 */
CTOR_REG(8010bc, 0x0, ctor_sm_802458_id);                       /* vendor 0x8c1ba4 */
CTOR_REG(801118, 0x0, ctor_sm_802754_id);                       /* vendor 0x8c1b5c */
CTOR_REG(801140, 0x0, ctor_sm_802758_id);                       /* vendor 0x8c1b50 */
CTOR_REG(80130c, 0x0, ctor_obj_805170);                         /* vendor 0x8c196c */
CTOR_REG(80135c, 0x0, ctor_sm_802940_id);                       /* vendor 0x8c1b2c */
CTOR_REG(8013b8, 0x0, ctor_sm_802b08_id);                       /* vendor 0x8c1b20 */
CTOR_REG(8013e0, 0x0, ctor_sm_802b64_id);                       /* vendor 0x8c1b38 */
CTOR_REG(8013ec, 0x0, ctor_obj_842840_vtables);                 /* vendor 0x8c19b8 */
CTOR_REG(8013f8, 0x0, ctor_g8002f0_vtable);                     /* vendor 0x8c1928 */
CTOR_REG(801404, 0x0, ctor_obj_805234);                         /* vendor 0x8c1c5c */
CTOR_REG(8014a4, 0x0, ctor_sm_802cc4_id);                       /* vendor 0x8c1b98 */
CTOR_REG(80150c, 0x0, ctor_sm_802da0_id);                       /* vendor 0x8c1b8c */
CTOR_REG(8015e4, 0x0, ctor_sm_802f58_id);                       /* vendor 0x8c1b80 */
CTOR_REG(8015f0, 0x0, ctor_obj_8052e4);                         /* vendor 0x8c1c40 */
CTOR_REG(8015fc, 0x0, ctor_swc_psc_sm);                         /* vendor 0x8c1c68 */
CTOR_REG(801644, 0x0, ctor_scan_timeout_and_sm_802fb4);         /* vendor 0x8c19d0 */
CTOR_REG(8016a8, 0x0, ctor_sm_8030e0_id);                       /* vendor 0x8c1c1c */
CTOR_REG(8016e4, 0x0, ctor_sm_8030f4_id);                       /* vendor 0x8c1b68 */
CTOR_REG(8016f0, 0x0, ctor_fwq_tx_vtables);                     /* vendor 0x8c1a74 */
CTOR_REG(8016fc, 0x0, ctor_obj_805fe4_vtable);                  /* vendor 0x8c1a4c */
CTOR_REG(801708, 0x0, radio_mgr_install_vtable);                /* vendor 0x8c1a3c */
CTOR_REG(80175c, 0x0, rm_sm_desc_set_id);                       /* vendor 0x8c1c04 */
CTOR_REG(801790, 0x0, rm_ch_switch_sm_desc_set_id);             /* vendor 0x8c1bf8 */
CTOR_REG(80179c, 0x0, ctor_obj_84e7e0_vtable);                  /* vendor 0x8c19a8 */
CTOR_REG(801924, 0x0, ctor_obj_80676c_vtable);                  /* vendor 0x8c1c4c */
CTOR_REG(801b2c, 0x80, ctor_empty_8005b8);                       /* vendor 0x8c191c */
