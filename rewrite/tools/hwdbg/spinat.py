# PATCHPY: SPIN_FILE (lmac.c) + SPIN_AT (точный текст строки-маркера) → после него вечный цикл
import sys, os
f = os.path.join(os.path.dirname(sys.argv[1]), os.environ.get('SPIN_FILE', 'lmac.c'))
s = open(f).read(); a = os.environ['SPIN_AT']
assert s.count(a) == 1, (f, a, s.count(a))
s = s.replace(a, a + " for (;;) *(volatile u32 *)0x806a04 = 0x5709;")
open(f, 'w').write(s)
