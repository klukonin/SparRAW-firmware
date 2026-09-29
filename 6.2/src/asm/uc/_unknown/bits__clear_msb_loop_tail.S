/* bits__clear_msb_loop_tail @ 0x9263c8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bits__clear_msb_loop_tail
bits__clear_msb_loop_tail:
L_9263c8:
	extb_s r0,r0
	.global bits__clear_msb_loop_tail_9263ca
bits__clear_msb_loop_tail_9263ca:
	.global L_9263ca
L_9263ca:
	brne_s r0,0,L_9263ba
L_9263cc:
	j_s [blink]
L_9263ce:
	nop_s
