/* hwd_phy_get_rx_swap_iq @ 0x8d1c30, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_phy_get_rx_swap_iq: I and Q inverse values are not the same, I=%d, Q=%d.
 * Зовут его: hwf_calib__acquire_hw
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_get_rx_swap_iq
hwd_phy_get_rx_swap_iq:
	.global L_8d1c30
L_8d1c30:
	push_s blink
L_8d1c32:
	bl L_8c01e4
L_8d1c36:
	mov_s r1,0x883000
L_8d1c3c:
	ld_s r0,[r1,0x38]
L_8d1c3e:
	ld_s r1,[r1,0x38]
L_8d1c40:
	bmsk r2,r0,0x0
L_8d1c44:
	lsr_s r1,r1
L_8d1c46:
	bmsk r3,r1,0x0
L_8d1c4a:
	bxor r0,r0,0x0
L_8d1c4e:
	bmsk_s r0,r0,0x0
L_8d1c50:
	bxor r1,r1,0x0
L_8d1c54:
	bmsk_s r1,r1,0x0
L_8d1c56:
	tst_s r1,r0
L_8d1c58:
	sub_s.ne r0,r0,r0
L_8d1c5a:
	bne_s L_8d1c8c
L_8d1c5c:
	cmp_s r2,0x1
L_8d1c5e:
	mov_s r14,0x1
L_8d1c60:
	sub_s.ne r14,r14,r14
L_8d1c62:
	cmp_s r3,0x1
L_8d1c64:
	mov_s r13,0x1
L_8d1c66:
	sub_s.ne r13,r13,r13
L_8d1c68:
	tst_s r13,r14
L_8d1c6a:
	mov.ne r0,0x1
L_8d1c6e:
	bne_s L_8d1c8c
L_8d1c70:
	tst_s r13,r0
L_8d1c72:
	mov.ne r0,0x4
L_8d1c76:
	bne_s L_8d1c8c
L_8d1c78:
	tst_s r14,r1
L_8d1c7a:
	mov_s r0,0x5
L_8d1c7c:
	bne_s L_8d1c8c
L_8d1c7e:
	mov_s r1,0x101d9a0
L_8d1c84:
	bl.d L_8dcc80
L_8d1c88:
	mov_s r0,0x11
L_8d1c8a:
	mov_s r0,0x3
	.global L_8d1c8c
L_8d1c8c:
	b L_8c0254
