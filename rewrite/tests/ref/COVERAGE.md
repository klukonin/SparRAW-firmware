# Покрытие 802.11-2020 эталонной моделью DMG MAC

Карта DMG-пунктов стандарта (802.11-2020, `docs/80211-2020.txt`; заголовок и страница — из текста, страница — маркер `[Page N]` после заголовка): что есть в модели `rewrite/tests/ref` (модуль/функция), есть ли правило судьи эфира `air_judge` (id правила), что не реализовано и что вне охвата (с причиной). Охват: open — AP/STA/PCP/PBSS DMG по стандарту, включая расписание DTI, SP и динамическое распределение (10.39.6–10.39.9); pro — FTM, OOB, IBSS; кластеризация AP/PCP (10.40) — в охвате open (решение 2026-11-07); relay (10.45, 11.34) и MMS/MMSL (11.32) — не делаем, биты/элементы 0; multi-band/FST (11.31) — pro, будущее (в open — 0); энергосбережение и adhoc удалены намеренно (точка отвечает отказом на PSC-REQ) — правило судьи `opt_caps`; reverse direction выключен намеренно (10.29.4).

Статусы: **М+С** — модель и правило судьи эфира; **М** — модель (по захватам не проверяется: кадров нет или поле не записано); **Ч** — частично (что именно — в примечании); **С** — только судья; **Н** — не реализовано (в охвате open); **ВНЕ** — вне охвата (причина в примечании). Перечень «не проверяемо по записи» — `air_judge.NOT_CHECKABLE`.

## Сводка

| Статус | Пунктов |
|---|---|
| М+С | 213 |
| М | 53 |
| Ч | 0 |
| С | 3 |
| Н | 0 |
| ВНЕ | 38 |
| всего | 307 |

Реализовано (М+С, М, С): 269; частично: 0; не реализовано: 0; вне охвата: 38. Подсчёт — по строкам таблиц (пункт —
одна строка, повторов нет). Волна 5 (PLAN.md №100–№107): 15 «Ч» и 2 «Н» закрыты до М+С; добавлены строки 9.4.2.15,
9.4.2.217, 9.6.2.4, 9.6.2.5, 10.2.6, 10.28.4, 11.17 (М+С) и 11.11 (ВНЕ).

## 9.2 Общий формат MAC-кадра (DMG-особенности)

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.2.2 | 755 | Conventions | М+С | fields._pack/_unpack (порядок бит, резерв = 0) | fc, ba_control (резерв) | PLAN №18: BA Control B0 |
| 9.2.4.1 | 758 | Frame Control field | М+С | fields.check_fc / encode_fc / parse_fc (рис. 9-3, 9-4, табл. 9-1, 9-2) | fc, opt_caps | Power Management = 1 в наших кадрах — opt_caps (PS) |
| 9.2.4.2 | 767 | Duration/ID field | М+С | duration.field / decode | dur_cts, dur_resp, dur_cf_end, dur_bf |  |
| 9.2.4.3 | 768 | Address fields | М+С | addrs.check_addresses / addresses / check_ta (9.2.4.3.1–9.2.4.3.8; Address 3 управления 9.3.3.1 c), 11.17; To DS/From DS табл. 9-3, 9-4); fields.is_group | addr, cts_self, resp_seq | TA — индивидуальный (групповой «bandwidth signaling TA» — только VHT/S1G); DMG CTS-to-self — исключение 9.3.1.13 (TA — получатель следующего кадра); табл. 9-26 (Address Extension Mode) — Mesh Control, вне охвата; 4 адреса у DMG не определены — model; фильтрация приёма — addr_rx_filter |
| 9.2.4.4 | 770 | Sequence Control field | М+С | blockack.encode_ssc / parse_ssc, sn_* | ba_window |  |
| 9.2.4.5 | 771 | QoS Control field | М+С | air_judge.qos_of; amsdu.parse_qos / encode_qos (табл. 9-11); qosctl.generate / check (табл. 9-12, 9-13, рис. 9-10) | ack_policy, rd, amsdu, qos_ctl | A-MSDU Present/Type — amsdu; генератор DMG: TID по политике (9-12), EOSP (9.2.4.5.3), Ack Policy (9-13), Buffered AC, RDG/AC Constraint = 0 (RD выключен); PSMP/CF-Poll — вне DMG |
| 9.2.4.6 | 777 | HT Control field | М+С | fields.check_fc (+HTC = 0 у DMG) | fc | HT Control в DMG не используется |
| 9.2.4.8 | 790 | FCS field | М | fields.fcs / fcs_residue |  | FCS в записи PMC не хранится |
| 9.2.5 | 791 | Duration/ID field (QoS STA) | М+С | duration.* (QoS STA, 9.2.5.1–9.2.5.7) | dur_resp, dur_cts, nav_txop, txop_limit | PLAN №19 |

## 9.3.1 Кадры управления (Control)

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.3.1.2 | 797 | RTS frame format | М+С | duration.duration_rts; cbap.Station | ctl_len, txop_limit, resp_seq |  |
| 9.3.1.4 | 798 | Ack frame format | М+С | duration.duration_ack; cbap | ctl_len, dur_resp, mcs_response |  |
| 9.3.1.5 | 799 | PS-Poll frame format | ВНЕ | optcaps.FRAME_OFF | opt_caps | PS-Poll — энергосбережение — не делаем; наш PS-Poll — нарушение |
| 9.3.1.6 | 799 | CF-End frame format | М+С | duration.duration_cf_end / cf_end_check; cbap.Nav | dur_cf_end, cf_end_rules, cf_end_unanswered |  |
| 9.3.1.7 | 800 | BlockAckReq frame format | М+С | blockack (BlockAckReq) | resp_seq |  |
| 9.3.1.8 | 803 | BlockAck frame format | М+С | blockack.encode_ba_control / encode_ba_info / Scoreboard | ba_control, ba_window, mcs_response | битмап целиком — не проверяемо (ba_scoreboard) |
| 9.3.1.9 | 807 | Control Wrapper frame format | ВНЕ |  |  | Control Wrapper — не для DMG (+HTC = 0) |
| 9.3.1.10 | 808 | Poll frame format | М+С | fields (Poll); duration.pp_schedule; dynalloc.pp / check_dyn_log (Duration (10-18), Response Offset) | dynalloc, cfe_fields | в захватах нет — dynalloc «не проверяемо» |
| 9.3.1.11 | 808 | Service period request (SPR) frame format | М+С | fields (SPR, 9.5.2, 9.5.5); duration.duration_spr_*; dynalloc (ответ на Poll); sp (продление 10.39.9) | dynalloc, sp_access, cfe_fields | PLAN №26 (Duration: 10.39.7.2 / 9.3.1.11) |
| 9.3.1.12 | 809 | Grant frame format | М+С | fields (Grant); duration.duration_grant_*; dynalloc.gp / relinquish_grant; sp (уступка, усечение, продление); sls.iss_start_after_grant | dynalloc, sp_access, cfe_fields | PLAN №29 |
| 9.3.1.13 | 809 | DMG CTS frame format | М+С | fields (DMG CTS); duration.duration_cts_response / duration_cts_to_self; nav.single_nav_updates | dur_cts, cfe_fields, resp_seq, cts_self | новое правило cts_self: TA CTS-to-self (волна C) |
| 9.3.1.14 | 810 | DMG DTS frame format | М | fields (DMG DTS); duration.duration_dts; nav.MultiNav (NAV-SA/NAV-DA) |  | защищённый период (10.39.6.6) — Н |
| 9.3.1.15 | 810 | Sector sweep (SSW) frame format | М+С | fields (SSW); sls; abft; duration.duration_ssw | cfe_fields, dur_bf, sls, abft |  |
| 9.3.1.16 | 811 | Sector sweep feedback (SSW-Feedback) frame format | М+С | fields (SSW-Feedback); sls; abft; duration.duration_ssw_fb | cfe_fields, dur_bf, sls, blm |  |
| 9.3.1.17 | 811 | Sector sweep Ack (SSW-Ack) frame format | М+С | fields (SSW-Ack); sls; duration.duration_ssw_ack | cfe_fields, dur_bf, sls, blm, brp_role |  |
| 9.3.1.18 | 812 | Grant Ack frame format | М+С | fields (Grant Ack); duration.duration_grant_ack; dynalloc (Grant Ack 10.39.4) | dynalloc | PLAN №30: AID в Grant Ack не копируются (поля нет) |
| 9.3.1.19 | 812 | VHT NDP Announcement frame format | ВНЕ |  |  | VHT NDP Announcement — не DMG |
| 9.3.1.21 | 814 | TACK frame format | ВНЕ |  |  | TACK — S1G |

## 9.3.2–9.3.4 Данные, управление, DMG Beacon

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.3.2.1 | 815 | Format of Data frames | М+С | addrs.check_data_header / header_len (рис. 9-65, табл. 9-30, 9.3.2.1.2 a)/e), 9.3.2.1.4, 9.3.2.1.5 NOTE 1/2); blockack; duration.duration_data_single | data_hdr, ack_policy, rd, ampdu_dur, amsdu | только QoS Data/QoS Null, без HT Control, QoS Null без тела; полный заголовок — с rxqos/txqos, без них — длина QoS Null по PSDU (и у синтетических RX) |
| 9.3.2.2 | 819 | Aggregate MSDU (A-MSDU) format | М+С | amsdu.encode_basic / encode_short / parse / check_addresses / check_mpdu / Aggregator (рис. 9-68, 9-69, 9-71, табл. 9-25, 9-30) | amsdu | Dynamic A-MSDU — только S1G, mesh (рис. 9-70) — не DMG; тела данных — только с rxqos/txqos (amsdu_body); PLAN №26–28 |
| 9.3.3.1 | 822 | Format of (PV0) Management frames | М+С | elements.check_order (порядок, «Last») | mgmt_body |  |
| 9.3.3.2 | 825 | Beacon frame format | ВНЕ |  |  | Beacon (не DMG); DMG — 9.3.4.2 |
| 9.3.3.3 | 829 | ATIM frame format | ВНЕ | optcaps.FRAME_OFF | opt_caps | ATIM — энергосбережение — не делаем (и IBSS); наш ATIM — нарушение |
| 9.3.3.4 | 829 | Disassociation frame format | М+С | elements (Disassociation, табл. 9-33) | mgmt_body, assoc_state |  |
| 9.3.3.5 | 830 | Association Request frame format | М+С | elements (табл. 9-34) | mgmt_body, assoc_state |  |
| 9.3.3.6 | 832 | Association Response frame format | М+С | elements (табл. 9-35), _check_assoc_resp | mgmt_body, assoc_state (AID, статус) |  |
| 9.3.3.7 | 835 | Reassociation Request frame format | М+С | elements (табл. 9-36) | mgmt_body, assoc_state | в захватах нет |
| 9.3.3.8 | 839 | Reassociation Response frame format | М+С | elements (табл. 9-37) | mgmt_body, assoc_state | в захватах нет |
| 9.3.3.9 | 843 | Probe Request frame format | М+С | elements (табл. 9-38) | mgmt_body, beam_track |  |
| 9.3.3.10 | 845 | Probe Response frame format | М+С | elements (табл. 9-39); mlme.should_respond_probe / probe_response_ra | mgmt_body, beam_track | PLAN №15 |
| 9.3.3.11 | 850 | Authentication frame format | М+С | elements (табл. 9-40/9-41), _check_auth | mgmt_body, assoc_state (open_system) | у DMG — без Open System (12.3.3.1); в захватах нет |
| 9.3.3.12 | 856 | Deauthentication | М+С | elements (табл. 9-42) | mgmt_body, assoc_state | в захватах нет |
| 9.3.3.13 | 856 | Action frame format | М+С | actions.classify / check_action (табл. 9-43); air_pcap.classify | action_fmt, addba, brp, assoc_state | MME/AMPE (табл. 9-43, Last − 1/Last) — защищённые/mesh, тело зашифровано; Vendor Specific в хвосте не разбирается |
| 9.3.3.14 | 856 | Action No Ack frame format | М+С | actions.NO_ACK / noack_allowed / check_action (9.6.6.4/9.6.6.5 — DMG BSS, 9.6.19.5 — широковещательный Information Response, 9.6.21.2 Announce, 9.6.21.3 BRP — только No Ack; 10.39.3 — не в ATI) | action_fmt, brp, brp_role |  |
| 9.3.3.15 | 857 | Timing Advertisement frame format | ВНЕ |  |  | Timing Advertisement — не DMG-функция |
| 9.3.4.2 | 857 | DMG Beacon | М+С | fields.encode/parse/check_dmg_beacon (табл. 9-45, рис. 9-77…9-79); bi; duration.duration_dmg_beacon | beacon_fields, bi, bti_delay, abft, ati |  |

## 9.4.1 Поля тел кадров

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.4.1.1 | 867 | Authentication Algorithm Number field | М+С | elements (Authentication Algorithm Number) | mgmt_body, assoc_state |  |
| 9.4.1.2 | 867 | Authentication Transaction Sequence Number field | М+С | elements | mgmt_body |  |
| 9.4.1.3 | 868 | Beacon Interval field | М+С | fields (DMG Beacon), elements | beacon_fields, bi |  |
| 9.4.1.4 | 868 | Capability Information field | М+С | elements.encode/parse/validate_capinfo_dmg (рис. 9-86) | mgmt_body, opt_caps | Triggered Unscheduled PS = 0 — opt_caps |
| 9.4.1.5 | 870 | Current AP Address field | М | elements (Current AP Address) |  |  |
| 9.4.1.6 | 870 | Listen Interval field | М+С | elements | mgmt_body |  |
| 9.4.1.7 | 871 | Reason Code field | М+С | elements; mlme (CONFIG_REASON) | mgmt_body, assoc_state |  |
| 9.4.1.8 | 874 | AID field | М+С | elements; timing.AID_*; mlme.ApMlme | assoc_state (aid_range, aid_dup) | DMG: 1…254 |
| 9.4.1.9 | 875 | Status Code field | М+С | elements; mlme (статусы) | mgmt_body, assoc_state |  |
| 9.4.1.10 | 880 | Timestamp field | М+С | tsf.check_monotonic / check_deltas / check_tbtt_offset / check_same_point / check_anchor; fields (DMG Beacon) | timestamp, beacon_fields | точка Timestamp относительно антенны (11.1.3.1) — не проверяема без внешней опоры (timestamp_point); проверяется всё, что от неё не зависит |
| 9.4.1.11 | 880 | Action field | М+С | actions.CATEGORY / ACTION / table_dmg (табл. 9-51 и таблицы действий 9.6 — open/pro/out/nondmg), must_echo / check_echo (10.28.4) | action_fmt, addba, brp | PLAN №105 |
| 9.4.1.12 | 882 | Dialog Token field | М+С | blockack | addba |  |
| 9.4.1.13 | 882 | Block Ack Parameter Set field | М+С | blockack.encode/parse_ba_params; amsdu.buffer_octets (A-MSDU Supported) | addba, amsdu |  |
| 9.4.1.14 | 883 | Block Ack Timeout Value field | М+С | blockack.InactivityTimer | addba |  |
| 9.4.1.16 | 884 | DELBA Parameter Set field | М | blockack.encode/parse_delba_params |  | DELBA в захватах нет |
| 9.4.1.44 | 906 | Relay Capable STA Info field | ВНЕ |  |  | Relay Capable STA Info — relay — необязательно, не поддерживается (решение 2026-11-07); поле только в кадрах relay (opt_caps) |
| 9.4.1.45 | 907 | Band ID field | ВНЕ |  |  | Band ID — multi-band/FST — pro, будущее (в open — 0) |
| 9.4.1.46 | 907 | DMG Parameters field | М+С | fields.check/encode/parse_dmg_params; elements; bi.DmgParameters | beacon_fields, mgmt_body | PLAN №9 |

## 9.4.2 Элементы (DMG и используемые DMG STA)

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.4.2.2 | 949 | SSID element | М+С | elements.encode/parse_ssid | mgmt_body |  |
| 9.4.2.9 | 962 | Request element | М+С | discovery.encode_request_el / check_request | info_req | по возрастанию, без повторов, без ID 255 и DMG Capabilities |
| 9.4.2.10 | 962 | Extended Request element | М | discovery.encode_ext_request_el / parse | info_req |  |
| 9.4.2.15 | 965 | TPC Request element | М+С | tpc.encode_tpc_request_frame / parse_tpc_frame (рис. 9-174: Length 0) | tpc |  |
| 9.4.2.16 | 966 | TPC Report element | М+С | tpc.encode/parse_tpc_report, check_frame_element (11.7.7; табл. 9-45 строка 50, табл. 9-39); linkadapt (в Link Measurement Report) | tpc, link_margin | Link Margin в DMG Beacon/Probe Response/Announce — 0; точность Transmit Power ± 5 дБ — tpc_power_accuracy |
| 9.4.2.17 | 966 | Supported Channels element | М+С | chswitch.encode/parse/check_supported_channels, channels_of / subbands_of (рис. 9-176, каналы табл. E-4) | supp_channels |  |
| 9.4.2.20.16 | 995 | Directional Channel Quality request | М+С | spsh.encode/parse_dcq_req, check_dcq_req (рис. 9-216, 9-217, табл. 9-120, 9-121) | spsh | в захватах нет |
| 9.4.2.21.15 | 1044 | Directional Channel Quality report | М+С | spsh.encode/parse_dcq_rep, check_dcq_rep, answer (рис. 9-277, табл. 9-144) | spsh | отчёт — по формату запроса (11.30.2) |
| 9.4.2.24 | 1051 | RSNE | М+С | elements.encode/parse_rsne (структура); capelems.rsn_effective / check_rsne / check_selection / mfp_actions / check_assoc_status (табл. 9-149…9-151, рис. 9-289, табл. 12-5) | mgmt_body, assoc_state (rsna), rsne | умолчание DMG — GCMP-128 (9.4.2.24.2), AKM — 00-0F-AC:1; WEP в DMG BSS — PLAN №67; выбор STA — 12.6.3; 4-way handshake — нет |
| 9.4.2.25 | 1060 | Vendor Specific element | М | elements.encode_vendor | mgmt_body (порядок) |  |
| 9.4.2.26 | 1061 | Extended Capabilities element | М+С | capelems.parse_ext_cap / encode_ext_cap / check_ext_cap (табл. 9-153 целиком); dms.ext_cap_dms | mgmt_body, dms, qab, ext_caps, opt_caps | резерв, биты только AP (80, 84, QAB 47), Service Interval Granularity при S-PSMP, Max Number Of MSDUs In A-MSDU — резерв у DMG; PS-биты 4, 6, 11, 17, 18, 28, 29, 45 = 0 — opt_caps (optcaps.EXT_CAP_OFF) |
| 9.4.2.30 | 1078 | TCLAS element | М+С | tclas.parse / encode / check / check_in_frame / match (типы 0–10: табл. 9-163/9-164, рис. 9-302…9-327, табл. 9-165…9-170); dms (DMS: 0, 1, 4) | tclas, dms | типы 7–9 (PV1) — только S1G, у DMG model; тип 2 и тип 1 для IPv6 — «deprecated» (model); классификация MSDU — tclas_classification; PLAN №106 |
| 9.4.2.32 | 1092 | TCLAS Processing element | М+С | dms.tclas_set_match, правила Processing (табл. 9-171) | dms |  |
| 9.4.2.28 | 1068 | EDCA Parameter Set element | М+С | cbap.EdcaParams; air_judge.edca_from | edca, access, txop_limit |  |
| 9.4.2.48 | 1116 | Timeout Interval element (TIE) | М+С | elements.encode/parse_tie; mlme (holdoff) | assoc_state (holdoff) |  |
| 9.4.2.52 | 1119 | Extended Channel Switch Announcement element | М+С | chswitch.encode/parse/check_ecsa (рис. 9-369; режим 0/1, DMG-классы 180/181 табл. E-4) | ecsa | Channel Switch Count для mesh (биты 6–0, ×2/×100 TU) — не DMG; в захватах нет |
| 9.4.2.53 | 1119 | Supported Operating Classes element | М+С | capelems.encode_soc / parse_soc / check_soc (рис. 9-370…9-372), DMG_GLOBAL_CLASSES (табл. E-4: 180, 181) | mgmt_body, op_classes | класс в работе DMG — глобальный (PLAN №68); порядок предпочтения не проверяем |
| 9.4.2.87 | 1190 | DMS Request element | М+С | dms.Descriptor / encode_descriptor / parse_descriptors / check_descriptor / encode_request_elements (рис. 9-475, 9-476, табл. 9-229, 9-230) | dms | TSPEC — 55 октетов без разбора; GCR Request — нарушение у DMG; PLAN №29 |
| 9.4.2.88 | 1193 | DMS Response element | М+С | dms.Status / encode_status / parse_statuses / check_status / encode_response_elements (рис. 9-478, 9-479, табл. 9-233, 9-234) | dms | GCR Response / «GCR Advertise» — нарушение у DMG; PLAN №30 |
| 9.4.2.125 | 1234 | GCR Group Address element | ВНЕ |  |  | GCR — не DMG (11.21.16.1: «DMG STAs do not use GCR») |
| 9.4.2.126 | 1235 | DMG BSS Parameter Change element | М+С | elements.encode/parse_bss_param_change; bssparams.check_change (резерв, BI Duration, aMaxBIDuration) | bss_params | процедура — 11.29 (bssparams); в захватах нет |
| 9.4.2.127 | 1235 | DMG Capabilities element | М+С | elements.encode/parse/validate_dmg_capabilities (рис. 9-549…9-554); linkadapt.check_fla_caps (Fast Link Adaptation ⇒ Reverse Direction) | mgmt_body, beam_track, link_meas, cluster, opt_caps | Decentralized/Centralized Clustering ↔ Clustering Control — cluster; битов relay/MMS/FST/PS в 2020 нет (Heartbeat, Power Source — не PS, PLAN №88) |
| 9.4.2.128 | 1242 | DMG Operation element | М+С | elements.encode/parse/validate_dmg_operation; mlme (MIB из DMG Operation) | mgmt_body |  |
| 9.4.2.129 | 1244 | DMG Beam Refinement element | М+С | brp.BeamRefinement (рис. 9-558…9-560) | brp, brp_role | новое правило brp_role: Initiator |
| 9.4.2.130 | 1246 | DMG Wakeup Schedule element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | DMG Wakeup Schedule — энергосбережение — не делаем |
| 9.4.2.131 | 1246 | Extended Schedule element | М+С | elements.encode/parse/validate_extended_schedule; schedule.encode/decode/check/plan; bi.Allocation / layout | schedule, bi | в маяках стенда Extended Schedule нет (CBAP Only) — schedule проверяет CBAP Only |
| 9.4.2.132 | 1250 | STA Availability element | М+С | staavail.encode / parse / check / PpAvailability (10.39.7.1); dynalloc.check_dyn_log(pp_available) | sta_avail, dynalloc | PLAN №100 |
| 9.4.2.133 | 1251 | DMG TSPEC element | М+С | tspec.encode/parse/check_dmg_tspec, alloc_info, period_us (рис. 9-568…9-571, табл. 9-260…9-262) | addts | TSCONST Period отчёта о помехах — PLAN №70; в захватах нет |
| 9.4.2.134 | 1254 | CMMG TSPEC element | ВНЕ |  |  | CMMG |
| 9.4.2.135 | 1255 | Next DMG ATI element | М | elements.encode/parse_next_dmg_ati; bi; mlme.ati_start_earliest | ati (ATI Present) | в захватах ATI нет |
| 9.4.2.136 | 1255 | Channel Measurement Feedback element | М | brp.cmf_payload / cmf_octets (табл. 9-263/9-264) | brp (размер) |  |
| 9.4.2.137 | 1258 | Awake Window element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | Awake Window — энергосбережение — не делаем |
| 9.4.2.138 | 1258 | Multi-band element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | Multi-band — multi-band/FST — pro, будущее (в open — 0); элемента в наших кадрах нет (elements знает порядок) |
| 9.4.2.139 | 1260 | ADDBA Extension element | М+С | addbaext.encode / parse / check / check_frame / Agreement.check_fragment (10.2.6) | addba_ext | HE Fragmentation Operation / Extended Buffer Size — не 802.11-2020 (B1–B7 Reserved), у DMG не применимы; PLAN №101 |
| 9.4.2.140 | 1261 | Next PCP List element | М+С | handover.encode/parse/check_next_pcp_list, NextPcpListPcp, check_next_pcp_tokens (рис. 9-581) | pcp_handover | Length 0 при отсутствии способных STA — PLAN №63; в захватах нет (BSS — инфраструктура) |
| 9.4.2.141 | 1261 | PCP Handover element | М+С | handover.encode/parse_pcp_handover, check_handover_beacons (рис. 9-582) | pcp_handover | PLAN №65; в захватах нет |
| 9.4.2.142 | 1262 | DMG Link Margin element | М+С | linkadapt.LinkMargin / encode/parse/check_link_margin (рис. 9-583, табл. 9-266, коды MCS, −128, SNR — PLAN №36) | link_margin, link_meas | значения против измерения — не проверяемо (lm_measure); в захватах нет |
| 9.4.2.143 | 1263 | DMG Link Adaptation Acknowledgment element | М+С | linkadapt.LaAck / encode/parse/check_la_ack (рис. 9-584) | link_margin | Reference Timestamp — PLAN №37; ссылка текста на 10.42.9 — опечатка (10.43) |
| 9.4.2.144 | 1263 | Switching Stream element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | Switching Stream — multi-band/FST — pro, будущее (в open — 0) |
| 9.4.2.145 | 1265 | Session Transition element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | Session Transition — multi-band/FST — pro, будущее (в open — 0) |
| 9.4.2.146 | 1266 | Cluster Report element | М+С | cluster.ClusterReport / encode/parse/check_cluster_report, report_condition, make_reports, check_sta_report (рис. 9-589, 9-590) | cluster | PLAN №82, №84; в захватах нет |
| 9.4.2.147 | 1268 | Relay Capabilities element | ВНЕ | optcaps.ELEMENT_OFF / check_relay_cap (рис. 9-592) | opt_caps | Relay Capabilities — relay — необязательно, не поддерживается (решение 2026-11-07); элемент и биты Relay Supporter/Client/Permission… — 0/нет |
| 9.4.2.148 | 1269 | Relay Transfer Parameter Set element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | Relay Transfer Parameter Set — relay — необязательно, не поддерживается (решение 2026-11-07) |
| 9.4.2.149 | 1270 | Quiet Period Request element | М+С | qab.encode/parse_qp_req, check_qp_req, quiet_intervals (рис. 9-595) | qab | в захватах нет (одна точка — NOT_CHECKABLE qab_peer) |
| 9.4.2.150 | 1271 | Quiet Period Response element | М+С | qab.encode/parse_qp_resp (рис. 9-596), check_response | qab | PLAN №62 |
| 9.4.2.151 | 1271 | BeamLink Maintenance element | М | fields.Blm / blm_time / blm_negotiate; linkmaint.negotiate |  | элемент (в Probe/Information) не кодируется отдельно — поле то же, что в SSW-Feedback |
| 9.4.2.152 | 1271 | Multiple MAC Sublayers (MMS) element | ВНЕ | optcaps.ELEMENT_OFF | opt_caps | MMS — MMS/MMSL — необязательно, не поддерживается (решение 2026-11-07); dot11MultipleMACActivated = false |
| 9.4.2.153 | 1273 | U-PID element | ВНЕ |  |  | U-PID — FST |
| 9.4.2.154 | 1274 | ECAPC Policy element | М+С | cluster.EcapcPolicy / encode/parse/check_ecapc_policy, available_bitmap, in_use_offsets (рис. 9-601, 9-602) | cluster | PLAN №81; в (Re)Association Response нет строки табл. 9-35 — PLAN №89 |
| 9.4.2.155 | 1275 | Cluster Time Offset element | М+С | cluster.encode/parse/check_cto, select_cto (рис. 9-603) | cluster | PLAN №81 |
| 9.4.2.156 | 1275 | Antenna Sector ID Pattern element | М+С | sectorpat.encode / parse / lfsr_step / sectors / check / check_beacons (рис. 9-604…9-606) | asid_pattern | PLAN №102; назначение — энергосбережение (11.2.7.1), в open не нужен |
| 9.4.2.217 | 1367 | Max Channel Switch Time element | М+С | ecs.encode/parse_mcst, check_mcst_in_frame, check_switch_gap (Length 4, Switch Time в TU) | ecs | в табл. 9-45 (DMG Beacon) нет — у DMG только Probe Response с ECSA; PLAN №104 |
| 9.4.2.219 | 1369 | CDMG Capabilities element | ВНЕ |  |  | CDMG/CMMG/EDMG-элементы (9.4.2.219–9.4.2.233) — вне охвата |

## 9.5 Поля BF и управления DMG

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.5.1 | 1437 | Sector Sweep field | М+С | fields.check/encode/parse_ssw | cfe_fields, beacon_fields, sls, abft | PLAN №2 |
| 9.5.2 | 1438 | Dynamic Allocation Info field | М+С | fields.check/encode/parse_dai; dynalloc; sp | dynalloc, sp_access | Allocation Duration по контексту Grant (9.5.2) |
| 9.5.3 | 1439 | Sector Sweep Feedback field | М+С | fields.check/encode/parse_ssw_fb, snr_quantize | cfe_fields, sls | PLAN №3, №6 |
| 9.5.4 | 1440 | BRP Request field | М+С | fields.check/encode/parse_brp_req; brp.BrpRequest | cfe_fields, brp, brp_role | PLAN №7 |
| 9.5.5 | 1441 | Beamforming Control field | М+С | fields.check/encode/parse_bf_control; schedule (в Extended Schedule); sp (BF в начале SP); dynalloc (Grant Ack: BT) | schedule, sp_access, dynalloc | в захватах нет |
| 9.5.6 | 1442 | Beamformed Link Maintenance field | М+С | fields.Blm, blm_time, blm_negotiate (табл. 9-344/9-345); linkmaint | blm | новое (волна C) |

## 9.6–9.7 Action-кадры и A-MPDU

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.6.2.4 | 1445 | TPC Request frame format | М+С | tpc.encode_tpc_request_frame / parse_tpc_frame / check_request (рис. 9-856, Dialog Token ≠ 0) | tpc |  |
| 9.6.2.5 | 1445 | TPC Report frame format | М+С | tpc.encode_tpc_report_frame / respond / check_report (рис. 9-857; 11.7.7 «shall respond») | tpc |  |
| 9.6.3.2 | 1448 | Basic and DMG ADDTS Request frame format | М+С | tspec.encode_addts_req / parse_addts / check_addts (табл. 9-348, 9-351) | addts | вариант по Element ID; Basic — только распознаётся; в захватах нет |
| 9.6.3.3 | 1450 | Basic and DMG ADDTS Response frame format | М+С | tspec.encode_addts_resp / parse_addts / check_addts / check_addts_pair (табл. 9-349, 9-353) | addts | вариант после TS Delay — PLAN №71; SUCCESS_POWER_SAVE_MODE — PLAN №72 |
| 9.6.3.4 | 1452 | DELTS frame format | М+С | tspec.encode/parse_delts, check_delts (табл. 9-354) | addts | DMG Allocation Info; хвост — только Multi-band (СПОРНО в tspec.parse_delts) |
| 9.6.4.2 | 1456 | ADDBA Request frame format | М+С | blockack.encode/parse_addba_req | addba |  |
| 9.6.4.3 | 1457 | ADDBA Response frame format | М+С | blockack.encode/parse_addba_resp, check_addba_response | addba |  |
| 9.6.4.4 | 1458 | DELBA frame format | М | blockack.encode/parse_delba |  | в захватах нет |
| 9.6.6.2 | 1459 | Radio Measurement Request frame format | М+С | spsh.encode_rm_request / parse_rm (рис. 9-860) | spsh | только тип Directional Channel Quality (13); Link Measurement — ref/linkadapt |
| 9.6.6.3 | 1460 | Radio Measurement Report frame format | М+С | spsh.encode_rm_report / parse_rm / check_rm_pair | spsh |  |
| 9.6.6.4 | 1460 | Link Measurement Request frame format | М+С | linkadapt.LmRequest / encode/parse/check_lm_request (рис. 9-862, 9.4.1.19/9.4.1.20) | link_meas | Action и Action No Ack (DMG); в захватах нет |
| 9.6.6.5 | 1461 | Link Measurement Report frame format | М+С | linkadapt.LmReport / encode/parse/check_lm_report (рис. 9-863: TPC Report, DMG antenna ID, RCPI табл. 9-176, RSNI, DMG Link Margin, DMG LA Ack) | link_meas, link_margin | в захватах нет |
| 9.6.7.7 | 1469 | Extended Channel Switch Announcement frame format | М+С | chswitch.encode/parse_ecsa_frame, check_ecsa_frame_addr (рис. 9-871, 11.9.1) | ecsa | Mesh Channel Switch Parameters, Wide Bandwidth Channel Switch — не DMG; New Country / New TPE — только как элементы |
| 9.6.7.34 | 1492 | QAB Request frame format | М+С | qab.encode_frame / parse_frame / check_request (табл. 9-381) | qab | Protected Dual (категория 9, табл. 9-404) — тот же формат |
| 9.6.7.35 | 1493 | QAB Response frame format | М+С | qab.encode_frame / check_response (табл. 9-382) | qab |  |
| 9.6.13.1 | 1528 | WNM Action fields | М+С | actions.ACTION[10]/[11] (табл. 9-425/9-434), WNM_FEATURE_BIT, check_wnm_request / check_wnm_response; dms (WNM Action 23/24) | wnm, dms | FMS / WNM sleep / TIM broadcast / TIM — на TIM/DTIM, у DMG nondmg; BSS Transition и прочие — применимы к DMG, в open не реализуются (биты 0); отказ разбирается у BTM и DMS (wnm_reject_status); PLAN №107 |
| 9.6.13.26 | 1547 | DMS Request frame format | М+С | dms.encode_request_frame / parse_frame / check_request (рис. 9-947) | dms | в захватах нет |
| 9.6.13.27 | 1547 | DMS Response frame format | М+С | dms.encode_response_frame / parse_frame / check_response / check_exchange (рис. 9-948) | dms | в захватах нет |
| 9.6.19.2 | 1570 | Power Save Configuration Request frame format | ВНЕ | optcaps.check_action | opt_caps | PSC Request: энергосбережение — не делаем; от нашей STA — нарушение |
| 9.6.19.3 | 1570 | Power Save Configuration Response frame format | ВНЕ | optcaps.check_action | opt_caps | PSC Response точки — только отказ (Status Code ≠ SUCCESS) без DMG Wakeup Schedule |
| 9.6.19.4 | 1571 | Information Request frame format | М+С | discovery.encode_request / parse / check_request (табл. 9-460; Request — 9.4.2.9, Extended Request — 9.4.2.10) | info_req | в захватах нет |
| 9.6.19.5 | 1572 | Information Response frame format | М+С | discovery.encode_response / check_response (табл. 9-461) | info_req | «пустой» ответ — только свой DMG Capabilities (PLAN №60) |
| 9.6.19.6 | 1573 | Handover Request frame format | М+С | handover.encode_request / parse_frame / check_request (табл. 9-462) | pcp_handover | в захватах нет |
| 9.6.19.7 | 1573 | Handover Response frame format | М+С | handover.encode_response / check_response (табл. 9-463) | pcp_handover | Result 2/3 из 11.27.2.2 — PLAN №64 |
| 9.6.19.8 | 1574 | Relay Search Request frame format | ВНЕ | optcaps.ACTION_OFF | opt_caps | 9.6.19.8–9.6.19.22: relay, RLS, TPA, ROC — relay — необязательно, не поддерживается (решение 2026-11-07); DMG Action 8–22 в наших кадрах — нарушение |
| 9.6.21.2 | 1588 | Announce frame format | М | mlme.AtiAp / check_ati_frame; air_judge._bss_frames (ECSA, DMG BSS Parameter Change — табл. 9-487) | ati, ecsa | Announce — в захватах нет (ATI Present = 0); air_pcap называет Announce по категории/действию 20/0 |
| 9.6.21.3 | 1590 | BRP frame format | М+С | brp.BrpFrame, brp_frame_length | brp, brp_role |  |
| 9.7.1 | 1612 | A-MPDU format | М+С | duration (A-MPDU); ampdu.build / parse / check, encode/parse_delim (рис. 9-971, 9-973, 9-975, табл. 9-528) | ampdu_dur, ampdu_limits | разделители запись не несёт — судья по длине PSDU; паддинг/спейсинг — NOT_CHECKABLE ampdu_spacing |
| 9.7.2 | 1615 | MPDU delimiter CRC field | М | ampdu.crc8 (рис. 9-977) |  | разделители запись не несёт |
| 9.7.3 | 1615 | A-MPDU contents | М+С | duration.check_ampdu_same_duration; blockack.ampdu_response | ampdu_dur, ack_policy |  |

## 10.3 DCF-основа: CS, IFS, NAV, ответы

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.3.2.1 | 1642 | CS mechanism | М+С | cbap.Nav.busy; nav.MultiNav.busy (несколько NAV) | nav_rx, access | новое: nav.py |
| 10.3.2.3.3 | 1644 | SIFS | М+С | timing.SIFS, SIFS_TOL | ifs_sifs, holder_gap |  |
| 10.3.2.3.4 | 1645 | PIFS | М+С | timing.PIFS, PIFS_TOL | holder_gap, sls (повтор Feedback) | PLAN №8 |
| 10.3.2.3.5 | 1646 | DIFS | М | timing.DIFS |  | в DMG EDCA — AIFS |
| 10.3.2.3.6 | 1646 | AIFS | М+С | timing.aifs; cbap.Edcaf | access |  |
| 10.3.2.3.7 | 1647 | EIFS | М | cbap (EIFS) | access (EIFS после неверного приёма) |  |
| 10.3.2.3.8 | 1647 | SBIFS | М+С | timing.SBIFS, SBIFS_MAX | bi, sls, abft |  |
| 10.3.2.3.9 | 1648 | BRPIFS | М+С | timing.BRPIFS; brp | brp |  |
| 10.3.2.3.10 | 1648 | MBIFS | М+С | timing.MBIFS, MBIFS_TOL | sls, abft |  |
| 10.3.2.3.11 | 1648 | LBIFS | М+С | timing.lbifs / LBIFS | sls, abft | PLAN №2, №14 |
| 10.3.2.4 | 1648 | Setting and resetting the NAV | М+С | cbap.Nav (единый NAV, NAVTimeout DMG); nav.single_nav_updates, nav.check_nav_log | nav_rx, nav_txop | новое правило nav_rx (волна C) |
| 10.3.2.9 | 1655 | CTS and DMG CTS procedure | М+С | cbap.Nav.idle_for_rts; duration | resp_seq, dur_cts, ifs_sifs |  |
| 10.3.2.11 | 1660 | Acknowledgment procedure | М+С | cbap (AckTimeout, ответ) | ifs_sifs, ack_policy |  |
| 10.3.7 | 1680 | DCF timing relations | М+С | cbap (граница слота на эфире), timing | access, ifs_sifs |  |

## 10.2, 10.6, 10.12, 10.23, 10.25, 10.28, 10.29 — фрагментация, скорости, A-MPDU, EDCA, BA, элементы, RD

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.2.6 | 1638 | Fragmentation/defragmentation overview | М+С | addbaext.Agreement.check_fragment (DMG: по No-Fragmentation ответа ADDBA, вне A-MPDU, Normal Ack) | addba_ext | общий запрет для HT-immediate уступает DMG-абзацу (PLAN №101); фрагменты видны только с rxqos/txqos |
| 10.6.7.1 | 1701 | Usage of DMG Control modulation class | М+С | duration (control-кадры на MCS 0) | mcs_control |  |
| 10.6.7.2 | 1702 | Rate selection rules for Control frames transmitted by DMG STAs | М+С | duration.response_mcs_set / response_mcs | mcs_response |  |
| 10.11 | 1715 | A-MSDU operation | М+С | amsdu.check_mpdu / check_addresses / Aggregator / lifetime_expired / short_allowed | amsdu | DMG: одна пара RA/TA, один TID, без фрагментации, Address 1 индивидуальный, пределы табл. 9-253/9-254, под BA — A-MSDU Supported, Short — по PTP TSPEC (PTP TSPEC не разбирается — вердикт capture); SPP A-MSDU (табл. 10-12) — HT/S1G; PLAN №27, №28, №34 |
| 10.12 | 1719 | A-MPDU operation | М+С | blockack, duration; amsdu.check_ampdu_qos, check_mpdu(in_ampdu); ampdu.check / length_limit / mmss_octets / sc_rate (10.12.2–10.12.4, табл. 9-251, 20-15) | ampdu_dur, ba_window, amsdu, ampdu_limits | A-MSDU в A-MPDU — amsdu; длина по Maximum A-MPDU Length Exponent — ampdu_limits; Minimum MPDU Start Spacing (QoS Null DMG — без него) — модель; групповой RA — минимум/максимум по связанным |
| 10.13 | 1724 | PPDU duration constraint | М | amsdu.fits_ppdu / max_amsdu_in_ppdu (aPPDUMaxTime, табл. 20-30) |  | одно MPDU с A-MSDU 7935 октетов — ≈ 165 мкс на MCS 1: предел ограничивает A-MPDU, не A-MSDU |
| 10.23.2.2 | 1739 | EDCA backoff procedure | М | cbap.Edcaf (backoff a–e) | access (статистика AIFS) | выбор счётчика не наблюдаем — только распределение |
| 10.23.2.4 | 1741 | Obtaining an EDCA TXOP | М+С | cbap.Station | access |  |
| 10.23.2.8 | 1747 | Multiple frame transmission in an EDCA TXOP | М+С | cbap.Station (несколько кадров в TXOP) | holder_gap, responder_tx, nav_txop |  |
| 10.23.2.9 | 1750 | TXOP limits | М+С | cbap (лимит TXOP) | txop_limit |  |
| 10.23.2.10 | 1751 | Truncation of TXOP | М+С | cbap.Nav (CF-End DMG); duration.cf_end_nonzero_allowed | cf_end_rules, cf_end_unanswered |  |
| 10.23.2.12 | 1754 | Retransmit procedures | М | cbap (повторы, QSRC) |  | предел повторов MAC — открыт (MAC-STAND.md) |
| 10.25.1 | 1786 | Introduction | М+С | blockack (номера по модулю 4096) | ba_window |  |
| 10.25.2 | 1787 | Setup and modification of the block ack parameters | М+С | blockack.agreement_allowed, make_addba_response; amsdu (A-MSDU Supported ответа) | addba, amsdu |  |
| 10.25.6 | 1791 | HT-immediate block ack extensions | М+С | blockack.Recipient / Originator / Scoreboard / ReorderBuffer | ba_window, ba_control |  |
| 10.28.4 | 1816 | Response to an invalid Action and Action No Ack frame | М+С | actions.must_echo / check_echo | action_fmt | категория Reserved — нераспознана всегда; не-DMG/вне охвата — по реализации (None) |
| 10.28.6 | 863 | on the parsing of the elements. | М | elements.parse_elements (неизвестные ID) |  |  |
| 10.28.8 | 1817 | Extensible element parsing | М | elements.known_info (расширяемые элементы) |  |  |
| 10.28.11 | 1817 | Element fragmentation | М | elements.encode_fragmented |  |  |
| 10.29.2 | 1819 | Reverse direction (RD) exchange sequence | С |  | rd | reverse direction выключен намеренно (10.29.4: ответчик отклоняет RDG); судья ловит RDG/RD-ответ |
| 10.29.3 | 1820 | Rules for RD initiator | С |  | rd | см. выше |
| 10.29.4 | 1821 | Rules for RD responder | С |  | rd | см. выше |

## 10.39 Доступ к среде DMG

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.39.1 | 1878 | General | М | bi |  |  |
| 10.39.2 | 1878 | Access periods within a beacon interval | М+С | bi.layout / period_at / check_schedule; bi.rx_advance_time | bi |  |
| 10.39.3 | 1879 | ATI transmission rules | М+С | mlme.AtiAp / ati_sta_response / ati_start_earliest / check_ati_frame; bi (ATI) | ati | новое правило ati; в захватах ATI Present = 0 |
| 10.39.4 | 1882 | DTI transmission rules | М+С | bi; cbap; sp.check_dti (кто начинает, LP SC); dynalloc (Grant Ack) | bi, cbap_end, sp_access, dynalloc |  |
| 10.39.5 | 1882 | Contention based access period (CBAP) transmission rules | М+С | cbap.Station (CBAP-окна, приостановка EDCAF); bi; sp.check_dti (CBAP расписания) | cbap_end, access, sp_access | PLAN №9 |
| 10.39.6.1 | 1884 | General | М+С | bi.Allocation, full_tsf; schedule.check / check_repeats / StaView (obsolete) | bi, schedule | PLAN №12 |
| 10.39.6.2 | 1885 | Service period (SP) allocation | М+С | sp.check_sp / check_dti / sp_exchange; schedule (BF Training, aDMGPPMinListeningTime) | sp_access, bi | в захватах SP нет (CBAP Only); RD в SP — выключен намеренно |
| 10.39.6.3 | 1886 | Contention based access period (CBAP) allocation | М+С | bi (CBAP-распределения); schedule.check (CBAP Only); sp.check_dti (CBAP расписания) | bi, schedule, sp_access |  |
| 10.39.6.4 | 1887 | Pseudo-static allocations | М+С | bi.pseudo_static_valid, obsolete; schedule.check_history / StaView | schedule (история по BI) | PLAN №34 |
| 10.39.6.5 | 1888 | Guard time | М+С | bi.guard_time / guard_between; schedule.plan / check | schedule |  |
| 10.39.6.6 | 1888 | DMG and CMMG protected period | М+С | protperiod.PpStation / check_rts / check_dts / check_cts_answer / interference_constraints / rts_timeout; duration.duration_dts*; nav.MultiNav (DTS) | prot_period | в захватах SP нет (CBAP Only) — «не проверяемо»; прослушивание и NAV — NOT_CHECKABLE pp_listening; PLAN №69, №70 |
| 10.39.6.7 | 1895 | Service period recovery | М+С | sp.check_sp (AP-получатель после dot11SPIdleTimeout, только Truncatable); sprecovery.ati_responders / reclaimable / may_reclaim; sp.check_dti(reclaimed) | sp_access, sp_recovery | возврат SP по ответам в ATI — PLAN №103; в захватах SP нет |
| 10.39.7 | 1896 | Dynamic allocation of service period | М+С | dynalloc.pp / gp / check_dyn_log; duration.pp_schedule / duration_grant_* | dynalloc | PLAN №26–№29; в захватах нет — «не проверяемо» |
| 10.39.8 | 1900 | Dynamic truncation of service period | М+С | sp.check_sp, truncation_cf_end / truncation_grant; duration.duration_grant_truncation | sp_access | PLAN №32; CDMG (10.39.8.2) — вне охвата |
| 10.39.9 | 1901 | Dynamic extension of service period | М+С | sp.check_sp, extension; duration.duration_grant_ext_* | sp_access | PLAN №30 |
| 10.39.10 | 1902 | Updating multiple NAVs | М | nav.MultiNav (псевдокод буквально), nav.check_nav_log(multi=True) |  | новое; поддержка нескольких NAV у узла не видна — судья ведёт единый NAV (nav_multi) |
| 10.39.11 | 1370 | and is set to 0 otherwise. | ВНЕ |  |  | CDMG |

## 10.40–10.41 Кластеризация AP/PCP

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.40.1 | 1908 | General (DMG and CMMG AP or PCP clustering) | М+С | cluster.cluster_time_offset / beacon_sp / beacon_sp_of / maxmem_ok / check_cluster_params / check_own_beacon / check_beacon_series; fields.check/encode/parse_cc | beacon_fields, cluster | Beacon SP_n, ClusterMaxMem (целые мкс), предел Beacon SP Duration, роль/Cluster ID, CC в каждом маяке члена; CC без бит кластеризации — PLAN №87 |
| 10.40.2.1 | 1909 | Decentralized AP or PCP cluster formation | М+С | cluster.DecentralizedAp (start_sap, join, schedule, may_tx), empty_beacon_sps, beacon_sp_entries, check_beacon_sps_scheduled, check_member_vs_sap | cluster | PLAN №80, №83; прослушивание — NOT_CHECKABLE cluster_monitor |
| 10.40.2.2 | 1910 | Centralized AP or PCP cluster formation | М+С | cluster.CcsrConfig / check_ccsr_config / verification_ok / ecapc_blind / must_react_to_ecapc / CentralizedSap / CentralizedMember / select_cto | cluster | CCSR — «not defined» (NOT_CHECKABLE cluster_ccsr), слепота — cluster_blind; реакция любой точки на S-AP с ECAPC = 1 (join/cease) — судья, вердикт capture; ECAPC Policy в табл. 9-35 нет — PLAN №89 |
| 10.40.3.1 | 1914 | General cluster maintenance | М | cluster.tbtt_from_beacon (TBTT S-AP — опора) |  |  |
| 10.40.3.2 | 1914 | Decentralized AP or PCP cluster maintenance | М | cluster.DecentralizedAp.on_beacon / end_bi (периоды мониторинга, наименьший MAC, dot11MaxNumberOfClusteringMonitoringPeriods, встреча двух S-AP) |  | NOT_CHECKABLE cluster_handover (одна точка на стенде) |
| 10.40.3.3 | 1915 | Centralized AP or PCP cluster maintenance | М | cluster.CentralizedSap.reconfigure / CentralizedMember.on_sap_beacon / end_bi | cluster | ECAPC = 1 до конца BSS, после ухода ECAPC = 0 и без ECAPC Policy — судья (по маякам и кадрам) |
| 10.40.3.4 | 1916 | Centralized AP or PCP cluster MAC requirements | М | cluster.bhi_deadline / txss_cbap_windows |  | PLAN №85; NOT_CHECKABLE cluster_txss_cbap |
| 10.40.4 | 1917 | Cluster report and rescheduling | М+С | cluster.report_condition / make_reports / check_sta_report | cluster | «should send» — не нарушение; «shall not send» и копии полей — нарушения; PLAN №84 |
| 10.40.5 | 1918 | Decentralized AP or PCP cluster request | М+С | cluster.cluster_request_expired / check_broadcast_announce; DecentralizedAp (ответ точки — «should») | cluster | Announce с TA = broadcast — MCS 0 |
| 10.41 | 1919 | CDMG AP or PCP clustering | ВНЕ |  |  | CDMG |

## 10.42 Формирование луча DMG

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.42.1 | 1931 | General | М+С | sls (dot11BFRetryLimit, dot11MaxBFTime), brp.bf_brp_expired, medium | sls | PLAN №11 |
| 10.42.2.1 | 1933 | General | М+С | sls | sls |  |
| 10.42.2.2 | 1935 | Initiator sector sweep (ISS) | М+С | sls.plan_sweep / sweep_slots / slots_cdown, Initiator | sls |  |
| 10.42.2.3 | 1937 | Responder sector sweep (RSS) | М+С | sls.Responder; abft.Responder | sls, abft |  |
| 10.42.2.4 | 1940 | Sector sweep (SSW) feedback | М+С | sls; abft | sls |  |
| 10.42.2.5 | 1941 | SSW ack | М+С | sls | sls |  |
| 10.42.3.1 | 1941 | General | М+С | brp.run_transaction, Participant | brp, brp_role | новое правило brp_role (волна C) |
| 10.42.3.2 | 1943 | BRP setup subphase | М | brp.check_setup, setup_required, midc_subphases | brp (если есть setup) |  |
| 10.42.4 | 1938 | and 10.42.6 or if the end of an SSW slot is reached as described in | М+С | sls.bti_txss; bi.txss_plan / bti_beacons | bi, beacon_fields | PLAN №5 |
| 10.42.5.1 | 1946 | Allocation of A-BFT | М+С | abft.ApAbftSchedule, abft_start; bi | abft (Next A-BFT, N BIs A-BFT) |  |
| 10.42.5.2 | 1946 | Operation during the A-BFT | М+С | abft.Responder / ApAbft / simulate_abft / check_abft_log / may_access | abft (кадры в A-BFT, BIC), bi (abft_kind) | волна C: судья проверяет кадры в объявленной A-BFT; PLAN №1, №4 |
| 10.42.5.3 | 1950 | STA Beamforming after A-BFT | М | abft.Obligation / check_obligations |  | обязанности точки после A-BFT — нет кадров A-BFT |
| 10.42.5.4 | 1951 | Beamforming in A-BFT with multiple DMG antennas | М | abft (A-BFT Count, N A-BFT in Ant) | abft (BIC) | одна антенна у стенда |
| 10.42.6.1 | 1952 | General | М+С | sls | sls |  |
| 10.42.6.2 | 1952 | SLS phase execution | М+С | sls (SP/CBAP, MBIFS, повтор Feedback, PIFS) | sls |  |
| 10.42.6.3 | 1953 | Multiple sector ID capture (MIDC) subphase | М | brp.check_mid / check_bc / midc_subphases |  | MIDC в захватах нет |
| 10.42.6.4.1 | 1961 | General | М+С | brp.check_brp_log, _check_response_content | brp, brp_role (бит Initiator) |  |
| 10.42.6.4.2 | 1962 | Beam refinement transaction | М+С | brp.run_transaction | brp, brp_role |  |
| 10.42.6.4.3 | 1963 | Beam refinement transaction after SLS | М+С | brp.first_brp_after_sls_ok | brp_role (обязан послать BRP) | тип PPDU (BRP-RX) — не виден |
| 10.42.6.4.4 | 1963 | Antenna configuration setting during a beam refinement transaction | М | brp.rx_config_*, trn_r_tx_awv, reciprocity_awv |  | AWV не записываются |
| 10.42.7 | 1964 | Beam tracking | М | beamtrack.bt_time_limit (табл. 10-31), Initiator, Responder, check_bt_log | beam_track (поле) | новое; запросы в PPDU не видны (beam_tracking_ppdu); наше поле = 0 — «не поддерживается» |
| 10.42.8 | 1966 | State machines | М+С | sls.Initiator / Responder (рис. 10-91/10-92) | sls |  |
| 10.42.9 | 1967 | CDMG enhanced beam tracking | ВНЕ |  |  | CDMG enhanced beam tracking |

## 10.43–10.45 Адаптация, relay

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.43.1 | 1970 | General | М+С | linkadapt.LinkMeasResponder (токен ≠ 0 — следующий кадр, 0 — любой), check_report_reply, unsolicited | link_meas | выбор MCS/Activity — «implementation specific»; значения — lm_measure |
| 10.43.2 | 1971 | DMG TPC | М+С | linkadapt.TpcPeer, check_la_ack_reply, LA_ACK_DEADLINE (2·aPPDUMaxTime) | link_margin | выполнение рекомендации не видно (tpc_applied); PLAN №37 |
| 10.43.3 | 1971 | Fast link adaptation | М+С | linkadapt.check_fla_caps / fla_may_initiate / is_fla_request / check_fla_exchange / fla_respond (рис. 10-95, aMinPPDUDurationForDMGMeasurement) | link_meas | RD-роль и кадры с немедленным ответом — fla_immediate; откат на 10.43.1 — заметка, не нарушение; PLAN №35 |
| 10.44 | 1972 | Link adaptation using the CMMG link measurement | ВНЕ |  |  | CMMG |
| 10.45 | 1975 | DMG relay operation | ВНЕ |  | opt_caps | DMG relay — relay — необязательно, не поддерживается (решение 2026-11-07) (нет ни в open, ни в pro) |

## 11.1 Синхронизация, маяки, сканирование

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.1.2.1 | 2049 | TSF for an infrastructure BSS or a PBSS | М+С | bi (TSF, TBTT); mlme | bi |  |
| 11.1.3.1 | 2050 | General | М+С | mlme.LinkMonitor; tsf (Timestamp = TSF источника) | beacon_fields, bti_delay, timestamp | точка Timestamp — не проверяема (timestamp_point); монотонность, разности против меток RX пира, смещение от TBTT, одна точка — timestamp |
| 11.1.3.3.1 | 2052 | General | М+С | bi.txss_plan / bti_beacons; bssparams (сброс TSF при смене параметров BSS) | bi, bti_delay, bss_params |  |
| 11.1.3.3.2 | 2053 | Beacon generation in a PBSS | М | bi; mlme |  | PBSS — в захватах нет |
| 11.1.3.3.3 | 2053 | Beacon generation in a DMG infrastructure BSS | М | timing.DOT11_MAX_LOST_BEACONS |  | PLAN №10 |
| 11.1.3.4 | 2053 | DMG beacon generation before establishment of a BSS | М | mlme.DiscoveryBeaconing; abft (Discovery Mode) |  |  |
| 11.1.3.7 | 2055 | Beacon reception | М | mlme (приём маяка, синхронизация) |  |  |
| 11.1.3.9 | 2057 | TSF timer accuracy | М | timing.aDMGTSFAccuracy |  |  |
| 11.1.4.2.2 | 2061 | Passive scanning for DMG STAs | М | mlme.PassiveScan |  | RX управления в записи нет |
| 11.1.4.3.3 | 2063 | Active scanning procedure for a DMG STA | М | mlme.DmgActiveScan |  |  |
| 11.1.4.3.4 | 2065 | Criteria for sending a response | М | mlme.should_respond_probe |  |  |
| 11.1.4.3.9 | 2071 | Contents of a probe response | М+С | mlme.probe_response_ra; elements | mgmt_body |  |
| 11.1.4.3.10 | 2072 | PCP selection in a PBSS | М | mlme.pcp_factor / candidate_pcp |  | PBSS |
| 11.1.4.4.2 | 2075 | Initializing a DMG BSS | М | mlme.start_bssid / personal_start_window |  |  |
| 11.1.4.5 | 2075 | Synchronizing with a BSS | М | mlme.Join |  |  |
| 11.2.7 | 2112 | Power management in a PBSS and DMG infrastructure BSS | ВНЕ | optcaps | opt_caps | power save DMG — энергосбережение — не делаем (удалён намеренно) |
| 11.2.8 | 2124 | ATIM frame and frame transmission in IBSS, DMG infrastructure BSS, and PBSS | ВНЕ |  | opt_caps | ATIM — энергосбережение — не делаем (PS/IBSS) |

## 11.3 Аутентификация и ассоциация

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.3.1 | 2126 | State variables | М+С | mlme.Peer (State 2 — старт DMG без аутентификации) | assoc_state |  |
| 11.3.3 | 2127 | Frame filtering based on STA state | М+С | mlme.frame_class / class_allowed / may_transmit / rx_filter | assoc_state | новое правило assoc_state (волна C) |
| 11.3.4 | 2130 | Authentication and deauthentication | М+С | mlme.Peer.auth_ok / deauth; StaMlme; ApMlme | assoc_state (open_system) |  |
| 11.3.5.1 | 2132 | General | М+С | mlme.rx_filter | assoc_state (missing_reply) |  |
| 11.3.5.2 | 2133 | Non-AP and non-PCP STA association initiation procedures | М+С | mlme.StaMlme | assoc_state (holdoff) |  |
| 11.3.5.3 | 2135 | AP or PCP association receipt procedures | М+С | mlme.ApMlme (AID) | assoc_state (aid_range, aid_dup) |  |
| 11.3.5.4 | 2137 | Non-AP and non-PCP STA reassociation initiation procedures | М | mlme.StaMlme; dms.DmsProvider.reassociate (DMS-соглашения) |  | PLAN №31 |
| 11.3.5.5 | 2140 | AP or PCP reassociation receipt procedures | М | mlme.ApMlme |  |  |
| 11.3.5.6 | 2142 | Non-AP and non-PCP STA disassociation initiation procedures | М | mlme.StaMlme |  |  |
| 11.3.5.7 | 2142 | Non-AP and non-PCP STA disassociation receipt procedure | М+С | mlme.StaMlme | assoc_state |  |
| 11.3.5.8 | 2143 | AP or PCP disassociation initiation procedure | М | mlme.ApMlme |  |  |
| 11.3.5.9 | 2143 | AP or PCP disassociation receipt procedure | М | mlme.ApMlme |  |  |
| 11.3.5.10 | 2144 | PBSS procedures for nonassociated STAs | М | mlme |  | PBSS |
| 11.3.7 | 2145 | Communicating PBSS information | М | mlme.PbssInfoDistribution |  | PBSS |

## 11.4–11.17 TS, каналы, измерения, DSE, адресация Public Action

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.4.1 | 2147 | Introduction | М+С | tspec.allocation_key, check_dmg_tspec (LP SC Used, не-DMG STA) | addts | распределение — (Source AID, Allocation ID, Destination AID) |
| 11.4.4.4 | 2153 | TS setup procedures for both AP and non-AP STA initiation | М+С | tspec.AllocationTable.admit, response_targets, check_addts_pair (U-PID), check_schedule_has | addts | ответ — источнику и получателю; после SUCCESS — Extended Schedule |
| 11.4.7 | 2158 | Failed TS setup | М | tspec.check_addts (TS Delay ⇔ REJECTED_FOR_DELAY_PERIOD) | addts |  |
| 11.4.9.1 | 2159 | Deletion of a TS established between an HC, DMG AP, or PCP and a non-AP and non-PCP STA | М | tspec.AllocationTable.on_disassoc; tspec.check_delts | addts (DELTS) | удаление при (раз/пере)ассоциации — локально, DELTS пиру |
| 11.4.9.2 | 2160 | Peer-to-peer TS deletion and deletion of an allocation | М | tspec.AllocationTable.on_delts / on_disassoc |  | точка шлёт DELTS второй стороне (не broadcast) |
| 11.4.13 | 2165 | DMG allocation formats | М+С | tspec.check_isochronous / check_schedule_has (11.4.13.2–3) | addts | распределение после SUCCESS — в Extended Schedule; Minimum Allocation/Duration — should (NOT_CHECKABLE tspec_admission) |
| 11.8.2.2 | 2178 | Providing supported channels upon association in a DMG BSS | М+С | chswitch.check_association_channels, check_bcast_supported_channels | supp_channels | PLAN №41 (11.8.2.2 выше условия табл. 9-34/9-36); Country — не проверяется |
| 11.8.8.6 | 2188 | Selecting and advertising a new channel in a DMG BSS | М+С | chswitch.ApChannelSwitch / StaChannelSwitch / check_ecsa_sequence / check_sta_no_ecsa | ecsa | сам переход на канал не виден (ecsa_switch); PLAN №42 |
| 11.9 | 2189 | Extended channel switching (ECS) | М+С | chswitch (11.9.1: бит Extended Channel Switching, Address 1 кадра ECSA; 11.9.2: Current Operating Class; 11.9.3.2: ECSA только от AP); ecs.encode/parse_mcst, check_mcst_in_frame, check_switch_gap, ocv_required, check_after_switch | ecsa, supp_channels, ecs | DSE/enabling STA — диапазон 3650 МГц (11.11.1), у DMG не применимо; IBSS/MBSS (11.9.3.3–11.9.3.4) — вне open; Max Channel Switch Time у DMG — PLAN №104 |
| 11.10.11 | 2217 | Link measurement | М+С | linkadapt.LinkMeasResponder (activated / is_ap), rm_link_meas | link_meas | срок ответа не задан — REPLY_WAIT, вердикт model |
| 11.11 | 2223 | DSE procedures | ВНЕ |  |  | DSE — регуляторный механизм диапазона 3650 МГц (11.11.1); у DMG STA dot11DSERequired false; Public Action DSE — nondmg (ref/actions) |
| 11.17 | 2244 | Public Action frame addressing | М+С | addrs.check_addresses (Address 3: BSSID своей BSS, wildcard для групповых и чужих) | addr |  |

## 11.21 WNM

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.21.1 | 2256 | Wireless network management dependencies | М+С | actions.check_wnm_caps / check_wnm_request / check_wnm_response / WNM_DMG; dms.DmsRecipient.may_request, DmsProvider (отказ без бита) | wnm, dms | биты 7–27: не запрашивать неподдержанное, отказ на неподдержанное, WNM STA ⇒ ECS и Radio Measurement, Ext Cap в кадрах ассоциации/Probe |
| 11.21.16.1 | 2291 | General (group addressed transmission service) | М+С | dms (подэлементы GCR, «GCR Advertise» — нарушения) | dms | DMG STA не использует GCR |
| 11.21.16.2 | 2291 | DMS procedures | М+С | dms.DmsProvider (on_request, terminate, transmit_group) / DmsRecipient (request, on_response, rx_group, rx_amsdu) / check_exchange | dms | отброс станцией и групповая копия — не проверяемо (dms_recipient, dms_group_copy); FMS/TFS — нет; PLAN №29–33 |
| 11.21.16.3 | 2294 | GCR procedures | ВНЕ |  |  | 11.21.16.1: «DMG STAs do not use GCR» |
| 11.21.16.4 | 2305 | GLK-GCR | ВНЕ |  |  | GLK и GCR — не DMG |

## 11.27–11.37 DMG-процедуры

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.27.1 | 2355 | Beamformed link maintenance | М+С | linkmaint.negotiate / LinkTimer / expiry / sets_timer / check_blm_log | blm | новое; у нас BLM Value = 0 — dot11BeamLinkMaintenanceTime не определён |
| 11.27.2 | 2357 | PCP Handover | М+С | handover.HandoverPcp / HandoverMember / ImplicitCandidate / choose_new_pcp / check_handover_beacons / check_pseudo_static_kept / check_member_contact | pcp_handover | явная и неявная передача; MIB dot11NbrOfChangeBeacons/dot11ImplicitHandoverLostBeacons — PLAN №65, №66; неявная — NOT_CHECKABLE handover_implicit |
| 11.28 | 2359 | DMG BSS peer and service discovery | М+С | discovery.InfoStation (on_request, presence_probe), ap_should_respond, check_answer_content | info_req | PLAN №60, №61; поддержка элементов отвечающим — NOT_CHECKABLE info_resp_supported; Supported Channels (11.8.2.2) — ref/linkadapt |
| 11.29.1 | 2361 | General | М+С | bssparams.ApBssParamChange / check_beacon_sequence (элемент в каждом маяке до вступления) | bss_params | Announce и доставка STA с псевдостатичными SP/PS — нет (SP — pro, PS удалён) |
| 11.29.2 | 2361 | Moving the TBTT | М+С | bssparams.ApBssParamChange.plan(move_to) / check_beacon_sequence / sta_tx_crosses_new_tbtt (рис. 11-47) | bss_params | PLAN №38, №39, №40; после сброса TSF — bss_params_tsf |
| 11.29.3 | 2362 | Changing beacon interval duration | М+С | bssparams.ApBssParamChange.plan(new_bi_tu) / check_beacon_sequence / check_schedule_fits (рис. 11-48) | bss_params | PLAN №38 |
| 11.29.4 | 2363 | Maintaining synchronization in an AP or PCP cluster | М+С | cluster.change_moves_beacon_sps / member_change / check_change_beacons | cluster | Clustering Control S-AP в каждом маяке с DMG BSS Parameter Change; член вставляет свой элемент сразу |
| 11.29.5 | 2363 | Recommending DMG BSS parameters to the AP or PCP | М+С | bssparams.recommend / ap_answer / check_recommendation_answer | bss_params | в захватах нет |
| 11.30 | 2364 | Spatial sharing and interference mitigation for DMG STAs | М+С | spsh.assessment_requests / monitor_request / answer / check_dcq_req / check_dcq_rep / check_rm_pair / check_overlap_allowed / measurement_antenna / SwitchBackoff (11.30.1–11.30.4) | spsh | значения ANIPI/RSNI — NOT_CHECKABLE spsh_measure; совмещение SP — should (вердикт model) |
| 11.31 | 2367 | Multi-band operation | ВНЕ |  | opt_caps | multi-band/FST — pro, будущее (в open — 0); категория FST и Multi-band в наших кадрах — нарушение |
| 11.32 | 2383 | MMSL cluster operation | ВНЕ |  | opt_caps | MMS/MMSL — необязательно, не поддерживается (решение 2026-11-07) |
| 11.33 | 2385 | DMG coexistence with non-IEEE-802.11 systems | ВНЕ |  |  | сосуществование с не-802.11 — требований к нашему MAC нет |
| 11.34 | 2386 | DMG relay procedures | ВНЕ |  | opt_caps | relay — необязательно, не поддерживается (решение 2026-11-07) |
| 11.35 | 2389 | Quieting adjacent DMG BSSs | М+С | qab.QabRequester / QabResponder / quiet_intervals / quiet_allocation_ok / check_quiet_tx | qab | PLAN №62; на стенде одна точка — NOT_CHECKABLE qab_peer |
| 11.36 | 2391 | DMG beamforming | М+С | bftrain.BfTrainingSme (6.3.91: .request / .confirm / .indication; SLS, затем BRP iff RequestBRP), check_air; dmg_sta (SLS + BRP при входе STA); sls, abft, brp | bf_training, sls, brp | RequestBRP и примитивы по эфиру не видны (bf_request_brp); BRP без SLS пары — model |
| 11.37 | 2393 | DMG MAC sublayer attributes | М+С | timing (табл. 11-22) |  | постоянные — test_consistency |

## Решения по охвату

- **Кластеризация AP/PCP (10.40, 11.29.4, 9.4.2.146/154/155)** — в охвате open (решение 2026-11-07): модель `cluster`
  (Beacon SP, децентрализованная и централизованная, S-AP/член, сопровождение, Cluster Report, ECAPC Policy, Cluster Time
  Offset, BHI/TXSS CBAP), судья `cluster` (`air_wave4`). Сейчас маяки open объявляют CC Present = 0, биты Decentralized/
  Centralized AP or PCP Clustering = 0 — судья проверяет согласованность «кластеризация не используется»; кадров кластера
  в захватах нет. Централизованный член требует MM-SME со второй non-AP STA (10.40.2.2), S-AP — CCSR (вне стандарта).
- **Relay (10.45, 11.34, 9.4.2.147/148, 9.6.19.8–9.6.19.22)** — необязательно, не поддерживается (решение 2026-11-07),
  нет ни в open, ни в pro; судья `opt_caps`: элементов и кадров relay в наших кадрах нет.
- **MMS/MMSL (11.32, 9.4.2.152)** — необязательно, не поддерживается (решение 2026-11-07); `opt_caps`.
- **Multi-band/FST (11.31, 9.4.2.138/144/145, категория FST)** — pro, будущее; в open — 0/нет (`opt_caps`).
- **Расписание DTI, SP и динамическое распределение (9.4.2.131, 10.39.6–10.39.9, Poll/SPR/Grant/Grant Ack)** — охват
  open (open — реализация стандарта): модель `schedule` (Extended Schedule, согласованность с BI, псевдостатика, знание
  STA, генератор), `sp` (правила SP, усечение, продление, восстановление, CBAP расписания, судья DTI `check_dti`),
  `dynalloc` (PP/GP, Grant Ack, использование выделенного), сценарии `tdma_scen`; судья `schedule`, `sp_access`,
  `dynalloc` (`air_sched`). В захватах стенда расписания с SP и этих кадров нет — `sp_access`/`dynalloc` «не
  проверяемо» с причиной. Не реализовано: защищённый период (10.39.6.6), резервирование через DMG TSPEC/ADDTS (11.4),
  spatial sharing (11.30).
- **Power save (11.2.7, PSC, Awake Window, Wakeup Schedule)** — энергосбережение не делаем (удалён намеренно); точка
  отвечает отказом на PSC-REQ. `opt_caps`: Triggered Unscheduled PS, PS-биты Extended Capabilities, PS-элементы и кадры,
  Power Management = 1 — в наших кадрах 0/нет (список — ref/optcaps).
- **Reverse direction (10.29)** — выключен намеренно; судья rd ловит RDG/RD-ответы в эфире.
- **BRP TXSS** — EDMG (802.11-2024 10.41.10.5), в 802.11-2020 нет; в 2020 есть только запрос списка секторов
  TXSS-FBCK-REQ в BRP (10.42.6.4.1) — brp (`txss-fbck`).
- **GCR (11.21.16.3–11.21.16.4, 9.4.2.125)** — «DMG STAs do not use GCR» (11.21.16.1); подэлементы GCR в DMS-элементах
  и «GCR Advertise» модель dms считает нарушением у DMG.
- **CDMG/CMMG/EDMG** (10.37, 10.39.11, 10.41, 10.42.9, 10.44, 9.4.2.219–9.4.2.233) — вне охвата.

## Приоритеты «Н» для open (что делает прошивка в эфире)

«Н» и «Ч» в карте нет (волна 5). По записям стенда судья волны 5 видит: Timestamp Probe Response точки = 0 (`timestamp`;
9.4.1.10, 11.1.3.1); Antenna Sector ID Pattern из нулей в Probe Response (`asid_pattern`: Tap 1 = 0 — элемент
недействителен, энергосбережения в open нет — элемент не нужен); биты WNM в Extended Capabilities (точка — 25, станция —
17, 19, 25) без Extended Channel Switching и Radio Measurement (`wnm`, 11.21.1). Не реализовано в прошивке (кадров в
захватах нет): возврат нераспознанного Action с MSB = 1 (10.28.4), TPC Request/Report (не обязательны при Spectrum
Management = 0), STA Availability, восстановление SP по ATI, Max Channel Switch Time, OCV; для SP — защищённый период
(10.39.6.6), резервирование DMG TSPEC/ADDTS (11.4), spatial sharing (11.30) — сначала нужен сценарий.
