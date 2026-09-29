/* ka_necessity_detector__start_monitoring @ 0x8e7af0, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector::start_monitoring(): Detector is not yet initialized
 *   ka_necessity_detector::start_monitoring | cid %d | is_enabled %d | check_link_loss_period_usec %d
 *   [NNL] | ka_snr_th_low_db %d | ka_snr_th_high_db %d
 *   [NNL] | ka_period_usec_low_snr %d | ka_period_usec_low_snr %d
 * Зовут его: lm_if__start_link_loss_monitoring
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, detector__arm_timer, detector__init_common, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, ka__check_peer_state, ka_detector__is_enabled, ll_detector__is_armed, periodic_service__start
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ka_necessity_detector__start_monitoring
ka_necessity_detector__start_monitoring:
	.global L_8e7af0
L_8e7af0:
	push_s blink
L_8e7af2:
	bl L_8c01e0
L_8e7af6:
	bl.d L_8da35c
L_8e7afa:
	mov_s r13,r0
L_8e7afc:
	brne_s r0,0,L_8e7b0c
L_8e7afe:
	mov_s r1,0x1014ac4
L_8e7b04:
	bl.d L_8dcba8
L_8e7b08:
	mov_s r0,0xb
L_8e7b0a:
	b_s L_8e7bb0
	.global L_8e7b0c
L_8e7b0c:
	add r14,r13,0x20
L_8e7b10:
	ldb_s r0,[r14,0x10]
L_8e7b12:
	brge r0,0x8,L_8e7bb4
	.global L_8e7b16
L_8e7b16:
	bl.d L_8da214
L_8e7b1a:
	mov_s r0,r13
L_8e7b1c:
	ldb_s r2,[r14,0x10]
L_8e7b1e:
	mov_s r15,r0
L_8e7b20:
	ld_s r3,[r13,0x34]
L_8e7b22:
	mov_s r1,0x1014b10
L_8e7b28:
	asl_s r0,r2,0x2
L_8e7b2a:
	add3_s r0,r0,r0
L_8e7b2c:
	/* add_s r3,0x4 */
	.byte 0x04,0xe3
L_8e7b2e:
	ld r4,[r3,r0]
L_8e7b32:
	mov_s r0,0x2b
L_8e7b34:
	bl.d L_8dcd00
L_8e7b38:
	mov_s r3,r15
L_8e7b3a:
	ldb_s r3,[r14,0x10]
L_8e7b3c:
	mov_s r1,0x1014b74
L_8e7b42:
	ld_s r0,[r13,0x34]
L_8e7b44:
	/* asl_s r3,r3,0x2 */
	.byte 0x02,0xbb
L_8e7b46:
	add3_s r3,r3,r3
L_8e7b48:
	add_s r2,r0,r3
L_8e7b4a:
	add_s r0,r0,r3
L_8e7b4c:
	ld_s r3,[r0,0x18]
L_8e7b4e:
	mov_s r0,0x2b
L_8e7b50:
	bl.d L_8dcc80
L_8e7b54:
	ld_s r2,[r2,0x14]
L_8e7b56:
	mov_s r1,0x1014ba8
L_8e7b5c:
	ldb_s r2,[r14,0x10]
L_8e7b5e:
	ld_s r0,[r13,0x34]
L_8e7b60:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_8e7b62:
	add_s r0,r0,0x10
L_8e7b64:
	add3_s r2,r2,r2
L_8e7b66:
	ld_s r2,[r0,r2]
L_8e7b68:
	mov_s r0,0x2b
L_8e7b6a:
	bl.d L_8dcc80
L_8e7b6e:
	mov_s r3,r2
L_8e7b70:
	bl.d L_8e7e8c
L_8e7b74:
	mov_s r0,r13
L_8e7b76:
	bl.d L_8c67f0
L_8e7b7a:
	mov_s r0,r13
L_8e7b7c:
	ld_s r2,[r13,0x34]
L_8e7b7e:
	mov_s r1,0x0
L_8e7b80:
	ldb_s r0,[r14,0x10]
L_8e7b82:
	add r2,r2,0x1c4
L_8e7b86:
	add2_s r2,r2,r0
L_8e7b88:
	st_s r1,[r2]
L_8e7b8a:
	ldb_s r1,[r14,0x10]
L_8e7b8c:
	mov_s r2,0x0
L_8e7b8e:
	ld_s r0,[r13,0x34]
L_8e7b90:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e7b92:
	add3_s r1,r1,r1
L_8e7b94:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e7b96:
	ld_s r1,[r0,r1]
L_8e7b98:
	mov_s r0,r13
L_8e7b9a:
	mov_s r3,0x1
L_8e7b9c:
	bl.d L_8d8fa0
L_8e7ba0:
	mov r4,0x5
L_8e7ba4:
	cmp_s r15,0x0
L_8e7ba6:
	mov.ne r0,r13
L_8e7baa:
	bl.ne.d L_8e77c4
L_8e7bae:
	sub_s.ne r1,r1,r1
	.global L_8e7bb0
L_8e7bb0:
	b L_8c024c
	.global L_8e7bb4
L_8e7bb4:
	mov_s r0,blink
L_8e7bb6:
	mov_s r1,0x1547
L_8e7bbc:
	bl L_8c9b28
L_8e7bc0:
	b_s L_8e7b16
L_8e7bc2:
	nop_s
