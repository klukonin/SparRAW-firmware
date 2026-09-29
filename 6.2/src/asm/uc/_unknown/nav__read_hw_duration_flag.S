/* nav__read_hw_duration_flag @ 0x9290d0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_nav__set_from_duration
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global nav__read_hw_duration_flag
nav__read_hw_duration_flag:
	.global L_9290d0
L_9290d0:
	ld r2,[0x8812d8]
L_9290d8:
	mov r1,r0
L_9290dc:
	bbit0.d r2,0x4,L_9290ec
L_9290e0:
	lsr r0,r2,0x4
L_9290e4:
	lsr_s r2,r2,0x10
L_9290e6:
	bmsk_s r2,r2,0x4
L_9290e8:
	st r2,[r1]
	.global L_9290ec
L_9290ec:
	j.d [blink]
L_9290f0:
	bmsk_s r0,r0,0x0
L_9290f2:
	nop_s
