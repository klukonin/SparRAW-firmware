/* mid__link_acquisition_action @ 0x8d7838, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid::link_acquisition_action() Start for link for: ADDR-%04X%08X
 *   mid::link_acquisition_action() Reject an attempt to create SELF-Link.
 *   mid::link_acquisition_action() Re-start Link to this destination (CID=%d, state=%x).
 *   mid::link_acquisition_action() following_connect: %d.
 *   mid::link_acquisition_action() L2MGR allocated and configured new link for: ADDR-%04X%08X
 *   mid::link_acquisition_action() FAILED!!!
 * Зовут его: mid__acquire_link, mid__connect
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, conn__bind_cid_to_lm, conn__on_bf_results, conn_mgr__activate_conn, conn_mgr__alloc_cid, connection__init, fw_log__emit0, fw_log__emit1, fw_log__emit2, llist__insert, mid_list__find_by
 */
	.section .text.mid__link_acquisition_action,"ax",@progbits
	.global mid__link_acquisition_action
mid__link_acquisition_action:
	.global L_8d7838
L_8d7838:
	push_s blink
L_8d783a:
	bl L_8c02b4
L_8d783e:
	mov_s r14,r0
L_8d7840:
	mov_s r13,r1
L_8d7842:
	mov_s r16,r2
L_8d7844:
	mov_s r17,r3
L_8d7846:
	mov_s r15,r4
L_8d7848:
	mov r18,r5
L_8d784c:
	mov_s r2,0x100b53c
L_8d7852:
	ld r4,[r1]
L_8d7856:
	mov_s r0,0xb
L_8d7858:
	mov_s r1,0x2
L_8d785a:
	bl.d L_8edff8
L_8d785e:
	ldw_s r3,[r13,0x4]
L_8d7860:
	ldb_s r2,[r13]
L_8d7862:
	ldb_s r1,[r14,0xa]
L_8d7864:
	mov_s r0,0x0
L_8d7866:
	brne r2,r1,L_8d7894
L_8d786a:
	ldb_s r2,[r13,0x1]
L_8d786c:
	ldb_s r1,[r14,0xb]
L_8d786e:
	brne r2,r1,L_8d7894
L_8d7872:
	ldb_s r2,[r13,0x2]
L_8d7874:
	ldb_s r1,[r14,0xc]
L_8d7876:
	brne r2,r1,L_8d7894
L_8d787a:
	ldb_s r2,[r13,0x3]
L_8d787c:
	ldb_s r1,[r14,0xd]
L_8d787e:
	brne r2,r1,L_8d7894
L_8d7882:
	ldb_s r2,[r13,0x4]
L_8d7884:
	ldb_s r1,[r14,0xe]
L_8d7886:
	brne r2,r1,L_8d7894
L_8d788a:
	ldb_s r2,[r13,0x5]
L_8d788c:
	ldb_s r1,[r14,0xf]
L_8d788e:
	cmp_s r2,r1
L_8d7890:
	mov.eq r0,0x1
	.global L_8d7894
L_8d7894:
	extb_s r0,r0
L_8d7896:
	brne r0,0x1,L_8d78ac
L_8d789a:
	mov_s r2,0x100b580
L_8d78a0:
	mov_s r0,0xb
L_8d78a2:
	bl.d L_8edfb0
L_8d78a6:
	mov_s r1,0x1
L_8d78a8:
	mov_s r13,0x0
L_8d78aa:
	b_s L_8d7968
	.global L_8d78ac
L_8d78ac:
	mov_s r0,r14
L_8d78ae:
	bl.d L_8c9e74
L_8d78b2:
	mov_s r1,r13
L_8d78b4:
	mov.f r3,r0
L_8d78b8:
	st_s r0,[r15]
L_8d78ba:
	beq_s L_8d78e8
L_8d78bc:
	ldb r4,[r3, 0xfc]
L_8d78c0:
	mov_s r2,0x100b5c8
L_8d78c6:
	mov_s r0,0xb
L_8d78c8:
	mov_s r1,0x2
L_8d78ca:
	bl.d L_8edff8
L_8d78ce:
	ldb_s r3,[r3,0x8]
L_8d78d0:
	ld_s r1,[r15]
L_8d78d2:
	st r17,[r1, 0x18]
L_8d78d6:
	ld_s r1,[r15]
L_8d78d8:
	st r18,[r1, 0x20]
L_8d78dc:
	ld_s r0,[r15]
L_8d78de:
	bl.d L_8f1358
L_8d78e2:
	ldb_s r1,[r0,0x8]
L_8d78e4:
	mov_s r13,0x1
L_8d78e6:
	b_s L_8d7968
	.global L_8d78e8
L_8d78e8:
	mov_s r2,0x100b620
L_8d78ee:
	mov_s r0,0xb
L_8d78f0:
	mov_s r1,0x2
L_8d78f2:
	bl.d L_8edfcc
L_8d78f6:
	mov_s r3,r17
L_8d78f8:
	bl L_8c2b18
L_8d78fc:
	st_s r0,[r15]
L_8d78fe:
	breq_s r0,0,L_8d7958
L_8d7900:
	mov_s r1,r13
L_8d7902:
	bl.d L_8ed290
L_8d7906:
	mov_s r2,r14
L_8d7908:
	cmp r16,0x0
L_8d790c:
	ld_s r0,[r15]
L_8d790e:
	bl.ne.d L_8c22a8
L_8d7912:
	mov.ne r1,r16
L_8d7916:
	ld_s r1,[r15]
L_8d7918:
	add r0,r14,0x18
L_8d791c:
	st r17,[r1, 0x18]
L_8d7920:
	ld_s r1,[r15]
L_8d7922:
	st r18,[r1, 0x20]
L_8d7926:
	bl.d L_8c1fc4
L_8d792a:
	ld_s r1,[r15]
L_8d792c:
	mov_s r2,0x100b658
L_8d7932:
	ld r4,[r13]
L_8d7936:
	mov_s r0,0xb
L_8d7938:
	mov_s r1,0x2
L_8d793a:
	bl.d L_8edff8
L_8d793e:
	ldw_s r3,[r13,0x4]
L_8d7940:
	mov_s r13,0x1
L_8d7942:
	ld_s r0,[r15]
L_8d7944:
	bl.d L_8c1df0
L_8d7948:
	mov_s r1,r13
L_8d794a:
	ldb r1,[r14, 0x24]
L_8d794e:
	bset r1,r1,r0
L_8d7952:
	stb r1,[r14, 0x24]
L_8d7956:
	b_s L_8d7968
	.global L_8d7958
L_8d7958:
	mov_s r2,0x100b6b4
L_8d795e:
	mov_s r0,0xb
L_8d7960:
	mov_s r13,0x0
L_8d7962:
	bl.d L_8edfb0
L_8d7966:
	mov_s r1,r13
	.global L_8d7968
L_8d7968:
	b.d L_8c0314
L_8d796c:
	mov_s r0,r13
L_8d796e:
	nop_s
