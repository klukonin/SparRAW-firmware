/* dmaq_hw__read_ptr @ 0x9290a8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__flush_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dmaq_hw__read_ptr
dmaq_hw__read_ptr:
	.global L_9290a8
L_9290a8:
	asl_s r0,r0,0x8
L_9290aa:
	add_s r0,r0,0x440c120
L_9290b0:
	lsr_s r0,r0,0x3
L_9290b2:
	bic r0,r0,0x3
L_9290b6:
	ld_s r0,[r0]
L_9290b8:
	j_s [blink]
L_9290ba:
	nop_s
