/* fw_sysapi_mgr__mac_ampdu_statistics_cmd_start @ 0x8f6270, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mac_ampdu_statistics_cmd_start: Enter
 *   fw_sysapi_mgr::mac_ampdu_statistics_cmd_start: Rejecting sysapi request since previous command is still not completed (prev request_type=%d, new request type=%d)
 * Зовут его: fw_sysapi__start_ampdu_stats
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, channel_est__clamp_64, fw_log_emit0, fw_log_emit2, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__start_sysapi_cmd, mac_ampdu_statistics_timeout_cb, memset0_words, print_input_filter_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__mac_ampdu_statistics_cmd_start
fw_sysapi_mgr__mac_ampdu_statistics_cmd_start:
	.global L_8f6270
L_8f6270:
	push_s blink
L_8f6272:
	bl L_8c01dc
L_8f6276:
	sub_s sp,sp,0x28
L_8f6278:
	mov_s r13,r0
L_8f627a:
	mov_s r14,r1
L_8f627c:
	mov_s r15,r2
L_8f627e:
	mov_s r16,r3
L_8f6280:
	mov_s r1,0x1012840
L_8f6286:
	bl.d L_8dcba8
L_8f628a:
	mov_s r0,0x20
L_8f628c:
	mov_s r0,r13
L_8f628e:
	mov_s r1,r14
L_8f6290:
	bl.d L_8f7490
L_8f6294:
	mov_s r2,r15
L_8f6296:
	mov_s r0,r13
L_8f6298:
	mov_s r1,0x5
L_8f629a:
	bl.d L_8f9a20
L_8f629e:
	mov_s r2,r16
L_8f62a0:
	brne_s r0,0,L_8f62cc
L_8f62a2:
	mov_s r0,sp
L_8f62a4:
	bl.d L_8c1cd8
L_8f62a8:
	mov_s r1,0x28
L_8f62aa:
	ld_s r2,[r13]
L_8f62ac:
	mov_s r1,0x1012868
L_8f62b2:
	mov_s r0,0x20
L_8f62b4:
	bl.d L_8dcc80
L_8f62b8:
	mov_s r3,0x5
L_8f62ba:
	ld_s r1,[r13,0x20]
L_8f62bc:
	mov_s r2,sp
L_8f62be:
	add r4,r13,0x4
L_8f62c2:
	mov_s r0,r13
L_8f62c4:
	bl.d L_8f8948
L_8f62c8:
	mov_s r3,0x28
L_8f62ca:
	b_s L_8f62f2
	.global L_8f62cc
L_8f62cc:
	ldb_s r0,[r14,0x3]
L_8f62ce:
	mov_s r1,0x84e7e0
L_8f62d4:
	stb_s r0,[r13,0x14]
L_8f62d6:
	mov_s r0,0x1
L_8f62d8:
	st_s r0,[r1,0x38]
L_8f62da:
	mov_s r0,0x0
L_8f62dc:
	st_s r0,[r13,0x34]
L_8f62de:
	mov_s r2,0x363c4
L_8f62e4:
	mov_s r0,r13
L_8f62e6:
	bl.d L_8f9070
L_8f62ea:
	mov_s r1,r15
L_8f62ec:
	bl.d L_8f6370
L_8f62f0:
	mov_s r0,r13
	.global L_8f62f2
L_8f62f2:
	b.d L_8c0244
L_8f62f6:
	add_s sp,sp,0x28
