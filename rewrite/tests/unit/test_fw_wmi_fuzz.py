# SPDX-License-Identifier: AGPL-3.0-or-later
"""Каждая команда хоста из диспетчера (fw/wmi_cmd.c wmi_host_cmd_dispatch) с телом из нулей, из 0xff и из байтов
SPARRAW_MAX_STA — после загрузки и при подключённой STA: fw не падает фатальным ассертом, не попадает в недопустимое
событие автомата, не опрашивает регистр вечно и не обращается вне карты памяти. Уже найденные отказы — xfail(strict)
с кодом ассерта (другой сбой xfail не засчитывается)."""
import functools, os, re

import pytest

import fwemu
import fwflows as F
from fwflows import SPARRAW_MAX_STA

_SRC = open(os.path.join(F.REW, 'fw', 'wmi_cmd.c')).read()
_DISPATCH = _SRC[_SRC.index('void wmi_host_cmd_dispatch'):]
CMDS = sorted(set(int(x, 16) for x in re.findall(r'case (0x[0-9a-f]+):', _DISPATCH)))
# WMI_UNIT_TEST — отладочный интерфейс: по замыслу пишет произвольные регистры/память (свои проверки — в
# test_fw_wmi_validation.py)
SKIP = {0x900}
PATTERNS = {'zero': bytes(0x100), 'ff': b'\xff' * 0x100, 'max_sta': bytes([SPARRAW_MAX_STA]) * 0x100}

KNOWN = {}                                  # (состояние, команда, тело) → (код ассерта, почему) — найденные отказы


@functools.lru_cache(maxsize=None)
def _snapshot(elf, state):
    fw = fwemu.FW(elf).boot()
    if state == 'conn':
        w = F.Fw(fw)
        w.sta_connect()
        w.sta_add_vring()
    return fw.save()


def _params():
    for state in ('boot', 'conn'):
        for cmd in CMDS:
            if cmd in SKIP:
                continue
            for pat in PATTERNS:
                k = (state, cmd, pat)
                marks = ()
                if k in KNOWN:
                    code, why = KNOWN[k]
                    marks = pytest.mark.xfail(strict=True, raises=F.KnownFatal,
                                              reason='ассерт %#x: %s' % (code, why))
                yield pytest.param(state, cmd, pat, id='%s-%#05x-%s' % k, marks=marks)


@pytest.mark.parametrize('state,cmd,pat', list(_params()))
def test_wmi_command_does_not_crash(fw_elf, state, cmd, pat):
    fw = fwemu.FW(fw_elf).boot()
    fw.restore(_snapshot(fw_elf, state))
    code = KNOWN.get((state, cmd, pat), (None,))[0]
    with F.known_fatal(code if code is not None else -1):
        fw.wmi(cmd, PATTERNS[pat])
        F.settle(fw)
    assert not fw.wild, 'обращения вне карты памяти: %s' % fw.wild[:4]
