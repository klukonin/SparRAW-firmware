/* ucode_cmd_0x31_handler @ 0x920dc8, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   BRP is pending or sta isn't connected; peer_id: %d; b_assoc=%d
 *   BRP is pending peer_id: %d;
 *   AOA was started peer_id: %d; aoa_meas_type: %d
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf__abort_step, bf_req__enqueue, uc_evt__send_24, uc_log__emit1, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x31_handler
ucode_cmd_0x31_handler:
	.global L_920dc8
L_920dc8:
	push_s blink
L_920dca:
	bl.d L_92022c
L_920dce:
	mov_s r2,0x0
L_920dd0:
	ldb_s r1,[r0,0x6]
L_920dd2:
	mov_s r13,0x8024b8
L_920dd8:
	ldw_s r14,[r0,0xc]
L_920dda:
	stb_s r1,[r13,0x6]
L_920ddc:
	ld_s r1,[r0]
L_920dde:
	mov_s r3,0x0
L_920de0:
	st_s r1,[r13]
L_920de2:
	ldw_s r1,[r0,0x4]
L_920de4:
	bset r3,r3,r14
L_920de8:
	stw_s r1,[r13,0x4]
L_920dea:
	ldb_s r15,[r0,0x7]
L_920dec:
	sub.f r4,r3,0x0
L_920df0:
	mov_s r1,0x80218c
L_920df6:
	ldb_s r1,[r1,0x8]
L_920df8:
	mov.ne r4,0x1
L_920dfc:
	and.f r4,r4,r1
L_920e00:
	stb_s r15,[r13,0x7]
L_920e02:
	mov_s r0,0x1
L_920e04:
	beq_s L_920e16
L_920e06:
	mov r16,0x801ffc
L_920e0e:
	ld r1,[r16, 0xb4]
L_920e12:
	tst_s r1,r3
L_920e14:
	beq_s L_920e36
	.global L_920e16
L_920e16:
	mov_s r1,0x10012d8
L_920e1c:
	mov_s r0,0x10
L_920e1e:
	mov_s r2,r14
L_920e20:
	bl.d L_92d27c
L_920e24:
	mov_s r3,r4
	.global L_920e26
L_920e26:
	mov_s r0,0x2
L_920e28:
	stb_s r0,[r13,0xc]
L_920e2a:
	mov_s r0,0x0
L_920e2c:
	stb_s r0,[r13,0xd]
L_920e2e:
	bl.d L_927550
L_920e32:
	mov_s r0,r13
L_920e34:
	b_s L_920eee
	.global L_920e36
L_920e36:
	mov_s r1,0x8013f4
L_920e3c:
	brne r15,0x1,L_920e48
L_920e40:
	mov_s r2,0x2
L_920e42:
	stw_s r2,[r1,0x8]
L_920e44:
	stb_s r0,[r13,0xd]
L_920e46:
	b_s L_920e4e
	.global L_920e48
L_920e48:
	stw_s r0,[r1,0x8]
L_920e4a:
	stb_s r2,[r13,0xd]
L_920e4c:
	mov_s r0,r2
	.global L_920e4e
L_920e4e:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_920e50:
	add_s r0,r0,0x40
L_920e52:
	stw_s r0,[r13,0xe]
L_920e54:
	mov_s r0,0xff
L_920e56:
	stb_s r0,[r13,0xc]
L_920e58:
	lr r15,[0xa]
L_920e5c:
	bclr r0,r15,0x1
L_920e60:
	flag r0
L_920e64:
	ld r0,[r16, 0xb4]
L_920e68:
	tst_s r0,r3
L_920e6a:
	mov_s r1,0x0
L_920e6c:
	bne_s L_920eb8
L_920e6e:
	asl_s r13,r14,0x2
L_920e70:
	add2_s r13,r13,r13
L_920e72:
	add r1,r13,0x857e38
L_920e7a:
	ldb_s r0,[r1,0x11]
L_920e7c:
	mov_s r2,0x8013f4
L_920e82:
	bset_s r0,r0,0x6
L_920e84:
	stb_s r0,[r1,0x11]
L_920e86:
	extb_s r0,r14
L_920e88:
	bl.d L_921bd4
L_920e8c:
	mov_s r1,0x9
L_920e8e:
	asl_s r0,r14,0x4
L_920e90:
	add2_s r0,r0,r0
L_920e92:
	add_s r0,r0,0x801124
L_920e98:
	ld_s r2,[r0,0x10]
L_920e9a:
	mov_s r1,0x80212c
L_920ea0:
	ldw_s r0,[r0,0x14]
L_920ea2:
	st_s r2,[r1,0x5c]
L_920ea4:
	stw r0,[r1, 0x60]
L_920ea8:
	add_s r13,r13,r16
L_920eaa:
	ldb_s r0,[r13,0xa]
L_920eac:
	bset_s r0,r0,0x0
L_920eae:
	stb_s r0,[r13,0xa]
L_920eb0:
	bl.d L_921824
L_920eb4:
	mov_s r0,r14
L_920eb6:
	mov_s r1,0x1
	.global L_920eb8
L_920eb8:
	lr r0,[0xa]
L_920ebc:
	bic r15,r15,-0x3
L_920ec0:
	or_s r15,r15,r0
L_920ec2:
	flag r15
L_920ec6:
	mov_s r13,0x8024b8
L_920ecc:
	brne_s r1,0,L_920ede
L_920ece:
	mov_s r1,0x1001318
L_920ed4:
	mov_s r0,0x10
L_920ed6:
	bl.d L_92d1d0
L_920eda:
	mov_s r2,r14
L_920edc:
	b_s L_920e26
	.global L_920ede
L_920ede:
	mov_s r1,0x1001334
L_920ee4:
	mov_s r0,0x20
L_920ee6:
	mov_s r2,r14
L_920ee8:
	bl.d L_92d27c
L_920eec:
	ldb_s r3,[r13,0x7]
	.global L_920eee
L_920eee:
	b L_920294
L_920ef2:
	nop_s
