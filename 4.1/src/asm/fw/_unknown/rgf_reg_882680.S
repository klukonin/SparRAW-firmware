/* rgf_reg_882680 @ 0x8ce474, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_debug
 */
	.section .text.rgf_reg_882680,"ax",@progbits
	.global rgf_reg_882680
rgf_reg_882680:
	.global L_8ce474
L_8ce474:
	mov_s r1,0x882680
L_8ce47a:
	ld_s r0,[r1,0x10]
L_8ce47c:
	st_s r0,[r1,0xc]
L_8ce47e:
	j_s [blink]
