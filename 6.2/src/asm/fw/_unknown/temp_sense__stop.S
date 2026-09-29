/* temp_sense__stop @ 0x8e7ea4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__on_system_state
 * Зовёт сам: platform__is_asic, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_sense__stop
temp_sense__stop:
	.global L_8e7ea4
L_8e7ea4:
	push_s blink
L_8e7ea6:
	bl L_8da61c
L_8e7eaa:
	breq_s r0,0,L_8e7ec0
L_8e7eac:
	ld_s r0,[gp,-0x8]
L_8e7eae:
	breq_s r0,0,L_8e7eba
L_8e7eb0:
	bl L_8c8de0
L_8e7eb4:
	mov_s r0,0x0
L_8e7eb6:
	st.as r0,[gp,-0x2]
	.global L_8e7eba
L_8e7eba:
	mov_s r0,0x1
L_8e7ebc:
	st.as r0,[gp,-0xd]
	.global L_8e7ec0
L_8e7ec0:
	pop_s blink
L_8e7ec2:
	j_s [blink]
