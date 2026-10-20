/* bi_manager_step_b @ 0x922afc, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__enter_dti
 * Зовёт сам: memset0_words_uc, sxd_hal__mac_select_indexed
 */
	.section .text.bi_manager_step_b,"ax",@progbits
	.global bi_manager_step_b
bi_manager_step_b:
	.global L_922afc
L_922afc:
	push_s r13
L_922afe:
	mov_s r13,blink
L_922b00:
	mov r0,0x801e82
L_922b08:
	bl.d L_92166c
L_922b0c:
	mov r1,0x2
L_922b10:
	bl.d L_9250a8
L_922b14:
	mov r0,0x0
L_922b18:
	bl.d L_9250a8
L_922b1c:
	mov r0,0x1
L_922b20:
	bl.d L_9250a8
L_922b24:
	mov r0,0x2
L_922b28:
	mov_s r0,0x54
L_922b2a:
	asl_s r0,r0,0x18
L_922b2c:
	mov r32,r0
L_922b30:
	st.ab r0,[r25,0x4]
L_922b34:
	bclr r25,r25,0xa
L_922b38:
	mov_s r1,0x54
L_922b3a:
	asl_s r1,r1,0x18
L_922b3c:
	mov r32,r1
L_922b40:
	st.ab r1,[r25,0x4]
L_922b44:
	bclr r25,r25,0xa
L_922b48:
	mov_s r2,0x49000100
L_922b4e:
	mov_s r32,r2
L_922b50:
	st.ab r2,[r25,0x4]
L_922b54:
	bclr r25,r25,0xa
L_922b58:
	mov_s r3,0x51000284
L_922b5e:
	mov_s r32,r3
L_922b60:
	st.ab r3,[r25,0x4]
L_922b64:
	bclr r25,r25,0xa
L_922b68:
	mov r4,0x54000508
L_922b70:
	mov r32,r4
L_922b74:
	st.ab r4,[r25,0x4]
L_922b78:
	bclr r25,r25,0xa
L_922b7c:
	mov_s blink,r13
L_922b7e:
	j_s.d [blink]
L_922b80:
	pop_s r13
L_922b82:
	nop_s
