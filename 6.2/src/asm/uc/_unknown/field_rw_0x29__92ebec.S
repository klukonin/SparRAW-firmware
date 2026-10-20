/* field_rw_0x29__92ebec @ 0x92ebec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x05_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x29__92ebec
field_rw_0x29__92ebec:
	.global L_92ebec
L_92ebec:
	ldb r2,[r0, 0x29]
L_92ebf0:
	bclr r2,r2,r1
L_92ebf4:
	j_s.d [blink]
L_92ebf6:
	stb r2,[r0, 0x29]
L_92ebfa:
	nop_s
