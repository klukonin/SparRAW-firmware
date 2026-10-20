/* TX_API__flush_pending_peer_pm_connection @ 0x8cad48, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::flush_pending_peer_pm_connection for cid=%d
 *   TX_API::flush_pending_peer_pm_connection - marking 0x%x to remove
 *   TX_API::flush_pending_peer_pm_connection iter tx_metadata_p->m_cid=%d
 *   flush_timeout_handler for fwq 0x%X
 * Зовут его: TX_CTRL_API__flush_connection
 * Зовёт сам: TX_API__callback_and_release, __ld_r13_to_r13_ret, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, iter__init, iter__next, list__has_items, tx_api__mask_from_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__flush_pending_peer_pm_connection
TX_API__flush_pending_peer_pm_connection:
	.global L_8cad48
L_8cad48:
	push_s blink
L_8cad4a:
	bl L_8c01dc
L_8cad4e:
	sub_s sp,sp,0x4
L_8cad50:
	mov_s r16,r0
L_8cad52:
	mov_s r1,0x1018250
L_8cad58:
	mov_s r0,0x27
L_8cad5a:
	bl.d L_8dcc10
L_8cad5e:
	mov_s r2,r16
L_8cad60:
	mov_s r15,sp
L_8cad62:
	mov_s r1,0x842148
L_8cad68:
	bl.d L_8e5df4
L_8cad6c:
	mov_s r0,r15
L_8cad6e:
	mov_s r14,0x0
L_8cad70:
	b_s L_8cad80
	.global L_8cad72
L_8cad72:
	mov_s r1,0x1018284
L_8cad78:
	mov_s r0,0x27
L_8cad7a:
	bl.d L_8dcc10
L_8cad7e:
	mov_s r2,r14
	.global L_8cad80
L_8cad80:
	mov_s r13,r14
L_8cad82:
	b_s L_8cadaa
	.global L_8cad84
L_8cad84:
	bl.d L_8df438
L_8cad88:
	mov_s r0,r15
L_8cad8a:
	mov_s r14,r0
L_8cad8c:
	mov_s r1,0x10182c8
L_8cad92:
	mov_s r0,0x27
L_8cad94:
	bl.d L_8dcc10
L_8cad98:
	ldb_s r2,[r14,0xa]
L_8cad9a:
	breq_s r13,0,L_8cada4
L_8cad9c:
	bl.d L_8c5a8c
L_8cada0:
	mov_s r0,r13
L_8cada2:
	mov_s r13,0x0
	.global L_8cada4
L_8cada4:
	ldb_s r0,[r14,0xa]
L_8cada6:
	breq r0,r16,L_8cad72
	.global L_8cadaa
L_8cadaa:
	bl.d L_8cdcb8
L_8cadae:
	mov_s r0,r15
L_8cadb0:
	brne_s r0,0,L_8cad84
L_8cadb2:
	cmp_s r13,0x0
L_8cadb4:
	bl.ne.d L_8c5a8c
L_8cadb8:
	mov.ne r0,r13
L_8cadbc:
	b.d L_8c0244
L_8cadc0:
	add_s sp,sp,0x4
L_8cadc2:
	nop_s
L_8cadc4:
	push_s blink
L_8cadc6:
	push_s r13
L_8cadc8:
	mov_s r13,r0
L_8cadca:
	mov_s r1,0x1018c18
L_8cadd0:
	mov_s r0,0x27
L_8cadd2:
	bl.d L_8dcc10
L_8cadd6:
	mov_s r2,r13
L_8cadd8:
	mov_s r0,0x0
L_8cadda:
	st_s r0,[r13,0x10]
L_8caddc:
	ld_s r0,[r13,0x4c]
L_8cadde:
	ld_s r1,[r0,0xc]
L_8cade0:
	jl_s.d [r1]
L_8cade2:
	mov_s r0,r13
L_8cade4:
	b L_8c025c
L_8cade8:
	b L_8e97f8
