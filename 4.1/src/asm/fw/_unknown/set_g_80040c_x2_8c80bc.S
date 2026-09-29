/* set_g_80040c_x2_8c80bc @ 0x8c80bc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__system_state_evt_handler
 * Глобалы (через gp): 0x80040c, 0x800424
 */
	.section .text.set_g_80040c_x2_8c80bc,"ax",@progbits
	.global set_g_80040c_x2_8c80bc
set_g_80040c_x2_8c80bc:
	.global L_8c80bc
L_8c80bc:
	mov_s r0,0x1
L_8c80be:
	st.as r0,[gp,0xa7]
L_8c80c2:
	j_s.d [blink]
L_8c80c4:
	st.as r0,[gp,0xad]
