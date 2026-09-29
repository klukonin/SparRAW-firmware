/* bitstream__push @ 0x93cd00, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__pick_tx_params, rx__handle_status_flags, tx_sta__flow_loop
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bitstream__push
bitstream__push:
	.global L_93cd00
L_93cd00:
	push_s r13
L_93cd02:
	push_s r14
L_93cd04:
	ld_s r14,[r0]
L_93cd06:
	ld_s r13,[r0,0x4]
L_93cd08:
	bbit0 r14,0x1f,L_93cd10
L_93cd0c:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_93cd0e:
	st_s r13,[r0,0x4]
	.global L_93cd10
L_93cd10:
	asl_s r14,r14
L_93cd12:
	st_s r14,[r0]
L_93cd14:
	breq_s r2,0,L_93cd1e
L_93cd16:
	or_s r3,r3,r14
L_93cd18:
	st_s r3,[r0]
L_93cd1a:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_93cd1c:
	st_s r13,[r0,0x4]
	.global L_93cd1e
L_93cd1e:
	cmp_s r1,r13
L_93cd20:
	mov_s r0,0x1
L_93cd22:
	sub.hi r0,r0,r0
L_93cd26:
	pop_s r14
L_93cd28:
	j_s.d [blink]
L_93cd2a:
	pop_s r13
