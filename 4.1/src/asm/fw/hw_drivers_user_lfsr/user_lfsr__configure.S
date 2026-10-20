/* user_lfsr__configure @ 0x8e359c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_user_lfsr.c
 * Зовут его: tail_user_lfsr__configure
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.user_lfsr__configure,"ax",@progbits
	.global user_lfsr__configure
user_lfsr__configure:
	.global L_8e359c
L_8e359c:
	push_s blink
L_8e359e:
	push_s r13
L_8e35a0:
	mov_s r13,r0
L_8e35a2:
	bclr.f r0,r0,0x0
L_8e35a6:
	bne_s L_8e35ba
	.global L_8e35a8
L_8e35a8:
	mov_s r1,0x880b80
L_8e35ae:
	ld_s r0,[r1,0x40]
L_8e35b0:
	bclr_s r0,r0,0x0
L_8e35b2:
	or_s r13,r13,r0
L_8e35b4:
	st_s r13,[r1,0x40]
L_8e35b6:
	b L_8c033c
	.global L_8e35ba
L_8e35ba:
	mov_s r0,blink
L_8e35bc:
	mov_s r2,0x1019780
L_8e35c2:
	mov_s r1,0xac
L_8e35c4:
	bl.d L_8c82c0
L_8e35c8:
	mov_s r3,0x17
L_8e35ca:
	b_s L_8e35a8
