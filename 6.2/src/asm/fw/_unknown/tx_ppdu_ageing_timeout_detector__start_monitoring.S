/* tx_ppdu_ageing_timeout_detector__start_monitoring @ 0x8e7bc4, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector::start_monitoring(): Detector is not yet initialized
 *   tx_ppdu_ageing_timeout_detector::start_monitoring(): | cid %d | is_enabled %d | check_link_loss_period_usec %d
 *   [NNL] tx_ageing_threshold_usec %d
 * Зовут его: lm_if__start_link_loss_monitoring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, arc_protect_addr, detector__arm_timer, detector__init_common, fw_log_emit0, fw_log_emit1, fw_log_emit3, fw_sysassert_fatal, ll_detector__is_armed_b, peer__check_flag_30, periodic_service__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_ppdu_ageing_timeout_detector__start_monitoring
tx_ppdu_ageing_timeout_detector__start_monitoring:
	.global L_8e7bc4
L_8e7bc4:
	push_s blink
L_8e7bc6:
	bl L_8c01dc
L_8e7bca:
	bl.d L_8da378
L_8e7bce:
	mov_s r13,r0
L_8e7bd0:
	brne_s r0,0,L_8e7be0
L_8e7bd2:
	mov_s r1,0x10147d4
L_8e7bd8:
	bl.d L_8dcba8
L_8e7bdc:
	mov_s r0,0xb
L_8e7bde:
	b_s L_8e7c8e
	.global L_8e7be0
L_8e7be0:
	add r14,r13,0x20
L_8e7be4:
	ldb_s r0,[r14,0x10]
L_8e7be6:
	brge r0,0x8,L_8e7c92
	.global L_8e7bea
L_8e7bea:
	bl.d L_8da260
L_8e7bee:
	mov_s r0,r13
L_8e7bf0:
	ldb_s r2,[r14,0x10]
L_8e7bf2:
	mov_s r16,r0
L_8e7bf4:
	ld_s r3,[r13,0x34]
L_8e7bf6:
	mov_s r1,0x101482c
L_8e7bfc:
	asl_s r0,r2,0x2
L_8e7bfe:
	add3_s r0,r0,r0
L_8e7c00:
	/* add_s r3,0x4 */
	.byte 0x04,0xe3
L_8e7c02:
	ld r4,[r3,r0]
L_8e7c06:
	mov_s r0,0x2b
L_8e7c08:
	bl.d L_8dcd00
L_8e7c0c:
	mov_s r3,r16
L_8e7c0e:
	ldb_s r2,[r14,0x10]
L_8e7c10:
	mov_s r1,0x101489c
L_8e7c16:
	ld_s r0,[r13,0x34]
L_8e7c18:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8e7c1a:
	add3_s r2,r2,r2
L_8e7c1c:
	add_s r0,r0,0x8
L_8e7c1e:
	ld_s r2,[r0,r2]
L_8e7c20:
	bl.d L_8dcc10
L_8e7c24:
	mov_s r0,0x2b
L_8e7c26:
	bl.d L_8e7e8c
L_8e7c2a:
	mov_s r0,r13
L_8e7c2c:
	bl.d L_8c6844
L_8e7c30:
	mov_s r0,r13
L_8e7c32:
	bl.d L_8cd080
L_8e7c36:
	mov_s r15,0x0
L_8e7c38:
	ld_s r1,[r0]
L_8e7c3a:
	ld_s r2,[r1,0x2c]
L_8e7c3c:
	jl_s.d [r2]
L_8e7c3e:
	ldb_s r1,[r14,0x10]
L_8e7c40:
	ld_s r0,[r13,0x34]
L_8e7c42:
	ldb_s r1,[r14,0x10]
L_8e7c44:
	add r0,r0,0x120
L_8e7c48:
	add2_s r0,r0,r1
L_8e7c4a:
	st_s r15,[r0]
L_8e7c4c:
	ld_s r0,[r13,0x34]
L_8e7c4e:
	ldb_s r1,[r14,0x10]
L_8e7c50:
	add r0,r0,0x140
L_8e7c54:
	add2_s r0,r0,r1
L_8e7c56:
	st_s r15,[r0]
L_8e7c58:
	ldb_s r1,[r14,0x10]
L_8e7c5a:
	mov_s r2,r15
L_8e7c5c:
	ld_s r0,[r13,0x34]
L_8e7c5e:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e7c60:
	add3_s r1,r1,r1
L_8e7c62:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e7c64:
	ld_s r1,[r0,r1]
L_8e7c66:
	mov_s r0,r13
L_8e7c68:
	mov_s r3,0x1
L_8e7c6a:
	bl.d L_8d8fa0
L_8e7c6e:
	mov r4,0x5
L_8e7c72:
	cmp r16,0x0
L_8e7c76:
	mov.ne r0,r13
L_8e7c7a:
	bl.ne.d L_8e77c4
L_8e7c7e:
	mov.ne r1,r15
L_8e7c82:
	add r1,r13,0x30
L_8e7c86:
	mov_s r0,0x0
L_8e7c88:
	bl.d L_8c3b90
L_8e7c8c:
	mov_s r2,0x3
	.global L_8e7c8e
L_8e7c8e:
	b L_8c0244
	.global L_8e7c92
L_8e7c92:
	mov_s r0,blink
L_8e7c94:
	mov_s r1,0x1589
L_8e7c9a:
	bl L_8c9b28
L_8e7c9e:
	b_s L_8e7bea
