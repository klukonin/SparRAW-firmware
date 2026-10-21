#!/usr/bin/env python3
# SPDX-License-Identifier: AGPL-3.0-or-later
# merge3.py файл… — после `git checkout --conflict=diff3`: разрешить конфликты, где правки ours и theirs
# относительно base не пересекаются (вставки в одно место — ours, затем theirs); остальные оставить.
import sys,difflib
def edits(b,x):
    sm=difflib.SequenceMatcher(a=b,b=x,autojunk=False)
    return [(i1,i2,x[j1:j2]) for tag,i1,i2,j1,j2 in sm.get_opcodes() if tag!='equal']
def merge(b,o,t):
    eo,et=edits(b,o),edits(b,t)
    for a1,a2,_ in eo:
        for c1,c2,_ in et:
            if (a1<c2 and c1<a2) or (a1==a2==c1 and False): return None
            if a1<a2 and c1<c2 and not (a2<=c1 or c2<=a1): return None
            if (a1==a2 and c1<a1<c2) or (c1==c2 and a1<c1<a2): return None
    allx=sorted([(a1,a2,r,0) for a1,a2,r in eo]+[(c1,c2,r,1) for c1,c2,r in et],key=lambda e:(e[0],e[1]>e[0],e[3]))
    out=[];pos=0
    for a1,a2,r,_ in allx:
        if a1<pos: return None
        out+=b[pos:a1]+r; pos=a2
    return out+b[pos:]
for path in sys.argv[1:]:
    L=open(path).read().split('\n'); out=[]; i=0; left=0
    while i<len(L):
        if L[i].startswith('<<<<<<< '):
            st=i;o=[];b=[];t=[];cur=o;i+=1
            while not L[i].startswith('>>>>>>> '):
                if L[i].startswith('||||||| '): cur=b
                elif L[i]=='=======': cur=t
                else: cur.append(L[i])
                i+=1
            r=merge(b,o,t)
            if r is None: out+=L[st:i+1]; left+=1
            else: out+=r
        else: out.append(L[i])
        i+=1
    open(path,'w').write('\n'.join(out)); print(path,'осталось конфликтов',left)
