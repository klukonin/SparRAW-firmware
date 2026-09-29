/* ka_necessity_detector__start_monitoring @ 0x8e28ec, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ka_necessity_detector::start_monitoring(): Detector is not yet initialized
 *   ka_necessity_detector::start_monitoring | cid %d | is_enabled %d | check_link_loss_period_usec %d
 *   [NNL] | ka_snr_th_low_db %d | ka_snr_th_high_db %d
 *   [NNL] | ka_period_usec_low_snr %d | ka_period_usec_low_snr %d
 *   ka_necessity_detector.cpp
 * Зовут его: lm_if__start_link_loss_monitoring
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, detector__arm_timer, detector__init_common, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, ka_detector__configure, ka_detector__get_state, ka_detector__is_active, periodic_service__start
 */
	.section .text.ka_necessity_detector__start_monitoring,"ax",@progbits
	.global ka_necessity_detector__start_monitoring
ka_necessity_detector__start_monitoring:
	.global L_8e28ec
L_8e28ec:
	push_s blink
L_8e28ee:
	bl L_8c02bc
L_8e28f2:
	bl.d L_8d72b0
L_8e28f6:
	mov_s r14,r0
L_8e28f8:
	brne_s r0,0,L_8e290a
L_8e28fa:
	mov_s r2,0x10113d4
L_8e2900:
	mov_s r0,0xb
L_8e2902:
	bl.d L_8edfb0
L_8e2906:
	mov_s r1,0x0
L_8e2908:
	b_s L_8e29b8
	.global L_8e290a
L_8e290a:
	add r13,r14,0x20
L_8e290e:
	ldb_s r0,[r13,0x10]
L_8e2910:
	brge r0,0x8,L_8e29bc
	.global L_8e2914
L_8e2914:
	bl.d L_8d714c
L_8e2918:
	mov_s r0,r14
L_8e291a:
	ldb_s r3,[r13,0x10]
L_8e291c:
	mov_s r16,r0
L_8e291e:
	ld_s r1,[r14,0x34]
L_8e2920:
	mov_s r2,0x1011420
L_8e2926:
	asl_s r0,r3,0x2
L_8e2928:
	add3_s r0,r0,r0
L_8e292a:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8e292c:
	ld r5,[r1,r0]
L_8e2930:
	mov_s r0,0xb
L_8e2932:
	mov_s r1,0x2
L_8e2934:
	bl.d L_8ee034
L_8e2938:
	mov r4,r16
L_8e293c:
	ldb_s r1,[r13,0x10]
L_8e293e:
	mov_s r2,0x1011484
L_8e2944:
	ld_s r0,[r14,0x34]
L_8e2946:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e2948:
	add3_s r1,r1,r1
L_8e294a:
	add_s r3,r0,r1
L_8e294c:
	add_s r0,r0,r1
L_8e294e:
	ld r4,[r0, 0x18]
L_8e2952:
	mov_s r0,0xb
L_8e2954:
	mov_s r1,0x2
L_8e2956:
	bl.d L_8edff8
L_8e295a:
	ld_s r3,[r3,0x14]
L_8e295c:
	mov_s r2,0x10114b8
L_8e2962:
	ldb_s r0,[r13,0x10]
L_8e2964:
	ld_s r1,[r14,0x34]
L_8e2966:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8e2968:
	add3_s r0,r0,r0
L_8e296a:
	add_s r1,r1,0x10
L_8e296c:
	ld_s r3,[r1,r0]
L_8e296e:
	mov_s r0,0xb
L_8e2970:
	mov_s r1,0x2
L_8e2972:
	bl.d L_8edff8
L_8e2976:
	mov_s r4,r3
L_8e2978:
	bl.d L_8e2d84
L_8e297c:
	mov_s r0,r14
L_8e297e:
	bl.d L_8c5a70
L_8e2982:
	mov_s r0,r14
L_8e2984:
	ld_s r0,[r14,0x34]
L_8e2986:
	mov_s r2,0x0
L_8e2988:
	ldb_s r1,[r13,0x10]
L_8e298a:
	add r0,r0,0x1c4
L_8e298e:
	add2_s r0,r0,r1
L_8e2990:
	st_s r2,[r0]
L_8e2992:
	ldb_s r1,[r13,0x10]
L_8e2994:
	mov_s r3,0x1
L_8e2996:
	ld_s r0,[r14,0x34]
L_8e2998:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8e299a:
	add3_s r1,r1,r1
L_8e299c:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8e299e:
	ld_s r1,[r0,r1]
L_8e29a0:
	mov_s r0,r14
L_8e29a2:
	bl.d L_8d5e80
L_8e29a6:
	mov r4,0x5
L_8e29aa:
	cmp r16,0x0
L_8e29ae:
	mov.ne r0,r14
L_8e29b2:
	bl.ne.d L_8e2570
L_8e29b6:
	sub_s.ne r1,r1,r1
	.global L_8e29b8
L_8e29b8:
	b L_8c0324
	.global L_8e29bc
L_8e29bc:
	mov_s r0,blink
L_8e29be:
	mov_s r2,0x10113b8
L_8e29c4:
	mov_s r1,0x147a
L_8e29ca:
	bl.d L_8c82c0
L_8e29ce:
	mov_s r3,0x46
L_8e29d0:
	b_s L_8e2914
L_8e29d2:
	nop_s
