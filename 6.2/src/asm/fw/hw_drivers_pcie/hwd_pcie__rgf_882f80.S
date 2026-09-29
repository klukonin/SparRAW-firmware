/* hwd_pcie__rgf_882f80 @ 0x8d13e0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_18
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__rgf_882f80
hwd_pcie__rgf_882f80:
	.global L_8d13e0
L_8d13e0:
	mov_s r1,0x882f80
L_8d13e6:
	ld_s r0,[r1,0x54]
L_8d13e8:
	st_s r0,[r1,0x50]
L_8d13ea:
	j_s [blink]
