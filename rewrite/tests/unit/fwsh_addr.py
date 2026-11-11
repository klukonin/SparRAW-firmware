# SPDX-License-Identifier: AGPL-3.0-or-later
"""Адреса общей памяти fw ↔ uc для тестов — из одного места, include/fwsh.h: A['<имя>'] = FWSH_A_<имя> (тот же литерал,
что у макросов uc и символов fw/fw.ld, сверка — tools/check_fwsh.py); ESE_OWN_SLOTS_N — число записей ese_own_tbl."""
import os
import re

_H = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), 'include', 'fwsh.h')
_SRC = open(_H).read()

A = {m.group(1): int(m.group(2), 16)
     for m in re.finditer(r'^#define\s+FWSH_A_(\w+)\s+(0x[0-9a-fA-F]+)u?\b', _SRC, re.M)}
ESE_OWN_SLOTS_N = int(re.search(r'^#define\s+ESE_OWN_SLOTS_N\s+(\d+)', _SRC, re.M).group(1))
SP_GATE_SIZE = 0x18                    # sizeof(struct fwsh_sp_gate) — _Static_assert в include/fwsh.h

ESE_SLOT_TBL = A['ese_slot_tbl']
ESE_OWN_TBL = A['ese_own_tbl']
SP_GATE = A['fwsh_sp_gate']
UC_WAIT = A['fwsh_uc_wait']            # struct fwsh_uc_wait: +0 tmo_cnt, +4 last_marker, +8 last_tsf
