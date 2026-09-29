/* set_reg_882670 @ 0x8cecb8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.set_reg_882670,"ax",@progbits
	.global set_reg_882670
set_reg_882670:
	.global L_8cecb8
L_8cecb8:
	mov_s r1,0x20
L_8cecba:
	mov_s r0,0x882600
L_8cecc0:
	st_s r1,[r0,0x70]
L_8cecc2:
	j_s [blink]
