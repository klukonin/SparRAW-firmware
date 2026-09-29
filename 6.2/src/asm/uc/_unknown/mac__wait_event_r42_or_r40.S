/* mac__wait_event_r42_or_r40 @ 0x93675c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__run
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__wait_event_r42_or_r40
mac__wait_event_r42_or_r40:
	.global L_93675c
L_93675c:
	tst r42,r0
L_936760:
	jne_s [blink]
L_936762:
	tst r40,r1
L_936766:
	jne_s [blink]
L_936768:
	b_s L_93675c
L_93676a:
	nop_s
