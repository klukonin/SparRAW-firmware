#!/bin/bash
# fwcheck.sh <dir> — что видно в журнале fw
F=$1/fwlog.txt
for p in 'ADDBA|BA_SM|ba_agreed' 'DELBA' 'ECHO' 'TOF|FTM|tof_mgr|ftm_session' 'BURST' 'SNIFFER|sniffer' 'LED' 'PMC' 'sysassert|ASSERT'; do printf "%-28s %s\n" "$p" "$(grep -ciE "$p" $F)"; done
