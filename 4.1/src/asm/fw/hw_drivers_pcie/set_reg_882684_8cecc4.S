/* set_reg_882684_8cecc4 @ 0x8cecc4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.set_reg_882684_8cecc4,"ax",@progbits
	.global set_reg_882684_8cecc4
set_reg_882684_8cecc4:
	.global L_8cecc4
L_8cecc4:
	mov_s r1,0x20
L_8cecc6:
	mov_s r0,0x882680
L_8ceccc:
	st_s r1,[r0,0x4]
L_8cecce:
	j_s [blink]
