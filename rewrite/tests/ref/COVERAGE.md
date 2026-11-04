# Покрытие 802.11-2020 эталонной моделью DMG MAC

Карта DMG-пунктов стандарта (802.11-2020, `docs/80211-2020.txt`; заголовок и страница — из текста, страница — маркер `[Page N]` после заголовка): что есть в модели `rewrite/tests/ref` (модуль/функция), есть ли правило судьи эфира `air_judge` (id правила), что не реализовано и что вне охвата (с причиной). Охват: open — AP/STA/PCP/PBSS DMG по стандарту; pro — FTM, OOB, IBSS, строгий SP/PP-GP TDMA; power save и adhoc удалены намеренно (точка отвечает отказом на PSC-REQ); reverse direction выключен намеренно (10.29.4).

Статусы: **М+С** — модель и правило судьи эфира; **М** — модель (по захватам не проверяется: кадров нет или поле не записано); **Ч** — частично (что именно — в примечании); **С** — только судья; **Н** — не реализовано (в охвате open); **ВНЕ** — вне охвата (причина в примечании). Перечень «не проверяемо по записи» — `air_judge.NOT_CHECKABLE`.

## Сводка

| Статус | Пунктов |
|---|---|
| М+С | 108 |
| М | 52 |
| Ч | 15 |
| С | 3 |
| Н | 26 |
| ВНЕ | 52 |
| всего | 256 |

Реализовано (М+С, М, С): 163; частично: 15; не реализовано: 26; вне охвата: 52.

## 9.2 Общий формат MAC-кадра (DMG-особенности)

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.2.2 | 755 | Conventions | М+С | fields._pack/_unpack (порядок бит, резерв = 0) | fc, ba_control (резерв) | PLAN №18: BA Control B0 |
| 9.2.4.1 | 758 | Frame Control field | М+С | fields.check_fc / encode_fc / parse_fc (рис. 9-3, 9-4, табл. 9-1, 9-2) | fc |  |
| 9.2.4.2 | 767 | Duration/ID field | М+С | duration.field / decode | dur_cts, dur_resp, dur_cf_end, dur_bf |  |
| 9.2.4.3 | 768 | Address fields | Ч | fields.mac_str / is_group; air_pcap (RA/TA) | resp_seq, cts_self | адреса — как часть кадров |
| 9.2.4.4 | 770 | Sequence Control field | М+С | blockack.encode_ssc / parse_ssc, sn_* | ba_window |  |
| 9.2.4.5 | 771 | QoS Control field | Ч | air_judge.qos_of (табл. 9-11) | ack_policy, rd | поля QoS Control данных; модели-генератора нет |
| 9.2.4.6 | 777 | HT Control field | М+С | fields.check_fc (+HTC = 0 у DMG) | fc | HT Control в DMG не используется |
| 9.2.4.8 | 790 | FCS field | М | fields.fcs / fcs_residue |  | FCS в записи PMC не хранится |
| 9.2.5 | 791 | Duration/ID field (QoS STA) | М+С | duration.* (QoS STA, 9.2.5.1–9.2.5.7) | dur_resp, dur_cts, nav_txop, txop_limit | PLAN №19 |

## 9.3.1 Кадры управления (Control)

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.3.1.2 | 797 | RTS frame format | М+С | duration.duration_rts; cbap.Station | ctl_len, txop_limit, resp_seq |  |
| 9.3.1.4 | 798 | Ack frame format | М+С | duration.duration_ack; cbap | ctl_len, dur_resp, mcs_response |  |
| 9.3.1.5 | 799 | PS-Poll frame format | ВНЕ |  |  | PS-Poll — power save удалён намеренно |
| 9.3.1.6 | 799 | CF-End frame format | М+С | duration.duration_cf_end / cf_end_check; cbap.Nav | dur_cf_end, cf_end_rules, cf_end_unanswered |  |
| 9.3.1.7 | 800 | BlockAckReq frame format | М+С | blockack (BlockAckReq) | resp_seq |  |
| 9.3.1.8 | 803 | BlockAck frame format | М+С | blockack.encode_ba_control / encode_ba_info / Scoreboard | ba_control, ba_window, mcs_response | битмап целиком — не проверяемо (ba_scoreboard) |
| 9.3.1.9 | 807 | Control Wrapper frame format | ВНЕ |  |  | Control Wrapper — не для DMG (+HTC = 0) |
| 9.3.1.10 | 808 | Poll frame format | М | fields.encode_frame/parse_frame (Poll); duration | cfe_fields (если есть) | Poll — динамическое распределение (pro), в захватах нет |
| 9.3.1.11 | 808 | Service period request (SPR) frame format | М | fields (SPR, 9.5.2, 9.5.5); duration.duration_spr_* | cfe_fields (если есть) | pro |
| 9.3.1.12 | 809 | Grant frame format | М | fields (Grant); duration.duration_grant_*; sls.iss_start_after_grant | cfe_fields (если есть) | pro; SLS по Grant — sls |
| 9.3.1.13 | 809 | DMG CTS frame format | М+С | fields (DMG CTS); duration.duration_cts_response / duration_cts_to_self; nav.single_nav_updates | dur_cts, cfe_fields, resp_seq, cts_self | новое правило cts_self: TA CTS-to-self (волна C) |
| 9.3.1.14 | 810 | DMG DTS frame format | М | fields (DMG DTS); duration.duration_dts; nav.MultiNav (NAV-SA/NAV-DA) |  | DTS — защищённый период/SP (pro) |
| 9.3.1.15 | 810 | Sector sweep (SSW) frame format | М+С | fields (SSW); sls; abft; duration.duration_ssw | cfe_fields, dur_bf, sls, abft |  |
| 9.3.1.16 | 811 | Sector sweep feedback (SSW-Feedback) frame format | М+С | fields (SSW-Feedback); sls; abft; duration.duration_ssw_fb | cfe_fields, dur_bf, sls, blm |  |
| 9.3.1.17 | 811 | Sector sweep Ack (SSW-Ack) frame format | М+С | fields (SSW-Ack); sls; duration.duration_ssw_ack | cfe_fields, dur_bf, sls, blm, brp_role |  |
| 9.3.1.18 | 812 | Grant Ack frame format | М | fields (Grant Ack); duration.duration_grant_ack |  | pro |
| 9.3.1.19 | 812 | VHT NDP Announcement frame format | ВНЕ |  |  | VHT NDP Announcement — не DMG |
| 9.3.1.21 | 814 | TACK frame format | ВНЕ |  |  | TACK — S1G |

## 9.3.2–9.3.4 Данные, управление, DMG Beacon

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.3.2.1 | 815 | Format of Data frames | Ч | blockack, duration.duration_data_single | ack_policy, rd, ampdu_dur | заголовки данных — только в записях rxqos/txqos |
| 9.3.2.2 | 819 | Aggregate MSDU (A-MSDU) format | Н |  |  | A-MSDU (в т. ч. Short A-MSDU DMG) не моделируется; согласование — ADDBA |
| 9.3.3.1 | 822 | Format of (PV0) Management frames | М+С | elements.check_order (порядок, «Last») | mgmt_body |  |
| 9.3.3.2 | 825 | Beacon frame format | ВНЕ |  |  | Beacon (не DMG); DMG — 9.3.4.2 |
| 9.3.3.3 | 829 | ATIM frame format | ВНЕ |  |  | ATIM — PS/IBSS |
| 9.3.3.4 | 829 | Disassociation frame format | М+С | elements (Disassociation, табл. 9-33) | mgmt_body, assoc_state |  |
| 9.3.3.5 | 830 | Association Request frame format | М+С | elements (табл. 9-34) | mgmt_body, assoc_state |  |
| 9.3.3.6 | 832 | Association Response frame format | М+С | elements (табл. 9-35), _check_assoc_resp | mgmt_body, assoc_state (AID, статус) |  |
| 9.3.3.7 | 835 | Reassociation Request frame format | М+С | elements (табл. 9-36) | mgmt_body, assoc_state | в захватах нет |
| 9.3.3.8 | 839 | Reassociation Response frame format | М+С | elements (табл. 9-37) | mgmt_body, assoc_state | в захватах нет |
| 9.3.3.9 | 843 | Probe Request frame format | М+С | elements (табл. 9-38) | mgmt_body, beam_track |  |
| 9.3.3.10 | 845 | Probe Response frame format | М+С | elements (табл. 9-39); mlme.should_respond_probe / probe_response_ra | mgmt_body, beam_track | PLAN №15 |
| 9.3.3.11 | 850 | Authentication frame format | М+С | elements (табл. 9-40/9-41), _check_auth | mgmt_body, assoc_state (open_system) | у DMG — без Open System (12.3.3.1); в захватах нет |
| 9.3.3.12 | 856 | Deauthentication | М+С | elements (табл. 9-42) | mgmt_body, assoc_state | в захватах нет |
| 9.3.3.13 | 856 | Action frame format | Ч | air_pcap.classify (категория, действие) | addba, brp, assoc_state | общий формат Action |
| 9.3.3.14 | 856 | Action No Ack frame format | Ч | air_pcap.classify | brp, brp_role | Action No Ack: BRP, Announce |
| 9.3.3.15 | 857 | Timing Advertisement frame format | ВНЕ |  |  | Timing Advertisement — не DMG-функция |
| 9.3.4.2 | 857 | DMG Beacon | М+С | fields.encode/parse/check_dmg_beacon (табл. 9-45, рис. 9-77…9-79); bi; duration.duration_dmg_beacon | beacon_fields, bi, bti_delay, abft, ati |  |

## 9.4.1 Поля тел кадров

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.4.1.1 | 867 | Authentication Algorithm Number field | М+С | elements (Authentication Algorithm Number) | mgmt_body, assoc_state |  |
| 9.4.1.2 | 867 | Authentication Transaction Sequence Number field | М+С | elements | mgmt_body |  |
| 9.4.1.3 | 868 | Beacon Interval field | М+С | fields (DMG Beacon), elements | beacon_fields, bi |  |
| 9.4.1.4 | 868 | Capability Information field | М+С | elements.encode/parse/validate_capinfo_dmg (рис. 9-86) | mgmt_body |  |
| 9.4.1.5 | 870 | Current AP Address field | М | elements (Current AP Address) |  |  |
| 9.4.1.6 | 870 | Listen Interval field | М+С | elements | mgmt_body |  |
| 9.4.1.7 | 871 | Reason Code field | М+С | elements; mlme (CONFIG_REASON) | mgmt_body, assoc_state |  |
| 9.4.1.8 | 874 | AID field | М+С | elements; timing.AID_*; mlme.ApMlme | assoc_state (aid_range, aid_dup) | DMG: 1…254 |
| 9.4.1.9 | 875 | Status Code field | М+С | elements; mlme (статусы) | mgmt_body, assoc_state |  |
| 9.4.1.10 | 880 | Timestamp field | Ч | fields (DMG Beacon), bi | beacon_fields (Timestamp = метка TX) | точка Timestamp (11.1.3.1) — не проверяема без внешней опоры (timestamp_point) |
| 9.4.1.11 | 880 | Action field | Ч | air_pcap.ACTION_NAME | addba, brp | категории/действия, нужные DMG |
| 9.4.1.12 | 882 | Dialog Token field | М+С | blockack | addba |  |
| 9.4.1.13 | 882 | Block Ack Parameter Set field | М+С | blockack.encode/parse_ba_params | addba |  |
| 9.4.1.14 | 883 | Block Ack Timeout Value field | М+С | blockack.InactivityTimer | addba |  |
| 9.4.1.16 | 884 | DELBA Parameter Set field | М | blockack.encode/parse_delba_params |  | DELBA в захватах нет |
| 9.4.1.44 | 906 | Relay Capable STA Info field | ВНЕ |  |  | Relay Capable STA Info — relay вне охвата |
| 9.4.1.45 | 907 | Band ID field | ВНЕ |  |  | Band ID — multi-band/FST вне охвата |
| 9.4.1.46 | 907 | DMG Parameters field | М+С | fields.check/encode/parse_dmg_params; elements; bi.DmgParameters | beacon_fields, mgmt_body | PLAN №9 |

## 9.4.2 Элементы (DMG и используемые DMG STA)

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.4.2.2 | 949 | SSID element | М+С | elements.encode/parse_ssid | mgmt_body |  |
| 9.4.2.24 | 1051 | RSNE | Ч | elements.encode/parse_rsne (структура) | mgmt_body, assoc_state (rsna) | допустимые наборы шифров/AKM не проверяются |
| 9.4.2.25 | 1060 | Vendor Specific element | М | elements.encode_vendor | mgmt_body (порядок) |  |
| 9.4.2.26 | 1061 | Extended Capabilities element | Ч | elements (порядок) | mgmt_body | содержимое не разбирается |
| 9.4.2.28 | 1068 | EDCA Parameter Set element | М+С | cbap.EdcaParams; air_judge.edca_from | edca, access, txop_limit |  |
| 9.4.2.48 | 1116 | Timeout Interval element (TIE) | М+С | elements.encode/parse_tie; mlme (holdoff) | assoc_state (holdoff) |  |
| 9.4.2.52 | 1119 | Extended Channel Switch Announcement element | Н |  |  | Extended Channel Switch Announcement (смена канала DMG, 11.8.8.6) — не моделируется |
| 9.4.2.53 | 1119 | Supported Operating Classes element | Ч | elements (порядок) | mgmt_body | содержимое не разбирается |
| 9.4.2.125 | 1234 | GCR Group Address element | ВНЕ |  |  | GCR — не DMG |
| 9.4.2.126 | 1235 | DMG BSS Parameter Change element | М | elements.encode/parse_bss_param_change |  | процедура 11.29 — нет |
| 9.4.2.127 | 1235 | DMG Capabilities element | М+С | elements.encode/parse/validate_dmg_capabilities (рис. 9-549…9-554) | mgmt_body, beam_track |  |
| 9.4.2.128 | 1242 | DMG Operation element | М+С | elements.encode/parse/validate_dmg_operation; mlme (MIB из DMG Operation) | mgmt_body |  |
| 9.4.2.129 | 1244 | DMG Beam Refinement element | М+С | brp.BeamRefinement (рис. 9-558…9-560) | brp, brp_role | новое правило brp_role: Initiator |
| 9.4.2.130 | 1246 | DMG Wakeup Schedule element | ВНЕ |  |  | DMG Wakeup Schedule — power save удалён |
| 9.4.2.131 | 1246 | Extended Schedule element | М+С | elements.encode/parse/validate_extended_schedule; bi.Allocation / layout | bi | в маяках стенда Extended Schedule нет (CBAP Only) |
| 9.4.2.132 | 1250 | STA Availability element | ВНЕ |  |  | STA Availability — для PS/планирования SP |
| 9.4.2.133 | 1251 | DMG TSPEC element | ВНЕ |  |  | DMG TSPEC — резервирование SP (pro) |
| 9.4.2.134 | 1254 | CMMG TSPEC element | ВНЕ |  |  | CMMG |
| 9.4.2.135 | 1255 | Next DMG ATI element | М | elements.encode/parse_next_dmg_ati; bi; mlme.ati_start_earliest | ati (ATI Present) | в захватах ATI нет |
| 9.4.2.136 | 1255 | Channel Measurement Feedback element | М | brp.cmf_payload / cmf_octets (табл. 9-263/9-264) | brp (размер) |  |
| 9.4.2.137 | 1258 | Awake Window element | ВНЕ |  |  | Awake Window — PS |
| 9.4.2.138 | 1258 | Multi-band element | ВНЕ |  |  | Multi-band — FST вне охвата (elements знает порядок) |
| 9.4.2.139 | 1260 | ADDBA Extension element | Н |  |  | ADDBA Extension — не используется |
| 9.4.2.140 | 1261 | Next PCP List element | Н |  |  | Next PCP List — передача PCP (11.27.2), не реализовано |
| 9.4.2.141 | 1261 | PCP Handover element | Н |  |  | PCP Handover — 11.27.2, не реализовано |
| 9.4.2.142 | 1262 | DMG Link Margin element | Н |  |  | DMG Link Margin — 10.43 (TPC/быстрая адаптация), не реализовано |
| 9.4.2.143 | 1263 | DMG Link Adaptation Acknowledgment element | Н |  |  | DMG Link Adaptation Acknowledgment — 10.43, не реализовано |
| 9.4.2.144 | 1263 | Switching Stream element | ВНЕ |  |  | Switching Stream — FST |
| 9.4.2.145 | 1265 | Session Transition element | ВНЕ |  |  | Session Transition — FST |
| 9.4.2.146 | 1266 | Cluster Report element | ВНЕ |  |  | Cluster Report — кластеризация (решение ниже) |
| 9.4.2.147 | 1268 | Relay Capabilities element | ВНЕ |  |  | Relay Capabilities — relay |
| 9.4.2.148 | 1269 | Relay Transfer Parameter Set element | ВНЕ |  |  | Relay Transfer Parameter Set — relay |
| 9.4.2.149 | 1270 | Quiet Period Request element | Н |  |  | Quiet Period Request — 11.35, не реализовано |
| 9.4.2.150 | 1271 | Quiet Period Response element | Н |  |  | Quiet Period Response — 11.35, не реализовано |
| 9.4.2.151 | 1271 | BeamLink Maintenance element | М | fields.Blm / blm_time / blm_negotiate; linkmaint.negotiate |  | элемент (в Probe/Information) не кодируется отдельно — поле то же, что в SSW-Feedback |
| 9.4.2.152 | 1271 | Multiple MAC Sublayers (MMS) element | ВНЕ |  |  | MMS — несколько MAC (вне охвата) |
| 9.4.2.153 | 1273 | U-PID element | ВНЕ |  |  | U-PID — FST |
| 9.4.2.154 | 1274 | ECAPC Policy element | ВНЕ |  |  | ECAPC Policy — кластеризация |
| 9.4.2.155 | 1275 | Cluster Time Offset element | ВНЕ |  |  | Cluster Time Offset — кластеризация |
| 9.4.2.156 | 1275 | Antenna Sector ID Pattern element | Н |  |  | Antenna Sector ID Pattern — не используется |
| 9.4.2.219 | 1369 | CDMG Capabilities element | ВНЕ |  |  | CDMG/CMMG/EDMG-элементы (9.4.2.219–9.4.2.233) — вне охвата |

## 9.5 Поля BF и управления DMG

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.5.1 | 1437 | Sector Sweep field | М+С | fields.check/encode/parse_ssw | cfe_fields, beacon_fields, sls, abft | PLAN №2 |
| 9.5.2 | 1438 | Dynamic Allocation Info field | М | fields.check/encode/parse_dai |  | Dynamic Allocation Info — SPR/Grant (pro) |
| 9.5.3 | 1439 | Sector Sweep Feedback field | М+С | fields.check/encode/parse_ssw_fb, snr_quantize | cfe_fields, sls | PLAN №3, №6 |
| 9.5.4 | 1440 | BRP Request field | М+С | fields.check/encode/parse_brp_req; brp.BrpRequest | cfe_fields, brp, brp_role | PLAN №7 |
| 9.5.5 | 1441 | Beamforming Control field | М | fields.check/encode/parse_bf_control |  | в Grant/SPR/Extended Schedule — нет в захватах |
| 9.5.6 | 1442 | Beamformed Link Maintenance field | М+С | fields.Blm, blm_time, blm_negotiate (табл. 9-344/9-345); linkmaint | blm | новое (волна C) |

## 9.6–9.7 Action-кадры и A-MPDU

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 9.6.3.2 | 1448 | Basic and DMG ADDTS Request frame format | ВНЕ |  |  | DMG ADDTS Request — резервирование SP (pro) |
| 9.6.3.3 | 1450 | Basic and DMG ADDTS Response frame format | ВНЕ |  |  | DMG ADDTS Response — pro |
| 9.6.4.2 | 1456 | ADDBA Request frame format | М+С | blockack.encode/parse_addba_req | addba |  |
| 9.6.4.3 | 1457 | ADDBA Response frame format | М+С | blockack.encode/parse_addba_resp, check_addba_response | addba |  |
| 9.6.4.4 | 1458 | DELBA frame format | М | blockack.encode/parse_delba |  | в захватах нет |
| 9.6.19.2 | 1570 | Power Save Configuration Request frame format | ВНЕ |  |  | PSC Request: PS удалён; точка отвечает отказом — не моделируется |
| 9.6.19.3 | 1570 | Power Save Configuration Response frame format | ВНЕ |  |  | PSC Response (отказ точки) — см. выше |
| 9.6.19.4 | 1571 | Information Request frame format | Н |  |  | Information Request — 11.28.1, не реализовано |
| 9.6.19.5 | 1572 | Information Response frame format | Н |  |  | Information Response — 11.28.1, не реализовано |
| 9.6.19.6 | 1573 | Handover Request frame format | Н |  |  | Handover Request — передача PCP (11.27.2) |
| 9.6.19.7 | 1573 | Handover Response frame format | Н |  |  | Handover Response — 11.27.2 |
| 9.6.19.8 | 1574 | Relay Search Request frame format | ВНЕ |  |  | 9.6.19.8–9.6.19.22: relay, RLS, TPA, ROC — relay вне охвата |
| 9.6.21.2 | 1588 | Announce frame format | М | mlme.AtiAp / check_ati_frame | ati | Announce — в захватах нет (ATI Present = 0) |
| 9.6.21.3 | 1590 | BRP frame format | М+С | brp.BrpFrame, brp_frame_length | brp, brp_role |  |
| 9.7.1 | 1612 | A-MPDU format | Ч | duration (A-MPDU) | ampdu_dur | разбор разделителей не нужен (запись — по MPDU) |
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

## 10.6, 10.12, 10.23, 10.25, 10.28, 10.29 — скорости, A-MPDU, EDCA, BA, элементы, RD

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.6.7.1 | 1701 | Usage of DMG Control modulation class | М+С | duration (control-кадры на MCS 0) | mcs_control |  |
| 10.6.7.2 | 1702 | Rate selection rules for Control frames transmitted by DMG STAs | М+С | duration.response_mcs_set / response_mcs | mcs_response |  |
| 10.12 | 1719 | A-MPDU operation | Ч | blockack, duration | ampdu_dur, ba_window | пределы длины A-MPDU/MPDU spacing — нет |
| 10.23.2.2 | 1739 | EDCA backoff procedure | М | cbap.Edcaf (backoff a–e) | access (статистика AIFS) | выбор счётчика не наблюдаем — только распределение |
| 10.23.2.4 | 1741 | Obtaining an EDCA TXOP | М+С | cbap.Station | access |  |
| 10.23.2.8 | 1747 | Multiple frame transmission in an EDCA TXOP | М+С | cbap.Station (несколько кадров в TXOP) | holder_gap, responder_tx, nav_txop |  |
| 10.23.2.9 | 1750 | TXOP limits | М+С | cbap (лимит TXOP) | txop_limit |  |
| 10.23.2.10 | 1751 | Truncation of TXOP | М+С | cbap.Nav (CF-End DMG); duration.cf_end_nonzero_allowed | cf_end_rules, cf_end_unanswered |  |
| 10.23.2.12 | 1754 | Retransmit procedures | М | cbap (повторы, QSRC) |  | предел повторов MAC — открыт (MAC-STAND.md) |
| 10.25.1 | 1786 | Introduction | М+С | blockack (номера по модулю 4096) | ba_window |  |
| 10.25.2 | 1787 | Setup and modification of the block ack parameters | М+С | blockack.agreement_allowed, make_addba_response | addba |  |
| 10.25.6 | 1791 | HT-immediate block ack extensions | М+С | blockack.Recipient / Originator / Scoreboard / ReorderBuffer | ba_window, ba_control |  |
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
| 10.39.4 | 1882 | DTI transmission rules | М+С | bi; cbap | bi, cbap_end |  |
| 10.39.5 | 1882 | Contention based access period (CBAP) transmission rules | М+С | cbap.Station (CBAP-окна, приостановка EDCAF); bi | cbap_end, access | PLAN №9 |
| 10.39.6.1 | 1884 | General | М+С | bi.Allocation, full_tsf | bi | PLAN №12 |
| 10.39.6.2 | 1885 | Service period (SP) allocation | Ч | bi (SP в расписании) | bi | правила внутри SP — строгий TDMA (pro) |
| 10.39.6.3 | 1886 | Contention based access period (CBAP) allocation | М+С | bi (CBAP-распределения) | bi |  |
| 10.39.6.4 | 1239 | and is set to 0 otherwise. The Pseudo-static Allocations subfield is | М | bi.pseudo_static_valid, obsolete |  | в захватах нет |
| 10.39.6.5 | 1888 | Guard time | М | bi.guard_time / guard_between |  |  |
| 10.39.6.6 | 1888 | DMG and CMMG protected period | ВНЕ | duration.duration_dts*; nav.MultiNav (DTS) |  | защищённый период — SP/DTS (pro) |
| 10.39.6.7 | 1895 | Service period recovery | ВНЕ |  |  | восстановление SP — pro |
| 10.39.7 | 1896 | Dynamic allocation of service period | ВНЕ | duration.duration_grant_* / duration_spr_*, pp_schedule; fields (Poll/SPR/Grant) |  | PP/GP — строгий TDMA (pro); open не использует (NOT_CHECKABLE dyn_alloc) |
| 10.39.8 | 1900 | Dynamic truncation of service period | ВНЕ | duration.duration_grant_truncation |  | усечение SP — pro |
| 10.39.9 | 1901 | Dynamic extension of service period | ВНЕ | duration.duration_grant_ext_* |  | продление SP — pro |
| 10.39.10 | 1902 | Updating multiple NAVs | М | nav.MultiNav (псевдокод буквально), nav.check_nav_log(multi=True) |  | новое; поддержка нескольких NAV у узла не видна — судья ведёт единый NAV (nav_multi) |
| 10.39.11 | 1370 | and is set to 0 otherwise. | ВНЕ |  |  | CDMG |

## 10.40–10.41 Кластеризация AP/PCP

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 10.40 | 1908 | DMG and CMMG AP or PCP clustering | ВНЕ | fields.check/encode/parse_cc (Clustering Control) | beacon_fields (поля) | решение: вне open — опция для нескольких AP/PCP рядом; наши маяки — без кластеризации (CC Present = 0). Модель знает только поле Clustering Control |
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
| 10.43.1 | 1970 | General | Н |  |  | общие правила адаптации линка DMG — не моделируются |
| 10.43.2 | 1971 | DMG TPC | Н |  |  | DMG TPC (Link Measurement Report + DMG Link Margin) — не реализовано |
| 10.43.3 | 1971 | Fast link adaptation | Н |  |  | быстрая адаптация — не реализовано (поле Fast Link Adaptation — в DMG Capabilities) |
| 10.44 | 1972 | Link adaptation using the CMMG link measurement | ВНЕ |  |  | CMMG |
| 10.45 | 1975 | DMG relay operation | ВНЕ |  |  | DMG relay — нет ни в open, ни в pro |

## 11.1 Синхронизация, маяки, сканирование

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.1.2.1 | 2049 | TSF for an infrastructure BSS or a PBSS | М+С | bi (TSF, TBTT); mlme | bi |  |
| 11.1.3.1 | 2050 | General | Ч | mlme.LinkMonitor | beacon_fields (Timestamp), bti_delay | точка Timestamp — не проверяема |
| 11.1.3.3.1 | 2052 | General | М+С | bi.txss_plan / bti_beacons | bi, bti_delay |  |
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
| 11.2.7 | 2112 | Power management in a PBSS and DMG infrastructure BSS | ВНЕ |  |  | power save DMG — удалён намеренно |
| 11.2.8 | 2124 | ATIM frame and frame transmission in IBSS, DMG infrastructure BSS, and PBSS | ВНЕ |  |  | ATIM — PS/IBSS |

## 11.3 Аутентификация и ассоциация

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.3.1 | 2126 | State variables | М+С | mlme.Peer (State 2 — старт DMG без аутентификации) | assoc_state |  |
| 11.3.3 | 2127 | Frame filtering based on STA state | М+С | mlme.frame_class / class_allowed / may_transmit / rx_filter | assoc_state | новое правило assoc_state (волна C) |
| 11.3.4 | 2130 | Authentication and deauthentication | М+С | mlme.Peer.auth_ok / deauth; StaMlme; ApMlme | assoc_state (open_system) |  |
| 11.3.5.1 | 2132 | General | М+С | mlme.rx_filter | assoc_state (missing_reply) |  |
| 11.3.5.2 | 2133 | Non-AP and non-PCP STA association initiation procedures | М+С | mlme.StaMlme | assoc_state (holdoff) |  |
| 11.3.5.3 | 2135 | AP or PCP association receipt procedures | М+С | mlme.ApMlme (AID) | assoc_state (aid_range, aid_dup) |  |
| 11.3.5.4 | 2137 | Non-AP and non-PCP STA reassociation initiation procedures | М | mlme.StaMlme |  |  |
| 11.3.5.5 | 2140 | AP or PCP reassociation receipt procedures | М | mlme.ApMlme |  |  |
| 11.3.5.6 | 2142 | Non-AP and non-PCP STA disassociation initiation procedures | М | mlme.StaMlme |  |  |
| 11.3.5.7 | 2142 | Non-AP and non-PCP STA disassociation receipt procedure | М+С | mlme.StaMlme | assoc_state |  |
| 11.3.5.8 | 2143 | AP or PCP disassociation initiation procedure | М | mlme.ApMlme |  |  |
| 11.3.5.9 | 2143 | AP or PCP disassociation receipt procedure | М | mlme.ApMlme |  |  |
| 11.3.5.10 | 2144 | PBSS procedures for nonassociated STAs | М | mlme |  | PBSS |
| 11.3.7 | 2145 | Communicating PBSS information | М | mlme.PbssInfoDistribution |  | PBSS |

## 11.4–11.10 TS, каналы, измерения

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.4.9.1 | 2159 | Deletion of a TS established between an HC, DMG AP, or PCP and a non-AP and non-PCP STA | ВНЕ |  |  | удаление TS DMG — pro (SP) |
| 11.4.13 | 2165 | DMG allocation formats | ВНЕ |  |  | форматы распределений DMG (TSPEC) — pro |
| 11.8.2.2 | 2178 | Providing supported channels upon association in a DMG BSS | Н |  |  | Supported Channels при ассоциации DMG — не моделируется |
| 11.8.8.6 | 2188 | Selecting and advertising a new channel in a DMG BSS | Н |  |  | смена канала DMG BSS (ECSA в DMG Beacon/Announce/Information Response) — не реализовано |
| 11.9 | 2189 | Extended channel switching (ECS) | Н |  |  | ECS — не реализовано |
| 11.10.11 | 2217 | Link measurement | Н |  |  | Link Measurement (DMG Link Margin, 10.43.2) — не реализовано |

## 11.27–11.37 DMG-процедуры

| Пункт | Стр. | Предмет | Статус | Модель | Судья | Примечание |
|---|---|---|---|---|---|---|
| 11.27.1 | 2355 | Beamformed link maintenance | М+С | linkmaint.negotiate / LinkTimer / expiry / sets_timer / check_blm_log | blm | новое; у нас BLM Value = 0 — dot11BeamLinkMaintenanceTime не определён |
| 11.27.2 | 2357 | PCP Handover | Н |  |  | передача PCP (PBSS) — не реализовано |
| 11.28 | 2359 | DMG BSS peer and service discovery | Н |  |  | Information Request/Response, peer service discovery — не реализовано |
| 11.29.1 | 2361 | General | Н | elements (DMG BSS Parameter Change) |  | смена параметров BSS (TBTT, BI) — процедура не моделируется |
| 11.29.4 | 2363 | Maintaining synchronization in an AP or PCP cluster | ВНЕ |  |  | синхронизация в кластере — кластеризация |
| 11.29.5 | 2363 | Recommending DMG BSS parameters to the AP or PCP | Н |  |  | рекомендация параметров точке — не реализовано |
| 11.30 | 2364 | Spatial sharing and interference mitigation for DMG STAs | ВНЕ |  |  | spatial sharing — SP (pro) |
| 11.31 | 2367 | Multi-band operation | ВНЕ |  |  | multi-band/FST |
| 11.32 | 2383 | MMSL cluster operation | ВНЕ |  |  | MMSL |
| 11.33 | 2385 | DMG coexistence with non-IEEE-802.11 systems | ВНЕ |  |  | сосуществование с не-802.11 — требований к нашему MAC нет |
| 11.34 | 2386 | DMG relay procedures | ВНЕ |  |  | relay |
| 11.35 | 2389 | Quieting adjacent DMG BSSs | Н |  |  | подавление соседних DMG BSS (Quiet Period) — не реализовано |
| 11.36 | 2391 | DMG beamforming | Ч | dmg_sta (SLS + BRP при входе STA) | sls, brp | MLME-BF-TRAINING — уровень SME |
| 11.37 | 2393 | DMG MAC sublayer attributes | М+С | timing (табл. 11-22) |  | постоянные — test_consistency |

## Решения по охвату

- **Кластеризация AP/PCP (10.40)** — вне open: опция для нескольких AP/PCP в зоне друг друга, в нашей схеме одна
  точка; маяки объявляют CC Present = 0. Модель знает поле Clustering Control (рис. 9-78/9-79), правила кластера — нет.
- **Relay (10.45, 11.34, 9.6.19.8–9.6.19.22)** — нет ни в open, ни в pro.
- **Динамическое распределение (10.39.7–10.39.9, Poll/SPR/Grant)** — строгий TDMA, pro; open не использует (в захватах
  этих кадров нет). Кодеки кадров (fields) и Duration (duration) в модели есть — для pro.
- **Power save (11.2.7, PSC, Awake Window, Wakeup Schedule)** — удалён намеренно; точка отвечает отказом на PSC-REQ.
- **Reverse direction (10.29)** — выключен намеренно; судья rd ловит RDG/RD-ответы в эфире.
- **BRP TXSS** — EDMG (802.11-2024 10.41.10.5), в 802.11-2020 нет; в 2020 есть только запрос списка секторов
  TXSS-FBCK-REQ в BRP (10.42.6.4.1) — brp (`txss-fbck`).
- **CDMG/CMMG/EDMG** (10.37, 10.39.11, 10.41, 10.42.9, 10.44, 9.4.2.219–9.4.2.233) — вне охвата.

## Приоритеты «Н» для open (что делает прошивка в эфире)

Смена канала DMG BSS (11.8.8.6, ECSA), TPC/адаптация (10.43, Link Measurement), Information Request/Response (11.28),
передача PCP (11.27.2), смена параметров BSS (11.29), Quiet Period (11.35), A-MSDU (9.3.2.2). В захватах стенда
таких кадров нет — сначала нужен сценарий, где прошивка их передаёт.

