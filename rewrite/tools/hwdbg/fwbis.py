import subprocess, sys, time
import os; SP=os.environ.get('SP','/tmp/fwdbg')
L=[l.strip() for l in open(SP+'/fwbis.list')]
def test(i):
    r=subprocess.run([SP+'/fwbis.sh',L[i]],capture_output=True,text=True).stdout.strip()
    print(time.strftime('%H:%M:%S'), i, r, flush=True); return r.split()[1] if r else 'NOBUILD'
lo, hi = -1, len(L)-1          # lo — последний «ready» (развилка 40d6fc13), hi — первый «noready»
while hi - lo > 1:
    mid=(lo+hi)//2; j=mid; res=test(j)
    k=1
    while res=='NOBUILD' and k<6:
        j=mid+k if k%2 else mid-k; k+=1
        if lo<j<hi: res=test(j)
    if res=='READY': lo=j
    elif res=='NOREADY': hi=j
    else: print('не собирается около', mid); break
print('ИТОГ: последний ready', L[lo] if lo>=0 else '40d6fc13', '| первый noready', L[hi], flush=True)
