/* macq_hw__read_wptr @ 0x929068, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: macq__flush_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__read_wptr
macq_hw__read_wptr:
	.global L_929068
L_929068:
	asl_s r2,r0,0x3
L_92906a:
	sub_s r2,r2,r0
L_92906c:
	/* asl_s r2,r2,0x7 */
	.byte 0x07,0xba
L_92906e:
	add_s r2,r2,0x44098c0
L_929074:
	lsr r1,r2,0x3
L_929078:
	bic r1,r1,0x3
L_92907c:
	ld_s r0,[r1]
L_92907e:
	bmsk_s r2,r2,0x4
L_929080:
	lsr_s r0,r0,r2
L_929082:
	j_s.d [blink]
L_929084:
	extw_s r0,r0
L_929086:
	nop_s
