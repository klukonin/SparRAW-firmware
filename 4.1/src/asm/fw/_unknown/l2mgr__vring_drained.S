/* l2mgr__vring_drained @ 0x8e7240, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open, l2mgr__install_key
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, stream_mgr__find_pring_by_cid, tx_macq__is_empty, vring_by_index, vring_is_empty
 */
	.section .text.l2mgr__vring_drained,"ax",@progbits
	.global l2mgr__vring_drained
l2mgr__vring_drained:
	.global L_8e7240
L_8e7240:
	push_s blink
L_8e7242:
	bl L_8c02c4
L_8e7246:
	bl L_8caae0
L_8e724a:
	mov.f r14,r0
L_8e724e:
	beq_s L_8e7276
L_8e7250:
	bl.d L_8cacc0
L_8e7254:
	ldb_s r0,[r14,0x5]
L_8e7256:
	breq_s r0,0,L_8e7276
L_8e7258:
	mov_s r13,0x1
L_8e725a:
	bl.d L_8d7084
L_8e725e:
	mov_s r1,r13
L_8e7260:
	breq_s r0,0,L_8e7272
L_8e7262:
	ldb_s r0,[r14,0x7]
L_8e7264:
	bl.d L_8d16f0
L_8e7268:
	mov_s r1,r13
L_8e726a:
	cmp_s r0,0x0
L_8e726c:
	mov.ne r0,r13
L_8e7270:
	bne_s L_8e7278
	.global L_8e7272
L_8e7272:
	mov_s r0,0x0
L_8e7274:
	b_s L_8e7278
	.global L_8e7276
L_8e7276:
	mov_s r0,0x1
	.global L_8e7278
L_8e7278:
	b L_8c0334
