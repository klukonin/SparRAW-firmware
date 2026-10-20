/* temp_sense__stop @ 0x8e2d9c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__on_system_state
 * Зовёт сам: get_reg_880a3c_8d7540, u_schd__cancel
 * Глобалы (через gp): 0x800174
 */
	.section .text.temp_sense__stop,"ax",@progbits
	.global temp_sense__stop
temp_sense__stop:
	.global L_8e2d9c
L_8e2d9c:
	push_s blink
L_8e2d9e:
	bl L_8d7540
L_8e2da2:
	breq_s r0,0,L_8e2db8
L_8e2da4:
	ld_s r0,[gp,0x4]
L_8e2da6:
	breq_s r0,0,L_8e2db2
L_8e2da8:
	bl L_8c7794
L_8e2dac:
	mov_s r0,0x0
L_8e2dae:
	st.as r0,[gp,0x1]
	.global L_8e2db2
L_8e2db2:
	mov_s r0,0x1
L_8e2db4:
	st.as r0,[gp,-0x9]
	.global L_8e2db8
L_8e2db8:
	pop_s blink
L_8e2dba:
	j_s [blink]
