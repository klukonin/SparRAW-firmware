/* ba_sm__action_8c4394 @ 0x8c4394, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   VRING %d is waiting for TX MACQ delete notification. q_is_empty %d
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, ba_sm__build_addba_params, conn__sec_mode_not_1, fw_log_emit2, lmac_if_send_cmd_0x08, vring__active_ring_table, vring__get_pring_id, vring_is_empty, vring_tbl__entry_addr
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm__action_8c4394
ba_sm__action_8c4394:
	.global L_8c4394
L_8c4394:
	ld_s r0,[r0,0x40]
L_8c4396:
	ld_s r3,[r0,0x68]
L_8c4398:
	ld_s r3,[r3,0x4]
L_8c439a:
	j_s.d [r3]
L_8c439c:
	extw_s r2,r2
L_8c439e:
	nop_s
L_8c43a0:
	push_s blink
L_8c43a2:
	bl.d L_8c01dc
L_8c43a6:
	mov_s r1,0x1
L_8c43a8:
	mov_s r13,r0
L_8c43aa:
	mov_s r14,0x0
L_8c43ac:
	st_s r14,[r0,0x54]
L_8c43ae:
	ld_s r0,[r0,0x68]
L_8c43b0:
	ld_s r2,[r0,0x1c]
L_8c43b2:
	jl_s.d [r2]
L_8c43b4:
	mov_s r0,r13
L_8c43b6:
	bl.d L_8ccfd8
L_8c43ba:
	ldb_s r0,[r13,0x7]
L_8c43bc:
	mov_s r16,r0
L_8c43be:
	ld_s r0,[r13,0x58]
L_8c43c0:
	breq_s r0,0,L_8c4404
L_8c43c2:
	ldb_s r0,[r13,0x7]
L_8c43c4:
	bl.d L_8d47a0
L_8c43c8:
	mov_s r1,r14
L_8c43ca:
	cmp_s r0,0x0
L_8c43cc:
	mov_s r15,0x1
L_8c43ce:
	sub_s.ne r15,r15,r15
L_8c43d0:
	bl.d L_8cbed8
L_8c43d4:
	mov_s r0,r13
L_8c43d6:
	extb_s r2,r0
L_8c43d8:
	mov_s r0,0x3
L_8c43da:
	mov_s r1,0x1
L_8c43dc:
	ldb_s r3,[r13,0x5]
L_8c43de:
	mov_s r4,r14
L_8c43e0:
	mov_s r5,r14
L_8c43e2:
	bl.d L_8dbb60
L_8c43e6:
	mov_s r6,r15
L_8c43e8:
	bl.d L_8ccfd8
L_8c43ec:
	ldb_s r0,[r13,0x5]
L_8c43ee:
	mov_s r1,0x2
L_8c43f0:
	stb_s r1,[r0,0xc]
L_8c43f2:
	ldb_s r2,[r13,0x7]
L_8c43f4:
	mov_s r1,0x1010fec
L_8c43fa:
	mov_s r0,0x2b
L_8c43fc:
	bl.d L_8dcc80
L_8c4400:
	mov_s r3,r15
L_8c4402:
	b_s L_8c4428
	.global L_8c4404
L_8c4404:
	ld_s r0,[r13]
L_8c4406:
	bl.d L_8da5f8
L_8c440a:
	ldb_s r15,[r0,0x8]
L_8c440c:
	mov_s r5,r0
L_8c440e:
	mov_s r0,r16
L_8c4410:
	mov_s r1,0x5
L_8c4412:
	ldb_s r2,[r13,0x4]
L_8c4414:
	mov_s r3,r14
L_8c4416:
	bl.d L_8ea62c
L_8c441a:
	mov_s r4,r15
L_8c441c:
	bl L_8cd080
L_8c4420:
	ld_s r1,[r0]
L_8c4422:
	ld_s r2,[r1,0x18]
L_8c4424:
	jl_s.d [r2]
L_8c4426:
	ldb_s r1,[r13,0x7]
	.global L_8c4428
L_8c4428:
	b L_8c0244
