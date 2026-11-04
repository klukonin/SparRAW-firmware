// SPDX-License-Identifier: AGPL-3.0-or-later
/* SXD HAL uCode. */
#include "../include/types.h"
#include "../include/arc.h"


/* СРОК: программирование GP-таймера: 0x68 (группа) → 3 nop → 0x67 (данные) → 3 nop → 0x68|0xb
 * (применить); паузы — аппаратные (MAC применяет слово за ~3 такта), vendor 0x934f54 так же; запас —
 * единицы инструкций. Срыв: 0x67 попадёт в прежнюю группу — таймер окна BI/слота с чужим значением. */
/* Запись поля qset через mailbox (0x934f54). */
void sxd_hal_write_qset_field(u32 a, u32 b)
{
    if (b & 0xff000000u)
        uc_assert((u32)__builtin_return_address(0), 0x53);
    mac_evt_select_timer_group(a);
    u32 field = (a << 0x14) & 0xf00000u;
    uc_mac_cmd(field | 0x68000000u);
    arc_nops(3);
    uc_mac_cmd(b | 0x67000000u);
    arc_nops(3);
    uc_mac_cmd(field | 0x6800000bu);
}

/* СРОК: n слотов по slot2_event: 0x02000100 → 3 nop → ждать r42 без тайм-аута (vendor 0x936cc8 и
 * 0x936d64 ниже так же); выдержку задаёт число слотов n; запас по паузе — единицы инструкций. */
/* Ожидание занятости slot2 (0x936cc8). */
u32 sxd_hal_wait_slot2_busy2(u32 n)
{
    if (n == 0)
        uc_assert((u32)__builtin_return_address(0), 0x157f);
    uc_mac_cmd(mac_evt_en_shadow | 0x27000c00u);
    uc_mac_cmd(0x2004000u);
    while (n >= 1) {
        uc_mac_cmd(0x2000100u);
        arc_nops(3);
        uc_wait_event_busy(MAC_EVT1_SLOT2 | MAC_EVT1_BUSY2, 0);
        if (mac_evt1() & MAC_EVT1_BUSY2)
            return 1;
        n--;
    }
    return 0;
}

/* Ожидание занятости slot2 (0x936d64). Зовёт только rx_flow_main (ответчик в чужом TXOP: после своего ответа ждёт
 * следующий кадр держателя или RTS нового TXOP).
 *
 * исправлено (vendor): 0x2080000 здесь и 0x2080002 в начале прохода rx_flow_main стирают busy_event (r42 б19) без
 * проверки, не идёт ли уже приём. Ответчик RD после BlockAck держателя на свои данные приходит сюда, когда CF-End
 * держателя (через SIFS после BlockAck) уже начался (эмулятор, test_air test_live_rd_responder_*: CF-End начался за
 * 1,3 мкс до 0x2080002) — событие стёрто, ответного CF-End нет, счётчик PPDU uc отстаёт, и следующие RTS держателя
 * rx_flow_run отбрасывает (ветка 0xeeee04); стенд 2026-11-04 — CF-End без ответа в 2679 из 3335 TXOP станции с RD
 * (MAC-STAND «Ответчик RD глохнет»). После сброса — признак идущего приёма без гонки: счётчик начал CCA PHY опережает
 * счётчик концов PPDU (PHY_SIGNALS [21:16] / [13:8]; тот же признак у rx_flow_run, assert 68 при разнице ≥ 2) и PHY
 * занят (cca [2:0] / phy_rx_frame — против разницы от ложного CCA без конца PPDU). Тогда — сразу «занято»: rx_flow_run
 * разберёт кадр (вход при состоянии 2/3/5); счётчик стенда mac_mon_report.rx_busy_race. */
u32 sxd_hal_wait_slot2_busy(u32 n)
{
    if (n == 0)
        uc_assert((u32)__builtin_return_address(0), 0x52);
#ifdef UC_STAMP_MASK
    if (UC_STAMP_ON(STAMP_BUSY_LOST) && (mac_evt1() & MAC_EVT1_BUSY))
        UC_STAMP(STAMP_BUSY_LOST, 2, mac_evt1());
#endif
    uc_mac_cmd(0x41u << 0x13);
    {
        u32 g = mac_sel_shadow & ~MAC_SEL_FIELD;
        mac_sel_shadow = g | MAC_SEL_PHY_SIGNALS;
        uc_mac_cmd(g | MAC_CMD_STATUS_SEL | MAC_SEL_PHY_SIGNALS);
        arc_nops(3);
        u32 s = mac_status_sel();
        if (((MAC_PHYSIG_CCA_EVT_CNT_OF(s) - MAC_PHYSIG_PPDU_EVT_CNT_OF(s)) & 0x3f) &&
            (s & (MAC_PHYSIG_CCA | MAC_PHYSIG_PHY_RX_FRAME))) {
            mac_mon_report.rx_busy_race += 1;
            return 1;
        }
    }
    while (n >= 1) {
        uc_mac_cmd(0x2000100u);
        arc_nops(3);
        uc_wait_event_busy(MAC_EVT1_SLOT2 | MAC_EVT1_BUSY, 0);
        if (mac_evt1() & MAC_EVT1_BUSY)
            return 1;
        n--;
    }
    return 0;
}

