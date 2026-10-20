/* sdp__drive_pin_timed @ 0x8d6e88, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_OPERATIONAL_cmd_handler, fw_sysassert_fatal, hwf_rf__wait_ready_log, power_halt_seq, rf_power_off
 * Зовёт сам: SDP__sdp_drive_value, __ld_r16_to_r13_ret, __st_r16_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__drive_pin_timed
sdp__drive_pin_timed:
	.global L_8d6e88
L_8d6e88:
	push_s blink
L_8d6e8a:
	bl L_8c01dc
L_8d6e8e:
	sub_s sp,sp,0x8
L_8d6e90:
	mov.f r14,r0
L_8d6e94:
	mov_s r2,0x8004c6
L_8d6e9a:
	ldw_s r1,[r2]
L_8d6e9c:
	mov_s r0,0x2328
L_8d6ea2:
	max r1,r1,r0
L_8d6ea6:
	mov_s r13,0x800500
L_8d6eac:
	stw_s r1,[r2]
L_8d6eae:
	bne_s L_8d6ebc
L_8d6eb0:
	mov_s r0,0x0
L_8d6eb2:
	mov_s r1,r13
L_8d6eb4:
	bl.d L_8e9900
L_8d6eb8:
	mov_s r2,r0
L_8d6eba:
	b_s L_8d6eee
	.global L_8d6ebc
L_8d6ebc:
	ld_s r0,[r13]
L_8d6ebe:
	ld_s r15,[r13,0x4]
L_8d6ec0:
	or.f 0x0,r0,r15
L_8d6ec4:
	beq_s L_8d6eee
L_8d6ec6:
	add.f r16,r1,r0
L_8d6eca:
	mov_s r2,0x0
L_8d6ecc:
	adc r15,r15,r2
	.global L_8d6ed0
L_8d6ed0:
	mov_s r1,sp
L_8d6ed2:
	mov_s r0,0x0
L_8d6ed4:
	bl.d L_8e9900
L_8d6ed8:
	mov_s r2,r0
L_8d6eda:
	ld_s r1,[sp,0x4]
L_8d6edc:
	ld_s r0,[sp,0x0]
L_8d6ede:
	cmp_s r15,r1
L_8d6ee0:
	cmp.eq r16,r0
L_8d6ee4:
	bhi_s L_8d6ed0
L_8d6ee6:
	mov_s r1,0x0
L_8d6ee8:
	mov_s r0,0x0
L_8d6eea:
	st_s r1,[r13]
L_8d6eec:
	st_s r0,[r13,0x4]
	.global L_8d6eee
L_8d6eee:
	mov_s r0,r14
L_8d6ef0:
	bl.d L_8e4abc
L_8d6ef4:
	mov_s r1,0x4
L_8d6ef6:
	mov_s r0,0x13880
L_8d6efc:
	mov lp_count,r0
L_8d6f00:
	nop_s
L_8d6f02:
	lp L_8d6f0a
L_8d6f06:
	nop_s
L_8d6f08:
	nop_s
	.global L_8d6f0a
L_8d6f0a:
	brne r14,0x1,L_8d6f2a
L_8d6f0e:
	mov_s r0,0x8004c8
L_8d6f14:
	ldw_s r0,[r0]
L_8d6f16:
	breq_s r0,0,L_8d6f2a
L_8d6f18:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d6f1a:
	add2_s r0,r0,r0
L_8d6f1c:
	mov lp_count,r0
L_8d6f20:
	nop_s
L_8d6f22:
	lp L_8d6f2a
L_8d6f26:
	nop_s
L_8d6f28:
	nop_s
	.global L_8d6f2a
L_8d6f2a:
	b.d L_8c0244
L_8d6f2e:
	add_s sp,sp,0x8
