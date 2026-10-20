/* bitstream__push @ 0x93708c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__pick_tx_params, tx_flow_size_step, tx_initiator_substep
 */
	.section .text.bitstream__push,"ax",@progbits
	.global bitstream__push
bitstream__push:
	.global L_93708c
L_93708c:
	push_s r13
L_93708e:
	push_s r14
L_937090:
	ld_s r14,[r0]
L_937092:
	ld_s r13,[r0,0x4]
L_937094:
	bbit0 r14,0x1f,L_93709c
L_937098:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_93709a:
	st_s r13,[r0,0x4]
	.global L_93709c
L_93709c:
	asl_s r14,r14
L_93709e:
	st_s r14,[r0]
L_9370a0:
	breq_s r2,0,L_9370aa
L_9370a2:
	or_s r3,r3,r14
L_9370a4:
	st_s r3,[r0]
L_9370a6:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_9370a8:
	st_s r13,[r0,0x4]
	.global L_9370aa
L_9370aa:
	cmp_s r1,r13
L_9370ac:
	mov_s r0,0x1
L_9370ae:
	sub.hi r0,r0,r0
L_9370b2:
	pop_s r14
L_9370b4:
	j_s.d [blink]
L_9370b6:
	pop_s r13
