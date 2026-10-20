/* connection__bf_notify_entry @ 0x8e7530, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, conn__arm_retry_timer, connection__bf_id_at_6c, connection__cmp_bf_id
 * Глобалы (через gp): 0x80025b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__bf_notify_entry
connection__bf_notify_entry:
	.global L_8e7530
L_8e7530:
	push_s blink
L_8e7532:
	push_s r13
L_8e7534:
	mov_s r4,r0
L_8e7536:
	add3 r13,r0,0x30
L_8e753a:
	bl.d L_8e75a4
L_8e753e:
	ldb_s r1,[r13,0xe]
L_8e7540:
	bl.d L_8e75e8
L_8e7544:
	mov_s r0,r4
L_8e7546:
	b.d L_8c025c
L_8e754a:
	stb_s r0,[r13,0xd]
L_8e754c:
	push_s blink
L_8e754e:
	bl L_8c01e4
L_8e7552:
	mov_s r13,r0
L_8e7554:
	mov_s r14,0x0
L_8e7556:
	bl.d L_8e7530
L_8e755a:
	st_s r14,[r0,0x50]
L_8e755c:
	ldb r1,[r13, 0x4d]
L_8e7560:
	ldb_s r0,[gp,0xd7]
L_8e7562:
	cmp_s r1,r0
L_8e7564:
	mov.le r0,r13
L_8e7568:
	bl.le.d L_8e48d0
L_8e756c:
	mov.le r1,r14
L_8e7570:
	b L_8c0254
