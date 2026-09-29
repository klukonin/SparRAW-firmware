/* mids__get_count @ 0x8cc484, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, mids__count_active_conns, scan_mngr__dband_beacon_ind, stream_mgr__ready_step
 * Зовёт сам: ps_cfg__get_byte_8, ps_cfg__get_byte_a
 * Глобалы (через gp): 0x800259
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mids__get_count
mids__get_count:
	.global L_8cc484
L_8cc484:
	j_s.d [blink]
L_8cc486:
	ldb_s r0,[gp,0xd5]
L_8cc488:
	b L_8cb8a4
L_8cc48c:
	b L_8cc660
