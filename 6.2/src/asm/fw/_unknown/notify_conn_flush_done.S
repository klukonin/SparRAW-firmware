/* notify_conn_flush_done @ 0x8df4ac, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   notify_conn_flush_done: m_connection_pending_flush_msk = 0x%x.
 * Зовут его: fwq_tx__on_flush_done
 * Зовёт сам: TX_INTERNAL_API__connection, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, u_schd__cancel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global notify_conn_flush_done
notify_conn_flush_done:
	.global L_8df4ac
L_8df4ac:
	push_s blink
L_8df4ae:
	bl L_8c01e4
L_8df4b2:
	mov_s r13,r0
L_8df4b4:
	ld_s r0,[r0,0x14]
L_8df4b6:
	mov_s r14,r1
L_8df4b8:
	bclr r0,r0,r1
L_8df4bc:
	ld_s r1,[r13]
L_8df4be:
	st_s r0,[r13,0x14]
L_8df4c0:
	ld_s r0,[r1,0x20]
L_8df4c2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df4c4:
	st_s r0,[r1,0x20]
L_8df4c6:
	ld_s r0,[r13,0x14]
L_8df4c8:
	brne_s r0,0,L_8df4d6
L_8df4ca:
	ld_s r0,[r13,0x10]
L_8df4cc:
	breq_s r0,0,L_8df4d6
L_8df4ce:
	bl L_8c8de0
L_8df4d2:
	mov_s r0,0x0
L_8df4d4:
	st_s r0,[r13,0x10]
	.global L_8df4d6
L_8df4d6:
	mov_s r1,0x1018a28
L_8df4dc:
	mov_s r0,0x27
L_8df4de:
	bl.d L_8dcc10
L_8df4e2:
	ld_s r2,[r13,0x14]
L_8df4e4:
	bl.d L_8cb604
L_8df4e8:
	mov_s r0,r14
L_8df4ea:
	b L_8c0254
L_8df4ee:
	nop_s
