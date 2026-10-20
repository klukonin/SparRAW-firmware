/* get_reg_8825c0 @ 0x8ce720, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dbi_write_seq, pcie__l1_latency_wa, pcie_perst_handler_step
 */
	.section .text.get_reg_8825c0,"ax",@progbits
	.global get_reg_8825c0
get_reg_8825c0:
	.global L_8ce720
L_8ce720:
	mov_s r0,0x882580
L_8ce726:
	ld_s r0,[r0,0x40]
L_8ce728:
	j_s [blink]
L_8ce72a:
	nop_s
