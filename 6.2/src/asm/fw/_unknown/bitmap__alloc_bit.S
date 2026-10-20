/* bitmap__alloc_bit @ 0x8df444, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_calib_sparrow__estimation_alg, calibrate_baseband_gain, deep_sleep_exit, hw_sysapi_rfc_fetch_rgf_util, hwd_rfc_powerup_deep_all_rfs_fw, hwd_rfc_read_calibrate, l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd
 * Зовёт сам: bit_iter__has_more
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bitmap__alloc_bit
bitmap__alloc_bit:
	.global L_8df444
L_8df444:
	push_s blink
L_8df446:
	mov_s r2,r0
L_8df448:
	bl.d L_8cdcc4
L_8df44c:
	mov r1,-0x1
L_8df450:
	cmp_s r0,0x0
L_8df452:
	mov.eq r0,r1
L_8df456:
	beq_s L_8df46e
L_8df458:
	ld_s r1,[r2]
L_8df45a:
	mov_s r0,0x1f
L_8df45c:
	bbit1 r1,0x1f,L_8df468
L_8df460:
	norm r3,r1
L_8df464:
	rsub r0,r3,0x1e
	.global L_8df468
L_8df468:
	bclr r1,r1,r0
L_8df46c:
	st_s r1,[r2]
	.global L_8df46e
L_8df46e:
	pop_s blink
L_8df470:
	j_s [blink]
L_8df472:
	nop_s
