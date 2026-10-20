/* hwd_dma__ack_881c54 @ 0x8cdec4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__clear_hw_state, vring_schdlr__isr_dispatch
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.hwd_dma__ack_881c54,"ax",@progbits
	.global hwd_dma__ack_881c54
hwd_dma__ack_881c54:
	.global L_8cdec4
L_8cdec4:
	push_s blink
L_8cdec6:
	push_s r13
L_8cdec8:
	lr r13,[0xa]
L_8cdecc:
	bclr r2,r13,0x1
L_8cded0:
	flag r2
L_8cded4:
	mov_s r2,0x881c00
L_8cdeda:
	st_s r0,[r2,0x54]
L_8cdedc:
	breq_s r1,0,L_8cdee2
L_8cdede:
	sync
	.global L_8cdee2
L_8cdee2:
	lr r0,[0xa]
L_8cdee6:
	bic r13,r13,-0x3
L_8cdeea:
	or_s r13,r13,r0
L_8cdeec:
	flag r13
L_8cdef0:
	b L_8c033c
