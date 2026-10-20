/* conn__push_metric_sample @ 0x8e23e0, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__update_metric, connection__on_bf_result, connection__update_rs_metric
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.conn__push_metric_sample,"ax",@progbits
	.global conn__push_metric_sample
conn__push_metric_sample:
	.global L_8e23e0
L_8e23e0:
	push_s blink
L_8e23e2:
	bl L_8c02c0
L_8e23e6:
	ldb r2,[r0, 0x60]
L_8e23ea:
	ldb r3,[gp, 0xd4]
L_8e23ee:
	breq r2,r3,L_8e23fa
L_8e23f2:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8e23f4:
	extb_s r2,r2
L_8e23f6:
	stb r2,[r0, 0x60]
	.global L_8e23fa
L_8e23fa:
	ld_s r13,[r0,0x5c]
L_8e23fc:
	add3 r14,r0,0x8
L_8e2400:
	ldb r4,[r14, 0x8]
L_8e2404:
	add_s r13,r13,r1
L_8e2406:
	add r2,r14,r4
L_8e240a:
	ldb_s r15,[r2,0x9]
L_8e240c:
	stb_s r1,[r2,0x9]
L_8e240e:
	sub_s r13,r13,r15
L_8e2410:
	st_s r13,[r0,0x5c]
L_8e2412:
	add r2,r4,0x1
L_8e2416:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8e2418:
	and_s r3,r3,r2
L_8e241a:
	stb_s r3,[r14,0x8]
L_8e241c:
	add r0,r0,0x186
L_8e2420:
	b.d L_8c032c
L_8e2424:
	stb_s r1,[r0]
L_8e2426:
	nop_s
