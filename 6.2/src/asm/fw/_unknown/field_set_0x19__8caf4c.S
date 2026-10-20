/* field_set_0x19__8caf4c @ 0x8caf4c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mem_pool__free_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_set_0x19__8caf4c
field_set_0x19__8caf4c:
	.global L_8caf4c
L_8caf4c:
	mov_s r1,0x0
L_8caf4e:
	j_s.d [blink]
L_8caf50:
	stb_s r1,[r0,0x19]
L_8caf52:
	nop_s
