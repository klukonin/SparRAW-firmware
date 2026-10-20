/* uc_wait_event1_or_event4 @ 0x9318f4, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder_worker, brp_flow_step, bti_worker__collect_bf_metric, internal_tx__await_rx_frame_a, internal_tx__await_rx_frame_b, mac_mode_brp_step, mac_mode_program_c, mac_mode_step_b, txss__init_sweep, txss__prepare_frames
 */
	.section .text.uc_wait_event1_or_event4,"ax",@progbits
	.global uc_wait_event1_or_event4
uc_wait_event1_or_event4:
	.global L_9318f4
L_9318f4:
	st.a r13,[sp,-0xc]
L_9318f8:
	st blink,[sp, 0x4]
L_9318fc:
	st_s r14,[sp,0x8]
L_9318fe:
	tst r42,r0
L_931902:
	mov_s r14,r0
L_931904:
	bne.d L_931968
L_931908:
	mov_s r13,r1
L_93190a:
	tst r54,r13
L_93190e:
	bne_s L_931968
L_931910:
	cmp r2,0x0
L_931914:
	beq.d L_931948
L_931918:
	mov.eq r4,r14
L_93191c:
	or r2,r2,0x23010000
L_931924:
	mov r32,r2
L_931928:
	st.ab r2,[r25,0x4]
L_93192c:
	bclr r25,r25,0xa
L_931930:
	mov r7,0x2000200
L_931938:
	mov r32,r7
L_93193c:
	st.ab r7,[r25,0x4]
L_931940:
	bclr r25,r25,0xa
L_931944:
	bset r4,r14,0x9
	.global L_931948
L_931948:
	nop_s
L_93194a:
	nop_s
L_93194c:
	mov 0x0,0x0
	.global L_931950
L_931950:
	tst r42,r4
L_931954:
	bne_s L_93195c
L_931956:
	tst r54,r13
L_93195a:
	beq_s L_931950
	.global L_93195c
L_93195c:
	tst r42,r14
L_931960:
	bne_s L_931968
L_931962:
	tst r54,r13
L_931966:
	beq_s L_931970
	.global L_931968
L_931968:
	b.d L_931974
L_93196c:
	mov r0,0x1
	.global L_931970
L_931970:
	mov r0,0x0
	.global L_931974
L_931974:
	ld blink,[sp, 0x4]
L_931978:
	ld_s r14,[sp,0x8]
L_93197a:
	j_s.d [blink]
L_93197c:
	ld.ab r13,[sp,0xc]
