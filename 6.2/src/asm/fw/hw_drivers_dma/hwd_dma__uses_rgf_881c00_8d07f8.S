/* hwd_dma__uses_rgf_881c00_8d07f8 @ 0x8d07f8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: pring__isr_dispatch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__uses_rgf_881c00_8d07f8
hwd_dma__uses_rgf_881c00_8d07f8:
	.global L_8d07f8
L_8d07f8:
	lr r1,[0xa]
L_8d07fc:
	bclr r0,r1,0x1
L_8d0800:
	flag r0
L_8d0804:
	mov_s r0,0x881c00
L_8d080a:
	ld_s r0,[r0,0x2c]
L_8d080c:
	lr r2,[0xa]
L_8d0810:
	bic r1,r1,-0x3
L_8d0814:
	or_s r1,r1,r2
L_8d0816:
	flag r1
L_8d081a:
	j_s [blink]
