/* rate_search__reset_stats @ 0x92c29c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flow_substep
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, memset0_words_uc, rate_search__build_mcs_mask
 */
	.section .text.rate_search__reset_stats,"ax",@progbits
	.global rate_search__reset_stats
rate_search__reset_stats:
	.global L_92c29c
L_92c29c:
	push_s blink
L_92c29e:
	bl L_920210
L_92c2a2:
	ldb_s r14,[r0]
L_92c2a4:
	mov_s r15,r1
L_92c2a6:
	mul64 r14,0x2c
L_92c2aa:
	add r13,mlo,0x801738
L_92c2b2:
	add r0,r13,0x24
L_92c2b6:
	bl.d L_92166c
L_92c2ba:
	mov_s r1,0x8
L_92c2bc:
	brne r15,0x1,L_92c2c4
L_92c2c0:
	ldb_s r0,[r13,0x1b]
L_92c2c2:
	stb_s r0,[r13,0x1a]
	.global L_92c2c4
L_92c2c4:
	mul64 r14,0x26
L_92c2c8:
	ldb_s r1,[r13,0x1c]
L_92c2ca:
	add r15,mlo,0x801898
L_92c2d2:
	ldw_s r2,[r15,0x24]
L_92c2d4:
	ldw_s r0,[r15,0x22]
L_92c2d6:
	asl_s r2,r2,0x10
L_92c2d8:
	or_s r0,r0,r2
L_92c2da:
	norm r0,r0
L_92c2de:
	rsub r2,r0,0x1e
L_92c2e2:
	breq r1,r2,L_92c2ee
L_92c2e6:
	bl.d L_92c1fc
L_92c2ea:
	mov_s r0,r14
L_92c2ec:
	stb_s r0,[r13,0x1c]
	.global L_92c2ee
L_92c2ee:
	ldb_s r2,[r13,0x1a]
L_92c2f0:
	ldw_s r1,[r15,0x24]
L_92c2f2:
	ldw_s r0,[r15,0x22]
L_92c2f4:
	asl_s r1,r1,0x10
L_92c2f6:
	or_s r0,r0,r1
L_92c2f8:
	norm r0,r0
L_92c2fc:
	rsub r1,r0,0x1e
L_92c300:
	cmp_s r2,r1
L_92c302:
	mov_s r0,0x1
L_92c304:
	b.d L_92027c
L_92c308:
	sub_s.ne r0,r0,r0
L_92c30a:
	nop_s
