// SPDX-License-Identifier: AGPL-3.0-or-later
/* l2_mgr: ключ соединения в pring-и, колбэк radio_mgr при
 * потере связи и флаги PCIe-блоков, которые они дёргают (вызовы — из lmac_evt.c).
 *
 * Переменные fw_data (gp = 0x800184):
 *   [gp-0x48] 0x80013c — заявка radio_mgr на обработку потери связи (lmac_evt.c);
 *   [gp-0xa8] 0x8000dc — таймер проверки частоты ложных тревог (0x8f1980);
 *   [gp+0x1ec] 0x800370 — счётчик ложных тревог (потерь связи);
 *   [gp+0x1f0] 0x800374 — длительность последнего захвата радио (мкс×16);
 *   [gp+0xd4] 0x800258 — байт mid событий хосту. */
#include "../include/types.h"
#include "../include/power.h"
#include "../include/hw.h"
#include "../include/radio_mgr.h"
#include "../include/conn.h"



#define LL_RM_REQ        conn_link_lost_rm_req    /* [gp-0x48] */
#define FALSE_ALARM_TMR  conn_false_alarm_timer    /* [gp-0xa8] */
#define FALSE_ALARM_CNT  l2_false_alarm_count    /* [gp+0x1ec] */
#define LL_RADIO_TIME    l2_false_alarm_lock_time    /* [gp+0x1f0] */

/* l2mgr__apply_key_to_prings (0x8fa7f8, 32 Б): переустановить ключ во всех стримах
 * соединения (флаг 0) и событие 5 автомату соединения. */
void l2mgr_apply_key_to_prings(struct conn *conn)
{
    vring_reinstall_keys_for_conn(conn, 0);
    conn_sm_handle_event(conn, 5, 0, 0, 0);
}

/* check_high_false_alarm_aging_cb (0x8f1980, 56 Б): таймер через 0x44aa20 мкс (4,5 с)
 * после потери связи; cnt0 — счётчик тревог при постановке. Прирост ≥ 8 за
 * это время — ассерт 0x142e. Таймер [0x8000dc] снят. */
static void check_high_false_alarm_aging_cb(u32 cnt0, u32 a1)
{
    (void)a1;
    fw_log_emit2(0x2b, 0x100f4e8, FALSE_ALARM_CNT, cnt0);
    if (FALSE_ALARM_CNT - cnt0 >= 8)                   /* cmp_s / blnc: беззнаково */
        fw_sysassert_fatal(__builtin_return_address(0), 0x142e);
    FALSE_ALARM_TMR = 0;
}

/* (0x8f3ce8, 132 Б) колбэк radio_mgr__request из lmac_evt.c (у vendor — число 0x33ce8):
 * радио получено после потери связи. Системное состояние 0x13, вернуть заявку
 * [0x80013c] radio_mgr, длительность (now − t0)·16 в [0x800374], счётчик тревог +1;
 * таймер проверки частоты тревог, если ещё не стоит. a не используется. */
void l2mgr_link_lost_radio_cb(struct rm_req *a, u32 t0)
{
    u32 d;

    (void)a;
    calib_mngr_system_state_evt_handler(0x13, 0);
    fw_log_emit1(0x2c, 0x100f3fc, LL_RM_REQ);
    radio_mgr_call_method_10((struct rm_req *)LL_RM_REQ);
    d = (u_schd_now() - t0) << 4;
    LL_RADIO_TIME = d;
    fw_log_emit1(0x2b, 0x100f440, d);
    FALSE_ALARM_CNT = FALSE_ALARM_CNT + 1;
    LL_RM_REQ = 0;
    if (FALSE_ALARM_TMR != 0)
        return;
    fw_log_emit0(0x2b, 0x100f494);
    FALSE_ALARM_TMR = u_schd_schedule(check_high_false_alarm_aging_cb, FALSE_ALARM_CNT,
                                      0, 1, 0x44aa20, 0, 0);
}
