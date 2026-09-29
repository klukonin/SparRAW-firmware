/* set_reg_882684 @ 0x8ce4fc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 */
	.section .text.set_reg_882684,"ax",@progbits
	.global set_reg_882684
set_reg_882684:
	.global L_8ce4fc
L_8ce4fc:
	mov_s r0,0x882680
L_8ce502:
	st 0x20000000,[r0, 0x4]
L_8ce50a:
	j_s [blink]
