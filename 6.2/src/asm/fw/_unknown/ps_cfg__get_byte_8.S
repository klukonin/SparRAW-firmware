/* ps_cfg__get_byte_8 @ 0x8cc660, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mids__get_count
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_cfg__get_byte_8
ps_cfg__get_byte_8:
	.global L_8cc660
L_8cc660:
	mov_s r0,0x803d7c
L_8cc666:
	j_s.d [blink]
L_8cc668:
	ldb_s r0,[r0,0x8]
L_8cc66a:
	nop_s
