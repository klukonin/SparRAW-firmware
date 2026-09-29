/* channels_switch__check_g80017c @ 0x8e494c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__read_and_check, temp_service__radio_locked_cb
 * Зовёт сам: TEMPERATURE_SERVICE__timer_exp_handler, __ld_r13_to_r13_ret, u_schd__cancel, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch__check_g80017c
channels_switch__check_g80017c:
	.global L_8e494c
L_8e494c:
	push_s blink
L_8e494e:
	push_s r13
L_8e4950:
	mov_s r13,r0
L_8e4952:
	ld_s r0,[gp,-0x8]
L_8e4954:
	breq_s r0,0,L_8e4960
L_8e4956:
	bl L_8c8de0
L_8e495a:
	mov_s r0,0x0
L_8e495c:
	st.as r0,[gp,-0x2]
	.global L_8e4960
L_8e4960:
	breq_s r13,0,L_8e4982
L_8e4962:
	mov_s r0,0x29438
L_8e4968:
	mov_s r1,0x0
L_8e496a:
	mov_s r2,0x0
L_8e496c:
	mov_s r3,0x1
L_8e496e:
	mov_s r4,r13
L_8e4970:
	mov r5,0x0
L_8e4974:
	bl.d L_8e0c0c
L_8e4978:
	mov r6,0x0
L_8e497c:
	st.as r0,[gp,-0x2]
L_8e4980:
	b_s L_8e4988
	.global L_8e4982
L_8e4982:
	bl.d L_8e9438
L_8e4986:
	mov_s r0,0x0
	.global L_8e4988
L_8e4988:
	b L_8c025c
