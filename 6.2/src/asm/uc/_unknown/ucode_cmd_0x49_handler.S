/* ucode_cmd_0x49_handler @ 0x9351e4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x49_handler
ucode_cmd_0x49_handler:
	.global L_9351e4
L_9351e4:
	ldb_s r0,[r0]
L_9351e6:
	j_s.d [blink]
L_9351e8:
	stb r0,[gp, -0xec]
