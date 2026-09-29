/* hwd_pcie__rgf_882600 @ 0x8d13d4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_vector_16
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_pcie__rgf_882600
hwd_pcie__rgf_882600:
	.global L_8d13d4
L_8d13d4:
	mov_s r1,0x882600
L_8d13da:
	ld_s r0,[r1,0x74]
L_8d13dc:
	st_s r0,[r1,0x70]
L_8d13de:
	j_s [blink]
