/* macq_hw__clear_2d8 @ 0x928f78, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__flush_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__clear_2d8
macq_hw__clear_2d8:
	.global L_928f78
L_928f78:
	push_s r13
L_928f7a:
	mov_s r13,blink
L_928f7c:
	asl_s r1,r0,0x3
L_928f7e:
	sub_s r1,r1,r0
L_928f80:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_928f82:
	add_s r1,r1,0x44096c0
L_928f88:
	lsr_s r1,r1,0x3
L_928f8a:
	mov_s r2,0x0
L_928f8c:
	st r2,[r1]
L_928f90:
	sync
L_928f94:
	mov_s blink,r13
L_928f96:
	j_s.d [blink]
L_928f98:
	pop_s r13
L_928f9a:
	nop_s
