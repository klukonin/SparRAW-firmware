/* hwd_dma__uses_rgf_881c00_8d0870 @ 0x8d0870, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schdlr__isr_dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881c00_8d0870
hwd_dma__uses_rgf_881c00_8d0870:
	.global L_8d0870
L_8d0870:
	lr r1,[0xa]
L_8d0874:
	bclr r0,r1,0x1
L_8d0878:
	flag r0
L_8d087c:
	mov_s r0,0x881c00
L_8d0882:
	ld_s r0,[r0,0x48]
L_8d0884:
	lr r2,[0xa]
L_8d0888:
	bic r1,r1,-0x3
L_8d088c:
	or_s r1,r1,r2
L_8d088e:
	flag r1
L_8d0892:
	j_s [blink]
