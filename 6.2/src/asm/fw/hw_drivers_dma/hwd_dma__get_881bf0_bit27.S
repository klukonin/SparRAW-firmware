/* hwd_dma__get_881bf0_bit27 @ 0x8d07b8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_halt_seq
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__get_881bf0_bit27
hwd_dma__get_881bf0_bit27:
	.global L_8d07b8
L_8d07b8:
	mov_s r0,0x881b80
L_8d07be:
	ld_s r0,[r0,0x70]
L_8d07c0:
	lsr_s r0,r0,0x1b
L_8d07c2:
	j_s.d [blink]
L_8d07c4:
	bmsk_s r0,r0,0x0
L_8d07c6:
	nop_s
