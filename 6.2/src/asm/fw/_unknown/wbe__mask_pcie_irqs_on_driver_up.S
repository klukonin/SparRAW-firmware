/* wbe__mask_pcie_irqs_on_driver_up @ 0x8f6b6c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down_notif
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wbe__mask_pcie_irqs_on_driver_up
wbe__mask_pcie_irqs_on_driver_up:
	.global L_8f6b6c
L_8f6b6c:
	mov_s r1,0x882680
L_8f6b72:
	st 0x2000,[r1]
L_8f6b7a:
	st 0x4000,[r1]
L_8f6b82:
	mov_s r0,0x8
L_8f6b84:
	st_s r0,[r1]
L_8f6b86:
	j_s [blink]
