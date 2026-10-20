/* set_reg_88264c @ 0x8ce4dc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__dbi_transfer, pcie_serdes_step
 */
	.section .text.set_reg_88264c,"ax",@progbits
	.global set_reg_88264c
set_reg_88264c:
	.global L_8ce4dc
L_8ce4dc:
	mov_s r1,0x882600
L_8ce4e2:
	st_s r0,[r1,0x4c]
L_8ce4e4:
	j_s [blink]
L_8ce4e6:
	nop_s
