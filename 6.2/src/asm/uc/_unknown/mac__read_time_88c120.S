/* mac__read_time_88c120 @ 0x92948c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__read_time_88c120
mac__read_time_88c120:
	.global L_92948c
L_92948c:
	ld r0,[0x88c120]
L_929494:
	j.d [blink]
L_929498:
	bmsk_s r0,r0,0x17
L_92949a:
	nop_s
