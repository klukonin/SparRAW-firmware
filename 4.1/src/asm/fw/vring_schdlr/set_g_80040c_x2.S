/* set_g_80040c_x2 @ 0x8c7984, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__system_state_evt_handler, l2mgr__init
 * Глобалы (через gp): 0x80040c, 0x800424
 */
	.section .text.set_g_80040c_x2,"ax",@progbits
	.global set_g_80040c_x2
set_g_80040c_x2:
	.global L_8c7984
L_8c7984:
	mov_s r0,0x0
L_8c7986:
	st.as r0,[gp,0xa7]
L_8c798a:
	j_s.d [blink]
L_8c798c:
	st.as r0,[gp,0xad]
