/* stream_mgr__delba_tx_complete @ 0x8c8d14, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr::delba_tx_complete after disconnection
 *   stream_mgr::delba_tx_complete p_conn == NULL - called after disconnection
 * Зовёт сам: TX_API__free_memory, __ld_r14_to_r13_ret, __st_r14_to_r13, ba_sm_evt_type, fw_log_emit0, vring_tbl__find_by_tid_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__delba_tx_complete
stream_mgr__delba_tx_complete:
	.global L_8c8d14
L_8c8d14:
	push_s blink
L_8c8d16:
	bl L_8c01e4
L_8c8d1a:
	mov_s r13,r0
L_8c8d1c:
	mov_s r14,r1
L_8c8d1e:
	breq_s r2,0,L_8c8d46
L_8c8d20:
	ldb_s r0,[r13,0x1b]
L_8c8d22:
	lsr_s r0,r0,0x4
L_8c8d24:
	bl.d L_8cce44
L_8c8d28:
	ldb_s r1,[r2,0x8]
L_8c8d2a:
	brne_s r0,0,L_8c8d34
L_8c8d2c:
	mov_s r1,0x1010980
L_8c8d32:
	b_s L_8c8d4c
	.global L_8c8d34
L_8c8d34:
	cmp_s r14,0x0
L_8c8d36:
	mov_s r2,0x1
L_8c8d38:
	sub_s.ne r2,r2,r2
L_8c8d3a:
	mov_s r1,0x2
L_8c8d3c:
	mov_s r3,0x0
L_8c8d3e:
	bl.d L_8d9c4c
L_8c8d42:
	mov_s r4,r3
L_8c8d44:
	b_s L_8c8d52
	.global L_8c8d46
L_8c8d46:
	mov_s r1,0x10109b4
	.global L_8c8d4c
L_8c8d4c:
	bl.d L_8dcba8
L_8c8d50:
	mov_s r0,0x1b
	.global L_8c8d52
L_8c8d52:
	bl.d L_8cb10c
L_8c8d56:
	mov_s r0,r13
L_8c8d58:
	b L_8c0254
