/* ps_conn_mgr__psc_req_tx_wb_cb @ 0x8e1a18, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION_MGR::psc_req_tx_wb_cb - p_conn is NULL
 * Зовёт сам: TX_API__free_memory, __ld_r13_to_r13_ret, fw_log_emit0, psc_if__psc_req_tx_wb_cb
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_conn_mgr__psc_req_tx_wb_cb
ps_conn_mgr__psc_req_tx_wb_cb:
	.global L_8e1a18
L_8e1a18:
	b.d L_8e1a58
L_8e1a1c:
	add_s r0,r0,0x38
L_8e1a1e:
	nop_s
L_8e1a20:
	push_s blink
L_8e1a22:
	push_s r13
L_8e1a24:
	mov_s r13,r0
L_8e1a26:
	mov_s r3,r1
L_8e1a28:
	brne_s r2,0,L_8e1a38
L_8e1a2a:
	mov_s r1,0x1002490
L_8e1a30:
	bl.d L_8dcba8
L_8e1a34:
	mov_s r0,0x2e
L_8e1a36:
	b_s L_8e1a4e
	.global L_8e1a38
L_8e1a38:
	ldb_s r0,[r2,0x8]
L_8e1a3a:
	mov_s r1,r13
L_8e1a3c:
	mul64 r0,0x88
L_8e1a40:
	add r0,mlo,0x803db0
L_8e1a48:
	bl.d L_8e1a18
L_8e1a4c:
	mov_s r2,r3
	.global L_8e1a4e
L_8e1a4e:
	bl.d L_8cb10c
L_8e1a52:
	mov_s r0,r13
L_8e1a54:
	b L_8c025c
