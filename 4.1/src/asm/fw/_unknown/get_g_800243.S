/* get_g_800243 @ 0x8d73b8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__pcp_stop, l2_mgr__send_pcp_start_status_evt
 * Глобалы (через gp): 0x800243
 */
	.section .text.get_g_800243,"ax",@progbits
	.global get_g_800243
get_g_800243:
	.global L_8d73b8
L_8d73b8:
	ldb_s r0,[gp,0xd3]
L_8d73ba:
	cmp_s r0,0x0
L_8d73bc:
	mov_s r0,0x1
L_8d73be:
	j_s.d [blink]
L_8d73c0:
	sub.le r0,r0,r0
