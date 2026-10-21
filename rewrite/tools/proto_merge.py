#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# proto_merge.py base.h ours.h theirs.h out.h — трёхстороннее слияние fw/proto.h по именам функций
# (для конфликтов слияния; потом tools/gen_fw_proto.py). Взять: git show $(git merge-base HEAD MERGE_HEAD):rewrite/fw/proto.h …
import re,sys
def load(p):
    hdr=[];d={}
    for l in open(p):
        m=re.match(r'^\S.*?\b(\w+) \(',l)
        if m and ';' in l: d[m.group(1)]=l.rstrip('\n')
        else: hdr.append(l.rstrip('\n'))
    return hdr,d
_,b=load(sys.argv[1]); ho,o=load(sys.argv[2]); ht,t=load(sys.argv[3])
names=set(b)|set(o)|set(t); res={}
for n in names:
    bo,oo,to=b.get(n),o.get(n),t.get(n)
    if oo==to: v=oo
    elif oo==bo: v=to
    elif to==bo: v=oo
    else: v=oo
    if v: res[n]=v
inc=sorted(set(l for l in ho+ht if l.startswith('#include')))
structs=sorted(set(l for l in ho+ht if l.startswith('struct ')))
out=['/* Сгенерировано tools/gen_fw_proto.py — не редактировать. */','#ifndef FW_PROTO_H','#define FW_PROTO_H']+inc+['']+structs+['']+[res[n] for n in sorted(res)]+['','#endif','']
open(sys.argv[4],'w').write('\n'.join(out))
