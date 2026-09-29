/* hw_personality_detect @ 0x8f84c0, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   HW personality is DEVICE
 *   HW personality is ROOT
 * Зовут его: sdp_gpio__boot_init
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, hw_personality__read_strap
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_personality_detect
hw_personality_detect:
	.global L_8f84c0
L_8f84c0:
	push_s blink
L_8f84c2:
	push_s r13
L_8f84c4:
	mov_s r1,0x803c00
L_8f84ca:
	ld_s r1,[r1,0x20]
L_8f84cc:
	mov_s r0,0x800c34
L_8f84d2:
	lsr_s r1,r1,0xd
L_8f84d4:
	bmsk_s r1,r1,0x1
L_8f84d6:
	mov_s r13,0x880a3c
L_8f84dc:
	ld_s r0,[r0]
L_8f84de:
	breq r1,0x1,L_8f84ea
L_8f84e2:
	bl.d L_8f4424
L_8f84e6:
	bmsk_s r0,r0,0x4
L_8f84e8:
	brne_s r0,0,L_8f84fa
	.global L_8f84ea
L_8f84ea:
	mov_s r1,0x1008e9c
L_8f84f0:
	bl.d L_8dcba8
L_8f84f4:
	mov_s r0,0x20
L_8f84f6:
	mov_s r0,0x0
L_8f84f8:
	b_s L_8f8508
	.global L_8f84fa
L_8f84fa:
	mov_s r1,0x1008eb8
L_8f8500:
	bl.d L_8dcba8
L_8f8504:
	mov_s r0,0x20
L_8f8506:
	mov_s r0,0x1
	.global L_8f8508
L_8f8508:
	b.d L_8c025c
L_8f850c:
	st_s r0,[r13,0x7c]
L_8f850e:
	nop_s
