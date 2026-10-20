/* hwd_dma__uses_rgf_881c00_8d07d4 @ 0x8d07d4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txrx_mgr__handle_dma_irq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881c00_8d07d4
hwd_dma__uses_rgf_881c00_8d07d4:
	.global L_8d07d4
L_8d07d4:
	lr r1,[0xa]
L_8d07d8:
	bclr r0,r1,0x1
L_8d07dc:
	flag r0
L_8d07e0:
	mov_s r0,0x881c00
L_8d07e6:
	ld_s r0,[r0,0x10]
L_8d07e8:
	lr r2,[0xa]
L_8d07ec:
	bic r1,r1,-0x3
L_8d07f0:
	or_s r1,r1,r2
L_8d07f2:
	flag r1
L_8d07f6:
	j_s [blink]
