/* fw_image_info__set_flavor @ 0x8f33ac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_boot__log_versions
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_image_info__set_flavor
fw_image_info__set_flavor:
	.global L_8f33ac
L_8f33ac:
	mov_s r1,0x880a00
L_8f33b2:
	j_s.d [blink]
L_8f33b4:
	st_s r0,[r1,0x10]
L_8f33b6:
	nop_s
