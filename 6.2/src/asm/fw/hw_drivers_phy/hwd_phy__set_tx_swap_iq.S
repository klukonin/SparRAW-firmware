/* hwd_phy__set_tx_swap_iq @ 0x8d2c98, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__release_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__set_tx_swap_iq
hwd_phy__set_tx_swap_iq:
	.global L_8d2c98
L_8d2c98:
	push_s blink
L_8d2c9a:
	bl L_8c01e4
L_8d2c9e:
	mov_s r13,0x0
L_8d2ca0:
	breq_s r0,0,L_8d2cc0
L_8d2ca2:
	breq r0,0x1,L_8d2cb8
L_8d2ca6:
	breq r0,0x2,L_8d2cbc
L_8d2caa:
	mov_s r0,blink
L_8d2cac:
	mov_s r1,0x112c
L_8d2cb2:
	bl L_8c9b28
L_8d2cb6:
	b_s L_8d2cc0
	.global L_8d2cb8
L_8d2cb8:
	mov_s r13,0x1
L_8d2cba:
	b_s L_8d2cc0
	.global L_8d2cbc
L_8d2cbc:
	ldb r13,[gp, 0xe0]
	.global L_8d2cc0
L_8d2cc0:
	bclr.f r14,r13,0x0
L_8d2cc4:
	bne_s L_8d2ce0
	.global L_8d2cc6
L_8d2cc6:
	brne_s r14,0,L_8d2cea
	.global L_8d2cc8
L_8d2cc8:
	mov_s r0,0x884000
L_8d2cce:
	ld_s r1,[r0,0x28]
L_8d2cd0:
	bclr_s r1,r1,0x0
L_8d2cd2:
	or_s r1,r1,r13
L_8d2cd4:
	asl_s r13,r13
L_8d2cd6:
	bclr_s r1,r1,0x1
L_8d2cd8:
	or_s r13,r13,r1
L_8d2cda:
	st_s r13,[r0,0x28]
L_8d2cdc:
	b L_8c0254
	.global L_8d2ce0
L_8d2ce0:
	mov_s r0,blink
L_8d2ce2:
	bl.d L_8c9b28
L_8d2ce6:
	mov_s r1,0xad
L_8d2ce8:
	b_s L_8d2cc6
	.global L_8d2cea
L_8d2cea:
	mov_s r0,blink
L_8d2cec:
	bl.d L_8c9b28
L_8d2cf0:
	mov_s r1,0xae
L_8d2cf2:
	b_s L_8d2cc8
