/* aw_ie__copy_to_bcon @ 0x934d54, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x25_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw_ie__copy_to_bcon
aw_ie__copy_to_bcon:
	.global L_934d54
L_934d54:
	ldb r11,[r1]
L_934d58:
	ldb r10,[r1, 0x1]
L_934d5c:
	ldb r9,[r1, 0x2]
L_934d60:
	ldb r8,[r1, 0x3]
L_934d64:
	stb r11,[r0, 0x3c]
L_934d68:
	stb r10,[r0, 0x3d]
L_934d6c:
	stb r9,[r0, 0x3e]
L_934d70:
	stb r8,[r0, 0x3f]
L_934d74:
	ldb r11,[r1, 0x4]
L_934d78:
	ldb r10,[r1, 0x5]
L_934d7c:
	ldb r9,[r1, 0x6]
L_934d80:
	ldb r8,[r1, 0x7]
L_934d84:
	stb r11,[r0, 0x40]
L_934d88:
	stb r10,[r0, 0x41]
L_934d8c:
	stb r9,[r0, 0x42]
L_934d90:
	stb r8,[r0, 0x43]
L_934d94:
	ldb r11,[r1, 0x8]
L_934d98:
	ldb r10,[r1, 0x9]
L_934d9c:
	ldb r9,[r1, 0xa]
L_934da0:
	ldb r8,[r1, 0xb]
L_934da4:
	stb r11,[r0, 0x44]
L_934da8:
	stb r10,[r0, 0x45]
L_934dac:
	stb r9,[r0, 0x46]
L_934db0:
	stb r8,[r0, 0x47]
L_934db4:
	mov_s r1,0x1
L_934db6:
	j_s.d [blink]
L_934db8:
	st_s r1,[r0,0x44]
L_934dba:
	nop_s
