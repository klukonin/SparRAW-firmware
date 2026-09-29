/* conn_mgr__arm_all_retry_timers @ 0x8e238c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, conn__arm_retry_timer, conn__update_metric
 * Глобалы (через gp): 0x800244
 */
	.section .text.conn_mgr__arm_all_retry_timers,"ax",@progbits
	.global conn_mgr__arm_all_retry_timers
conn_mgr__arm_all_retry_timers:
L_8e238c:
	push_s blink
L_8e238e:
	bl L_8c02c4
L_8e2392:
	mov_s r13,r0
L_8e2394:
	mov_s r14,0x0
L_8e2396:
	bl.d L_8e2370
L_8e239a:
	st_s r14,[r0,0x44]
L_8e239c:
	ldb r1,[r13, 0x41]
L_8e23a0:
	ldb_s r0,[gp,0xd4]
L_8e23a2:
	cmp_s r1,r0
L_8e23a4:
	mov.le r0,r13
L_8e23a8:
	bl.le.d L_8dfc14
L_8e23ac:
	mov.le r1,r14
L_8e23b0:
	b L_8c0334
