/* txop__await_cts_ppdu @ 0x9399a4, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_mtp_queue_gate, txop_initiator_open_txop_flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fixed_sched_manager__decrement_curr_sta_rd_counter, fsched_slot__f3_positive, mac__cmd_29000001, mac__program_rx_window, mac__select_all_sectors_and_wait
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txop__await_cts_ppdu
txop__await_cts_ppdu:
	.global L_9399a4
L_9399a4:
	push_s blink
L_9399a6:
	bl L_920234
L_9399aa:
	ld_s r0,[gp,-0x44]
L_9399ac:
	mov_s r13,r1
L_9399ae:
	and r0,r0,0xffff0fff
L_9399b6:
	bset r1,r0,0xd
L_9399ba:
	bset_s r1,r1,0xf
L_9399bc:
	st.as r1,[gp,-0x11]
L_9399c0:
	or r0,r0,0x1d00a000
L_9399c8:
	mov_s r32,r0
L_9399ca:
	st.ab r0,[r25,0x4]
L_9399ce:
	bclr r25,r25,0xa
L_9399d2:
	bl L_936870
L_9399d6:
	bl L_936520
L_9399da:
	mov_s r1,r40
L_9399dc:
	mov_s r0,r42
L_9399de:
	bbit1 r0,0xe,L_9399e6
L_9399e2:
	bbit1 r1,0x18,L_9399fa
	.global L_9399e6
L_9399e6:
	mov_s r0,0x29000002
L_9399ec:
	mov_s r32,r0
L_9399ee:
	st.ab r0,[r25,0x4]
L_9399f2:
	bclr r25,r25,0xa
L_9399f6:
	mov_s r0,0x0
L_9399f8:
	b_s L_939a5e
	.global L_9399fa
L_9399fa:
	ld_s r1,[r13,0x8]
L_9399fc:
	mov_s r0,0x5
L_9399fe:
	ld_s r2,[r13]
L_939a00:
	bl.d L_92f798
L_939a04:
	ld_s r3,[r13,0x4]
L_939a06:
	mov_s r0,0x2008000
L_939a0c:
	mov_s r32,r0
L_939a0e:
	st.ab r0,[r25,0x4]
L_939a12:
	bclr r25,r25,0xa
L_939a16:
	mov_s r0,0x19000001
L_939a1c:
	mov_s r32,r0
L_939a1e:
	st.ab r0,[r25,0x4]
L_939a22:
	bclr r25,r25,0xa
L_939a26:
	lsr r13,r43,0x1a
L_939a2a:
	ld_s r0,[gp,-0x34]
L_939a2c:
	bmsk_s r13,r13,0x0
L_939a2e:
	breq_s r0,0,L_939a48
L_939a30:
	mov_s r14,0x801be8
L_939a36:
	bl.d L_92be0c
L_939a3a:
	mov_s r0,r14
L_939a3c:
	cmp_s r0,0x0
L_939a3e:
	and_s r13,r13,r0
L_939a40:
	bl.ne.d L_92574c
L_939a44:
	mov.ne r0,r14
	.global L_939a48
L_939a48:
	asl r0,r13,0xb
L_939a4c:
	bset_s r0,r0,0xe
L_939a4e:
	bset_s r0,r0,0x1b
L_939a50:
	bset_s r0,r0,0x1c
L_939a52:
	mov_s r32,r0
L_939a54:
	st.ab r0,[r25,0x4]
L_939a58:
	bclr r25,r25,0xa
L_939a5c:
	mov_s r0,0x1
	.global L_939a5e
L_939a5e:
	b L_9202a4
L_939a62:
	nop_s
