/* set_g_80035c @ 0x8e1928, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__system_state_evt_handler
 * Глобалы (через gp): 0x80035c
 */
	.section .text.set_g_80035c,"ax",@progbits
	.global set_g_80035c
set_g_80035c:
	.global L_8e1928
L_8e1928:
	mov_s r0,0x8035fc
L_8e192e:
	j_s.d [blink]
L_8e1930:
	st.as r0,[gp,0x7b]
