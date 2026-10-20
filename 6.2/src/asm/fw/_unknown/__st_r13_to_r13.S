/* __st_r13_to_r13 @ 0x8c01e8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r13_to_r13
__st_r13_to_r13:
	.global L_8c01e8
L_8c01e8:
	j_s.d [blink]
L_8c01ea:
	st.a r13,[sp,-0x4]
L_8c01ee:
	nop_s
L_8c01f0:
	j_s [blink]
L_8c01f2:
	nop_s
