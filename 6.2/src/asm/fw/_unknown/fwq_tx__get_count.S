/* fwq_tx__get_count @ 0x8e3c64, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fwq_tx__handle_completion
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__get_count
fwq_tx__get_count:
	.global L_8e3c64
L_8e3c64:
	mov_s r0,0x805fe4
L_8e3c6a:
	j_s.d [blink]
L_8e3c6c:
	ld_s r0,[r0,0x28]
L_8e3c6e:
	nop_s
