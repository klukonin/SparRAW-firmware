/* get_g_800242 @ 0x8ca258, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8f1908, l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, scan_mngr__dband_beacon_ind
 * Глобалы (через gp): 0x800242
 */
	.section .text.get_g_800242,"ax",@progbits
	.global get_g_800242
get_g_800242:
	.global L_8ca258
L_8ca258:
	j_s.d [blink]
L_8ca25a:
	ldb_s r0,[gp,0xd2]
