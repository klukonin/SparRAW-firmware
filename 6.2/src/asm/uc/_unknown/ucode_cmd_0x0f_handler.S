/* ucode_cmd_0x0f_handler @ 0x93477c, 216 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bf__abort_to_state11, bf_pending__set_bit, bti__clear_cid_sweep_counters, internal_tx__clear_pending, ps__release_awake_for_sta, ucode_cmd__reset_queue_state
 * Глобалы (через gp): 0x8005b6, 0x8005b8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x0f_handler
ucode_cmd_0x0f_handler:
	.global L_93477c
L_93477c:
	push_s blink
L_93477e:
	bl L_920228
L_934782:
	ld_s r14,[r0]
L_934784:
	mov_s r2,0x80218c
L_93478a:
	ldb_s r1,[r2,0x8]
L_93478c:
	mov_s r15,0x80212c
L_934792:
	stb_s r1,[r2,0x9]
L_934794:
	ldw_s r0,[r0,0x4]
L_934796:
	breq_s r0,0,L_9347d4
L_934798:
	ldb r0,[r15, 0x68]
L_93479c:
	brne_s r0,0,L_9347aa
L_93479e:
	mov_s r0,0x0
L_9347a0:
	mov_s r3,0x801498
L_9347a6:
	st_s r0,[r3]
L_9347a8:
	st_s r0,[r3,0x4]
	.global L_9347aa
L_9347aa:
	bset r1,r1,r14
L_9347ae:
	stb_s r1,[r2,0x8]
L_9347b0:
	bl.d L_92b184
L_9347b4:
	mov_s r0,r14
L_9347b6:
	ld_s r0,[gp,-0x90]
L_9347b8:
	breq r0,0x0,L_93484e
L_9347bc:
	mov_s r0,0x8014a4
L_9347c2:
	ld_s r0,[r0,0x1c]
L_9347c4:
	brne r0,0x0,L_93484e
L_9347c8:
	mov_s r0,0x802f80
L_9347ce:
	bl L_92b210
L_9347d2:
	b_s L_93484e
	.global L_9347d4
L_9347d4:
	mov_s r13,0x0
L_9347d6:
	bset r13,r13,r14
L_9347da:
	not r17,r13
L_9347de:
	mov r16,0x801ffc
L_9347e6:
	ld r0,[r16, 0xb4]
L_9347ea:
	and r1,r1,r17
L_9347ee:
	tst_s r0,r13
L_9347f0:
	stb_s r1,[r2,0x8]
L_9347f2:
	beq_s L_93481c
L_9347f4:
	bl.d L_9258c8
L_9347f8:
	mov_s r0,r14
L_9347fa:
	ld r0,[r16, 0xc0]
L_9347fe:
	mov_s r1,0x8020b4
L_934804:
	bmsk_s r0,r0,0x2
L_934806:
	ldb_s r0,[r1,r0]
L_934808:
	brne r14,r0,L_934814
L_93480c:
	bl.d L_9216f8
L_934810:
	mov_s r0,0x1
L_934812:
	b_s L_93481c
	.global L_934814
L_934814:
	ldb_s r0,[gp,-0xf1]
L_934816:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_934818:
	stb r0,[gp, -0xf1]
	.global L_93481c
L_93481c:
	ldb r0,[r15, 0x68]
L_934820:
	brne_s r0,0,L_934836
L_934822:
	mov_s r0,0x8014a4
L_934828:
	ld_s r0,[r0,0x1c]
L_93482a:
	brne_s r0,0,L_934836
L_93482c:
	mov_s r0,0x802f80
L_934832:
	bl L_93d980
	.global L_934836
L_934836:
	bl.d L_9394d0
L_93483a:
	mov_s r0,r14
L_93483c:
	ldw_s r0,[gp,0x90]
L_93483e:
	or_s r0,r0,r13
L_934840:
	stw.as r0,[gp,0x48]
L_934844:
	ldw_s r0,[gp,0x8e]
L_934846:
	and r0,r0,r17
L_93484a:
	stw.as r0,[gp,0x47]
	.global L_93484e
L_93484e:
	b L_92028c
L_934852:
	nop_s
