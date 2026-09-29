/* bf_sm__check_sta_timeout @ 0x922500, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__state_failure_path
 * Зовёт сам: __ld_r13_ret_uc, bf_sm__clear_pending, bf_sm_step, bf_state__set, uc_read_tsf_lo
 * Глобалы (через gp): 0x8005ec, 0x8005f0
 */
	.section .text.bf_sm__check_sta_timeout,"ax",@progbits
	.global bf_sm__check_sta_timeout
bf_sm__check_sta_timeout:
	.global L_922500
L_922500:
	push_s blink
L_922502:
	push_s r13
L_922504:
	mov_s r13,r0
L_922506:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_922508:
	add2_s r0,r0,r0
L_92250a:
	mov_s r1,0x857849
L_922510:
	ldb_s r0,[r1,r0]
L_922512:
	breq_s r0,0,L_92254e
L_922514:
	mov_s r0,0x801034
L_92251a:
	ldb_s r0,[r0]
L_92251c:
	bbit0 r0,r13,L_92254e
L_922520:
	bl L_9315e8
L_922524:
	mov_s r1,0x800f74
L_92252a:
	st_s r0,[r1,0x2c]
L_92252c:
	mov_s r0,r13
L_92252e:
	bl.d L_9283c8
L_922532:
	mov_s r1,0x12
L_922534:
	ld_s r0,[gp,0xc8]
L_922536:
	brne r0,0x1,L_92255c
L_92253a:
	ld_s r0,[gp,0xc4]
L_92253c:
	cmp_s r0,0x1
L_92253e:
	sub_s.ne r0,r0,r0
L_922540:
	mov.ne r1,r13
L_922544:
	bl.ne.d L_92a924
L_922548:
	mov.ne r2,0x2
L_92254c:
	b_s L_92255c
	.global L_92254e
L_92254e:
	mov_s r0,r13
L_922550:
	bl.d L_9283c8
L_922554:
	mov_s r1,0x11
L_922556:
	bl.d L_92208c
L_92255a:
	mov_s r0,r13
	.global L_92255c
L_92255c:
	b L_92028c
