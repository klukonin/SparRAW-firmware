/* set_reg_882644 @ 0x8ce4a4, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__ack_882644, pcie__dbi_transfer, set_reg_882648
 */
	.section .text.set_reg_882644,"ax",@progbits
	.global set_reg_882644
set_reg_882644:
	.global L_8ce4a4
L_8ce4a4:
	mov_s r0,0x882600
L_8ce4aa:
	st 0x40000000,[r0, 0x44]
L_8ce4b2:
	j_s [blink]
