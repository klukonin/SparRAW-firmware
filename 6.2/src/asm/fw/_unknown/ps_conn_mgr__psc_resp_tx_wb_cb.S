/* ps_conn_mgr__psc_resp_tx_wb_cb @ 0x8e1b30, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PS_CONNECTION_MGR::psc_resp_tx_wb_cb - p_conn is NULL
 * Зовёт сам: TX_API__free_memory, __ld_r13_to_r13_ret, fw_log_emit0, psc_if__psc_resp_tx_wb_cb
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_conn_mgr__psc_resp_tx_wb_cb
ps_conn_mgr__psc_resp_tx_wb_cb:
	.global L_8e1b30
L_8e1b30:
	b.d L_8e1b70
L_8e1b34:
	add_s r0,r0,0x38
L_8e1b36:
	nop_s
L_8e1b38:
	push_s blink
L_8e1b3a:
	push_s r13
L_8e1b3c:
	mov_s r13,r0
L_8e1b3e:
	mov_s r3,r1
L_8e1b40:
	brne_s r2,0,L_8e1b50
L_8e1b42:
	mov_s r1,0x10024c8
L_8e1b48:
	bl.d L_8dcba8
L_8e1b4c:
	mov_s r0,0x2e
L_8e1b4e:
	b_s L_8e1b66
	.global L_8e1b50
L_8e1b50:
	ldb_s r0,[r2,0x8]
L_8e1b52:
	mov_s r1,r13
L_8e1b54:
	mul64 r0,0x88
L_8e1b58:
	add r0,mlo,0x803db0
L_8e1b60:
	bl.d L_8e1b30
L_8e1b64:
	mov_s r2,r3
	.global L_8e1b66
L_8e1b66:
	bl.d L_8cb10c
L_8e1b6a:
	mov_s r0,r13
L_8e1b6c:
	b L_8c025c
