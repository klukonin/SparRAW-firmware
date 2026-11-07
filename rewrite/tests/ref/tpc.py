# SPDX-License-Identifier: AGPL-3.0-or-later
"""TPC у DMG STA по 802.11-2020 вне Link Measurement: элементы TPC Request (9.4.2.15, рис. 9-174 — пустой) и TPC
Report (9.4.2.16 [p. 966], рис. 9-175: Transmit Power и Link Margin — дБм/дБ в дополнительном коде), кадры TPC
Request/TPC Report (9.6.2.4/9.6.2.5 [p. 1445], категория Spectrum Management, табл. 9-346), процедура 11.7.7
[p. 2177]: «A STA that receives a TPC Request frame shall respond with a TPC Report frame»; «An AP, PCP, or IBSS STA
shall autonomously include a TPC Report element with the Link Margin field set to 0 in Beacon frames, DMG Beacon
frames, Announce frames, or Probe Response frames» — при dot11SpectrumManagementRequired (11.7.1: «A STA shall use
the TPC procedures defined in 11.7 if dot11SpectrumManagementRequired is true»); табл. 9-45 (строка 50) / 9-39 —
TPC Report «present if dot11SpectrumManagementRequired is true or dot11RadioMeasurementActivated is true»; Link
Margin в Beacon/Probe Response — Reserved (9.4.2.16). Внутри Link Measurement Report — ref/linkadapt.

Признаки MIB по эфиру: dot11SpectrumManagementRequired — бит Spectrum Management Capability Information (9.4.1.4),
dot11RadioMeasurementActivated — бит Radio Measurement; поддержка TPC — бит TPC DMG STA Capability Information
(9.4.2.127.2, «supports the TPC as defined in 11.7»).

Принято: PLAN.md №110 (когда обязателен ответ и TPC Report в кадрах точки).

Нарушения — список строк."""
from collections import namedtuple

from . import elements as E

CAT_SPECTRUM = 0
ACT_TPC_REQUEST, ACT_TPC_REPORT = 2, 3          # табл. 9-346
EID_TPC_REQUEST = E.element_key('TPC Request')[0]     # 34
EID_TPC_REPORT = E.element_key('TPC Report')[0]       # 35
TPC_REPORT_LEN = 2

TpcReport = namedtuple('TpcReport', 'tx_power link_margin')
TpcFrame = namedtuple('TpcFrame', 'kind token report')


def _s8(b):
    return b - 256 if b > 127 else b


def _u8(v, what):
    if not -128 <= v <= 127:
        raise ValueError(f'{what} {v} вне −128…127 (дополнительный код, 9.4.2.16)')
    return v & 0xff


def encode_tpc_report(tx_power, link_margin=0):
    return E.encode_element(EID_TPC_REPORT, bytes([_u8(tx_power, 'Transmit Power'), _u8(link_margin, 'Link Margin')]))


def parse_tpc_report(info):
    if len(info) != TPC_REPORT_LEN:
        raise ValueError(f'TPC Report: Length {len(info)} ≠ 2 (рис. 9-175)')
    return TpcReport(_s8(info[0]), _s8(info[1]))


def encode_tpc_request_frame(token):
    """Рис. 9-856: Category, Spectrum Management Action (2), Dialog Token, TPC Request element."""
    return bytes([CAT_SPECTRUM, ACT_TPC_REQUEST, token]) + E.encode_element(EID_TPC_REQUEST, b'')


def encode_tpc_report_frame(token, tx_power, link_margin):
    """Рис. 9-857: Category, Spectrum Management Action (3), Dialog Token, TPC Report element."""
    return bytes([CAT_SPECTRUM, ACT_TPC_REPORT, token]) + encode_tpc_report(tx_power, link_margin)


def parse_tpc_frame(body):
    if len(body) < 3 or body[0] != CAT_SPECTRUM or body[1] not in (ACT_TPC_REQUEST, ACT_TPC_REPORT):
        raise ValueError('не кадр TPC Request/TPC Report (9.6.2.4/9.6.2.5)')
    els = E.parse_elements(body[3:])
    if body[1] == ACT_TPC_REQUEST:
        if not els or els[0].eid != EID_TPC_REQUEST or els[0].info:
            raise ValueError('TPC Request: нет элемента TPC Request с Length 0 (рис. 9-856, 9-174)')
        return TpcFrame('request', body[2], None)
    if not els or els[0].eid != EID_TPC_REPORT:
        raise ValueError('TPC Report: нет элемента TPC Report (рис. 9-857)')
    return TpcFrame('report', body[2], parse_tpc_report(els[0].info))


def check_request(f):
    """9.6.2.4: «The Dialog Token field is set to a nonzero value»."""
    return ['TPC Request: Dialog Token = 0 (9.6.2.4: «set to a nonzero value»)'] if f.token == 0 else []


def check_report(req, rep):
    """9.6.2.5: токен — копия запроса."""
    return [] if req.token == rep.token else [f'TPC Report: Dialog Token {rep.token} ≠ {req.token} запроса (9.6.2.5)']


def respond(req, tx_power, link_margin):
    """Ответчик 11.7.7: TPC Report с мощностью передачи ответа и оценкой запаса линии."""
    return TpcFrame('report', req.token, TpcReport(tx_power, link_margin))


def must_respond(spectrum_mgmt, tpc_cap):
    """Обязан ли получатель TPC Request ответить: 11.7.7 «shall respond» в рамках процедур 11.7, обязательных при
    dot11SpectrumManagementRequired (11.7.1). True — обязан (Spectrum Management = 1), None — по поддержке TPC (бит
    TPC DMG Capabilities = 1, model), False — не обязан."""
    if spectrum_mgmt:
        return True
    if tpc_cap:
        return None
    return False


def required_in_frame(kind, spectrum_mgmt, radio_meas):
    """Обязателен ли TPC Report в кадре AP/PCP: DMG Beacon (табл. 9-45 строка 50), Probe Response (табл. 9-39),
    Announce (11.7.7) — при Spectrum Management (11.7.7, 11.7.1) или Radio Measurement (табл. 9-45/9-39)."""
    if kind in ('DMG Beacon', E.PROBE_RESP):
        return bool(spectrum_mgmt or radio_meas)
    if kind == 'Announce':
        return bool(spectrum_mgmt)
    return False


def check_frame_element(kind, info, spectrum_mgmt, radio_meas):
    """TPC Report в кадре AP/PCP: обязателен (required_in_frame) и Link Margin = 0 (11.7.7; в Beacon/Probe Response —
    Reserved, 9.4.2.16). info — информация элемента или None (нет)."""
    v = []
    if info is None:
        if required_in_frame(kind, spectrum_mgmt, radio_meas):
            why = ('Spectrum Management = 1: 11.7.7 «shall autonomously include a TPC Report element»'
                   if spectrum_mgmt else 'Radio Measurement = 1: табл. 9-45/9-39 «present if … '
                                         'dot11RadioMeasurementActivated is true»')
            v.append(f'{kind} без TPC Report — {why}')
        return v
    try:
        r = parse_tpc_report(info)
    except ValueError as x:
        return [f'{kind}: {x}']
    if r.link_margin != 0:
        v.append(f'{kind}: TPC Report Link Margin {r.link_margin} ≠ 0 (11.7.7: «Link Margin field set to 0»; '
                 f'9.4.2.16: Reserved)')
    return v
