/* set_reg_88268c_x2_8f2930 @ 0x8f2930, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__ACTIVATING, wbe_driver__pcie_debug_isr
 */
	.section .text.set_reg_88268c_x2_8f2930,"ax",@progbits
	.global set_reg_88268c_x2_8f2930
set_reg_88268c_x2_8f2930:
	.global L_8f2930
L_8f2930:
	mov_s r1,0x8
L_8f2932:
	mov_s r0,0x882680
L_8f2938:
	st_s r1,[r0,0xc]
L_8f293a:
	st_s r1,[r0,0x20]
