// SPDX-License-Identifier: AGPL-3.0-or-later
/* Обработчики WMI-команд хоста: отладочные/прочие (диспетчер
 * wmi__host_cmd_dispatch 0x8de43c, fw/wmi_cmd.c; таблица — docs/WMI-DISPATCH.md).
 * Сильные определения вместо слабых заглушек fw/wmi_handlers_todo.c, сигнатуры —
 * include/wmi_handlers.h.
 *
 *   0x0042 PXMT_RANGE_CFG   wmi_pxmt_range_cfg               (0x8ec9d0)
 *   0x0804 DEEP_ECHO        wmi_deep_echo                    (0x8c87a4)
 *   0x0808 ADD_DEBUG_TX     wmi_add_debug_tx_pckt            (0x8e55ac)
 *   0x0853 RF_MGMT          low_sme_wmi_rf_mgmt_cmd_handler  (0x8ec9e8)
 *   0x0856 RF_XPM_READ      host_if_read_rf_xpm              (0x8e363c)
 *   0x0857 RF_XPM_WRITE     host_if_write_rf_xpm             (0x8e36cc) + цепочка записи XPM
 *   0x085d RF_PWR_ON_DELAY  wmi_rf_pwr_on_delay              (0x8e6e40)
 *   0x0fff (отладка vendor, бесконечная «пила» дробной частоты синтезатора — не перенесена: вешала диспетчер WMI)
 *   0xf04f PMC              wmi_pmc                          (0x8fb738)
 * и модули WMI_UNIT_TEST (0x900, диспетчер — wmi.c:wmi_ut_handler): calib_mgr_ut (7),
 * (power_mgr_ut, модуль 13 — PS вырезан).
 *
 * TOF/FTM/AoA (WMI 0x923, 0x991..0x999) — только SparRAW-pro. */
#include "../include/types.h"
#include "../include/arc.h"
#include "../include/rf_kill.h"
#include "../include/mid.h"
#include "../include/hw.h"
#include "../include/wmi_handlers.h"
#include "../include/mbox.h"
#include "../include/conn.h"
#include "../include/lmac_cmd.h"
#include "../include/fwdata.h"

/* otp.c */
/* calib_engine.c / radio_mgr.c */



static inline void *caller(void) { return __builtin_return_address(0); }

/* =========================== отладка / прочее =========================== */

/* wmi_deep_echo (0x8c87a4, 26 Б): LMAC-команда 2 {value} (4 Б) — эхо через ucode.
 * obj не используется. */
void wmi_deep_echo(struct wmi_mbox *mb, u32 value)
{
    struct lmac_cmd_echo *b;

    (void)mb;
    b = lmac_cmd_pool_alloc();
    b->value = value;
    lmac_if_post_cmd(b, 2, 4, 0);
}

/* wmi_add_debug_tx_pckt (0x8e55ac, 114 Б): отладочная передача кадра данных: буфер TX,
 * соединение с cid [body+4] в MID mid; нет — журнал. Иначе флаг g_fw_2_fw_test
 * ([gp+0x1e4] = 0x800368, st.as [gp,121]) = 1 и TX_API__send_packet(conn, 0, 2, буфер,
 * len = u16 [body], retry = u16 [body+8], [body+0x14], [body+0x15], [body+0xc], 0, 0).
 * Vendor-утечка: буфер TX_API__alloc_tx_payload берётся ДО поиска соединения и при
 * «No CID» не освобождался (0x8e55b6 → 0x8e55d0..0x8e55de: free нет) — исправлено. */
void wmi_add_debug_tx_pckt(const struct wmi_add_debug_tx_pckt_cmd *cmd, u32 mid)
{
    u32 pl = TX_API_alloc_tx_payload();
    struct conn *conn = ie_list_first(mid_list_by_mid_fw(mid), cmd->cid);

    if (conn == 0) {
        fw_log_emit1(0x27, 0x100ba78, cmd->cid);   /* "CMD TX DATA failed - No CID found..." */
        TX_API_free_memory(pl);                     /* vendor не освобождал — утечка элемента TX-пула */
        return;
    }
    tx_fw2fw_test = 1;
    fw_log_emit2(0x27, 0x100baa8, cmd->len32, 1);          /* "CMD TX DATA of %d bytes g_fw_2_fw_test = %d." */
    tx_api_send_packet(conn, 0, 2, pl, cmd->len, cmd->retry_limit, cmd->a6, cmd->a7,
                       cmd->a8, 0, 0);
}

/* wmi_rf_pwr_on_delay (0x8e6e40, 74 Б): задержки включения RF — u16 [0x8004c6] = [body],
 * u16 [0x8004c8] = [body+2]; ответ 0x185d {status 0} (4 Б).
 * vendor пишет только байт 0 ответа (stb_s r2,[r1,0] на 0x8e6e6a), байты 1..3 (reserved) у
 * vendor — остаток слота пула; у нас нули (mem_pool_alloc_locked обнуляет). */
void wmi_rf_pwr_on_delay(struct wmi_mbox *mb, const struct wmi_rf_pwr_on_delay_cmd *cmd, u32 mid)
{
    struct wmi_status_event *e = mem_pool_alloc_locked(&mb->mb);

    rf_pwr_on_extra_delay = cmd->up_delay_usec;
    rf_pwr_on_hold = cmd->down_delay_usec;
    e->status = 0;
    wmi_evt_post(mb, e, 0, 0x185d, sizeof(*e), mid, 0, 0);
}

/* wmi_pxmt_range_cfg (0x8ec9d0, 22 Б): только поиск пира по MAC [body] в MID mid
 * (mid_list__find_by); результат отбрасывается, ответа нет — как у vendor. */
void wmi_pxmt_range_cfg(const u8 *body, u32 mid)
{
    mid_list_find_by(mid_list_by_mid_fw(mid), body);
}

/* low_sme::wmi_rf_mgmt_cmd_handler (0x8ec9e8, 84 Б): rf_mgmt_type [body]: 0 — событие
 * W_DISABLE (1) автомату rf_mgmt_sm с аргументом 1 (программный kill), 1 — W_ENABLE (0)
 * с аргументом 1, 2 — только статус хосту (WMI 0x1853); иное — ассерт 0x107c. */
void low_sme_wmi_rf_mgmt_cmd_handler(const struct wmi_rf_mgmt_cmd *cmd)
{
    u32 t = cmd->rf_mgmt_type;

    fw_log_emit1(0x20, 0x100b79c, t);   /* "low_sme::wmi_rf_mgmt_cmd_handler (cmd->rf_mgmt_type=%d)" */
    switch (t) {
    case 0:
        basic_sm_handle_event(&rf_mgmt_sm, 1, 1, 0, 0);
        break;
    case 1:
        basic_sm_handle_event(&rf_mgmt_sm, 0, 1, 0, 0);
        break;
    case 2:
        low_sme_send_rf_mgmt_status();
        break;
    default:
        fw_sysassert_fatal(caller(), 0x107c);
        break;
    }
}

/* dma_reset (0x8d0970, 46 Б): журнал и сброс очереди дескрипторов q: слово
 * ((q·896 + 0x4409700) >> 3) & ~3 = 1. */
static void dma_reset(u32 q)
{
    fw_log_emit1(0x10, 0x101d4d0, q);   /* "dma_reset(DO.clr_all) call for descq %d" */
    MMIO32(((q * 896u + 0x4409700u) >> 3) & ~3u) = 1;
}

/* dma_mgr__reset_queue (0x8e7f6c, 40 Б): только очередь 7 (PMC), иначе ассерт 0x1501
 * (после него — всё равно сброс). */
static void dma_mgr_reset_queue(u32 q)
{
    if (q != 7)
        fw_sysassert_fatal(caller(), 0x1501);
    hwd_dma_reset_ring(q);
    dma_reset(q);
}

/* wmi_pmc (0x8fb738, 66 Б): op [body]: 0 — кольцо PMC (DMA 7) по хостовой памяти
 * mem_base (u64 [body+4]) размером ring_size (u16 [body+2]); 1 — сброс очереди 7;
 * иное — журнал «Illegal pmc op». Ответа нет. */
void wmi_pmc(const struct wmi_pmc_cmd *cmd)
{
    u32 op = cmd->op;

    if (op == 0)
        dma_mgr_configure_ring(7, cmd->mem_base[0], cmd->mem_base[1], cmd->ring_size,
                               0, 0, 0, 0);
    else if (op == 1)
        dma_mgr_reset_queue(7);
    else
        fw_log_emit1(0xb, 0x100e23c, op);   /* "Illegal pmc op: 0x%08X" */
}

/* =========================== RF XPM (OTP RF-модуля) =========================== */
/* Чтение — цепочка otp.c (hwf_rf_xpm_read_block 0x8f4b70). Запись (только 0x857):
 * hwf_rf_xpm_write_block (0x8f4a30) → hwf_rf_xpm_program_byte (0x8f4ab0) →
 * hwf_rf_xpm_program_bit (0x8f49d4) → rfc__write_core_c_flag (0x8d460c) +
 * hwd_rfc_xpm_get_write_status (0x8d4564). XPM — однократно программируемая память:
 * прожигаются только единичные биты байта, проверки входа (rf_id, диапазон бит,
 * num_bytes) — как у vendor, без ослаблений. NAMES-EXTRA: 0x8f4a30 ошибочно
 * «hwf_rf_xpm_read_block», 0x8f49d4 — «hwf_rf_xpm_program_byte» (его строка журнала —
 * от вызывающего); по телу это запись блока и прожиг одного бита. */

/* rfc__write_core_c_flag (0x8d460c, 50 Б): команда 0xc RFC-ядру — слово
 * ([0x803918] & ~0x3ffff) | бит 16 (прожиг) | (flag & 1) << 17 | u16 bit_addr
 * (чтение — тот же код 0xc без бита 16, otp.c:hwd_rfc_xpm_read_cmd). */
static void rfc_write_core_c_flag(u32 rf, u32 bit_addr, u32 flag)
{
    u32 w = (rfc_core_c_cmd_tmpl & 0xffff0000u) | (u16)bit_addr;   /* push [0x803918]; sth bit,[sp] */

    w &= ~(3u << 16);
    w |= 1u << 16;
    hwd_rfc_write_core_fw((u8)rf, 0xc, 0, ((flag & 1u) << 17) | w);
}

/* hwd_rfc_xpm_get_write_status (0x8d4564, 92 Б): итог прожига. wait != 0 — опрос выхода
 * RFC (до 4000 итераций, otp.c); wait == 0 — пауза 1600 × 2 nop и «готово». Успех —
 * готово и байт выхода 0; иначе журнал, 0.
 * ХРУПКО: пауза vendor — lp (lp_count = 1600) из 2 nop_s ≈ 3200 тактов (0x8d4584..
 * 0x8d4596); здесь та же форма arc_zol_nops2 — такты = vendor. Только она отделяет прожиг бита
 * от следующей команды RFC при wait = 0 (так зовёт 0x857): укорачивать нельзя. */
static u32 hwd_rfc_xpm_get_write_status(u32 rf, u32 wait)
{
    u8 out = 0;
    u32 done, ok = 0;

    if (wait != 0) {
        done = hwd_rfc_xpm_get_data_output((u8)rf, &out, wait, 0x7d << 5);
    } else {
        arc_zol_nops2(1600);
        done = 1;
    }
    if (done != 0 && out == 0)
        ok = 1;
    if (ok == 0)
        fw_log_emit2(0, 0x101e978, done, out);   /* "...XPM bit programming failure detected. is_completed=%d, data_output=0x%x" */
    return ok;
}

/* hwf_rf_xpm_program_bit (0x8f49d4, 92 Б): прожечь бит bit_addr, до trials попыток
 * (проверка входа с ассертами). 1 — успех. */
u32 hwf_rf_xpm_program_bit(u32 rf, u32 bit_addr, u32 wait, u32 trials)
{
    u32 n, trial = 1;

    if (xpm_byte_check_inputs(rf, bit_addr, 1) != 1)
        return 0;
    for (n = trials; n >= 1; n--, trial++) {      /* brlo r17,1 → 0; brhs.d r14,1 */
        rfc_write_core_c_flag(rf, bit_addr, 1);
        if (hwd_rfc_xpm_get_write_status(rf, wait) != 0)
            return 1;
        fw_log_emit3(0, 0x101b7fc, bit_addr, trial, trials);   /* "...XPM bit program failed ..., trial %d of %d" */
    }
    return 0;
}

/* hwf_rf_xpm_program_byte (0x8f4ab0, 192 Б): прожечь единичные биты val в байт
 * bit_addr & ~7 (bit_addr — битовый адрес); verify — перечитать байт и сравнить. */
u32 hwf_rf_xpm_program_byte(u32 rf, u32 bit_addr, u32 val, u32 wait, u32 trials,
                                   u32 verify)
{
    u32 base, i;
    u8 rd;

    fw_log_emit3(0x20, 0x101b858, bit_addr, val, trials);   /* "Start XPM byte programming: ..." */
    if (xpm_byte_check_inputs(rf, bit_addr, 1) != 1)
        return 0;
    base = bit_addr & ~7u;
    for (i = 0; i < 8; i = (u8)(i + 1)) {
        if (!((val >> i) & 1u))                          /* bbit0 r13,r14 */
            continue;
        if (hwf_rf_xpm_program_bit(rf, base + i, wait, trials) == 0) {
            fw_log_emit3(0, 0x101b8c4, i, val, base + i);   /* "XPM failed to program bit# %d ..." */
            return 0;
        }
    }
    if (verify == 0)
        return 1;
    rd = 0;
    if (hwf_rf_xpm_read_byte(rf, base, &rd) == 0) {
        fw_log_emit1(0, 0x101b9a4, base);                /* "...Verification failed due to XPM readout failure ..." */
        return 0;
    }
    if (val != rd) {
        fw_log_emit3(0, 0x101b928, base, val, rd);       /* "XPM Byte Write Verification failed ..." */
        return 0;
    }
    return 1;
}

/* hwf_rf_xpm_write_block (0x8f4a30, 126 Б): len байт src в XPM с битового адреса
 * addr & ~7 (байт i — addr + 8·i). Проверка входа с ассертами, max = len. 1 — успех. */
u32 hwf_rf_xpm_write_block(u32 rf, u32 addr, u32 len, const u8 *src, u32 wait,
                                  u32 trials, u32 verify)
{
    u32 i, a;

    if (xpm_block_check_inputs(rf, addr, len, src, len, 1) != 1)
        return 0;
    addr &= ~7u;
    for (i = 0; i < len; i++) {
        a = addr + (i << 3);                             /* add3 r13,r18,r14 */
        if (hwf_rf_xpm_program_byte(rf, a, src[i], wait, trials, verify) == 0) {
            fw_log_emit3(0, 0x101ba14, a, i, len);       /* "XPM failed to program byte at ..." */
            return 0;
        }
    }
    return 1;
}

/* host_if::read_rf_xpm_handler (0x8e363c, 144 Б): WMI_RF_XPM_READ {rf_id, xpm_bit_address,
 * num_bytes} → 0x1856 {status, data[num_bytes]}: проверка входа без ассертов (max —
 * размер элемента пула событий [obj+0x74] − 4), чтение. status 1 — ошибка (журнал).
 * Длина ответа — extw(num_bytes + 4) ВСЕГДА, и при провале проверки.
 * ХРУПКО (vendor, 0x8e36a0..0x8e36aa): при num_bytes > [obj+0x74] − 4 проверка не
 * проходит, но событие уходит с длиной num_bytes + 4 — больше элемента пула (хосту
 * уходит чужая память за элементом). Длина оставлена как у vendor (часть протокола), стенд
 * не проверял. При ошибке data у vendor — остаток слота пула, у нас нули (mem_pool_alloc_locked обнуляет). */
void host_if_read_rf_xpm(struct wmi_mbox *mb, const struct wmi_rf_xpm_read_cmd *cmd)
{
    struct wmi_rf_xpm_read_result_event *e = mem_pool_alloc_locked(&mb->mb);
    u32 rf = cmd->rf_id;
    u32 addr = cmd->xpm_bit_address;

    e->status = 1;
    /* исправлено (vendor): предел данных был tx_entry_size − 4 — без заголовка элемента пула (mbox_hdr), num_bytes
     * 237..252 писал за элемент (затирал звено free-list соседнего, дальше — произвольная запись при выделении). */
    if (xpm_block_check_inputs(rf, addr, cmd->num_bytes, e->data_bytes,
                               ((volatile struct wmi_mbox *)mb)->tx_entry_size - sizeof(struct mbox_hdr)
                               - __builtin_offsetof(struct wmi_rf_xpm_read_result_event, data_bytes), 0) == 1
        && hwf_rf_xpm_read_block(cmd->rf_id, addr, cmd->num_bytes, e->data_bytes) == 1)
        e->status = 0;
    if (e->status != 0)
        fw_log_emit3(0, 0x1006134, cmd->rf_id, cmd->xpm_bit_address, cmd->num_bytes); /* "XPM read failed. ..." */
    /* исправлено (vendor): при отказе проверки длина события всё равно num_bytes + 4 — больше элемента пула,
     * хосту уходила память fw за элементом. При отказе — только статус. */
    wmi_evt_post(mb, e, 0, 0x1856, (u16)(e->status == 0 ? cmd->num_bytes + 4 : 4), 0, 0, 0);
}

/* host_if::write_rf_xpm_handler (0x8e36cc, 152 Б): WMI_RF_XPM_WRITE {rf_id,
 * xpm_bit_address, num_bytes, verify, data[]} (данные с +0x10) → 0x1857 {status} (1 Б).
 * Сначала проверка входа без ассертов (max — размер элемента пула команд [obj+0x70] −
 * 0x10), затем запись блока: wait 0, до 0x12 попыток на бит, verify [body+0xc]. */
void host_if_write_rf_xpm(struct wmi_mbox *mb, const struct wmi_rf_xpm_write_cmd *cmd)
{
    struct wmi_status_event *e = mem_pool_alloc_locked(&mb->mb);
    const u8 *data = cmd->data_bytes;

    e->status = 1;
    if (xpm_block_check_inputs(cmd->rf_id, cmd->xpm_bit_address, cmd->num_bytes, data,
                               ((volatile struct wmi_mbox *)mb)->rx_entry_size - 0x10, 0) == 1
        && hwf_rf_xpm_write_block(cmd->rf_id, cmd->xpm_bit_address, cmd->num_bytes, data, 0, 0x12,
                                  cmd->verify) == 1)
        e->status = 0;
    if (e->status != 0)
        fw_log_emit3(0, 0x1006194, cmd->rf_id, cmd->xpm_bit_address, cmd->num_bytes); /* "XPM write failed. ..." */
    wmi_evt_post(mb, e, 0, 0x1857, 1, 0, 0, 0);
}

/* =========================== WMI_UNIT_TEST: модули =========================== */

/* calib_mgr_ut (0x8eadb8, 90 Б): модуль 7. sub 0 — смена системного состояния
 * calib-менеджера (st [b+4], канал [b+8], при st = 1 — канал − 1); sub 1 — запуск движка
 * {idx, mask, periodic, nfrag, u16 pause [b+0x14]}; иное — ассерт 0x108f. */
void calib_mgr_ut(const struct wmi_ut_cmd *c)
{
    u32 sub = c->subtype_id;

    fw_log_emit1(0x26, 0x100939c, sub);   /* "calib_mgr_ut handler (subtype = %d)" */
    if (sub == 0) {
        u32 st = c->place_holder[0], ch = c->place_holder[1];
        calib_mngr_system_state_evt_handler(st, st == 1 ? ch - 1 : ch);
    } else if (sub == 1) {
        /* {idx, mask, periodic, nfrag, u16 pause} */
        calib_mngr_engine_start(c->place_holder[0], c->place_holder[1],
                                c->place_holder[2], c->place_holder[3],
                                c->place_holder16[8], 0, 0, 0);   /* ldh [b+0x14] */
    } else {
        fw_sysassert_fatal(caller(), 0x108f);
    }
}
