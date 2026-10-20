/* bad_beacons_detector__handle_bcons_info @ 0x8caeb4, 220 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bad_beacons_detector::handle_bcons_info(): | cid %d | valid_bcon_received %d | bti_max_bcon_rx_snr %d
 *   [NNL] | snr_valid %d | bad_bcons_cnt %d | bad_beacons_num_threshold %d
 *   bad_beacons_detector::handle_bcons_info(): Link-Loss detected for cid=%d. Initating disconnect flow.
 * Зовут его: conn__feed_bcons_info
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bad_beacons_detector__configure, bad_beacons_detector__is_bad, conn__disconnect, conn_mgr__by_cid, fw_log__emit1, fw_log__emit3
 */
	.section .text.bad_beacons_detector__handle_bcons_info,"ax",@progbits
	.global bad_beacons_detector__handle_bcons_info
bad_beacons_detector__handle_bcons_info:
	.global L_8caeb4
L_8caeb4:
	push_s blink
L_8caeb6:
	bl L_8c02bc
L_8caeba:
	bl.d L_8d70fc
L_8caebe:
	mov_s r14,r0
L_8caec0:
	breq r0,0x0,L_8caf8c
L_8caec4:
	ld_s r0,[r14,0x8]
L_8caec6:
	breq r0,0x0,L_8caf8c
L_8caeca:
	mov_s r0,0x854de0
L_8caed0:
	add r16,r0,0x20
L_8caed4:
	ldb r15,[r16, 0xa]
L_8caed8:
	mov_s r3,0x0
L_8caeda:
	ldb_s r2,[r14]
L_8caedc:
	ld_s r1,[r14,0x4]
L_8caede:
	add r13,r1,0x20
L_8caee2:
	breq_s r15,0,L_8caef8
L_8caee4:
	ldb r15,[r16]
L_8caee8:
	breq_s r15,0,L_8caef6
L_8caeea:
	asl_s r15,r2,0x2
L_8caeec:
	add3_s r15,r15,r15
L_8caeee:
	ld_s r15,[r13,r15]
L_8caef0:
	ld_s r13,[r0,0x24]
L_8caef2:
	brge r15,r13,L_8caef8
	.global L_8caef6
L_8caef6:
	mov_s r3,0x1
	.global L_8caef8
L_8caef8:
	mov.f r4,r3
L_8caefc:
	add r1,r1,0x1e0
L_8caf00:
	add_s r2,r2,r1
L_8caf02:
	mov_s r1,0x0
L_8caf04:
	bne_s L_8caf0c
L_8caf06:
	ldb_s r1,[r2,0x4]
L_8caf08:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8caf0a:
	extb_s r1,r1
	.global L_8caf0c
L_8caf0c:
	stb_s r1,[r2,0x4]
L_8caf0e:
	ld_s r13,[r14,0x4]
L_8caf10:
	mov_s r1,r13
L_8caf12:
	ldb_s r3,[r14]
L_8caf14:
	add r1,r1,0x1e4
L_8caf18:
	ldb_s r2,[r1,r3]
L_8caf1a:
	asl_s r1,r3,0x2
L_8caf1c:
	add3_s r1,r1,r1
L_8caf1e:
	add_s r13,r13,0x1c
L_8caf20:
	ld_s r1,[r13,r1]
L_8caf22:
	ld r5,[r0, 0x24]
L_8caf26:
	cmp_s r2,r1
L_8caf28:
	mov_s r13,0x1
L_8caf2a:
	sub.ls r13,r13,r13
L_8caf2e:
	mov_s r2,0x1011764
L_8caf34:
	mov_s r0,0xb
L_8caf36:
	bl.d L_8ee034
L_8caf3a:
	mov_s r1,0x2
L_8caf3c:
	ld_s r1,[r14,0x4]
L_8caf3e:
	mov_s r2,0x10117cc
L_8caf44:
	ldb_s r0,[r14]
L_8caf46:
	mov_s r3,r1
L_8caf48:
	add r3,r3,0x1e4
L_8caf4c:
	ldb r4,[r3,r0]
L_8caf50:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8caf52:
	add3_s r0,r0,r0
L_8caf54:
	add_s r1,r1,0x1c
L_8caf56:
	ld r5,[r1,r0]
L_8caf5a:
	mov_s r0,0xb
L_8caf5c:
	mov_s r1,0x2
L_8caf5e:
	bl.d L_8ee034
L_8caf62:
	ldb r3,[r16]
L_8caf66:
	breq_s r13,0,L_8caf8c
L_8caf68:
	mov_s r2,0x1011814
L_8caf6e:
	mov_s r0,0xb
L_8caf70:
	mov_s r1,0x1
L_8caf72:
	bl.d L_8edfcc
L_8caf76:
	ldb_s r3,[r14]
L_8caf78:
	bl.d L_8c9e44
L_8caf7c:
	ldb_s r0,[r14]
L_8caf7e:
	mov_s r1,0x1
L_8caf80:
	bl.d L_8eb190
L_8caf84:
	mov_s r2,r1
L_8caf86:
	bl.d L_8c5a34
L_8caf8a:
	mov_s r0,r14
	.global L_8caf8c
L_8caf8c:
	b L_8c0324
