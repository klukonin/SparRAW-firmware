/* tx_ppdu_ageing_timeout_detector__start_monitoring @ 0x8e29d4, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector::start_monitoring(): Detector is not yet initialized
 *   tx_ppdu_ageing_timeout_detector::start_monitoring(): | cid %d | is_enabled %d | check_link_loss_period_usec %d
 *   [NNL] tx_ageing_threshold_usec %d
 * Зовут его: lm_if__start_link_loss_monitoring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ageing_detector__configure, ageing_detector__get_state, ageing_detector__is_active, detector__arm_timer, detector__init_common, fw_log__emit0, fw_log__emit1, fw_log__emit3, periodic_service__start
 */
	.section .text.tx_ppdu_ageing_timeout_detector__start_monitoring,"ax",@progbits
	.global tx_ppdu_ageing_timeout_detector__start_monitoring
tx_ppdu_ageing_timeout_detector__start_monitoring:
	.global L_8e29d4
L_8e29d4:
	push_s blink
L_8e29d6:
	bl L_8c02bc
L_8e29da:
	bl.d L_8d72cc
L_8e29de:
	mov_s r14,r0
L_8e29e0:
	mov_s r15,0x0
L_8e29e2:
	brne_s r0,0,L_8e29f4
L_8e29e4:
	mov_s r2,0x1011014
L_8e29ea:
	mov_s r0,0xb
L_8e29ec:
	bl.d L_8edfb0
L_8e29f0:
	mov_s r1,r15
L_8e29f2:
	b_s L_8e2a88
	.global L_8e29f4
L_8e29f4:
	bl.d L_8d71a0
L_8e29f8:
	mov_s r0,r14
L_8e29fa:
	add r13,r14,0x20
L_8e29fe:
	ldb_s r3,[r13,0x10]
L_8e2a00:
	mov_s r16,r0
L_8e2a02:
	ld_s r1,[r14,0x34]
L_8e2a04:
	mov_s r2,0x101106c
L_8e2a0a:
	asl_s r0,r3,0x2
L_8e2a0c:
	add3_s r0,r0,r0
L_8e2a0e:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8e2a10:
	ld r5,[r1,r0]
L_8e2a14:
	mov_s r0,0xb
L_8e2a16:
	mov_s r1,0x2
L_8e2a18:
	bl.d L_8ee034
L_8e2a1c:
	mov r4,r16
L_8e2a20:
	ldb_s r1,[r13,0x10]
L_8e2a22:
	mov_s r2,0x10110dc
L_8e2a28:
	ld_s r0,[r14,0x34]
L_8e2a2a:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e2a2c:
	add3_s r1,r1,r1
L_8e2a2e:
	add_s r0,r0,0x8
L_8e2a30:
	ld_s r3,[r0,r1]
L_8e2a32:
	mov_s r0,0xb
L_8e2a34:
	bl.d L_8edfcc
L_8e2a38:
	mov_s r1,0x2
L_8e2a3a:
	bl.d L_8e2d84
L_8e2a3e:
	mov_s r0,r14
L_8e2a40:
	bl.d L_8c5acc
L_8e2a44:
	mov_s r0,r14
L_8e2a46:
	ld_s r0,[r14,0x34]
L_8e2a48:
	ldb_s r1,[r13,0x10]
L_8e2a4a:
	add r0,r0,0x120
L_8e2a4e:
	add2_s r0,r0,r1
L_8e2a50:
	st_s r15,[r0]
L_8e2a52:
	ld_s r0,[r14,0x34]
L_8e2a54:
	ldb_s r1,[r13,0x10]
L_8e2a56:
	add r0,r0,0x140
L_8e2a5a:
	add2_s r0,r0,r1
L_8e2a5c:
	st_s r15,[r0]
L_8e2a5e:
	ldb_s r1,[r13,0x10]
L_8e2a60:
	mov_s r2,r15
L_8e2a62:
	ld_s r0,[r14,0x34]
L_8e2a64:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e2a66:
	add3_s r1,r1,r1
L_8e2a68:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e2a6a:
	ld_s r1,[r0,r1]
L_8e2a6c:
	mov_s r0,r14
L_8e2a6e:
	mov_s r3,0x1
L_8e2a70:
	bl.d L_8d5e80
L_8e2a74:
	mov r4,0x5
L_8e2a78:
	cmp r16,0x0
L_8e2a7c:
	mov.ne r0,r14
L_8e2a80:
	bl.ne.d L_8e2570
L_8e2a84:
	mov.ne r1,r15
	.global L_8e2a88
L_8e2a88:
	b L_8c0324
