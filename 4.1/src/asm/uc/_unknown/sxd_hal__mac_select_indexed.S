/* sxd_hal__mac_select_indexed @ 0x9250a8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager_step_a, bi_manager_step_b, brp__mode_step, brp_flow_step, txss__prepare_frames
 */
	.section .text.sxd_hal__mac_select_indexed,"ax",@progbits
	.global sxd_hal__mac_select_indexed
sxd_hal__mac_select_indexed:
	.global L_9250a8
L_9250a8:
	st.a r13,[sp,-0x8]
L_9250ac:
	st_s r14,[sp,0x4]
L_9250ae:
	mov_s r14,blink
L_9250b0:
	mov_s r13,r0
L_9250b2:
	add_s r0,r0,0x52
L_9250b4:
	asl_s r0,r0,0x18
L_9250b6:
	mov_s r32,r0
L_9250b8:
	st.ab r0,[r25,0x4]
L_9250bc:
	bclr r25,r25,0xa
L_9250c0:
	/* add_s r13,0x6 */
	.byte 0x06,0xe5
L_9250c2:
	mov_s r1,0x49
L_9250c4:
	asl_s r1,r1,0x18
L_9250c6:
	bset r1,r1,r13
L_9250ca:
	mov_s r32,r1
L_9250cc:
	st.ab r1,[r25,0x4]
L_9250d0:
	bclr r25,r25,0xa
L_9250d4:
	mov_s blink,r14
L_9250d6:
	ld_s r14,[sp,0x4]
L_9250d8:
	j.d [blink]
L_9250dc:
	ld.ab r13,[sp,0x8]
