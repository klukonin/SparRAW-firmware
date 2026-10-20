/* hwd_dma__ack_881c44 @ 0x8cd734, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__disable_and_ack, vring_schdlr__isr_dispatch
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.hwd_dma__ack_881c44,"ax",@progbits
	.global hwd_dma__ack_881c44
hwd_dma__ack_881c44:
	.global L_8cd734
L_8cd734:
	push_s blink
L_8cd736:
	push_s r13
L_8cd738:
	lr r13,[0xa]
L_8cd73c:
	bclr r2,r13,0x1
L_8cd740:
	flag r2
L_8cd744:
	mov_s r2,0x881c00
L_8cd74a:
	st_s r0,[r2,0x44]
L_8cd74c:
	breq_s r1,0,L_8cd752
L_8cd74e:
	sync
	.global L_8cd752
L_8cd752:
	lr r0,[0xa]
L_8cd756:
	bic r13,r13,-0x3
L_8cd75a:
	or_s r13,r13,r0
L_8cd75c:
	flag r13
L_8cd760:
	b L_8c033c
