/* hwd_dma__ack_881c44 @ 0x8d05c0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__ack_and_unmask_irq, vring_schdlr__isr_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__ack_881c44
hwd_dma__ack_881c44:
	.global L_8d05c0
L_8d05c0:
	push_s blink
L_8d05c2:
	push_s r13
L_8d05c4:
	lr r13,[0xa]
L_8d05c8:
	bclr r2,r13,0x1
L_8d05cc:
	flag r2
L_8d05d0:
	mov_s r2,0x881c00
L_8d05d6:
	st_s r0,[r2,0x44]
L_8d05d8:
	breq_s r1,0,L_8d05de
L_8d05da:
	sync
	.global L_8d05de
L_8d05de:
	lr r0,[0xa]
L_8d05e2:
	bic r13,r13,-0x3
L_8d05e6:
	or_s r13,r13,r0
L_8d05e8:
	flag r13
L_8d05ec:
	b L_8c025c
