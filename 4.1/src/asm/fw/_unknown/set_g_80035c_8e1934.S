/* set_g_80035c_8e1934 @ 0x8e1934, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__system_state_evt_handler
 * Глобалы (через gp): 0x80035c
 */
	.section .text.set_g_80035c_8e1934,"ax",@progbits
	.global set_g_80035c_8e1934
set_g_80035c_8e1934:
	.global L_8e1934
L_8e1934:
	mov_s r0,0x80360c
L_8e193a:
	j_s.d [blink]
L_8e193c:
	st.as r0,[gp,0x7b]
