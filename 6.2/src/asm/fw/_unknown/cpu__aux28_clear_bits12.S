/* cpu__aux28_clear_bits12 @ 0x8c034c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sysassert__wmi_lock_notice
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global cpu__aux28_clear_bits12
cpu__aux28_clear_bits12:
	.global L_8c034c
L_8c034c:
	lr r0,[0xa]
L_8c0350:
	bic r0,r0,0x6
L_8c0354:
	j.d [blink]
L_8c0358:
	flag r0
L_8c035c:
	lr r0,[0xa]
L_8c0360:
	bic r0,r0,0x2
L_8c0364:
	j.d [blink]
L_8c0368:
	flag r0
L_8c036c:
	lr r0,[0xa]
L_8c0370:
	bic r0,r0,0x4
L_8c0374:
	j.d [blink]
L_8c0378:
	flag r0
L_8c037c:
	nop_s
L_8c037e:
	nop_s
