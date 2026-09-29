/* set_g_8000fc @ 0x8d8f3c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__correction_alg
 * Зовёт сам: rfc__select_chain_and_write
 */
	.section .text.set_g_8000fc,"ax",@progbits
	.global set_g_8000fc
set_g_8000fc:
	.global L_8d8f3c
L_8d8f3c:
	b.d L_8d3110
L_8d8f40:
	st.as r2,[gp,-0x1d]
