#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# ucring.py <dir> — декодировать кольцевой лог uc (0x803240..0x803648) из серии снимков
# blob_uc_data (<dir>/<uptime_cs>.bin, см. REC= в hwboot.sh); запись = [hdr][ts][args..],
# hdr>>16 >= 0x8000, nargs = (hdr>>26)&3, смещение строки = hdr&0xffff (tools/ucode_strings.json).
import sys,glob,os,json,struct
T={int(k):v for k,v in json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)),'../../../../tools/ucode_strings.json')))['6.2.0.1000']['strings'].items()}
def dec(d,lo=0x3240,hi=0x3648):
    W=[struct.unpack_from('<I',d,o)[0] for o in range(0,len(d),4)]
    for i in range(lo//4,hi//4):
        w=W[i]; off=w&0xffff; h=w>>16
        if off in T and 0x8000<=h:
            n=((h>>8)>>2)&3; args=[W[i+2+k] for k in range(n)]; t=T[off]
            try: t=t%tuple(args) if n and '%' in t else t
            except Exception: t+=' args='+str([hex(a) for a in args])
            yield W[i+1],0x800000+i*4,t
seen={}
for f in sorted(glob.glob(sys.argv[1]+'/*.bin'), key=lambda p:int(os.path.basename(p)[:-4])):
    up=int(os.path.basename(f)[:-4])
    if os.path.getsize(f)<16384: continue
    for ts,a,t in dec(open(f,'rb').read()):
        if (ts,a) not in seen: seen[(ts,a)]=(up,t)
for (ts,a),(up,t) in sorted(seen.items()): print('%5.2f %08x %06x %s'%(up/100,ts,a,t))
