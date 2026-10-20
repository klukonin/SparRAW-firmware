/* hwd_phy_get_tx_swap_iq @ 0x8d1c90, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_get_tx_swap_iq: I and Q inverse values are not the same, I=%d, Q=%d.
 * Зовут его: hwf_calib__acquire_hw
 * Зовёт сам: fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_get_tx_swap_iq
hwd_phy_get_tx_swap_iq:
	.global L_8d1c90
L_8d1c90:
	push_s blink
L_8d1c92:
	mov_s r1,0x884000
L_8d1c98:
	ld_s r0,[r1,0x28]
L_8d1c9a:
	ld_s r3,[r1,0x28]
L_8d1c9c:
	bmsk r2,r0,0x0
L_8d1ca0:
	lsr_s r3,r3
L_8d1ca2:
	bmsk_s r3,r3,0x0
L_8d1ca4:
	breq r2,r3,L_8d1cb6
L_8d1ca8:
	mov_s r1,0x101d950
L_8d1cae:
	bl.d L_8dcc80
L_8d1cb2:
	mov_s r0,0x11
L_8d1cb4:
	b_s L_8d1cc6
	.global L_8d1cb6
L_8d1cb6:
	bbit1 r0,0x0,L_8d1cc0
L_8d1cba:
	mov_s r0,0x0
	.global L_8d1cbc
L_8d1cbc:
	pop_s blink
L_8d1cbe:
	j_s [blink]
	.global L_8d1cc0
L_8d1cc0:
	btst_s r0,0x0
L_8d1cc2:
	mov_s r0,0x1
L_8d1cc4:
	bne_s L_8d1cbc
	.global L_8d1cc6
L_8d1cc6:
	mov_s r0,0x3
L_8d1cc8:
	b_s L_8d1cbc
L_8d1cca:
	nop_s
