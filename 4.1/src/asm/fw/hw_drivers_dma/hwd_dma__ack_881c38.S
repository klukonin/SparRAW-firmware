/* hwd_dma__ack_881c38 @ 0x8cde20, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__isr_dispatch
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.hwd_dma__ack_881c38,"ax",@progbits
	.global hwd_dma__ack_881c38
hwd_dma__ack_881c38:
	.global L_8cde20
L_8cde20:
	push_s blink
L_8cde22:
	push_s r13
L_8cde24:
	lr r13,[0xa]
L_8cde28:
	bclr r2,r13,0x1
L_8cde2c:
	flag r2
L_8cde30:
	mov_s r2,0x881c00
L_8cde36:
	st_s r0,[r2,0x38]
L_8cde38:
	breq_s r1,0,L_8cde3e
L_8cde3a:
	sync
	.global L_8cde3e
L_8cde3e:
	lr r0,[0xa]
L_8cde42:
	bic r13,r13,-0x3
L_8cde46:
	or_s r13,r13,r0
L_8cde48:
	flag r13
L_8cde4c:
	b L_8c033c
