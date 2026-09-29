/* handle_pmc_triggers @ 0x9289c0, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_pmc_triggers: start recording at trigger %d param %d
 *   handle_pmc_triggers: stop recording at trigger %d param %d
 * Зовут его: sends_pmc_mark_aaab02
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, pmc__stop_recording, uc_evt__send_2c_tsf, uc_log__emit2
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global handle_pmc_triggers
handle_pmc_triggers:
	.global L_9289c0
L_9289c0:
	push_s blink
L_9289c2:
	bl L_920230
L_9289c6:
	mov_s r13,r0
L_9289c8:
	mov_s r14,0x801458
L_9289ce:
	ldb_s r0,[r14,0x10]
L_9289d0:
	mov_s r15,r1
L_9289d2:
	breq_s r0,0,L_928a42
L_9289d4:
	ldb_s r0,[r14,0x11]
L_9289d6:
	brne_s r0,0,L_928a0e
L_9289d8:
	ldb_s r0,[r14]
L_9289da:
	brne r13,r0,L_928a3c
L_9289de:
	ldb_s r0,[r14,0x3]
L_9289e0:
	brne r15,r0,L_928a3c
L_9289e4:
	mov_s r1,0x10016a4
L_9289ea:
	mov_s r0,0x20
L_9289ec:
	mov_s r2,r13
L_9289ee:
	bl.d L_92d27c
L_9289f2:
	mov_s r3,r15
L_9289f4:
	mov_s r1,0x886000
L_9289fa:
	ld_s r0,[r1,0x7c]
L_9289fc:
	bset_s r0,r0,0x10
L_9289fe:
	st_s r0,[r1,0x7c]
L_928a00:
	mov_s r0,0x1
L_928a02:
	stb_s r0,[r14,0x11]
L_928a04:
	mov_s r0,0x0
L_928a06:
	ld_s r2,[r14,0x8]
L_928a08:
	st_s r0,[r14,0xc]
L_928a0a:
	mov_s r1,r0
L_928a0c:
	b_s L_928a38
	.global L_928a0e
L_928a0e:
	ldb_s r0,[r14,0x1]
L_928a10:
	brne r13,r0,L_928a3c
L_928a14:
	ldb_s r0,[r14,0x4]
L_928a16:
	brne r15,r0,L_928a3c
L_928a1a:
	bl L_936134
L_928a1e:
	mov_s r1,0x10016e0
L_928a24:
	mov_s r0,0x20
L_928a26:
	mov_s r2,r13
L_928a28:
	bl.d L_92d27c
L_928a2c:
	mov_s r3,r15
L_928a2e:
	mov_s r0,0x0
L_928a30:
	stb_s r0,[r14,0x10]
L_928a32:
	ld_s r1,[r14,0xc]
L_928a34:
	mov_s r0,0x1
L_928a36:
	ld_s r2,[r14,0x8]
	.global L_928a38
L_928a38:
	bl L_927700
	.global L_928a3c
L_928a3c:
	ld_s r0,[r14,0xc]
L_928a3e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_928a40:
	st_s r0,[r14,0xc]
	.global L_928a42
L_928a42:
	b L_92029c
L_928a46:
	nop_s
