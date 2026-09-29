/* hwd_rfc__uses_rgf_889100 @ 0x8d37a8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc__uses_rgf_889100
hwd_rfc__uses_rgf_889100:
	.global L_8d37a8
L_8d37a8:
	push_s blink
L_8d37aa:
	mov_s r1,0x889100
L_8d37b0:
	ld_s r0,[r1,0x18]
L_8d37b2:
	bclr_s r0,r0,0x4
L_8d37b4:
	st_s r0,[r1,0x18]
L_8d37b6:
	mov_s r0,0x3a980
L_8d37bc:
	mov lp_count,r0
L_8d37c0:
	nop_s
L_8d37c2:
	lp L_8d37ca
L_8d37c6:
	nop_s
L_8d37c8:
	nop_s
	.global L_8d37ca
L_8d37ca:
	mov_s r1,0x889100
L_8d37d0:
	ld_s r0,[r1,0x18]
L_8d37d2:
	bset_s r0,r0,0x4
L_8d37d4:
	st_s r0,[r1,0x18]
L_8d37d6:
	pop_s blink
L_8d37d8:
	j_s [blink]
L_8d37da:
	nop_s
