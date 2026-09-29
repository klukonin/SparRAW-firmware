/* rate_search__pick_tx_params @ 0x92c44c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flow_size_step
 * Зовёт сам: __ld_r16_to_r13_ret_uc, __st_r16_to_r13_uc, bitstream__push, rate_search__commit_mcs
 */
	.section .text.rate_search__pick_tx_params,"ax",@progbits
	.global rate_search__pick_tx_params
rate_search__pick_tx_params:
	.global L_92c44c
L_92c44c:
	push_s blink
L_92c44e:
	bl.d L_92020c
L_92c452:
	mov_s r2,r1
L_92c454:
	ldb_s r14,[r0]
L_92c456:
	mov_s r15,r0
L_92c458:
	mul64 r14,0x2c
L_92c45c:
	add r16,mlo,0x801738
L_92c464:
	mul64 r14,0x26
L_92c468:
	add r1,mlo,0x801898
L_92c470:
	ldw_s r0,[r1,0x20]
L_92c472:
	ldw_s r3,[r1,0x1e]
L_92c474:
	asl_s r0,r0,0x10
L_92c476:
	or_s r3,r3,r0
L_92c478:
	add r0,r16,0x24
L_92c47c:
	bl.d L_93708c
L_92c480:
	ldb_s r1,[r1,0x1c]
L_92c482:
	asl_s r13,r14,0x2
L_92c484:
	add1_s r13,r13,r13
L_92c486:
	add_s r13,r13,0x8016d8
L_92c48c:
	brne r0,0x1,L_92c4b2
L_92c490:
	bl.d L_92c034
L_92c494:
	mov_s r0,r15
L_92c496:
	mov_s r0,0x4
L_92c498:
	st_s r0,[r13,0x4]
L_92c49a:
	ldb r0,[r16, 0x1b]
L_92c49e:
	brne r0,0x1,L_92c4a8
L_92c4a2:
	mov_s r0,0x2
L_92c4a4:
	st_s r0,[r13,0x4]
L_92c4a6:
	b_s L_92c4b2
	.global L_92c4a8
L_92c4a8:
	ld_s r0,[gp,-0x8]
L_92c4aa:
	bset r0,r0,r14
L_92c4ae:
	st.as r0,[gp,-0x2]
	.global L_92c4b2
L_92c4b2:
	b.d L_920274
L_92c4b6:
	ld_s r0,[r13,0x4]
