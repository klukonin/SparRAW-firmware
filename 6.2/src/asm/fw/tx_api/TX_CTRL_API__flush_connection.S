/* TX_CTRL_API__flush_connection @ 0x8cabc4, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_CTRL_API::flush_connection() for cid %d
 * Зовут его: conn_disc_sm__disassoc_sent_cb
 * Зовёт сам: TX_API__flush_pending_peer_pm_connection, TX_API__handle_completed_packets, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal, fwq_tx__request_flush
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_CTRL_API__flush_connection
TX_CTRL_API__flush_connection:
	.global L_8cabc4
L_8cabc4:
	push_s blink
L_8cabc6:
	bl L_8c01e4
L_8cabca:
	mov_s r13,r0
L_8cabcc:
	mov_s r1,0x101835c
L_8cabd2:
	mov_s r0,0x27
L_8cabd4:
	bl.d L_8dcc10
L_8cabd8:
	mov_s r2,r13
L_8cabda:
	mov_s r14,0x0
L_8cabdc:
	ld_s r0,[gp,-0xd0]
L_8cabde:
	bset r14,r14,r13
L_8cabe2:
	tst_s r0,r14
L_8cabe4:
	bne_s L_8cac0c
	.global L_8cabe6
L_8cabe6:
	ld_s r0,[gp,-0xd0]
L_8cabe8:
	or_s r0,r0,r14
L_8cabea:
	st.as r0,[gp,-0x34]
L_8cabee:
	bl.d L_8cad48
L_8cabf2:
	mov_s r0,r13
L_8cabf4:
	mov_s r14,0x842154
L_8cabfa:
	mov_s r0,r14
L_8cabfc:
	bl.d L_8cac1c
L_8cac00:
	mov_s r1,r13
L_8cac02:
	bl.d L_8cd5dc
L_8cac06:
	mov_s r0,r14
L_8cac08:
	b L_8c0254
	.global L_8cac0c
L_8cac0c:
	mov_s r0,blink
L_8cac0e:
	mov_s r1,0x1224
L_8cac14:
	bl L_8c9b28
L_8cac18:
	b_s L_8cabe6
L_8cac1a:
	nop_s
