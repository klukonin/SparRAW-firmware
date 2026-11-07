# SPDX-License-Identifier: AGPL-3.0-or-later
"""RSNE DMG (9.4.2.24 [p. 1051–1059], 12.6.3 [p. 2517–2519]), Extended Capabilities (9.4.2.26 [p. 1061], табл. 9-153),
Supported Operating Classes (9.4.2.53 [p. 1119–1120], табл. E-4) — ожидания из текста стандарта."""
from . import capelems as C
from . import dms as DM
from . import elements as E

G = C.sel(C.GCMP128)
PSK = C.sel(C.AKM_PSK)


def rsn(**kw):
    return E.parse_elements(E.encode_rsne(**kw))[0].info


# ---------------------------------------------------------------------------------------------------- RSNE
def test_dmg_defaults_gcmp128_and_akm1():
    """9.4.2.24.2: в DMG RSNA по умолчанию групповой и парный — 00-0F-AC:8 (GCMP-128); не-DMG — CCMP-128;
    9.4.2.24.3: AKM по умолчанию — 00-0F-AC:1; 9.4.2.24.4: Capabilities по умолчанию 0."""
    r = C.rsn_effective(rsn())
    assert r.group == C.Suite(C.OUI_IEEE, 8) and r.pairwise == [C.Suite(C.OUI_IEEE, 8)]
    assert r.akm == [C.Suite(C.OUI_IEEE, 1)] and not any(r.caps.values())
    assert C.rsn_effective(rsn(), dmg=False).group.type == C.CCMP128


def test_firmware_default_rsne_is_valid():
    """RSNE GCMP-128/GCMP-128/PSK, Capabilities 0 (так его собирает fw по умолчанию) — без нарушений у AP и STA."""
    info = rsn(group_data=G, pairwise=[G], akm=[PSK], capabilities=0)
    assert C.check_rsne(info, E.ROLE_AP) == []
    assert C.check_rsne(info, E.ROLE_STA, E.ASSOC_REQ) == []


def test_cipher_usage_table_9_150():
    bad = C.check_rsne(rsn(group_data=C.sel(C.USE_GROUP), pairwise=[G], akm=[PSK]))
    assert any('valid only as the pairwise' in m for m in bad)
    assert any('BIP' in m for m in C.check_rsne(rsn(group_data=C.sel(C.BIP_CMAC128), pairwise=[G], akm=[PSK])))
    assert any('не шифр PTK' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[C.sel(C.WEP40)], akm=[PSK])))
    assert any('Reserved' in m for m in C.check_rsne(rsn(group_data=C.sel(3), pairwise=[G], akm=[PSK])))
    # WEP групповой — только в TSN для до-RSNA STA (9.4.2.24.2); в DMG — PLAN.md №67
    assert any('№67' in m for m in C.check_rsne(rsn(group_data=C.sel(C.WEP104), pairwise=[G], akm=[PSK])))
    assert C.check_rsne(rsn(group_data=C.sel(C.WEP104), pairwise=[G], akm=[PSK]), dmg=False) == []


def test_use_group_rules():
    """«Use group cipher suite»: единственный парный у AP, недопустим при групповом не TKIP/WEP."""
    v = C.check_rsne(rsn(group_data=G, pairwise=[C.sel(C.USE_GROUP), G], akm=[PSK]))
    assert any('only pairwise' in m for m in v) and any('not a valid' in m for m in v)
    assert C.check_rsne(rsn(group_data=C.sel(C.TKIP), pairwise=[C.sel(C.USE_GROUP)], akm=[PSK]), dmg=False) == []
    # парный TKIP при групповом GCMP — «not supported»
    assert any('not supported' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[C.sel(C.TKIP)], akm=[PSK])))


def test_counts_and_akm_reserved():
    info = E.le(1, 2) + G + E.le(0, 2)               # Pairwise Count = 0
    assert any('Count = 0' in m for m in C.check_rsne(info))
    assert any('AKM 00-0F-AC:18' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[C.sel(18)])))
    assert any('AKM 00-0F-AC:21' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[C.sel(21)])))
    assert C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[C.sel(8)])) == []          # SAE
    assert C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[bytes([0x00, 0x10, 0x18, 1])])) == []   # vendor


def test_rsn_capabilities_by_role():
    caps = lambda **kw: E.pack(C.RSN_CAP, dict({n: 0 for n, _ in C.RSN_CAP}, **kw))     # noqa: E731
    assert any('Preauthentication' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[PSK],
                                                                 capabilities=caps(preauth=1)), E.ROLE_STA))
    assert C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[PSK], capabilities=caps(preauth=1)), E.ROLE_AP) == []
    assert any('No Pairwise' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[PSK],
                                                           capabilities=caps(no_pairwise=1)), E.ROLE_AP))
    assert any('invalid setting' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[PSK],
                                                               capabilities=caps(mfpr=1))))
    assert any('B15' in m for m in C.check_rsne(rsn(group_data=G, pairwise=[G], akm=[PSK], capabilities=caps(_r15=1))))


def test_sta_selection_12_6_3():
    ap = rsn(group_data=G, pairwise=[G, C.sel(C.GCMP256)], akm=[PSK, C.sel(C.AKM_SAE)])
    assert C.check_selection(ap, rsn(group_data=G, pairwise=[C.sel(C.GCMP256)], akm=[PSK])) == []
    assert any('не из объявленных' in m for m in C.check_selection(ap, rsn(group_data=G, pairwise=[C.sel(C.CCMP128)],
                                                                            akm=[PSK])))
    assert any('групповой' in m for m in C.check_selection(ap, rsn(group_data=C.sel(C.GCMP256), pairwise=[G],
                                                                    akm=[PSK])))
    two = C.check_rsne(rsn(group_data=G, pairwise=[G, G], akm=[PSK]), E.ROLE_STA, E.ASSOC_REQ)
    assert any('парных шифров 2' in m for m in two)


def test_mfp_table_12_5():
    """Табл. 12-5 построчно."""
    assert C.mfp_actions(0, 0, 0, 0) == ('may', 'may')
    assert C.mfp_actions(1, 0, 0, 0) == ('may', 'may')
    assert C.mfp_actions(1, 1, 1, 1) == ('may', 'may')
    assert C.mfp_actions(1, 1, 0, 0) == ('reject', 'not')
    assert C.mfp_actions(0, 0, 1, 1) == ('none', 'not')
    assert C.mfp_actions(0, 0, 1, 0) == ('may', 'may')
    assert C.mfp_actions(1, 0, 0, 1) == ('reject', 'not')      # STA: MFPR без MFPC
    assert C.mfp_actions(0, 1, 1, 0) == ('none', 'not')        # AP: MFPR без MFPC
    caps = lambda c, r: E.pack(C.RSN_CAP, dict({n: 0 for n, _ in C.RSN_CAP}, mfpc=c, mfpr=r))   # noqa: E731
    ap = rsn(group_data=G, pairwise=[G], akm=[PSK], capabilities=caps(1, 1))
    sta = rsn(group_data=G, pairwise=[G], akm=[PSK], capabilities=caps(0, 0))
    assert C.check_assoc_status(ap, sta, 0) and C.check_assoc_status(ap, sta, 31) == []
    assert any('shall not associate' in m for m in C.check_selection(ap, sta))


# ---------------------------------------------------------------------------------------------------- Ext Caps
def test_ext_cap_names_and_truncation():
    info = E.parse_elements(C.encode_ext_cap(['DMS', 'QAB Capability']))[0].info
    f = C.parse_ext_cap(info)
    assert f['DMS'] == 1 == DM.ext_cap_dms(info) and f['QAB Capability'] == 1
    assert C.EXT_CAP_BIT['QAB Capability'] == 47 and C.EXT_CAP_BIT['DMS'] == 26
    # 9.4.2.26: недостающие биты — 0
    assert C.parse_ext_cap(b'\x04')['Extended Channel Switching'] == 1 and C.parse_ext_cap(b'\x04')['DMS'] == 0
    assert sum(w for _, w, _ in C.EXT_CAP_FIELDS) == C.EXT_CAP_KNOWN_BITS == 88


def test_ext_cap_rules():
    el = lambda *b, **f: E.parse_elements(C.encode_ext_cap(b, fields=f or None))[0].info    # noqa: E731
    assert C.check_ext_cap(el('DMS', 'SSID List'), E.ROLE_STA) == []
    assert any('Reserved' in m for m in C.check_ext_cap(el(5)))
    assert any('88–n' in m for m in C.check_ext_cap(el(90)))
    assert any('S-PSMP' in m for m in C.check_ext_cap(el(**{'Service Interval Granularity': 2})))
    assert C.check_ext_cap(el('S-PSMP Support', **{'Service Interval Granularity': 2})) == []
    assert any('not an HT STA' in m for m in C.check_ext_cap(el(**{'Max Number Of MSDUs In A-MSDU': 1})))
    assert any('non-AP' in m for m in C.check_ext_cap(el('QAB Capability'), E.ROLE_STA))
    assert C.check_ext_cap(el('QAB Capability'), E.ROLE_AP) == []
    assert any('бит 84' in m for m in C.check_ext_cap(el(84), E.ROLE_STA))


# ---------------------------------------------------------------------------------------------------- SOC
def test_soc_roundtrip_and_delimiters():
    info = E.parse_elements(C.encode_soc(180, [180, 181], current_ext=[(128, 180)], duples=[(128, 1), (130, 2)]))[0]
    s = C.parse_soc(info.info)
    assert s == C.Soc(180, [180, 181], [(128, 180)], [(128, 1), (130, 2)])
    assert C.parse_soc(bytes([180])) == C.Soc(180, [], [], [])
    assert C.channel_in_class(180, 6) and not C.channel_in_class(180, 7) and C.channel_in_class(181, 2)


def test_soc_rules():
    el = lambda *a, **k: E.parse_elements(C.encode_soc(*a, **k))[0].info      # noqa: E731
    assert C.check_soc(el(180, [180])) == []
    assert any('№68' in m for m in C.check_soc(el(81, [81])))                 # 2,4 ГГц у DMG STA
    assert any('нет в Operating Classes' in m for m in C.check_soc(el(180, [181])))
    assert any('Reserved' in m for m in C.check_soc(el(180, [140, 180])))
    assert any('ascending' in m for m in C.check_soc(el(180, [180], duples=[(130, 2), (128, 1)])))
    assert any('ascending' not in m and 'не класс 60' not in m for m in C.check_soc(bytes([180, 0, 1])))  # нечётно
    assert any('≠ класс BSS' in m for m in C.check_soc(el(180, [180, 181]), current_class=181))
