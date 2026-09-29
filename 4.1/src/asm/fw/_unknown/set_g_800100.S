/* set_g_800100 @ 0x8de5d0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_long_term_trigger
 */
	.section .text.set_g_800100,"ax",@progbits
	.global set_g_800100
set_g_800100:
	.global L_8de5d0
L_8de5d0:
	mov_s r0,0x0
L_8de5d2:
	j_s.d [blink]
L_8de5d4:
	st.as r0,[gp,-0x1c]
