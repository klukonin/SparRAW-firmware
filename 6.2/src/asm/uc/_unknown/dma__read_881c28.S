/* dma__read_881c28 @ 0x928fa8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_is_tx_pipe_idle
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dma__read_881c28
dma__read_881c28:
	.global L_928fa8
L_928fa8:
	lr r1,[0xa]
L_928fac:
	bclr r3,r1,0x1
L_928fb0:
	flag r3
L_928fb4:
	ld r0,[0x881c28]
L_928fbc:
	lr r2,[0xa]
L_928fc0:
	bic r1,r1,-0x3
L_928fc4:
	or_s r1,r1,r2
L_928fc6:
	flag r1
L_928fca:
	j_s [blink]
