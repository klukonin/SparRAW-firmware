/* set_reg_882648 @ 0x8ce748, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pcie__clear_dbi_gateway
 * Зовёт сам: set_reg_882644
 */
	.section .text.set_reg_882648,"ax",@progbits
	.global set_reg_882648
set_reg_882648:
	.global L_8ce748
L_8ce748:
	mov_s r0,0x882600
L_8ce74e:
	st 0x4000000,[r0, 0x48]
L_8ce756:
	b L_8ce4a4
L_8ce75a:
	nop_s
