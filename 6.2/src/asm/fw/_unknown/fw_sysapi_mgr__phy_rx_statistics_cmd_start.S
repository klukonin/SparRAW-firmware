/* fw_sysapi_mgr__phy_rx_statistics_cmd_start @ 0x8f7228, 392 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   phy_rx_statistics_cmd_start: Enter
 *   fw_sysapi_mgr::phy_rx_statistics_cmd_start: Rejecting sysapi request since previous command is still not completed (prev request_type=%d, new request type=%d)
 *   phy_rx_statistics_timeout_cb: !! TIMEOUT !!halt cmd
 *   fw_sysapi_mgr::complete_plcp_header(): PLCP Header Results: status=%d, plcp_mcs=%d, plcp_length=%d
 *   fw_sysapi_mgr::complete_plcp_header(): PLCP Header Results: plcp_train_length=%d, plcp_packet_type=%d, plcp_add_ppdu=%d
 *   fw_sysapi_mgr::complete_plcp_header(): PLCP Header Results: plcp_aggregation=%d
 * Зовут его: fw_sysapi__start_phy_rx_stats, fw_sysapi_mgr__start_plcp_header
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, channel_est__clamp_64, channel_est__stack_args, field_set_0x00__8dbe88, fw_log_emit0, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysapi__send_measure_evt, fw_sysapi_mgr__send_evt2host
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__phy_rx_statistics_cmd_start
fw_sysapi_mgr__phy_rx_statistics_cmd_start:
	.global L_8f7228
L_8f7228:
	push_s blink
L_8f722a:
	bl L_8c01dc
L_8f722e:
	sub sp,sp,0x8c
L_8f7232:
	mov_s r13,r0
L_8f7234:
	mov_s r15,r1
L_8f7236:
	mov_s r14,r2
L_8f7238:
	mov_s r16,r3
L_8f723a:
	mov_s r1,0x101277c
L_8f7240:
	bl.d L_8dcba8
L_8f7244:
	mov_s r0,0x20
L_8f7246:
	mov_s r0,r13
L_8f7248:
	mov_s r1,r15
L_8f724a:
	bl.d L_8f7490
L_8f724e:
	mov_s r2,r14
L_8f7250:
	mov_s r0,r13
L_8f7252:
	mov_s r1,0x4
L_8f7254:
	bl.d L_8f9a20
L_8f7258:
	mov_s r2,r16
L_8f725a:
	brne_s r0,0,L_8f7286
L_8f725c:
	mov_s r0,sp
L_8f725e:
	bl.d L_8c1cd8
L_8f7262:
	mov_s r1,0x8c
L_8f7264:
	ld_s r2,[r13]
L_8f7266:
	mov_s r1,0x10127a0
L_8f726c:
	mov_s r0,0x20
L_8f726e:
	bl.d L_8dcc80
L_8f7272:
	mov_s r3,0x4
L_8f7274:
	ld_s r1,[r13,0x20]
L_8f7276:
	mov_s r2,sp
L_8f7278:
	add r4,r13,0x4
L_8f727c:
	mov_s r0,r13
L_8f727e:
	bl.d L_8f8948
L_8f7282:
	mov_s r3,0x8c
L_8f7284:
	b_s L_8f72c0
	.global L_8f7286
L_8f7286:
	mov_s r1,0x84e7e0
L_8f728c:
	mov_s r0,0x1
L_8f728e:
	bl.d L_8d1bc0
L_8f7292:
	st_s r0,[r1,0x38]
L_8f7294:
	mov_s r0,0x372f8
L_8f729a:
	st_s r0,[r13,0x34]
L_8f729c:
	mov_s r2,0x37300
L_8f72a2:
	mov_s r0,r13
L_8f72a4:
	bl.d L_8f9070
L_8f72a8:
	mov_s r1,r14
L_8f72aa:
	mov_s r0,sp
L_8f72ac:
	mov_s r1,r15
L_8f72ae:
	bl.d L_8c0380
L_8f72b2:
	mov_s r2,0x8
L_8f72b4:
	ld_s r1,[sp,0x0]
L_8f72b6:
	mov_s r0,0x37
L_8f72b8:
	ld_s r2,[sp,0x4]
L_8f72ba:
	bl.d L_8dbe54
L_8f72be:
	mov_s r3,0x0
	.global L_8f72c0
L_8f72c0:
	b.d L_8c0244
L_8f72c4:
	add sp,sp,0x8c
	.global L_8f72c8
L_8f72c8:
	push_s blink
L_8f72ca:
	push_s r13
L_8f72cc:
	mov_s r1,0x8576ac
L_8f72d2:
	bl.d L_8f8af8
L_8f72d6:
	mov_s r13,r0
L_8f72d8:
	mov_s r0,r13
L_8f72da:
	bl.d L_8f9bd0
L_8f72de:
	mov_s r1,0x4
L_8f72e0:
	bl L_8d2ae4
L_8f72e4:
	mov_s r1,0x84e7e0
L_8f72ea:
	mov_s r0,0x0
L_8f72ec:
	bl.d L_8d1bc0
L_8f72f0:
	st_s r0,[r1,0x38]
L_8f72f2:
	b L_8c025c
L_8f72f6:
	nop_s
L_8f72f8:
	b.d L_8f72c8
L_8f72fc:
	st_s r1,[r0,0x20]
L_8f72fe:
	nop_s
L_8f7300:
	push_s blink
L_8f7302:
	ld_s r2,[r0]
L_8f7304:
	mov_s r1,0x0
L_8f7306:
	st_s r1,[r0,0x10]
L_8f7308:
	brne r2,0x4,L_8f7314
L_8f730c:
	ld_s r2,[r0,0x20]
L_8f730e:
	cmp_s r2,0x2
L_8f7310:
	mov.eq r1,0x1
	.global L_8f7314
L_8f7314:
	extb.f 0x0,r1
L_8f7318:
	beq_s L_8f7330
L_8f731a:
	breq_s r0,0,L_8f7334
	.global L_8f731c
L_8f731c:
	mov_s r1,0x10130ac
L_8f7322:
	bl.d L_8dcba8
L_8f7326:
	mov_s r0,0x20
L_8f7328:
	mov_s r0,0x38
L_8f732a:
	bl.d L_8dbe88
L_8f732e:
	mov_s r1,0x3
	.global L_8f7330
L_8f7330:
	pop_s blink
L_8f7332:
	j_s [blink]
	.global L_8f7334
L_8f7334:
	mov_s r0,blink
L_8f7336:
	mov_s r1,0x1531
L_8f733c:
	bl L_8c9b28
L_8f7340:
	b_s L_8f731c
L_8f7342:
	nop_s
	.global L_8f7344
L_8f7344:
	push_s blink
L_8f7346:
	bl L_8c01dc
L_8f734a:
	mov_s r14,r0
L_8f734c:
	mov_s r16,r1
L_8f734e:
	mov_s r13,r2
L_8f7350:
	add3 r15,r0,0xd
L_8f7354:
	add_s r0,r0,0x68
L_8f7356:
	mov_s r1,r2
L_8f7358:
	bl.d L_8c0380
L_8f735c:
	mov_s r2,0x20
L_8f735e:
	add r4,r14,0x4
L_8f7362:
	mov_s r0,r14
L_8f7364:
	mov_s r1,r16
L_8f7366:
	mov_s r2,r15
L_8f7368:
	bl.d L_8f8948
L_8f736c:
	mov_s r3,0x20
L_8f736e:
	mov_s r0,r14
L_8f7370:
	bl.d L_8f9bd0
L_8f7374:
	mov_s r1,0x2
L_8f7376:
	mov_s r1,0x1012f48
L_8f737c:
	ld r4,[r13, 0xc]
L_8f7380:
	mov_s r0,0x20
L_8f7382:
	mov_s r2,r16
L_8f7384:
	bl.d L_8dcd00
L_8f7388:
	ld_s r3,[r13,0x8]
L_8f738a:
	mov_s r1,0x1012fac
L_8f7390:
	ld r4,[r13, 0x18]
L_8f7394:
	mov_s r0,0x20
L_8f7396:
	ld_s r2,[r13,0x10]
L_8f7398:
	bl.d L_8dcd00
L_8f739c:
	ld_s r3,[r13,0x14]
L_8f739e:
	mov_s r1,0x1013024
L_8f73a4:
	mov_s r0,0x20
L_8f73a6:
	bl.d L_8dcc10
L_8f73aa:
	ld_s r2,[r13,0x1c]
L_8f73ac:
	b L_8c0244
