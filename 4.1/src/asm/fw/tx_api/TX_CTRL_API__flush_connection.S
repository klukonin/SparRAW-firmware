/* TX_CTRL_API__flush_connection @ 0x8c8ebc, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_CTRL_API::flush_connection() for cid %d
 *   tx_api.cpp
 * Зовут его: disassoc_done
 * Зовёт сам: TX_API__flush_pending_peer_pm_connection, TX_API__handle_completed_packets, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fw_sysassert_fatal, fwq_tx__request_flush
 */
	.section .text.TX_CTRL_API__flush_connection,"ax",@progbits
	.global TX_CTRL_API__flush_connection
TX_CTRL_API__flush_connection:
	.global L_8c8ebc
L_8c8ebc:
	push_s blink
L_8c8ebe:
	bl.d L_8c02c4
L_8c8ec2:
	mov_s r1,0x2
L_8c8ec4:
	mov_s r14,r0
L_8c8ec6:
	mov_s r2,0x1014fbc
L_8c8ecc:
	mov_s r0,0x7
L_8c8ece:
	bl.d L_8edfcc
L_8c8ed2:
	mov_s r3,r14
L_8c8ed4:
	mov_s r13,0x0
L_8c8ed6:
	ld_s r0,[gp,-0xc0]
L_8c8ed8:
	bset r13,r13,r14
L_8c8edc:
	tst_s r0,r13
L_8c8ede:
	bne_s L_8c8f06
	.global L_8c8ee0
L_8c8ee0:
	ld_s r0,[gp,-0xc0]
L_8c8ee2:
	or_s r0,r0,r13
L_8c8ee4:
	st.as r0,[gp,-0x30]
L_8c8ee8:
	bl.d L_8c9058
L_8c8eec:
	mov_s r0,r14
L_8c8eee:
	mov_s r13,0x842410
L_8c8ef4:
	mov_s r0,r13
L_8c8ef6:
	bl.d L_8c8f20
L_8c8efa:
	mov_s r1,r14
L_8c8efc:
	bl.d L_8cb2c0
L_8c8f00:
	mov_s r0,r13
L_8c8f02:
	b L_8c0334
	.global L_8c8f06
L_8c8f06:
	mov_s r0,blink
L_8c8f08:
	mov_s r2,0x1014cd4
L_8c8f0e:
	mov_s r1,0x1224
L_8c8f14:
	bl.d L_8c82c0
L_8c8f18:
	mov r3,0x33f
L_8c8f1c:
	b_s L_8c8ee0
L_8c8f1e:
	nop_s
