/* get_g_800450 @ 0x8e243c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_msm__on_own_start_link__unresourced
 * Зовёт сам: mac_parser__build_mac_rule
 * Глобалы (через gp): 0x800450
 */
	.section .text.get_g_800450,"ax",@progbits
	.global get_g_800450
get_g_800450:
	.global L_8e243c
L_8e243c:
	mov_s r1,r0
L_8e243e:
	ld_s r0,[gp,0x2e0]
L_8e2440:
	cmp_s r0,0x0
L_8e2442:
	mov.ne r0,0x1
L_8e2446:
	neg_s r2,r0
L_8e2448:
	add r0,r1,0x10
L_8e244c:
	ldb_s r1,[r1,0x8]
L_8e244e:
	b.d L_8db85c
L_8e2452:
	bmsk_s r2,r2,0x4
