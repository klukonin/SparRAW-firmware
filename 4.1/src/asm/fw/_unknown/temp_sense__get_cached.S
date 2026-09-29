/* temp_sense__get_cached @ 0x8d9e84, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Temp sense is currently active - using old values
 * Зовут его: hwf_calib_all, lmac_if__lmac_ready_evt, wmi_handler_temp_sense
 * Зовёт сам: fw_log__emit0, timer_exp_handler, u_schd__cancel
 * Глобалы (через gp): 0x800174
 */
	.section .text.temp_sense__get_cached,"ax",@progbits
	.global temp_sense__get_cached
temp_sense__get_cached:
	.global L_8d9e84
L_8d9e84:
	push_s blink
L_8d9e86:
	ld.as r2,[gp,-0x33]
L_8d9e8a:
	breq_s r2,0,L_8d9eae
L_8d9e8c:
	mov_s r2,0x100fbb0
L_8d9e92:
	mov_s r0,0x0
L_8d9e94:
	bl.d L_8edfb0
L_8d9e98:
	mov_s r1,0x1
L_8d9e9a:
	ld.as r3,[gp,-0x33]
L_8d9e9e:
	ld_s r0,[gp,-0xd0]
L_8d9ea0:
	ld.as r1,[gp,-0xd]
L_8d9ea4:
	jl_s.d [r3]
L_8d9ea6:
	ld.as r2,[gp,-0x32]
	.global L_8d9eaa
L_8d9eaa:
	pop_s blink
L_8d9eac:
	j_s [blink]
	.global L_8d9eae
L_8d9eae:
	st.as r0,[gp,-0x33]
L_8d9eb2:
	ld_s r0,[gp,0x4]
L_8d9eb4:
	st.as r1,[gp,-0x32]
L_8d9eb8:
	breq_s r0,0,L_8d9ec4
L_8d9eba:
	bl L_8c7794
L_8d9ebe:
	mov_s r0,0x0
L_8d9ec0:
	st.as r0,[gp,0x1]
	.global L_8d9ec4
L_8d9ec4:
	ld_s r0,[gp,-0x24]
L_8d9ec6:
	brne_s r0,0,L_8d9ece
L_8d9ec8:
	bl L_8e45b0
L_8d9ecc:
	b_s L_8d9eaa
	.global L_8d9ece
L_8d9ece:
	b_s L_8d9eaa
