/* set_reg_882600 @ 0x8ce4e8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_transfer, pcie_serdes_step
 */
	.section .text.set_reg_882600,"ax",@progbits
	.global set_reg_882600
set_reg_882600:
	.global L_8ce4e8
L_8ce4e8:
	asl_s r0,r0,0x1f
L_8ce4ea:
	asl_s r1,r1,0x10
L_8ce4ec:
	or_s r0,r0,r1
L_8ce4ee:
	or_s r2,r2,r0
L_8ce4f0:
	mov_s r0,0x882600
L_8ce4f6:
	st_s r2,[r0,0x48]
L_8ce4f8:
	j_s [blink]
L_8ce4fa:
	nop_s
