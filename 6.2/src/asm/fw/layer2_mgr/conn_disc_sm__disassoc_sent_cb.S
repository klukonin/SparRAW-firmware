/* conn_disc_sm__disassoc_sent_cb @ 0x8f23a0, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disassoc_done() Stop DISCONNECT WD if running
 *   DISC SM - spurious Disassoc Done notification.
 *   conn_disc_sm::disassoc_sent_cb() arrived.
 *   conn_disc_sm::disassoc_sent_cb - p_conn is NULL
 * Зовёт сам: TX_API__free_memory, TX_CTRL_API__flush_connection, __ld_r13_to_r13_ret, __ld_r15_to_r13_ret, __st_r15_to_r13, conn__sm_handle_event, fw_log_emit0, lmac_if_send_cmd_0x0f, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_disc_sm__disassoc_sent_cb
conn_disc_sm__disassoc_sent_cb:
	.global L_8f23a0
L_8f23a0:
	push_s blink
L_8f23a2:
	push_s r13
L_8f23a4:
	mov_s r13,r0
L_8f23a6:
	ld_s r0,[r0,0x1c]
L_8f23a8:
	breq_s r0,0,L_8f23c0
L_8f23aa:
	mov_s r1,0x1011c54
L_8f23b0:
	bl.d L_8dcba8
L_8f23b4:
	mov_s r0,0x1b
L_8f23b6:
	bl.d L_8c8de0
L_8f23ba:
	ld_s r0,[r13,0x1c]
L_8f23bc:
	mov_s r0,0x0
L_8f23be:
	st_s r0,[r13,0x1c]
	.global L_8f23c0
L_8f23c0:
	ld_s r0,[r13,0xc]
L_8f23c2:
	bbit0 r0,0x3,L_8f23e6
L_8f23c6:
	bic r0,r0,0x9
L_8f23ca:
	bset_s r0,r0,0x0
L_8f23cc:
	st_s r0,[r13,0xc]
L_8f23ce:
	ld_s r0,[r13,0x8]
L_8f23d0:
	ld_s r0,[r0,0x8]
L_8f23d2:
	bl.d L_8cabc4
L_8f23d6:
	ldb_s r0,[r0,0x8]
L_8f23d8:
	ld_s r0,[r13,0x8]
L_8f23da:
	ld_s r0,[r0,0x8]
L_8f23dc:
	ldb_s r0,[r0,0x8]
L_8f23de:
	bl.d L_8dbd74
L_8f23e2:
	mov_s r1,0x0
L_8f23e4:
	b_s L_8f23f2
	.global L_8f23e6
L_8f23e6:
	mov_s r1,0x1011c84
L_8f23ec:
	bl.d L_8dcba8
L_8f23f0:
	mov_s r0,0x2b
	.global L_8f23f2
L_8f23f2:
	b L_8c025c
L_8f23f6:
	nop_s
L_8f23f8:
	push_s blink
L_8f23fa:
	bl L_8c01e0
L_8f23fe:
	mov_s r15,r0
L_8f2400:
	mov_s r13,r2
L_8f2402:
	mov_s r1,0x1011de8
L_8f2408:
	bl.d L_8dcba8
L_8f240c:
	mov_s r0,0x2b
L_8f240e:
	breq_s r13,0,L_8f242c
L_8f2410:
	mov_s r14,0x0
L_8f2412:
	st.as r14,[r13,0x52]
L_8f2416:
	bl.d L_8cb10c
L_8f241a:
	mov_s r0,r15
L_8f241c:
	mov_s r0,r13
L_8f241e:
	mov_s r1,0x6
L_8f2420:
	mov_s r2,r14
L_8f2422:
	mov_s r3,r14
L_8f2424:
	bl.d L_8d9cc0
L_8f2428:
	mov_s r4,r14
L_8f242a:
	b_s L_8f243e
	.global L_8f242c
L_8f242c:
	mov_s r1,0x1011e14
L_8f2432:
	bl.d L_8dcba8
L_8f2436:
	mov_s r0,0x2e
L_8f2438:
	bl.d L_8cb10c
L_8f243c:
	mov_s r0,r15
	.global L_8f243e
L_8f243e:
	b L_8c024c
L_8f2442:
	nop_s
