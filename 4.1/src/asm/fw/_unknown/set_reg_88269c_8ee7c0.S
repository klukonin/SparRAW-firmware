/* set_reg_88269c_8ee7c0 @ 0x8ee7c0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down, wbe_driver__pcie_debug_isr
 */
	.section .text.set_reg_88269c_8ee7c0,"ax",@progbits
	.global set_reg_88269c_8ee7c0
set_reg_88269c_8ee7c0:
	.global L_8ee7c0
L_8ee7c0:
	mov_s r1,0x8
L_8ee7c2:
	mov_s r0,0x882680
L_8ee7c8:
	st_s r1,[r0,0x1c]
L_8ee7ca:
	j_s [blink]
