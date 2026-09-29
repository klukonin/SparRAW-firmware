/* mem_pool__get_field14 @ 0x8e0904, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__put_block
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__get_field14
mem_pool__get_field14:
	.global L_8e0904
L_8e0904:
	j_s.d [blink]
L_8e0906:
	ld_s r0,[r0,0x14]
