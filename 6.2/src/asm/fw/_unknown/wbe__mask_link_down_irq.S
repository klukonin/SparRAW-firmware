/* wbe__mask_link_down_irq @ 0x8f6b5c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down_notif
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wbe__mask_link_down_irq
wbe__mask_link_down_irq:
	.global L_8f6b5c
L_8f6b5c:
	mov_s r0,0x882680
L_8f6b62:
	st 0x40000,[r0]
L_8f6b6a:
	j_s [blink]
