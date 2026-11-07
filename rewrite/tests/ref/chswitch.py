# SPDX-License-Identifier: AGPL-3.0-or-later
"""Смена канала DMG BSS по 802.11-2020: выбор и объявление нового канала в DMG BSS 11.8.8.6 [p. 2188], ECS 11.9
(11.9.1 [p. 2189], 11.9.2, 11.9.3.1–11.9.3.2 [p. 2189–2191] — в части, применимой к DMG BSS), Supported Channels при
ассоциации DMG 11.8.2.2 [p. 2178]; элементы Extended Channel Switch Announcement (9.4.2.52, рис. 9-369 [p. 1119]),
Supported Channels (9.4.2.17, рис. 9-176), Supported Operating Classes (9.4.2.53, рис. 9-370 — Current Operating Class
и список классов); кадр Extended Channel Switch Announcement (9.6.7.7, рис. 9-871 [p. 1469]); бит Extended Channel
Switching поля Extended Capabilities (табл. 9-153, бит 2); DMG-классы приложения E (табл. E-4: 180 — каналы 1–6,
181 — 2, 3; ширина 2160 МГц, начальная частота 56,16 ГГц).

Поведение:
  ApChannelSwitch  — точка: решение только AP/PCP; выбор канала (алгоритм вне стандарта — помощник: общий для всех
                     связанных STA по их Supported Channels); объявление ECSA в каждом DMG Beacon, Announce и
                     Information Response до момента смены; Channel Switch Count — число TBTT до смены (1 — смена
                     непосредственно перед следующим TBTT, 0 — в любой момент после кадра).
  StaChannelSwitch — станция: переходит на новый канал к TBTT по счётчику или выбирает другое действие; Channel Switch
                     Mode в DMG может игнорировать (11.8.8.6); сама ECSA не передаёт.
  check_ecsa_sequence — судья ряда маяков точки: счётчик −1 на каждый TBTT, неизменность режима/класса/канала,
                     присутствие в каждом маяке до смены, обрыв объявления до смены.
  supported_channels_*, check_association_channels — 11.8.2.2: список каналов STA при (повторной) ассоциации или в
                     Information Request; пересечение для широковещательного Information Response точки.

Не моделируется: Max Channel Switch Time (9.4.2.217) и Channel Switch Wrapper — их требования (11.9.3.2) — для Beacon
frame не-DMG; 11.8.8.6 их не называет; DSE/enabling STA (11.11, 11.9.3.2 первый абзац), OCV/SA Query после смены
(12.x, dot11RSNAOperatingChannelValidationActivated); IBSS/MBSS (11.9.3.3/11.9.3.4 — вне open); Channel Switch
Announcement (9.4.2.18) — только не-DMG. Канал, на котором записан кадр, запись PMC не хранит — смену канала на эфире
судья не видит (NOT_CHECKABLE ecsa_switch).

Нарушения — список строк."""
from collections import namedtuple

from . import elements as E
from .timing import BCAST

EID_ECSA = E.element_key('Extended Channel Switch Announcement')[0]          # 60
EID_SUPPORTED_CHANNELS = E.element_key('Supported Channels')[0]              # 36
EID_SUPPORTED_OPCLASSES = E.element_key('Supported Operating Classes')[0]    # 59
EID_EXT_CAP = E.element_key('Extended Capabilities')[0]                      # 127
EXT_CAP_ECS_BIT = 2                 # табл. 9-153: бит 2 — Extended Channel Switching
CAT_PUBLIC, ACT_ECSA = 4, 4         # табл. 9-51; табл. 9-364 (Public Action): 4 — Extended Channel Switch Announcement
ECSA_LEN = 4                        # рис. 9-369
MODE_NO_RESTRICTION, MODE_STOP_TX = 0, 1   # 9.4.2.52: AP/PCP ставит 0 или 1 (смысл — 11.8.8.2: 1 — STA молчат)
# табл. E-4 (Global operating classes): DMG — 180 (каналы 1–6), 181 (каналы 2, 3); 182 (1080 МГц) и 183 (42,66 ГГц,
# 540 МГц) — CMMG
DMG_OPCLASS = {180: (1, 2, 3, 4, 5, 6), 181: (2, 3)}
DMG_CHANNELS = (1, 2, 3, 4, 5, 6)
OPCLASS_DELIM = (130, 0)            # 9.4.2.53: Current Operating Class Extension / Duple — после разделителя 130 / 0


def channel_freq_mhz(ch):
    """Табл. E-4: начальная частота 56,16 ГГц, шаг 2160 МГц: f = 56 160 + 2160·n МГц."""
    return 56160 + 2160 * ch


# =====================================================================================================================
# Элементы
# =====================================================================================================================
Ecsa = namedtuple('Ecsa', 'mode opclass channel count')


def encode_ecsa(x):
    return E.encode_element(EID_ECSA, bytes([x.mode, x.opclass, x.channel, x.count]))


def parse_ecsa(info):
    # табл. 9-92: Extended Channel Switch Announcement — не расширяемый: длина ровно 4
    if len(info) != ECSA_LEN:
        raise ValueError(f'Extended Channel Switch Announcement: Length {len(info)} ≠ 4 (рис. 9-369)')
    return Ecsa(*info)


def check_ecsa(x):
    """Поля ECSA от AP/PCP (9.4.2.52): режим 0/1; класс — DMG (прил. E); канал — из класса."""
    v = []
    if x.mode not in (MODE_NO_RESTRICTION, MODE_STOP_TX):
        v.append(f'ECSA: Channel Switch Mode {x.mode} — AP/PCP ставит 0 или 1 (9.4.2.52)')
    if x.opclass not in DMG_OPCLASS:
        v.append(f'ECSA: New Operating Class {x.opclass} — не DMG-класс (табл. E-4: 180, 181)')
    elif x.channel not in DMG_OPCLASS[x.opclass]:
        v.append(f'ECSA: канал {x.channel} не из класса {x.opclass} (табл. E-4: {DMG_OPCLASS[x.opclass]})')
    return v


def encode_ecsa_frame(x, elements=()):
    """Тело Public Action ECSA (рис. 9-871): Category, Public Action, четыре поля, необязательные элементы."""
    return bytes([CAT_PUBLIC, ACT_ECSA, x.mode, x.opclass, x.channel, x.count]) + E.encode_elements(elements)


def parse_ecsa_frame(body):
    if len(body) < 6 or body[0] != CAT_PUBLIC or body[1] != ACT_ECSA:
        raise ValueError('не кадр Extended Channel Switch Announcement (9.6.7.7)')
    return Ecsa(*body[2:6]), E.parse_elements(body[6:])


def check_ecsa_frame_addr(a1):
    """11.9.1: «The Address 1 field of an Extended Channel Switch Announcement frame shall be set to the broadcast
    address»."""
    return [] if a1 == BCAST else [f'кадр ECSA: Address 1 = {a1}, а не широковещательный (11.9.1)']


def ext_cap_bit(info, bit):
    """Бит поля Extended Capabilities (9.4.2.26: длина переменная; отсутствующие октеты — 0)."""
    return bool(len(info) > bit // 8 and info[bit // 8] & (1 << bit % 8))


def encode_supported_channels(subbands):
    """[(первый канал, число каналов)] → элемент (рис. 9-176)."""
    return E.encode_element(EID_SUPPORTED_CHANNELS, b''.join(bytes([f, n]) for f, n in subbands))


def parse_supported_channels(info):
    if not info or len(info) % 2:
        raise ValueError(f'Supported Channels: длина {len(info)} — не пары октетов (рис. 9-176)')
    return [(info[i], info[i + 1]) for i in range(0, len(info), 2)]


def channels_of(subbands):
    return {f + k for f, n in subbands for k in range(n)}


def subbands_of(chs):
    """Множество каналов → минимальный список поддиапазонов (подряд идущие номера)."""
    out = []
    for c in sorted(chs):
        if out and out[-1][0] + out[-1][1] == c:
            out[-1] = (out[-1][0], out[-1][1] + 1)
        else:
            out.append((c, 1))
    return out


def check_supported_channels(subbands):
    """Supported Channels DMG STA: поддиапазоны из каналов DMG (табл. E-4), Number of Channels ≥ 1."""
    v = []
    for f, n in subbands:
        if n < 1:
            v.append(f'Supported Channels: поддиапазон с {f}: Number of Channels = 0 (9.4.2.17)')
        elif not {f + k for k in range(n)} <= set(DMG_CHANNELS):
            v.append(f'Supported Channels: каналы {f}…{f + n - 1} вне DMG-каналов 1–6 (табл. E-4)')
    return v


def parse_supported_opclasses(info):
    """(Current Operating Class, [классы до разделителя])."""
    if not info:
        raise ValueError('Supported Operating Classes без Current Operating Class (рис. 9-370)')
    cls = []
    for b in info[1:]:
        if b in OPCLASS_DELIM:
            break
        cls.append(b)
    return info[0], cls


def check_supported_opclasses(cur, cls, ecs=None):
    """11.9.2: при ECS Current Operating Class — класс работы (у DMG — 180/181)."""
    v = []
    if cur not in DMG_OPCLASS:
        v.append(f'Supported Operating Classes: Current Operating Class {cur} — не DMG (табл. E-4; 11.9.2)')
    return v


# =====================================================================================================================
# Точка
# =====================================================================================================================
ANNOUNCE_FRAMES = ('DMG Beacon', 'Announce', 'Information Response')    # 11.8.8.6


class ApChannelSwitch:
    """AP/PCP: решение о смене канала и объявление (11.8.8.6). channel — текущий канал, opclass — класс."""
    def __init__(self, opclass=180, channel=2, ecs=True):
        if not ecs:
            raise ValueError('без dot11ExtendedChannelSwitchActivated ECSA не используется (11.9.1); CSA — не DMG')
        self.opclass, self.channel = opclass, channel
        self.pending = None             # (BI объявления, Ecsa)

    @staticmethod
    def select(supported, candidates=DMG_CHANNELS, current=None):
        """Помощник выбора: первый канал, поддерживаемый всеми связанными STA (11.8.8.6: «may make use of the
        information in received Supported Channels elements»; алгоритм — «beyond the scope»)."""
        common = set(candidates)
        for chs in supported.values():
            common &= set(chs)
        common.discard(current)
        return min(common) if common else None

    def announce(self, k, channel, count, mode=MODE_NO_RESTRICTION, opclass=None):
        x = Ecsa(mode, opclass or self.opclass, channel, count)
        v = check_ecsa(x)
        if v:
            raise ValueError('; '.join(v))
        self.pending = (k, x)
        return x

    def element_for(self, k):
        """ECSA для кадров BI k (одинаков во всех маяках BTI) или None. Счётчик — число TBTT до смены."""
        if self.pending is None:
            return None
        k0, x = self.pending
        if k < k0:
            return None
        if x.count == 0:
            return x
        c = x.count - (k - k0)
        return x._replace(count=c) if c >= 1 else None

    def switch_bi(self):
        """Первый BI на новом канале (count ≥ 1: смена «immediately before the next TBTT» при count = 1)."""
        if self.pending is None:
            return None
        k0, x = self.pending
        return k0 + x.count if x.count else None

    def tick(self, k):
        """Начало BI k: при наступлении момента — смена канала."""
        sb = self.switch_bi()
        if sb is not None and k >= sb:
            self.channel, self.opclass = self.pending[1].channel, self.pending[1].opclass
            self.pending = None
            return True
        return False


class StaChannelSwitch:
    """Non-AP STA (11.8.8.6, 11.9.3.2)."""
    def __init__(self, channel, follow=True):
        self.channel, self.follow = channel, follow
        self.at = None                  # BI смены
        self.target = None

    def on_ecsa(self, k, x):
        """ECSA принят в BI k. follow=False — «alternative action» (например, другой BSS)."""
        if not self.follow:
            return 'alternative'
        self.target = x
        self.at = k + x.count if x.count else k
        return 'switch'

    def tick(self, k):
        if self.at is not None and k >= self.at:
            self.channel, self.at = self.target.channel, None
            return True
        return False

    @staticmethod
    def may_transmit(mode):
        """11.8.8.6: «A STA may ignore the Channel Switch Mode field and either cease transmissions or attempt new
        transmissions» — в DMG режим 1 передачу STA не запрещает."""
        return True

    @staticmethod
    def may_send_ecsa():
        return False                    # 11.8.8.6: «A non-AP and non-PCP STA … shall not transmit the … element»


# =====================================================================================================================
# Судья ряда кадров точки
# =====================================================================================================================
Obs = namedtuple('Obs', 'k kind ecsa ref')     # k — индекс BI; kind — DMG Beacon/Announce/Information Response


def check_ecsa_sequence(obs):
    """obs — кадры точки по времени. Возвращает (нарушения [(ref, текст)], заметки)."""
    v, notes = [], []
    cur, k0 = None, None
    last_k = None
    for o in obs:
        x = o.ecsa
        if x is not None:
            for m in check_ecsa(x):
                v.append((o.ref, m))
        if cur is None:
            if x is not None:
                cur, k0 = x, o.k
                if x.count == 0:
                    notes.append('ECSA с Channel Switch Count = 0 — смена в любой момент после кадра')
                # 11.8.8.6: «should be scheduled so that all … STAs … have the opportunity to receive at least one»
            last_k = o.k
            continue
        expect = cur.count - (o.k - k0) if cur.count else 0
        if cur.count and expect < 1:
            # момент смены прошёл: точка уже на новом канале (кадры на нём — та же запись узла); ECSA с прежними
            # полями после смены — нарушение счётчика
            if x is not None and x[:3] == cur[:3] and x.count:
                v.append((o.ref, f'ECSA с Count {x.count} в BI {o.k} — после объявленной смены (BI {k0 + cur.count}) '
                                 f'(9.4.2.52)'))
            cur, k0 = (x, o.k) if x is not None and x[:3] != cur[:3] else (None, None)
            last_k = o.k
            continue
        if x is None and not cur.count:
            cur, k0 = None, None            # Count 0: смена «any time after the frame» — кадр без ECSA уже после неё
            last_k = o.k
            continue
        if x is None:
            v.append((o.ref, f'{o.kind} точки без ECSA до момента смены (BI {o.k}, ожидался Count {expect}) (11.8.8.6: '
                             f'«shall … advertising the switch using the … element in its transmitted DMG Beacon '
                             f'frames, Announce frames, and Information Response frames until the intended channel '
                             f'switch time»)'))
            cur, k0 = None, None
            last_k = o.k
            continue
        if x[:3] != cur[:3]:
            v.append((o.ref, f'ECSA изменил режим/класс/канал до смены: {cur[:3]} → {x[:3]} (9.4.2.52)'))
            cur, k0 = x, o.k
        elif x.count != expect:
            v.append((o.ref, f'ECSA Count {x.count} в BI {o.k} ≠ {expect} (−1 на каждый TBTT от {cur.count} в BI {k0}) '
                             f'(9.4.2.52)'))
        if last_k is not None and o.k - last_k > 1:
            notes.append('пропуск BI в записи во время объявления')
        last_k = o.k
    return v, notes


def check_sta_no_ecsa(src_is_ap, has_ecsa):
    """11.8.8.6, 11.9.3.2: non-AP STA не передаёт ECSA."""
    if has_ecsa and not src_is_ap:
        return ['ECSA от non-AP STA (11.8.8.6: «shall not transmit the Extended Channel Switch Announcement element»)']
    return []


def check_association_channels(assoc_req_elements, info_req_elements=()):
    """11.8.2.2: STA «shall provide … a list of channels» — Supported Channels в (Re)Association Request или в
    Information Request. СПОРНО → принято (PLAN.md №41): DMG-правило 11.8.2.2 выше условия табл. 9-34 / 9-36
    («present if dot11SpectrumManagementRequired is true and dot11ExtendedChannelSwitchActivated is false»)."""
    have = [e for e in assoc_req_elements if e.eid == EID_SUPPORTED_CHANNELS]
    have += [e for els in info_req_elements for e in els if e.eid == EID_SUPPORTED_CHANNELS]
    if not have:
        return ['нет Supported Channels ни в (Re)Association Request, ни в Information Request STA (11.8.2.2: «When it '
                '(re)associates, the STA shall provide to the AP or PCP a list of channels»)'], None
    v = []
    for e in have:
        try:
            v += check_supported_channels(parse_supported_channels(e.info))
        except ValueError as x:
            v.append(str(x))
    return v, channels_of(parse_supported_channels(have[-1].info)) if not v else None


def check_bcast_supported_channels(subbands, sta_channels):
    """11.8.2.2: широковещательный Information Response точки — пересечение Supported Channels связанных STA."""
    if not sta_channels:
        return []
    common = set(DMG_CHANNELS)
    for chs in sta_channels.values():
        common &= set(chs)
    got = channels_of(subbands)
    if got != common:
        return [f'Information Response (Subject = broadcast): Supported Channels {sorted(got)} ≠ пересечению каналов '
                f'связанных STA {sorted(common)} (11.8.2.2)']
    return []
