/* hwd_dma__read_cause_881c48 @ 0x8cdac4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schdlr__isr_dispatch
 */
	.section .text.hwd_dma__read_cause_881c48,"ax",@progbits
	.global hwd_dma__read_cause_881c48
hwd_dma__read_cause_881c48:
	.global L_8cdac4
L_8cdac4:
	lr r1,[0xa]
L_8cdac8:
	bclr r0,r1,0x1
L_8cdacc:
	flag r0
L_8cdad0:
	mov_s r0,0x881c00
L_8cdad6:
	ld_s r0,[r0,0x48]
L_8cdad8:
	lr r2,[0xa]
L_8cdadc:
	bic r1,r1,-0x3
L_8cdae0:
	or_s r1,r1,r2
L_8cdae2:
	flag r1
L_8cdae6:
	j_s [blink]
