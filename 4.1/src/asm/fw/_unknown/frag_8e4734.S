/* frag_8e4734 @ 0x8e4734, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq__flush_timeout_handler
 */
	.section .text.frag_8e4734,"ax",@progbits
	.global frag_8e4734
frag_8e4734:
L_8e4734:
	mov_s r1,0x0
	.global sub_8e4736
sub_8e4736:
L_8e4736:
	nop_s
	.global L_8e4738
L_8e4738:
	ld r0,[r0, 0x8c]
L_8e473c:
	ld_s r1,[r0]
L_8e473e:
	ld_s r1,[r1,0x10]
