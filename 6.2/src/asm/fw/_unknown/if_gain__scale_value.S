/* if_gain__scale_value @ 0x8d6dcc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, calib__delta__8d6c7c, hwd_phy_rx_sar_rssi_measure, if_gain__get_scaled
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global if_gain__scale_value
if_gain__scale_value:
	.global L_8d6dcc
L_8d6dcc:
	cmp_s r0,0x0
L_8d6dce:
	mov_s r2,0x1
L_8d6dd0:
	mov.ne r2,r0
L_8d6dd4:
	rsub r0,r1,0x1f
L_8d6dd8:
	sexb_s r0,r0
L_8d6dda:
	b_s L_8d6de2
	.global L_8d6ddc
L_8d6ddc:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8d6dde:
	sexb_s r0,r0
L_8d6de0:
	asl_s r2,r2
	.global L_8d6de2
L_8d6de2:
	lsr.f 0x0,r2,0x1f
L_8d6de6:
	beq_s L_8d6ddc
L_8d6de8:
	/* mul64 r0,0x60546 */
	.byte 0x04,0x28,0x80,0x0f,0x06,0x00,0x46,0x05
L_8d6df0:
	mov_s r0,mlo
L_8d6df2:
	add r1,r2,0x800000
L_8d6dfa:
	lsr_s r1,r1,0x18
L_8d6dfc:
	sub r1,r1,0x80
L_8d6e00:
	cmp_s r1,0x0
L_8d6e02:
	mov_s r2,0x0
L_8d6e04:
	mov.hi r2,r1
L_8d6e08:
	mov_s r1,0x7f
L_8d6e0a:
	cmp_s r2,0x7f
L_8d6e0c:
	mov.cs r1,r2
L_8d6e10:
	extb_s r1,r1
L_8d6e12:
	mov_s r2,0x801824
L_8d6e18:
	ldw.as r1,[r2,r1]
L_8d6e1c:
	j_s.d [blink]
L_8d6e1e:
	add3_s r0,r0,r1
