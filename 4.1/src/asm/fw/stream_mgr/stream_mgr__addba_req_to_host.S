/* stream_mgr__addba_req_to_host @ 0x8c2848, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Initiator ADDBA REQ message - moved on thru Driver.
 *   <<---- [HOST EVENT] WMI_RCP_ADDBA_REQ_EVENTID for midid %d.
 *   stream_mgr.cpp
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__by_cid, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.stream_mgr__addba_req_to_host,"ax",@progbits
	.global stream_mgr__addba_req_to_host
stream_mgr__addba_req_to_host:
	.global L_8c2848
L_8c2848:
	push_s blink
L_8c284a:
	bl L_8c02c0
L_8c284e:
	mov_s r13,r0
L_8c2850:
	mov_s r15,r1
L_8c2852:
	mov_s r2,0x100e3a8
L_8c2858:
	mov_s r0,0xb
L_8c285a:
	bl.d L_8edfb0
L_8c285e:
	mov_s r1,0x2
L_8c2860:
	bl L_8c2b68
L_8c2864:
	mov_s r14,r0
L_8c2866:
	ldb_s r0,[r13,0x3]
L_8c2868:
	lsr_s r0,r0,0x2
L_8c286a:
	bmsk_s r0,r0,0x3
L_8c286c:
	asl_s r1,r0,0x4
L_8c286e:
	bmsk r0,r15,0x3
L_8c2872:
	or_s r0,r0,r1
L_8c2874:
	stb_s r0,[r14]
L_8c2876:
	ldb_s r0,[r13,0x2]
L_8c2878:
	stb_s r0,[r14,0x1]
L_8c287a:
	ldb_s r0,[r13,0x4]
L_8c287c:
	ldb_s r1,[r13,0x3]
L_8c287e:
	asl_s r0,r0,0x8
L_8c2880:
	or_s r1,r1,r0
L_8c2882:
	stw_s r1,[r14,0x2]
L_8c2884:
	ldb_s r0,[r13,0x6]
L_8c2886:
	ldb_s r1,[r13,0x5]
L_8c2888:
	asl_s r0,r0,0x8
L_8c288a:
	or_s r1,r1,r0
L_8c288c:
	stw_s r1,[r14,0x4]
L_8c288e:
	ldb_s r1,[r13,0x8]
L_8c2890:
	ldb_s r0,[r13,0x7]
L_8c2892:
	asl_s r1,r1,0x8
L_8c2894:
	or_s r0,r0,r1
L_8c2896:
	stw_s r0,[r14,0x6]
L_8c2898:
	bl.d L_8c9e44
L_8c289c:
	mov_s r0,r15
L_8c289e:
	mov.f r13,r0
L_8c28a2:
	beq_s L_8c28d4
	.global L_8c28a4
L_8c28a4:
	ld_s r3,[r13,0xc]
L_8c28a6:
	mov_s r2,0x100e3dc
L_8c28ac:
	mov_s r0,0xb
L_8c28ae:
	mov_s r1,0x2
L_8c28b0:
	bl.d L_8edfcc
L_8c28b4:
	ldb_s r3,[r3,0x10]
L_8c28b6:
	ld_s r3,[r13,0xc]
L_8c28b8:
	mov_s r0,r14
L_8c28ba:
	mov_s r1,0x1824
L_8c28c0:
	mov_s r2,0x8
L_8c28c2:
	ldb_s r3,[r3,0x10]
L_8c28c4:
	mov r4,0x0
L_8c28c8:
	bl.d L_8e0874
L_8c28cc:
	mov r5,r4
L_8c28d0:
	b L_8c032c
	.global L_8c28d4
L_8c28d4:
	mov_s r0,blink
L_8c28d6:
	mov_s r2,0x100e398
L_8c28dc:
	mov_s r1,0x1295
L_8c28e2:
	bl.d L_8c82c0
L_8c28e6:
	mov r3,0x1b2
L_8c28ea:
	b_s L_8c28a4
