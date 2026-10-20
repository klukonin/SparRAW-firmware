/* vring_hw__unmask_irq @ 0x8d05f0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__ack_and_unmask_irq, vring__reset_pair_b
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_hw__unmask_irq
vring_hw__unmask_irq:
	.global L_8d05f0
L_8d05f0:
	push_s blink
L_8d05f2:
	push_s r13
L_8d05f4:
	lr r13,[0xa]
L_8d05f8:
	bclr r2,r13,0x1
L_8d05fc:
	flag r2
L_8d0600:
	mov_s r2,0x881c00
L_8d0606:
	st_s r0,[r2,0x58]
L_8d0608:
	breq_s r1,0,L_8d060e
L_8d060a:
	sync
	.global L_8d060e
L_8d060e:
	lr r0,[0xa]
L_8d0612:
	bic r13,r13,-0x3
L_8d0616:
	or_s r13,r13,r0
L_8d0618:
	flag r13
L_8d061c:
	b L_8c025c
