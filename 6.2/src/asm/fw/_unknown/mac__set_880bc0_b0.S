/* mac__set_880bc0_b0 @ 0x8e860c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__enable_880bc0_b0
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__set_880bc0_b0
mac__set_880bc0_b0:
	.global L_8e860c
L_8e860c:
	push_s blink
L_8e860e:
	push_s r13
L_8e8610:
	mov_s r13,r0
L_8e8612:
	bclr.f r0,r0,0x0
L_8e8616:
	bne_s L_8e862a
	.global L_8e8618
L_8e8618:
	mov_s r1,0x880b80
L_8e861e:
	ld_s r0,[r1,0x40]
L_8e8620:
	bclr_s r0,r0,0x0
L_8e8622:
	or_s r13,r13,r0
L_8e8624:
	st_s r13,[r1,0x40]
L_8e8626:
	b L_8c025c
	.global L_8e862a
L_8e862a:
	mov_s r0,blink
L_8e862c:
	bl.d L_8c9b28
L_8e8630:
	mov_s r1,0xac
L_8e8632:
	b_s L_8e8618
