/* conn__update_metric @ 0x8e2370, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__arm_all_retry_timers
 * Зовёт сам: __ld_r13_ret, conn__metric_average, conn__push_metric_sample
 */
	.section .text.conn__update_metric,"ax",@progbits
	.global conn__update_metric
conn__update_metric:
	.global L_8e2370
L_8e2370:
	push_s blink
L_8e2372:
	push_s r13
L_8e2374:
	mov_s r5,r0
L_8e2376:
	add3 r13,r0,0x30
L_8e237a:
	bl.d L_8e23e0
L_8e237e:
	ldb_s r1,[r13,0x6]
L_8e2380:
	bl.d L_8e2428
L_8e2384:
	mov_s r0,r5
L_8e2386:
	b.d L_8c033c
L_8e238a:
	stb_s r0,[r13,0x5]
