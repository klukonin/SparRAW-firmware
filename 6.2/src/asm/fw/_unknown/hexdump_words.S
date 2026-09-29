/* hexdump_words @ 0x8c9790, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *       len:%u
 *       %08x:%08x:%08x
 * Зовут его: SW_TX_MGMT_API__send_packet, app_ie__print_ies, discovery_handle_probe_req, discovery_handle_probe_resp, find_main_sm__bcon, find_main_sm__bf_ntf, ieee80211_mgt_information_response_construct, l2mgr__data_port_open_and_keys, mgmt_tx__build_assoc_req, mgmt_tx__build_assoc_resp_8f9e88
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hexdump_words
hexdump_words:
	.global L_8c9790
L_8c9790:
	push_s blink
L_8c9792:
	bl L_8c01dc
L_8c9796:
	mov_s r13,r0
L_8c9798:
	mov_s r16,r1
L_8c979a:
	mov_s r1,0x1001278
L_8c97a0:
	mov_s r0,0x20
L_8c97a2:
	bl.d L_8dcc10
L_8c97a6:
	mov_s r2,r16
L_8c97a8:
	mov_s r14,0x0
L_8c97aa:
	b_s L_8c9802
	.global L_8c97ac
L_8c97ac:
	ldb_s r2,[r13]
L_8c97ae:
	mov_s r1,0x1001284
L_8c97b4:
	ldb_s r0,[r13,0x1]
L_8c97b6:
	asl_s r2,r2,0x18
L_8c97b8:
	asl_s r0,r0,0x10
L_8c97ba:
	or_s r2,r2,r0
L_8c97bc:
	ldb_s r0,[r13,0x2]
L_8c97be:
	ldb_s r3,[r13,0x3]
L_8c97c0:
	asl_s r0,r0,0x8
L_8c97c2:
	or_s r2,r2,r0
L_8c97c4:
	ldb_s r0,[r13,0x4]
L_8c97c6:
	ldb_s r15,[r13,0x5]
L_8c97c8:
	asl_s r0,r0,0x18
L_8c97ca:
	asl_s r15,r15,0x10
L_8c97cc:
	or_s r0,r0,r15
L_8c97ce:
	ldb_s r15,[r13,0x6]
L_8c97d0:
	ldb r6,[r13, 0x7]
L_8c97d4:
	asl_s r15,r15,0x8
L_8c97d6:
	or r5,r15,r0
L_8c97da:
	ldb_s r0,[r13,0x8]
L_8c97dc:
	ldb_s r15,[r13,0x9]
L_8c97de:
	asl_s r0,r0,0x18
L_8c97e0:
	asl_s r15,r15,0x10
L_8c97e2:
	or_s r0,r0,r15
L_8c97e4:
	ldb_s r15,[r13,0xa]
L_8c97e6:
	or_s r2,r2,r3
L_8c97e8:
	asl_s r15,r15,0x8
L_8c97ea:
	or r4,r15,r0
L_8c97ee:
	ldb_s r15,[r13,0xb]
L_8c97f0:
	mov_s r0,0x20
L_8c97f2:
	or r3,r6,r5
L_8c97f6:
	bl.d L_8dcd00
L_8c97fa:
	or r4,r4,r15
L_8c97fe:
	add_s r14,r14,0xc
L_8c9800:
	add_s r13,r13,0xc
	.global L_8c9802
L_8c9802:
	brlo r14,r16,L_8c97ac
L_8c9806:
	b L_8c0244
L_8c980a:
	nop_s
