/* ucode_cmd_0x24__copy_byte_164 @ 0x93dac0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x24_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x24__copy_byte_164
ucode_cmd_0x24__copy_byte_164:
	.global L_93dac0
L_93dac0:
	add r0,r0,0x200
L_93dac4:
	ldb r1,[r0, -0x9b]
L_93dac8:
	j.d [blink]
L_93dacc:
	stb r1,[r0, -0x9c]
