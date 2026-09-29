/* get_reg_882650 @ 0x8ce75c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie_serdes_step
 */
	.section .text.get_reg_882650,"ax",@progbits
	.global get_reg_882650
get_reg_882650:
	.global L_8ce75c
L_8ce75c:
	mov_s r0,0x882600
L_8ce762:
	ld_s r0,[r0,0x50]
L_8ce764:
	j_s [blink]
L_8ce766:
	nop_s
