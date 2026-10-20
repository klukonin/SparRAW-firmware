/* perform_first_measurement_operations @ 0x8e0908, 280 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   perform_first_measurement_operations() Calibrated BB measurement=%d
 *   perform_first_measurement_operations() rfc_idx=%d, Calibrated RF measurement=%d
 *   Starting Information flow periodic_info_flow
 *   Connection:%d, Is either NULL or not associated.
 * Зовут его: temp_service__radio_locked_cb
 * Зовёт сам: TEMPERATURE_SERVICE__consume_bb_sensor_calibration_parameters, TEMPERATURE_SERVICE__read_rf_sensor_calibration_parameters, __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, fw_log_emit2, info_flow__run, mid__state_is_2_or_3, mid_list__by_mid_fw
 * Глобалы (через gp): 0x8002cc, 0x80038c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global perform_first_measurement_operations
perform_first_measurement_operations:
	.global L_8e0908
L_8e0908:
	push_s blink
L_8e090a:
	push_s r13
L_8e090c:
	mov_s r0,0x1
L_8e090e:
	st.as r0,[gp,0x82]
L_8e0912:
	ld_s r0,[gp,-0xe0]
L_8e0914:
	mov_s r1,0x80114c
L_8e091a:
	add_s r2,r1,0x4
L_8e091c:
	st_s r0,[r1]
L_8e091e:
	mov lp_count,0x8
L_8e0922:
	mov_s r1,0x0
L_8e0924:
	lp L_8e093a
L_8e0928:
	mov_s r0,0x847fa8
L_8e092e:
	ld.as r0,[r0,r1]
L_8e0932:
	add2 r12,r2,r1
L_8e0936:
	st_s r0,[r12]
L_8e0938:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8e093a
L_8e093a:
	bl L_8c73f0
L_8e093e:
	bl L_8e2274
L_8e0942:
	ld_s r0,[gp,0x148]
L_8e0944:
	mov_s r1,0x0
L_8e0946:
	bset_s r1,r1,0xc
L_8e0948:
	cmp_s r0,0x0
L_8e094a:
	add.ge r0,r0,r1
L_8e094e:
	asr.ge r0,r0,0xd
L_8e0952:
	bge_s L_8e095a
L_8e0954:
	sub_s r1,r1,r0
L_8e0956:
	asr_s r1,r1,0xd
L_8e0958:
	neg_s r0,r1
	.global L_8e095a
L_8e095a:
	mul64 r0,0x3e8
L_8e095e:
	ld_s r0,[gp,-0xe0]
L_8e0960:
	mov_s r1,0x10122c0
L_8e0966:
	add r2,mlo,r0
L_8e096a:
	st.as r2,[gp,-0x38]
L_8e096e:
	bl.d L_8dcc10
L_8e0972:
	mov_s r0,0x26
L_8e0974:
	mov_s r13,0x0
L_8e0976:
	b_s L_8e09a6
	.global L_8e0978
L_8e0978:
	mov_s r0,0x847fa8
L_8e097e:
	add2_s r0,r0,r13
L_8e0980:
	ld_s r3,[r0]
L_8e0982:
	cmp r3,-0x1
L_8e0986:
	beq_s L_8e09a4
L_8e0988:
	mov_s r1,0x8019ec
L_8e098e:
	ld.as r1,[r1,r13]
L_8e0992:
	add_s r3,r3,r1
L_8e0994:
	st_s r3,[r0]
L_8e0996:
	mov_s r1,0x1012304
L_8e099c:
	mov_s r0,0x26
L_8e099e:
	bl.d L_8dcc80
L_8e09a2:
	mov_s r2,r13
	.global L_8e09a4
L_8e09a4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8e09a6
L_8e09a6:
	brlo r13,0x8,L_8e0978
L_8e09aa:
	b L_8c025c
L_8e09ae:
	nop_s
L_8e09b0:
	push_s blink
L_8e09b2:
	bl L_8c01dc
L_8e09b6:
	bl.d L_8cc3dc
L_8e09ba:
	mov_s r15,r0
L_8e09bc:
	mov_s r16,r0
L_8e09be:
	mov_s r13,0x0
L_8e09c0:
	st.as r13,[gp,-0x26]
L_8e09c4:
	bl.d L_8da488
L_8e09c8:
	mov_s r0,r15
L_8e09ca:
	breq_s r0,0,L_8e0a1c
L_8e09cc:
	mov_s r1,0x1010d6c
L_8e09d2:
	bl.d L_8dcba8
L_8e09d6:
	mov_s r0,0x2b
L_8e09d8:
	mov_s r14,r13
L_8e09da:
	b_s L_8e09ec
	.global L_8e09dc
L_8e09dc:
	mov_s r1,0x1010d9c
L_8e09e2:
	mov_s r0,0x2b
L_8e09e4:
	bl.d L_8dcc10
L_8e09e8:
	mov_s r2,r14
	.global L_8e09ea
L_8e09ea:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8e09ec
L_8e09ec:
	brge r14,0x8,L_8e0a12
L_8e09f0:
	bl.d L_8cbffc
L_8e09f4:
	mov_s r0,r14
L_8e09f6:
	mov.f r1,r0
L_8e09fa:
	beq_s L_8e09dc
L_8e09fc:
	ldb r0,[r1, 0xf0]
L_8e0a00:
	brne r0,0x2,L_8e09dc
L_8e0a04:
	mov_s r0,r16
L_8e0a06:
	mov_s r2,0x0
L_8e0a08:
	bl.d L_8d885c
L_8e0a0c:
	mov_s r3,r2
L_8e0a0e:
	mov_s r13,0x1
L_8e0a10:
	b_s L_8e09ea
	.global L_8e0a12
L_8e0a12:
	cmp_s r13,0x0
L_8e0a14:
	bl.ne.d L_8d86f0
L_8e0a18:
	mov.ne r0,r15
	.global L_8e0a1c
L_8e0a1c:
	b L_8c0244
