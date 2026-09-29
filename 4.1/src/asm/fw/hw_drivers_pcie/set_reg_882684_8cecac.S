/* set_reg_882684_8cecac @ 0x8cecac, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.set_reg_882684_8cecac,"ax",@progbits
	.global set_reg_882684_8cecac
set_reg_882684_8cecac:
	.global L_8cecac
L_8cecac:
	mov_s r1,0x10
L_8cecae:
	mov_s r0,0x882680
L_8cecb4:
	st_s r1,[r0,0x4]
L_8cecb6:
	j_s [blink]
