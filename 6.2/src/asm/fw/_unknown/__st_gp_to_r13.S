/* __st_gp_to_r13 @ 0x8c01b4, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_gp_to_r13
__st_gp_to_r13:
	.global L_8c01b4
L_8c01b4:
	st.a gp,[sp,-0x4]
