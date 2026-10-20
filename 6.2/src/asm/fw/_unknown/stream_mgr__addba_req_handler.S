/* stream_mgr__addba_req_handler @ 0x8c3028, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Initiator ADDBA REQ message - moved on thru Driver.
 *   stream_mgr::addba_req_handler AFTER DISCONNECTION
 *   <<---- [HOST EVENT] WMI_RCP_ADDBA_REQ_EVENTID for midid %d.
 *   stream_mgr::addba_req_tx_complete after disconnection
 *   stream_mgr::addba_req_tx_complete p_conn == NULL - called after disconnection
 * Зовут его: stream_mgr__action
 * Зовёт сам: TX_API__free_memory, __ld_r14_to_r13_ret, __ld_r16_to_r13_ret, __st_r14_to_r13, __st_r16_to_r13, ba_sm_evt_type, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, host_if__send_pair, low_sme__send_evt2sw, vring_tbl__find_by_tid_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__addba_req_handler
stream_mgr__addba_req_handler:
	.global L_8c3028
L_8c3028:
	push_s blink
L_8c302a:
	bl L_8c01dc
L_8c302e:
	mov_s r13,r0
L_8c3030:
	mov_s r16,r1
L_8c3032:
	mov_s r1,0x10104b8
L_8c3038:
	bl.d L_8dcba8
L_8c303c:
	mov_s r0,0x2b
L_8c303e:
	bl.d L_8cbffc
L_8c3042:
	mov_s r0,r16
L_8c3044:
	mov.f r15,r0
L_8c3048:
	bne_s L_8c3058
L_8c304a:
	mov_s r1,0x10104ec
L_8c3050:
	bl.d L_8dcba8
L_8c3054:
	mov_s r0,0x1b
L_8c3056:
	b_s L_8c30be
	.global L_8c3058
L_8c3058:
	bl L_8c32d8
L_8c305c:
	mov_s r14,r0
L_8c305e:
	ldb_s r0,[r13,0x3]
L_8c3060:
	lsr_s r0,r0,0x2
L_8c3062:
	bmsk_s r0,r0,0x3
L_8c3064:
	asl_s r1,r0,0x4
L_8c3066:
	bmsk r0,r16,0x3
L_8c306a:
	or_s r0,r0,r1
L_8c306c:
	stb_s r0,[r14]
L_8c306e:
	ldb_s r0,[r13,0x2]
L_8c3070:
	stb_s r0,[r14,0x1]
L_8c3072:
	ldb_s r0,[r13,0x4]
L_8c3074:
	ldb_s r1,[r13,0x3]
L_8c3076:
	asl_s r0,r0,0x8
L_8c3078:
	or_s r1,r1,r0
L_8c307a:
	stw_s r1,[r14,0x2]
L_8c307c:
	ldb_s r1,[r13,0x6]
L_8c307e:
	ldb_s r0,[r13,0x5]
L_8c3080:
	asl_s r1,r1,0x8
L_8c3082:
	or_s r0,r0,r1
L_8c3084:
	stw_s r0,[r14,0x4]
L_8c3086:
	ldb_s r1,[r13,0x8]
L_8c3088:
	ldb_s r0,[r13,0x7]
L_8c308a:
	asl_s r1,r1,0x8
L_8c308c:
	or_s r0,r0,r1
L_8c308e:
	stw_s r0,[r14,0x6]
L_8c3090:
	ld_s r2,[r15,0x18]
L_8c3092:
	mov_s r1,0x1010520
L_8c3098:
	mov_s r0,0x2b
L_8c309a:
	bl.d L_8dcc10
L_8c309e:
	ldb_s r2,[r2,0x10]
L_8c30a0:
	ld_s r3,[r15,0x18]
L_8c30a2:
	mov_s r0,r14
L_8c30a4:
	mov_s r1,0x1824
L_8c30aa:
	mov_s r2,0x8
L_8c30ac:
	ldb_s r3,[r3,0x10]
L_8c30ae:
	mov r4,0x0
L_8c30b2:
	mov r5,r4
L_8c30b6:
	bl.d L_8e5474
L_8c30ba:
	mov r6,r4
	.global L_8c30be
L_8c30be:
	b L_8c0244
L_8c30c2:
	nop_s
L_8c30c4:
	push_s blink
L_8c30c6:
	bl L_8c01e4
L_8c30ca:
	mov_s r13,r0
L_8c30cc:
	mov_s r14,r1
L_8c30ce:
	breq_s r2,0,L_8c30f8
L_8c30d0:
	ldb_s r0,[r13,0x1b]
L_8c30d2:
	lsr_s r0,r0,0x2
L_8c30d4:
	bmsk_s r0,r0,0x3
L_8c30d6:
	bl.d L_8cce44
L_8c30da:
	ldb_s r1,[r2,0x8]
L_8c30dc:
	cmp_s r14,0x0
L_8c30de:
	mov_s r2,0x1
L_8c30e0:
	sub_s.ne r2,r2,r2
L_8c30e2:
	brne_s r0,0,L_8c30ec
L_8c30e4:
	mov_s r1,0x10108f8
L_8c30ea:
	b_s L_8c30fe
	.global L_8c30ec
L_8c30ec:
	mov_s r1,0x3
L_8c30ee:
	mov_s r3,0x0
L_8c30f0:
	bl.d L_8d9c4c
L_8c30f4:
	mov_s r4,r3
L_8c30f6:
	b_s L_8c3104
	.global L_8c30f8
L_8c30f8:
	mov_s r1,0x1010930
	.global L_8c30fe
L_8c30fe:
	bl.d L_8dcba8
L_8c3102:
	mov_s r0,0x1b
	.global L_8c3104
L_8c3104:
	bl.d L_8cb10c
L_8c3108:
	mov_s r0,r13
L_8c310a:
	b L_8c0254
L_8c310e:
	nop_s
