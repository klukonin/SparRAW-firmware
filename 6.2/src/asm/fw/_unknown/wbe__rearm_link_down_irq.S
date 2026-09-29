/* wbe__rearm_link_down_irq @ 0x8fa83c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__link_down_notif
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wbe__rearm_link_down_irq
wbe__rearm_link_down_irq:
	.global L_8fa83c
L_8fa83c:
	mov_s r0,0x882800
L_8fa842:
	st.as 0x40000,[r0,-0x64]
L_8fa84a:
	st.as 0x40000,[r0,-0x5f]
L_8fa852:
	j_s [blink]
