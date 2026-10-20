/* rf__set_8894a0_field @ 0x8d0198, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__step
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__set_8894a0_field
rf__set_8894a0_field:
	.global L_8d0198
L_8d0198:
	push_s blink
L_8d019a:
	push_s r13
L_8d019c:
	mov_s r13,r0
L_8d019e:
	bic.f r0,r0,0xf
L_8d01a2:
	bne_s L_8d01be
	.global L_8d01a4
L_8d01a4:
	mov_s r1,0x889480
L_8d01aa:
	ld_s r0,[r1,0x20]
L_8d01ac:
	asl_s r13,r13,0x11
L_8d01ae:
	and r0,r0,0xffe1ffff
L_8d01b6:
	or_s r13,r13,r0
L_8d01b8:
	st_s r13,[r1,0x20]
L_8d01ba:
	b L_8c025c
	.global L_8d01be
L_8d01be:
	mov_s r0,blink
L_8d01c0:
	bl.d L_8c9b28
L_8d01c4:
	mov_s r1,0xac
L_8d01c6:
	b_s L_8d01a4
