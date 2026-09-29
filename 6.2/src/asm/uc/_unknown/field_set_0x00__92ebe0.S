/* field_set_0x00__92ebe0 @ 0x92ebe0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x08_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global field_set_0x00__92ebe0
field_set_0x00__92ebe0:
	.global L_92ebe0
L_92ebe0:
	mov_s r2,0xff
L_92ebe2:
	add2_s r1,r1,r1
L_92ebe4:
	add_s r0,r0,r1
L_92ebe6:
	j_s.d [blink]
L_92ebe8:
	stb_s r2,[r0]
L_92ebea:
	nop_s
