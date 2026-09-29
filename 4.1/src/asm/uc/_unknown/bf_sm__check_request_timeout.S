/* bf_sm__check_request_timeout @ 0x9220a4, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_sm__clear_pending, bf_state__set, uc_read_tsf_lo
 * Глобалы (через gp): 0x8005ec, 0x8005f0
 */
	.section .text.bf_sm__check_request_timeout,"ax",@progbits
	.global bf_sm__check_request_timeout
bf_sm__check_request_timeout:
	.global L_9220a4
L_9220a4:
	push_s blink
L_9220a6:
	bl L_920214
L_9220aa:
	mov_s r2,0x800ef4
L_9220b0:
	ld_s r0,[r2,0x78]
L_9220b2:
	mov_s r1,0x800f64
L_9220b8:
	bmsk_s r0,r0,0x2
L_9220ba:
	ldb_s r13,[r1,r0]
L_9220bc:
	asl_s r0,r13,0x2
L_9220be:
	add1_s r0,r0,r0
L_9220c0:
	ld_s r0,[r2,r0]
L_9220c2:
	brne r0,0x12,L_922116
L_9220c6:
	bl L_9315e8
L_9220ca:
	mov_s r2,0x800f74
L_9220d0:
	ld_s r1,[r2,0x2c]
L_9220d2:
	mov_s r14,0x800634
L_9220d8:
	sub_s r0,r0,r1
L_9220da:
	st_s r0,[r2,0x30]
L_9220dc:
	mov_s r1,0x857280
L_9220e2:
	ld_s r2,[r1,0x1c]
L_9220e4:
	brhs.d r2,r0,L_922110
L_9220e8:
	ld_s r1,[r14]
L_9220ea:
	mov_s r0,0x0
L_9220ec:
	st_s r0,[r14]
L_9220ee:
	ld_s r0,[gp,0xc8]
L_9220f0:
	st_s r1,[r14,0x4]
L_9220f2:
	brne r0,0x1,L_922102
L_9220f6:
	ld_s r0,[gp,0xc4]
L_9220f8:
	cmp_s r0,0x1
L_9220fa:
	mov.ne r0,r13
L_9220fe:
	mov_s r1,0x2
L_922100:
	bne_s L_922106
	.global L_922102
L_922102:
	mov_s r0,r13
L_922104:
	mov_s r1,0x11
	.global L_922106
L_922106:
	bl L_9283c8
L_92210a:
	bl.d L_92208c
L_92210e:
	mov_s r0,r13
	.global L_922110
L_922110:
	ld_s r0,[r14]
L_922112:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922114:
	st_s r0,[r14]
	.global L_922116
L_922116:
	b L_920284
L_92211a:
	nop_s
