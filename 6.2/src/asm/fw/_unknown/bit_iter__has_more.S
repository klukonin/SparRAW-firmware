/* bit_iter__has_more @ 0x8cdcc4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: basic_calib_sparrow__estimation_alg, bitmap__alloc_bit, calibrate_baseband_gain, deep_sleep_exit, hwd_rfc_powerup_deep_all_rfs_fw, hwd_rfc_read_calibrate, l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bit_iter__has_more
bit_iter__has_more:
	.global L_8cdcc4
L_8cdcc4:
	ld_s r0,[r0]
L_8cdcc6:
	sub.f r0,r0,0x0
L_8cdcca:
	j_s.d [blink]
L_8cdccc:
	mov.ne r0,0x1
