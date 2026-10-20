/* hwd_dma__set_881c00_8cddf0 @ 0x8cddf0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txrx_mgr__handle_dma_irq
 * Зовёт сам: __ld_r13_ret
 */
	.section .text.hwd_dma__set_881c00_8cddf0,"ax",@progbits
	.global hwd_dma__set_881c00_8cddf0
hwd_dma__set_881c00_8cddf0:
	.global L_8cddf0
L_8cddf0:
	push_s blink
L_8cddf2:
	push_s r13
L_8cddf4:
	lr r13,[0xa]
L_8cddf8:
	bclr r2,r13,0x1
L_8cddfc:
	flag r2
L_8cde00:
	mov_s r2,0x881c00
L_8cde06:
	st_s r0,[r2,0x1c]
L_8cde08:
	breq_s r1,0,L_8cde0e
L_8cde0a:
	sync
	.global L_8cde0e
L_8cde0e:
	lr r0,[0xa]
L_8cde12:
	bic r13,r13,-0x3
L_8cde16:
	or_s r13,r13,r0
L_8cde18:
	flag r13
L_8cde1c:
	b L_8c033c
