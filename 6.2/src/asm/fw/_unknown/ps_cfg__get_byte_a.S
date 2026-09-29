/* ps_cfg__get_byte_a @ 0x8cb8a4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mids__get_count
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__get_byte_a
ps_cfg__get_byte_a:
	.global L_8cb8a4
L_8cb8a4:
	mov_s r0,0x803d7c
L_8cb8aa:
	j_s.d [blink]
L_8cb8ac:
	ldb_s r0,[r0,0xa]
L_8cb8ae:
	nop_s
