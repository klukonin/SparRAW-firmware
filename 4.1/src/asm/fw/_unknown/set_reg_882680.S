/* set_reg_882680 @ 0x8ee778, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down, WBE_DRIVER__link_down_notif
 */
	.section .text.set_reg_882680,"ax",@progbits
	.global set_reg_882680
set_reg_882680:
	.global L_8ee778
L_8ee778:
	mov_s r0,0x882680
L_8ee77e:
	st 0x40000,[r0]
L_8ee786:
	j_s [blink]
