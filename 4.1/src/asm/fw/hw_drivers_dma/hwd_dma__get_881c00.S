/* hwd_dma__get_881c00 @ 0x8cda28, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txrx_mgr__handle_dma_irq
 */
	.section .text.hwd_dma__get_881c00,"ax",@progbits
	.global hwd_dma__get_881c00
hwd_dma__get_881c00:
	.global L_8cda28
L_8cda28:
	lr r1,[0xa]
L_8cda2c:
	bclr r0,r1,0x1
L_8cda30:
	flag r0
L_8cda34:
	mov_s r0,0x881c00
L_8cda3a:
	ld_s r0,[r0,0x10]
L_8cda3c:
	lr r2,[0xa]
L_8cda40:
	bic r1,r1,-0x3
L_8cda44:
	or_s r1,r1,r2
L_8cda46:
	flag r1
L_8cda4a:
	j_s [blink]
