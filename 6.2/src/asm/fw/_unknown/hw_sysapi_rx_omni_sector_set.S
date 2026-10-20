/* hw_sysapi_rx_omni_sector_set @ 0x8ce40c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_sysapi_rx_omni_sector_set(): sector = %d
 *   sector [%d] is not valid [0..%d[
 *   hw_sysapi_channel_switch_set_freq_ratio locked secondary. handle: 0x%X
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler, conn_main_sm__bcon_rx_timeout_evt, mid__link_acquis_step, scan_mngr__set_rx_omni_sector
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, hw_sysapi_rx__alloc_and_store, hwm_analog_channel_switch, radio_mgr__call_method_10
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_rx_omni_sector_set
hw_sysapi_rx_omni_sector_set:
	.global L_8ce40c
L_8ce40c:
	push_s blink
L_8ce40e:
	push_s r13
L_8ce410:
	mov_s r13,r0
L_8ce412:
	mov_s r1,0x101a510
L_8ce418:
	mov_s r0,0x25
L_8ce41a:
	bl.d L_8dcc10
L_8ce41e:
	mov_s r2,r13
L_8ce420:
	mov_s r1,0x8042c8
L_8ce426:
	mov_s r0,r1
L_8ce428:
	add r0,r0,0x400
L_8ce42c:
	ldw r2,[r0, 0x66]
L_8ce430:
	brlo r13,r2,L_8ce444
L_8ce434:
	mov_s r1,0x101a53c
L_8ce43a:
	bl.d L_8dcc10
L_8ce43e:
	mov_s r0,0x5
L_8ce440:
	mov_s r0,0x0
L_8ce442:
	b_s L_8ce452
	.global L_8ce444
L_8ce444:
	stb r13,[r0, 0x64]
L_8ce448:
	ldb_s r0,[r1]
L_8ce44a:
	bl.d L_8dbb04
L_8ce44e:
	mov_s r1,r13
L_8ce450:
	mov_s r0,0x1
	.global L_8ce452
L_8ce452:
	b L_8c025c
L_8ce456:
	nop_s
L_8ce458:
	push_s blink
L_8ce45a:
	bl L_8c01e4
L_8ce45e:
	mov_s r14,r0
L_8ce460:
	mov_s r13,r1
L_8ce462:
	mov_s r1,0x101a560
L_8ce468:
	mov_s r0,0x25
L_8ce46a:
	bl.d L_8dcc10
L_8ce46e:
	mov_s r2,r14
L_8ce470:
	ld_s r0,[r13]
L_8ce472:
	ld_s r1,[r13,0x4]
L_8ce474:
	bl.d L_8d73f4
L_8ce478:
	ld_s r2,[r13,0x8]
L_8ce47a:
	bl.d L_8ea800
L_8ce47e:
	mov_s r0,r14
L_8ce480:
	b L_8c0254
