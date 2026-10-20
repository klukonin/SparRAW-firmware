/* mac_ampdu_statistics_timeout_cb @ 0x8f6370, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mac_ampdu_statistics_timeout_cb: !! TIMEOUT !!halt cmd
 * Зовут его: fw_sysapi_mgr__mac_ampdu_statistics_cmd_start
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r15_to_r13_ret, __st_r14_to_r13, __st_r15_to_r13, fw_log_emit0, fw_sysapi_mgr__stop_sysapi_cmd, fw_sysassert_fatal, mac_rx_cnt__get_crc_err, mac_rx_cnt__get_crc_total, mac_rx_cnt__get_u64_bc, mac_tx_cnt__get_fail, mac_tx_cnt__get_ok
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_ampdu_statistics_timeout_cb
mac_ampdu_statistics_timeout_cb:
	.global L_8f6370
L_8f6370:
	push_s blink
L_8f6372:
	bl L_8c01e0
L_8f6376:
	bl.d L_8dd7a4
L_8f637a:
	mov_s r15,r0
L_8f637c:
	mov_s r13,0x805170
L_8f6382:
	mov_s r14,0x8051f0
L_8f6388:
	st r0,[r13, 0x94]
L_8f638c:
	bl.d L_8dd798
L_8f6390:
	st r1,[r13, 0x98]
L_8f6394:
	st r0,[r13, 0x9c]
L_8f6398:
	bl.d L_8dd758
L_8f639c:
	st r1,[r13, 0xa0]
L_8f63a0:
	bl.d L_8dd760
L_8f63a4:
	st_s r0,[r14,0x24]
L_8f63a6:
	bl.d L_8dd7ac
L_8f63aa:
	st_s r0,[r14,0x28]
L_8f63ac:
	bl.d L_8dd8a8
L_8f63b0:
	st_s r0,[r14,0x2c]
L_8f63b2:
	st_s r0,[r14,0x30]
L_8f63b4:
	ldb_s r0,[r15,0x14]
L_8f63b6:
	bl.d L_8dd7b8
L_8f63ba:
	add3 r1,r13,0x17
L_8f63be:
	b.d L_8c024c
L_8f63c2:
	st_s r0,[r14,0x34]
L_8f63c4:
	push_s blink
L_8f63c6:
	bl L_8c01e4
L_8f63ca:
	mov.f r13,r0
L_8f63ce:
	beq_s L_8f63de
	.global L_8f63d0
L_8f63d0:
	ld_s r0,[r13]
L_8f63d2:
	mov_s r14,0x0
L_8f63d4:
	st_s r14,[r13,0x10]
L_8f63d6:
	breq r0,0x5,L_8f63ec
	.global L_8f63da
L_8f63da:
	mov_s r0,r14
L_8f63dc:
	b_s L_8f63f4
	.global L_8f63de
L_8f63de:
	mov_s r0,blink
L_8f63e0:
	mov_s r1,0x145f
L_8f63e6:
	bl L_8c9b28
L_8f63ea:
	b_s L_8f63d0
	.global L_8f63ec
L_8f63ec:
	ld_s r0,[r13,0x20]
L_8f63ee:
	brne r0,0x2,L_8f63da
L_8f63f2:
	mov_s r0,0x1
	.global L_8f63f4
L_8f63f4:
	extb.f 0x0,r0
L_8f63f8:
	beq_s L_8f6420
L_8f63fa:
	mov_s r1,0x10130e0
L_8f6400:
	bl.d L_8dcba8
L_8f6404:
	mov_s r0,0x20
L_8f6406:
	bl.d L_8f62f8
L_8f640a:
	mov_s r0,r13
L_8f640c:
	mov_s r0,0x1
L_8f640e:
	st_s r0,[r13,0x20]
L_8f6410:
	mov_s r0,r13
L_8f6412:
	bl.d L_8f9bd0
L_8f6416:
	mov_s r1,0x5
L_8f6418:
	mov_s r0,0x84e7e0
L_8f641e:
	st_s r14,[r0,0x38]
	.global L_8f6420
L_8f6420:
	b L_8c0254
