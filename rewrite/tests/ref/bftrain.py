# SPDX-License-Identifier: AGPL-3.0-or-later
"""DMG beamforming на уровне SME по 802.11-2020: 11.36 [p. 2391] и примитивы MLME-BF-TRAINING (6.3.91 [p. 646–648]):
.request(PeerSTAAddress, RequestBRP), .confirm(PeerSTAAddress, ResultCode ∈ {SUCCESS, BF_TIMEOUT}),
.indication(PeerSTAAddress, ResultCode). Связь с моделью MAC: SLS — ref/sls (ISS/RSS/SSW-Feedback/SSW-Ack, 10.42.2;
таймаут dot11MaxBFTime), A-BFT — ref/abft (10.42.5), BRP — ref/brp (10.42.3, 10.42.6).

11.36: «Upon receipt of an MLME-BF-TRAINING.request primitive, a STA shall undertake beamforming training with the STA
indicated by the PeerSTAAddress … This training shall start with the SLS and shall include the BRP if and only if the
RequestBRP parameter … is true»; инициатор или ответчик — любой; к своей AP/PCP — A-BFT (10.42.5) или ISS в SP/TXOP
(10.42.2.2); .confirm — по завершении или таймауту; у пира, обученного по просьбе другого, — .indication.

BfTrainingSme — автомат одной стороны: request → план (SLS, затем BRP по RequestBRP); события MAC (sls_done,
brp_done, timeout) → примитивы. check_air(frames, pair) — по эфиру: первая BF-передача пары после (повторной)
ассоциации/начала записи — SLS (SSW/SSW в A-BFT), а не BRP («shall start with the SLS»); BRP без предшествующего SLS
пары — вердикт model (BRP после SLS, обученного вне записи, допустим 10.42.6). RequestBRP по эфиру не виден — «iff»
не проверяемо (NOT_CHECKABLE bf_request_brp)."""
from collections import namedtuple

from . import fields as F
from .timing import DOT11_MAX_BF_TIME

SUCCESS, BF_TIMEOUT = 'SUCCESS', 'BF_TIMEOUT'
SLS_KINDS = ('SSW', 'SSW-Feedback', 'SSW-Ack')
BRP_KINDS = ('BRP',)

Primitive = namedtuple('Primitive', 'name peer result')


class BfTrainingSme:
    """Сторона обучения: own — свой MAC; is_ap — AP/PCP; peer_is_ap — пир — AP/PCP своей BSS."""
    def __init__(self, own):
        self.own = own
        self.pending = {}                # peer → dict(brp, phase, by_request)
        self.out = []

    def request(self, peer, request_brp, peer_is_ap=False, in_abft=False):
        """MLME-BF-TRAINING.request → план MAC: [('SLS', где), ('BRP',)?]."""
        if F.is_group(peer):
            raise ValueError('PeerSTAAddress — «Any valid individual MAC address» (6.3.91.2.2)')
        where = 'A-BFT' if peer_is_ap and in_abft else 'DTI'
        self.pending[peer] = dict(brp=bool(request_brp), phase='SLS', by_request=True)
        return [('SLS', where)] + ([('BRP', 'DTI')] if request_brp else [])

    def peer_started(self, peer, request_brp=False):
        """Обучение начато пиром (по его .request): по завершении — .indication."""
        self.pending.setdefault(peer, dict(brp=bool(request_brp), phase='SLS', by_request=False))

    def sls_done(self, peer):
        st = self.pending.get(peer)
        if st is None:
            return None
        if st['brp']:
            st['phase'] = 'BRP'
            return None
        return self._finish(peer, SUCCESS)

    def brp_done(self, peer):
        st = self.pending.get(peer)
        if st is None or st['phase'] != 'BRP':
            raise ValueError('BRP до завершения SLS — «This training shall start with the SLS» (11.36)')
        return self._finish(peer, SUCCESS)

    def timeout(self, peer):
        """Таймаут 10.42 (dot11MaxBFTime и др.)."""
        if peer not in self.pending:
            return None
        return self._finish(peer, BF_TIMEOUT)

    def _finish(self, peer, result):
        st = self.pending.pop(peer)
        p = Primitive('MLME-BF-TRAINING.confirm' if st['by_request'] else 'MLME-BF-TRAINING.indication', peer, result)
        self.out.append(p)
        return p


def timed_out(t_start, t_now, bi_us, max_bf_time=DOT11_MAX_BF_TIME):
    """Таймаут обучения по dot11MaxBFTime (в BI, 10.42.1; ref/brp.bf_brp_expired — та же величина)."""
    return t_now - t_start > max_bf_time * bi_us


def check_air(frames, assoc_times=()):
    """frames — [(t, вид, src, dst)] BF-кадров пары по времени (SSW/SSW-Feedback/SSW-Ack/BRP); assoc_times — моменты
    (повторной) ассоциации пары. → [(индекс, текст, вердикт)]: BRP без SLS пары с начала записи/последней
    ассоциации («shall start with the SLS», 11.36) — model (обучение могло быть до записи)."""
    v = []
    marks = sorted(assoc_times)
    sls_seen = False
    mi = 0
    for i, (t, kind, src, dst) in enumerate(frames):
        while mi < len(marks) and marks[mi] <= t:
            sls_seen = False
            mi += 1
        if kind in SLS_KINDS:
            sls_seen = True
        elif kind in BRP_KINDS and not sls_seen:
            v.append((i, f'BRP {src}→{dst} без SLS пары перед ним — обучение по MLME-BF-TRAINING «shall start with '
                         f'the SLS» (11.36)', 'model'))
            sls_seen = True               # одно замечание на серию
    return v
