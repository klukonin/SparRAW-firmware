/* hwd_phy_pwr_fw @ 0x8d1e68, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hwd_phy_pwr ON: phy_tx_power_ack =%d,phy_rx_power_ack = %d,phy_ldpc_power_ack=%d
 * Зовут его: hwd_phy__power_up_seq
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy_pwr_fw
hwd_phy_pwr_fw:
	.global L_8d1e68
L_8d1e68:
	push_s blink
L_8d1e6a:
	bl L_8c01dc
L_8d1e6e:
	bclr.f r13,r0,0x0
L_8d1e72:
	mov_s r14,r0
L_8d1e74:
	bne_s L_8d1f06
	.global L_8d1e76
L_8d1e76:
	brne r13,0x0,L_8d1f10
	.global L_8d1e7a
L_8d1e7a:
	brne r13,0x0,L_8d1f1a
	.global L_8d1e7e
L_8d1e7e:
	mov_s r0,0x880c00
L_8d1e84:
	ld_s r1,[r0,0x78]
L_8d1e86:
	asl_s r2,r14
L_8d1e88:
	bclr_s r1,r1,0x0
L_8d1e8a:
	or_s r1,r1,r14
L_8d1e8c:
	bclr_s r1,r1,0x1
L_8d1e8e:
	or_s r2,r2,r1
L_8d1e90:
	bclr_s r2,r2,0x2
L_8d1e92:
	asl_s r1,r14,0x2
L_8d1e94:
	or_s r1,r1,r2
L_8d1e96:
	st_s r1,[r0,0x78]
L_8d1e98:
	mov lp_count,0xc8
L_8d1e9c:
	lp L_8d1ebe
L_8d1ea0:
	ld_s r1,[r0,0x7c]
L_8d1ea2:
	bmsk r13,r1,0x0
L_8d1ea6:
	lsr_s r15,r1
L_8d1ea8:
	lsr_s r1,r1,0x2
L_8d1eaa:
	bmsk_s r15,r15,0x0
L_8d1eac:
	bmsk r16,r1,0x0
L_8d1eb0:
	cmp_s r14,r13
L_8d1eb2:
	cmp.eq r14,r15
L_8d1eb6:
	cmp.eq r14,r16
L_8d1eba:
	beq_s L_8d1ebe
L_8d1ebc:
	nop_s
	.global L_8d1ebe
L_8d1ebe:
	cmp_s r14,r13
L_8d1ec0:
	cmp.eq r14,r15
L_8d1ec4:
	cmp.eq r14,r16
L_8d1ec8:
	beq_s L_8d1ee2
L_8d1eca:
	mov_s r1,0x101d828
L_8d1ed0:
	bl.d L_8dcba8
L_8d1ed4:
	mov_s r0,0x0
L_8d1ed6:
	mov_s r0,blink
L_8d1ed8:
	mov_s r1,0x1334
L_8d1ede:
	bl L_8c9b28
	.global L_8d1ee2
L_8d1ee2:
	cmp_s r14,r13
L_8d1ee4:
	cmp.eq r14,r16
L_8d1ee8:
	cmp.eq r14,r15
L_8d1eec:
	beq_s L_8d1f02
L_8d1eee:
	mov_s r1,0x101d9f0
L_8d1ef4:
	mov_s r0,0x1
L_8d1ef6:
	mov_s r2,r13
L_8d1ef8:
	mov_s r3,r15
L_8d1efa:
	bl.d L_8dcd00
L_8d1efe:
	mov r4,r16
	.global L_8d1f02
L_8d1f02:
	b L_8c0244
	.global L_8d1f06
L_8d1f06:
	mov_s r0,blink
L_8d1f08:
	bl.d L_8c9b28
L_8d1f0c:
	mov_s r1,0xaf
L_8d1f0e:
	b_s L_8d1e76
	.global L_8d1f10
L_8d1f10:
	mov_s r0,blink
L_8d1f12:
	bl.d L_8c9b28
L_8d1f16:
	mov_s r1,0xb0
L_8d1f18:
	b_s L_8d1e7a
	.global L_8d1f1a
L_8d1f1a:
	mov_s r0,blink
L_8d1f1c:
	bl.d L_8c9b28
L_8d1f20:
	mov_s r1,0xb1
L_8d1f22:
	b_s L_8d1e7e
