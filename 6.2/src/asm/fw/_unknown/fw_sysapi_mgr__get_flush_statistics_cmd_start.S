/* fw_sysapi_mgr__get_flush_statistics_cmd_start @ 0x8f34fc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_sysapi_mgr::get_flush_statistics_cmd_start: Rejecting sysapi request since previous command is still not completed (prev request_type=%d, new request type=%d)
 * Зовут его: ut_sysapi__flush_stats_start
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, fw_sysapi_mgr__start_sysapi_cmd, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_sysapi_mgr__get_flush_statistics_cmd_start
fw_sysapi_mgr__get_flush_statistics_cmd_start:
	.global L_8f34fc
L_8f34fc:
	push_s blink
L_8f34fe:
	push_s r13
L_8f3500:
	mov_s r13,r0
L_8f3502:
	mov_s r2,r1
L_8f3504:
	bl.d L_8f9a20
L_8f3508:
	mov_s r1,0x7
L_8f350a:
	brne_s r0,0,L_8f351e
L_8f350c:
	ld_s r2,[r13]
L_8f350e:
	mov_s r1,0x10129c0
L_8f3514:
	mov_s r0,0x20
L_8f3516:
	bl.d L_8dcc80
L_8f351a:
	mov_s r3,0x7
L_8f351c:
	b_s L_8f3534
	.global L_8f351e
L_8f351e:
	mov_s r0,0x33558
L_8f3524:
	bl.d L_8c3284
L_8f3528:
	st_s r0,[r13,0x34]
L_8f352a:
	mov_s r1,0x48
L_8f352c:
	mov_s r2,0x4
L_8f352e:
	bl.d L_8e5204
L_8f3532:
	mov_s r3,0x0
	.global L_8f3534
L_8f3534:
	b L_8c025c
