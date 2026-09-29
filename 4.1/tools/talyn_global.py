#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
"""Показать поля глобала из символьного пака Talyn 7.5.

  tools/talyn_global.py [--fw] ИМЯ [ИМЯ...]
  tools/talyn_global.py [--fw] --list [подстрока]
"""
import sys, xml.etree.ElementTree as ET
BASE='../../../WIGIG_TLN_7.5_11ad_pack/globals/TALYN_M_B0/%s_image_globals.xml'

def dump(n,d=0,base=None):
    nm=n.get('name'); ty=n.get('type'); ad=int(n.get('address'),16)
    if base is None: base=ad
    s,e=n.get('start'),n.get('end')
    off=ad-base
    if ty=='field':
        b=('бит %s'%s) if s==e else ('биты %s..%s'%(s,e))
        print('+0x%03x %s%s  %s'%(off,'  '*d,nm.replace('dump___',''),b))
    else:
        if not nm.startswith('dump_only__'):
            print('+0x%03x %s%s'%(off,'  '*d,nm)); d+=1
    for c in n: dump(c,d,base)

a=sys.argv[1:]
kind='ucode'
if a and a[0]=='--fw': kind='fw'; a=a[1:]
root=ET.parse(BASE%kind).getroot()
if a and a[0]=='--list':
    sub=a[1] if len(a)>1 else ''
    for n in sorted(root,key=lambda x:int(x.get('address'),16)):
        if sub in n.get('name'): print('%s  %s'%(n.get('address'),n.get('name')))
else:
    for n in root:
        if n.get('name') in a:
            print('=== %s @%s'%(n.get('name'),n.get('address'))); dump(n)
