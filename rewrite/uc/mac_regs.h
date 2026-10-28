// SPDX-License-Identifier: AGPL-3.0-or-later
/* Порты MAC uc: расширенные core-регистры r36…r55 (чтение командой mov) — имена регистров и бит.
 *
 * Источник имён — символьный пак 11ad (MSXD_LR_RGF) по docs/UC-REGISTERS.md §2; смысл — оттуда же.
 * Здесь названо только то, что там описано; неописанные биты в коде остаются числами.
 * Подключается через -include (Makefile, после uc/dccm.h).
 *
 * Чтение порта — макрос mac_*() (= arc_core_rd(N), каждый вызов — новое чтение `mov rX,rN`). Не
 * static inline: обёртка-функция меняла распределение регистров (uc_wait_event1_or_event4,
 * fsched_pick_ready_queue), а код uc должен оставаться тем же.
 *
 * Обозначения: MAC_<РЕГ>_<ПОЛЕ> — маска на своём месте (бит или поле целиком);
 * MAC_<РЕГ>_<ПОЛЕ>_OF(v) — значение поля из прочитанного слова v (сдвиг и маска).
 *
 * Регистры групп (r40, r41, r47, r55) мультиплексированы селектором: r40/r41/r47 — полубайт
 * команды 0x1d (тень mac_sel_shadow, §2.3), r55 — младшие биты команды 0x4d (§2.16). Имя бита
 * у таких регистров — по регистру группы (BACKOFF_IFS_STATUS, PHY_SIGNALS, …); верно только
 * после соответствующего селектора. */
#ifndef UC_MAC_REGS_H
#define UC_MAC_REGS_H
#include "../include/types.h"
#include "../include/arc.h"

/* ---- r36…r39: отчёт о принятом PPDU (single-mapped; готов по MAC_EVT1_PPDU_REPORT), §2.5 ---- */

#define mac_rx_rep1() arc_core_rd(36)      /* PPDU_REPORT_1_R36 */
#define mac_rx_rep2() arc_core_rd(37)      /* PPDU_REPORT_2_R37 */
#define mac_rx_rep3() arc_core_rd(38)      /* PPDU_REPORT_3_R38 */
#define mac_rx_misc() arc_core_rd(39)      /* PPDU_REPORT_MISC_R39 */

/* r36 PPDU_REPORT_1_R36 */
#define MAC_RX_REP1_QOS_DATA      (1u << 1)     /* qos_data_detected: QoS Data */
#define MAC_RX_REP1_MGMT          (1u << 2)     /* mgmt_detected: кадр управления */
#define MAC_RX_REP1_SS            (1u << 6)     /* ss_detected: принят SSW (развёртка секторов) */
#define MAC_RX_REP1_BEACON        (1u << 7)     /* beacon_detected: принят маяк */
#define MAC_RX_REP1_IMM_ACK       (1u << 8)     /* imm_ack: ожидаемый ACK пришёл */
#define MAC_RX_REP1_BACK          (1u << 9)     /* back: ожидаемый BlockAck пришёл */
#define MAC_RX_REP1_BAR           (1u << 18)    /* back_request_frame_detected: принят BAR */
#define MAC_RX_REP1_DATA_QID_OF(v) (((v) >> 19) & 0x1f)   /* data_frame_qid [23:19]: qid принятых данных */
#define MAC_RX_REP1_NOACK_MGMT    (1u << 25)    /* no_action_mgmt_detected: Action No Ack (BRP) */

/* r37 PPDU_REPORT_2_R37 */
#define MAC_RX_REP2_RTS           (1u << 0)     /* rts: принят RTS */
#define MAC_RX_REP2_CTS           (1u << 1)     /* mmWaveCTS: принят CTS */
#define MAC_RX_REP2_DTS           (1u << 2)     /* mmWaveDTS: принят DTS (NAV) */
#define MAC_RX_REP2_GRANT         (1u << 10)    /* grant: принят Grant */
#define MAC_RX_REP2_CF_END        (1u << 16)    /* mmWaveCF_END: принят CF-End */
#define MAC_RX_REP2_CFG1          (1u << 17)    /* cfg1 (имя из пака; смысл не установлен) */
#define MAC_RX_REP2_SSW           (1u << 24)    /* ss_bitmap б0: SSW */
#define MAC_RX_REP2_SSW_FB        (1u << 25)    /* ss_bitmap б1: SSW-Feedback */
#define MAC_RX_REP2_SSW_ACK       (1u << 26)    /* ss_bitmap б2: SSW-ACK */

/* r38 PPDU_REPORT_3_R38 */
#define MAC_RX_REP3_MY_BSS_BEACON (1u << 0)     /* my_bssid_beacon_detected: маяк своей BSS */
#define MAC_RX_REP3_ADDR2_IDX_OF(v) (((v) >> 8) & 7)      /* addr2_match_index [10:8]: индекс станции по TA */
#define MAC_RX_REP3_ADDR2_VALID   (1u << 11)    /* addr2_match_valid: индекс TA действителен */
#define MAC_RX_REP3_BAP_EN        (1u << 12)    /* bap_enable: BA-интерфейс (дальше r53) */
#define MAC_RX_REP3_MCAST         (1u << 13)    /* mcast_indication */
#define MAC_RX_REP3_BCAST         (1u << 14)    /* bcast_indication */
#define MAC_RX_REP3_RD            (1u << 15)    /* reverse_direction_detected */
#define MAC_RX_REP3_ACK_POLICY    0x30000u      /* requested_ack_policy [17:16] */
#define MAC_RX_REP3_ACK_POLICY_OF(v) (((v) >> 16) & 3)
#define MAC_RX_REP3_RX_MCS        0x1f00000u    /* received_mcs [24:20]: MCS принятого кадра */
#define MAC_RX_REP3_RX_MCS_OF(v)  (((v) >> 20) & 0x1f)
#define MAC_RX_REP3_MPDU_AGG      (1u << 25)    /* mpdu_aggregation: A-MPDU */
#define MAC_RX_REP3_PWR_MGMT      (1u << 26)    /* pwr_mgmt_set: PM-бит отправителя */
#define MAC_RX_REP3_NEIGHBOUR     (1u << 28)    /* neighbour_indication: кадр соседа (NAV) */
#define MAC_RX_REP3_FCS_OK_PART   (1u << 29)    /* fcs_ok_partial */
#define MAC_RX_REP3_FCS_OK_FULL   (1u << 30)    /* fcs_ok_full: кадр целиком верен */

/* r39 PPDU_REPORT_MISC_R39 */
#define MAC_RX_MISC_TYPE_IDX_OF(v) (((v) >> 8) & 0x3f)    /* type_index [13:8]: тип/подтип кадра */
#define MAC_RX_MISC_ZERO_CDOWN    (1u << 15)    /* zero_cdown: CDOWN = 0 в SSW (последний кадр развёртки) */

/* ---- r40: группа R40, селектор — полубайт [15:12] команды 0x1d, §2.6 ---- */

#define mac_status_sel() arc_core_rd(40)   /* R40[сел.]: BACKOFF_IFS_STATUS, BI_COUNTER, PHY_SIGNALS, … */

/* Выбор регистра группы R40: команда MAC 0x1d с номером регистра в полубайте [15:12]; тот же полубайт хранит
 * mac_sel_shadow (остальные биты команды — из него). Регистры 1, 2, 7, 8, 9, 0xc, 0xe, 0xf uc не выбирает. */
#define MAC_CMD_STATUS_SEL        0x1d000000u   /* команда «выбрать регистр R40» */
#define MAC_SEL_FIELD             0xf000u       /* номер регистра [15:12] */
#define MAC_SEL_BACKOFF_IFS       0x0000u       /* BACKOFF_IFS_STATUS: idle_detect, остатки слотов AC */
#define MAC_SEL_REM_TIME          0x3000u       /* REMAINING_TIME_RD: остаток времени */
#define MAC_SEL_BI_COUNTER        0x4000u       /* BI_COUNTER: позиция в BI, bi_sync */
#define MAC_SEL_TSF_LOW           0x5000u       /* TSF_LOW_R40: TSF [31:0] */
#define MAC_SEL_TSF_HIGH          0x6000u       /* TSF_HIGH_R40: TSF [63:32] */
#define MAC_SEL_PHY_SIGNALS       0xa000u       /* PHY_SIGNALS: cca, phy_rx_frame, счётчики PPDU/CCA, cca_ppdu_comp */
#define MAC_SEL_PLCP_RX           0xb000u       /* PHY_PLCP_RX_SIGNALS_R40: sifs_resp */
#define MAC_SEL_BF_METRIC         0xd000u       /* BF_METRIC_R40: метрика BF */

/* сел. 0x0 BACKOFF_IFS_STATUS */
#define MAC_BIFS_IDLE_DETECT      0x7u          /* idle_detect [2:0]: состояние среды (5 — свободна для развёртки маяка) */
#define MAC_BIFS_REM_SLOT_AC1_OF(v) (((v) >> 16) & 0xf)  /* remaining_slot_ac1 [19:16] */
#define MAC_BIFS_REM_SLOT_AC2_OF(v) (((v) >> 20) & 0xf)  /* remaining_slot_ac2 [23:20] */
#define MAC_BIFS_REM_SLOT_AC3_OF(v) (((v) >> 24) & 0xf)  /* remaining_slot_ac3 [27:24] */
#define MAC_BIFS_REM_SLOT_AC4_OF(v) ((v) >> 28)          /* remaining_slot_ac4 [31:28] */
/* сел. 0x3 REMAINING_TIME_RD */
#define MAC_REM_TIME              0xffffu       /* dump___remaining_time [15:0]: остаток времени */
/* сел. 0x4 BI_COUNTER */
#define MAC_BI_COUNTER            0x3ffffffu    /* bi_counter [25:0]: позиция в BI, мкс */
#define MAC_BI_SYNC_OF(v)         ((v) >> 31)   /* bi_sync б31: BI синхронизирован */
/* сел. 0xa PHY_SIGNALS */
#define MAC_PHYSIG_CCA            0x7u          /* cca [2:0] */
#define MAC_PHYSIG_PHY_RX_FRAME   (1u << 3)     /* phy_rx_frame: идёт приём кадра */
#define MAC_PHYSIG_PPDU_EVT_CNT_OF(v) (((v) >> 8) & 0x3f)  /* ppdu_event_counter [13:8] */
#define mac_status_sel_shr8()     UC_CORE_LSR(40, 8)     /* одной инструкцией: & 0x3f — ppdu_event_counter */
#define MAC_PHYSIG_CCA_EVT_CNT_OF(v)  (((v) >> 16) & 0x3f) /* cca_event_counter [21:16] */
#define MAC_PHYSIG_CCA_PPDU_COMP  (1u << 24)    /* cca_ppdu_comp: канал свободен (вместе с !MAC_EVT1_BUSY2) */
/* сел. 0xb PHY_PLCP_RX_SIGNALS_R40 */
#define MAC_PLCP_SIFS_RESP        (1u << 15)    /* sifs_resp: кадр требует ответа через SIFS */
/* сел. 0xd BF_METRIC_R40 (раскладка Sparrow, §7.2) */
#define MAC_BF_METRIC_OF(v)       (((v) >> 9) & 0x7ff)    /* [19:9]: 11-битная метрика BF со знаком */

/* ---- r41: группа R41 (выбор очередей), селектор — полубайт [11:8], §2.7 ---- */

#define mac_queue_sel() arc_core_rd(41)    /* R41[сел.]: QUEUE_SEL_STATUS, QSET_1_MASK_VECTOR, MTP/BAP_Q_AVAIL */

/* сел. 0x0 QUEUE_SEL_STATUS_R41 */
#define MAC_QSEL_LOWEST_QSET_OF(v) (((v) >> 8) & 0xf)     /* lowest_queue_set_found [11:8] */
#define MAC_QSEL_QID_OF(v)        (((v) >> 16) & 0x1f)    /* qid_for_found_queue_set (uc берёт [20:16]) */
/* сел. 0x1 QUEUE_SEL_FOUND_SET1_4_R41 */
#define MAC_QSET4_QID_OF(v)       (((v) >> 24) & 0x1f)    /* qid_selected_qset4 (uc берёт [28:24]) */
#define MAC_QSET4_VALID_OF(v)     ((v) >> 31)             /* qset4_valid б31 */
/* сел. 0x3 QSET_1_MASK_VECTOR */
#define MAC_QSET1_Q0_29           0x3fffffffu   /* очереди 0..29 ожидают */
#define MAC_QSET1_Q30             (1u << 30)    /* очередь 30 ожидает */

/* ---- r42: события EVENT1_STATUS_R42 (селектор не пишется), §2.8 ---- */

#define mac_evt1() arc_core_rd(42)         /* EVENT1_STATUS_R42 */

#define MAC_EVT1_SIFS             (1u << 0)     /* sifs_event (uc 6.2 не проверяет) */
#define MAC_EVT1_SLOT             (1u << 1)     /* slot_event: начало слота */
#define MAC_EVT1_BI1              (1u << 4)     /* bi1_event: TBTT */
#define MAC_EVT1_BI2              (1u << 5)     /* bi2_event: событие BI2 для BTI */
#define MAC_EVT1_TSF              (1u << 6)     /* tsf_event (uc 6.2 не проверяет) */
#define MAC_EVT1_TXOP             (1u << 7)     /* txop_event: TXOP закончился/идёт */
#define MAC_EVT1_SLOT2            (1u << 8)     /* slot2_event: второй слот */
#define MAC_EVT1_GP_TIMERS        (1u << 9)     /* gp_timers_event: таймаут ожидания (GP-таймер 0x23010000|t) */
#define MAC_EVT1_SFD_SYNC         (1u << 11)    /* sfd_sync_event: синхронизация SFD */
#define MAC_EVT1_RX_FRAME         (1u << 12)    /* rx_frame_event: принят кадр */
#define MAC_EVT1_CCA              (1u << 13)    /* cca_event (uc 6.2 не проверяет) */
#define MAC_EVT1_BUSY2            (1u << 14)    /* busy2_event: среда занята / подтверждение команды */
#define MAC_EVT1_TX_END           (1u << 15)    /* tx_end_event: передача закончена */
#define MAC_EVT1_PPDU_REPORT      (1u << 16)    /* ppdu_report_event: отчёт r36…r39 готов */
#define MAC_EVT1_BACKOFF          (1u << 18)    /* backoff_event: конец backoff */
#define MAC_EVT1_BUSY             (1u << 19)    /* busy_event: L1 — фаза автомата BI; TXSS — неожиданный кадр */
#define MAC_EVT1_ALL              0xffffffu     /* биты 0..23 — все события (24..31 резерв) */

/* ---- r43: ответ MTP на запрос, MTP_QUERY_RESPONSE_1, §2.9 ---- */

#define mac_mtp_resp() arc_core_rd(43)     /* MTP_QUERY_RESPONSE_1 */

#define MAC_MTP_RESP_PKT_MODE_OF(v) (((v) >> 4) & 0xf)    /* packet_mode [7:4] */
#define MAC_MTP_RESP_DEST_ID_OF(v)  (((v) >> 8) & 0xf)    /* dest_id [11:8]: индекс станции */
#define MAC_MTP_RESP_ACK_POLICY   0xc000u       /* ack_policy [15:14] */
#define MAC_MTP_RESP_ACK_POLICY_OF(v) (((v) >> 14) & 3)
#define MAC_MTP_RESP_MCS_OF(v)    (((v) >> 16) & 0x1f)    /* mcs [20:16] */
#define MAC_MTP_RESP_RD_SUPP      (1u << 26)    /* reverse_direction_supported */
#define MAC_MTP_RESP_RD_SUPP_OF(v) (((v) >> 26) & 1)
#define MAC_MTP_RESP_AGG_EN       (1u << 27)    /* aggregation_enabled: ответ будет BlockAck */
#define MAC_MTP_RESP_VALID        (1u << 31)    /* valid: ответ MTP готов */

/* ---- r45: разрешение MTP на передачу, MTP_TX_PERMISSION_RESP, §2.10 ---- */

#define mac_mtp_perm() arc_core_rd(45)     /* MTP_TX_PERMISSION_RESP */

#define MAC_MTP_PERM_Q_EMPTY      (1u << 1)     /* null_status б1: очередь MTP пуста (vendor-лог «MTP Queue is empty»; §7.1) */
#define MAC_MTP_PERM_Q_EMPTY_OF(v) (((v) >> 1) & 1)
#define MAC_MTP_PERM_NULL_B5_OF(v) (((v) >> 5) & 1)       /* null_status б5 (смысл по паку не установлен) */
#define MAC_MTP_PERM_VALID        (1u << 31)    /* valid: ответ готов */

/* ---- r47: группа R47, селектор — полубайт [19:16], §2.11 ---- */

#define mac_txctl_sel() arc_core_rd(47)    /* R47[сел.]: DIRECT_TX, COUNTER_EVENT, LFSR, RFC_SWITCH*, MTP_AGGREGATION */

/* сел. 0x0 DIRECT_TX_CMD_STATUS */
#define MAC_DTX_CMD_READY         (1u << 0)     /* cmd_ready: direct TX готов */
/* сел. 0x1 COUNTER_EVENT_STATUS */
#define MAC_CNT_IF_BUSY           (1u << 0)     /* counter_interface_busy: ждать снятия перед запуском PPDU */
/* сел. 0x3 RFC_SWITCH_ERROR_STATUS */
#define MAC_RFC_ACCESS_BUSY       (1u << 17)    /* rfc_access_busy: ждать снятия перед командой RFC */
/* сел. 0x5 RFC_SWITCH2RX_STATUS */
#define MAC_RFC2RX_ANALOG_TX_OFF  0xfu          /* analog_tx_off_status [3:0] */
#define MAC_RFC2RX_ANALOG_RX_ON   0xf0u         /* analog_rx_on_status [7:4] */
#define MAC_RFC2RX_RX_AWV_CFG     0xf000u       /* rx_awv_cfg_status [15:12] */
/* сел. 0x8 MTP_AGGREGATION */
#define MAC_MTP_AGG_VALID         (1u << 31)    /* valid */

/* ---- r49: EVENT_ENGINE2_STATUS (события PHY BRP), §2.12 ---- */

#define mac_evt_eng2() arc_core_rd(49)     /* EVENT_ENGINE2_STATUS */

#define MAC_EE2_BRP_DONE          (1u << 5)     /* phy_rx_brp_done: конец приёма BRP */
#define MAC_EE2_BRP_ON_AIR        (1u << 13)    /* phy_rx_brp_stage_on_air: идёт BRP-стадия */
#define MAC_EE2_PHY_STATE_OF(v)   (((v) >> 16) & 0xf)     /* [19:16] из phy_mac_status_2_11: состояние PHY (<6 — можно переключать) */
/* Одной инструкцией (горячие пути): состояние PHY = mac_evt_eng2_shr16() & 0xf; снимок порта в DCCM. */
#define mac_evt_eng2_shr16()      UC_CORE_LSR(49, 16)
#define mac_evt_eng2_store(var)   UC_CORE_ST(49, var)

/* ---- r51: MTP_DESCRIPTOR_SCRATCHPAD (поля не установлены), §2.13 ---- */

#define mac_mtp_desc() arc_core_rd(51)     /* MTP_DESCRIPTOR_SCRATCHPAD */

/* ---- r53: BAP_IF_0 (интерфейс Block Ack), §2.14 ---- */

#define mac_bap_if() arc_core_rd(53)       /* BAP_IF_0 */

#define MAC_BAP_TX_UPDATE         (1u << 0)     /* bap_tx_update_ind */
#define MAC_BAP_REL_DONE          (1u << 2)     /* bap_rel_done_ind: ждать перед запуском PPDU из очереди */
#define MAC_BAP_RX_UPDATE         (1u << 3)     /* bap_rx_update_ind */
#define MAC_BAP_TX_UP_STATUS      (1u << 4)     /* bap_tx_up_status: при ненуле BA не учитывается */
#define MAC_BAP_RX_UP_STATUS      (1u << 5)     /* bap_rx_up_status */
#define MAC_BAP_NUM_TX_PKTS_OF(v) (((v) >> 8) & 0x7f)     /* num_of_tx_pkts [14:8] */
#define MAC_BAP_NUM_NOACK_OF(v)   (((v) >> 16) & 0x7f)    /* num_of_non_acked_pkts [22:16] */

/* ---- r54: события EVENT4_STATUS (квитирование — MAC-команда 0x49), §2.15 ---- */

#define mac_evt4() arc_core_rd(54)         /* EVENT4_STATUS */

#define MAC_EVT4_TXSS_END         (1u << 0)     /* txss_end_ind: развёртка TXSS окончена */
#define MAC_EVT4_RXSS_BF_METRIC   (1u << 1)     /* rxss_bf_metric_ind: метрика RXSS готова */
#define MAC_EVT4_SP0              (1u << 4)     /* service_period_0_ind: вход DTI-аллокации */
#define MAC_EVT4_GP0_END          (1u << 6)     /* gp0_end_ind: таймаут GP0 */
#define MAC_EVT4_GP1_END          (1u << 7)     /* gp1_end_ind: таймаут GP1 */
#define MAC_EVT4_GP2_END          (1u << 8)     /* gp2_end_ind: конец GP2 */
#define MAC_EVT4_EXT_GP012_END    (1u << 15)    /* ext_gp_0_1_2_end_ind: переход AW→DTI */
#define MAC_EVT4_EXT_GP345_END    (1u << 16)    /* ext_gp_3_4_5_end_ind */
#define MAC_EVT4_EXT_GP6789_END   (1u << 17)    /* ext_gp_6_7_8_9_end_ind */

/* ---- r55: группа R55, селектор — младшие биты команды 0x4d, §2.16 ---- */

#define mac_timer_sel() arc_core_rd(55)    /* R55[сел.]: SIFS_CNT, G2_TSF_LOW, GP_CLK2_TIMER */

/* 0x4d000000 SIFS_CNT (бегущий счётчик) */
#define MAC_SIFS_CNT_USEC_OF(v)   (((v) >> 8) & 0xff)     /* usec [15:8] ([7:0] — такты) */
/* 0x4d00000a GP_CLK2_TIMER */
#define MAC_GP_CLK2_VAL           0xffffffu     /* val [23:0] */

/* Канал свободен: !busy2_event && PHY_SIGNALS.cca_ppdu_comp (r40 сел. 0xa). После mac_cmd_29000001
 * vendor читает r40, затем r42 (mov r1,r40; mov r0,r42). */
#define mac_cca_ok() ({ u32 _r40 = mac_status_sel(); \
                        !(mac_evt1() & MAC_EVT1_BUSY2) && (_r40 & MAC_PHYSIG_CCA_PPDU_COMP); })

#endif
