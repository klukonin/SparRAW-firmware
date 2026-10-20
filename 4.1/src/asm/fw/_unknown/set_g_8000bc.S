/* set_g_8000bc @ 0x8e1624, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_mngr__init_schemes, calib_mngr__switch_channel
 */
	.section .text.set_g_8000bc,"ax",@progbits
	.global set_g_8000bc
set_g_8000bc:
	.global L_8e1624
L_8e1624:
	j_s.d [blink]
L_8e1626:
	st.as r0,[gp,-0x2d]
L_8e162a:
	nop_s
