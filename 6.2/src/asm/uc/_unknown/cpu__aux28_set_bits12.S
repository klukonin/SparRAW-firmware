/* cpu__aux28_set_bits12 @ 0x9202f4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: boot_uc__init_g800610
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global cpu__aux28_set_bits12
cpu__aux28_set_bits12:
	.global L_9202f4
L_9202f4:
	lr r0,[0xa]
L_9202f8:
	or r0,r0,0x6
L_9202fc:
	j.d [blink]
L_920300:
	flag r0
L_920304:
	lr r0,[0xa]
L_920308:
	or r0,r0,0x2
L_92030c:
	j.d [blink]
L_920310:
	flag r0
L_920314:
	lr r0,[0xa]
L_920318:
	or r0,r0,0x4
L_92031c:
	j.d [blink]
L_920320:
	flag r0
L_920324:
	nop_s
L_920326:
	nop_s
L_920328:
	nop_s
L_92032a:
	nop_s
L_92032c:
	nop_s
L_92032e:
	nop_s
