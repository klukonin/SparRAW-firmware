/* mid__link_acquisition_action @ 0x8da928, 356 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: find_main_sm__bcon_args, mid__connect
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, conn__snapshot_bcon_ts, conn_mgr__activate_conn, conn_mgr__alloc_cid, connection__init, find_sm__start_listen, fw_log_emit0, fw_log_emit1, fw_log_emit2, list__find_entry_d, mid__link_acquis_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__link_acquisition_action
mid__link_acquisition_action:
	.global L_8da928
L_8da928:
	push_s blink
L_8da92a:
	bl L_8c01cc
L_8da92e:
	mov_s r15,r0
L_8da930:
	mov_s r14,r1
L_8da932:
	mov_s r16,r2
L_8da934:
	mov_s r17,r3
L_8da936:
	mov_s r13,r4
L_8da938:
	mov r19,r5
L_8da93c:
	mov r20,r6
L_8da940:
	mov r18,r7
L_8da944:
	ldw_s r2,[r14,0x4]
L_8da946:
	mov_s r1,0x100ca58
L_8da94c:
	mov_s r0,0x2b
L_8da94e:
	bl.d L_8dcc80
L_8da952:
	ld_s r3,[r14]
L_8da954:
	ldb_s r2,[r14]
L_8da956:
	ldb_s r1,[r15,0xa]
L_8da958:
	mov_s r0,0x0
L_8da95a:
	brne r2,r1,L_8da988
L_8da95e:
	ldb_s r2,[r14,0x1]
L_8da960:
	ldb_s r1,[r15,0xb]
L_8da962:
	brne r2,r1,L_8da988
L_8da966:
	ldb_s r2,[r14,0x2]
L_8da968:
	ldb_s r1,[r15,0xc]
L_8da96a:
	brne r2,r1,L_8da988
L_8da96e:
	ldb_s r2,[r14,0x3]
L_8da970:
	ldb_s r1,[r15,0xd]
L_8da972:
	brne r2,r1,L_8da988
L_8da976:
	ldb_s r2,[r14,0x4]
L_8da978:
	ldb_s r1,[r15,0xe]
L_8da97a:
	brne r2,r1,L_8da988
L_8da97e:
	ldb_s r2,[r14,0x5]
L_8da980:
	ldb_s r1,[r15,0xf]
L_8da982:
	cmp_s r2,r1
L_8da984:
	mov.eq r0,0x1
	.global L_8da988
L_8da988:
	extb_s r0,r0
L_8da98a:
	brne r0,0x1,L_8da998
L_8da98e:
	mov_s r1,0x100ca9c
L_8da994:
	mov_s r0,0x1b
L_8da996:
	b_s L_8daa80
	.global L_8da998
L_8da998:
	mov_s r0,r15
L_8da99a:
	bl.d L_8cc024
L_8da99e:
	mov_s r1,r14
L_8da9a0:
	mov.f r3,r0
L_8da9a4:
	st_s r0,[r13]
L_8da9a6:
	beq_s L_8da9ee
L_8da9a8:
	ldb_s r2,[r3,0x8]
L_8da9aa:
	mov_s r1,0x100cae4
L_8da9b0:
	ldb r3,[r3,0x124]
L_8da9b8:
	bl.d L_8dcc80
L_8da9bc:
	mov_s r0,0x2b
L_8da9be:
	ld_s r1,[r13]
L_8da9c0:
	breq r18,0xffff,L_8da9cc
L_8da9c8:
	stw r18,[r1, 0xc]
	.global L_8da9cc
L_8da9cc:
	cmp r20,0x0
L_8da9d0:
	ld_s r0,[r13]
L_8da9d2:
	bl.ne L_8e6558
L_8da9d6:
	ld_s r1,[r13]
L_8da9d8:
	st r17,[r1, 0x24]
L_8da9dc:
	ld_s r1,[r13]
L_8da9de:
	st r19,[r1, 0x2c]
L_8da9e2:
	ld_s r0,[r13]
L_8da9e4:
	bl.d L_8f9670
L_8da9e8:
	ldb_s r1,[r0,0x8]
L_8da9ea:
	mov_s r0,0x1
L_8da9ec:
	b_s L_8daa86
	.global L_8da9ee
L_8da9ee:
	mov_s r1,0x100cb3c
L_8da9f4:
	mov_s r0,0x2b
L_8da9f6:
	bl.d L_8dcc10
L_8da9fa:
	mov_s r2,r17
L_8da9fc:
	bl L_8c3290
L_8daa00:
	st_s r0,[r13]
L_8daa02:
	breq_s r0,0,L_8daa78
L_8daa04:
	mov_s r1,r14
L_8daa06:
	bl.d L_8f54a4
L_8daa0a:
	mov_s r2,r15
L_8daa0c:
	ld_s r0,[r13]
L_8daa0e:
	breq r16,0x0,L_8daa20
L_8daa12:
	bl.d L_8c28c8
L_8daa16:
	mov_s r1,r16
L_8daa18:
	ldw r0,[r16, 0xa]
L_8daa1c:
	ld_s r1,[r13]
L_8daa1e:
	stw_s r0,[r1,0xc]
	.global L_8daa20
L_8daa20:
	ld_s r1,[r13]
L_8daa22:
	breq r18,0xffff,L_8daa2e
L_8daa2a:
	stw r18,[r1, 0xc]
	.global L_8daa2e
L_8daa2e:
	cmp r20,0x0
L_8daa32:
	ld_s r0,[r13]
L_8daa34:
	bl.ne L_8e6558
L_8daa38:
	ld_s r1,[r13]
L_8daa3a:
	add r0,r15,0x18
L_8daa3e:
	st r17,[r1, 0x24]
L_8daa42:
	ld_s r1,[r13]
L_8daa44:
	st r19,[r1, 0x2c]
L_8daa48:
	bl.d L_8c25f4
L_8daa4c:
	ld_s r1,[r13]
L_8daa4e:
	mov_s r1,0x100cb74
L_8daa54:
	ldw_s r2,[r14,0x4]
L_8daa56:
	mov_s r0,0x2b
L_8daa58:
	bl.d L_8dcc80
L_8daa5c:
	ld_s r3,[r14]
L_8daa5e:
	ld_s r0,[r13]
L_8daa60:
	mov_s r13,0x1
L_8daa62:
	bl.d L_8c2460
L_8daa66:
	mov_s r1,r13
L_8daa68:
	ldb r1,[r15, 0x24]
L_8daa6c:
	bset r1,r1,r0
L_8daa70:
	stb r1,[r15, 0x24]
L_8daa74:
	mov_s r0,r13
L_8daa76:
	b_s L_8daa86
	.global L_8daa78
L_8daa78:
	mov_s r1,0x100cbd0
L_8daa7e:
	mov_s r0,0xb
	.global L_8daa80
L_8daa80:
	bl L_8dcba8
L_8daa84:
	mov_s r0,0x0
	.global L_8daa86
L_8daa86:
	b L_8c0224
L_8daa8a:
	nop_s
