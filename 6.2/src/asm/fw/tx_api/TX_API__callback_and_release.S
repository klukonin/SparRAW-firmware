/* TX_API__callback_and_release @ 0x8c5a8c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::callback_and_release() - flushing(0x%x)
 * Зовут его: TX_API__flush_pending_peer_pm_connection
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, TX_API__free_memory, __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__by_cid, fw_log_emit1, fw_sysassert_fatal, tx_list__remove
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__callback_and_release
TX_API__callback_and_release:
	.global L_8c5a8c
L_8c5a8c:
	push_s blink
L_8c5a8e:
	bl L_8c01e0
L_8c5a92:
	sub_s sp,sp,0x8
L_8c5a94:
	mov_s r14,r0
L_8c5a96:
	mov_s r1,0x1018220
L_8c5a9c:
	mov_s r0,0x27
L_8c5a9e:
	bl.d L_8dcc10
L_8c5aa2:
	mov_s r2,r14
L_8c5aa4:
	mov_s r13,sp
L_8c5aa6:
	breq_s r14,0,L_8c5aee
	.global L_8c5aa8
L_8c5aa8:
	st_s r14,[r13]
L_8c5aaa:
	add r0,r14,0x24
L_8c5aae:
	st_s r0,[r13,0x4]
L_8c5ab0:
	mov_s r0,0xff
L_8c5ab2:
	stb_s r0,[r14,0x11]
L_8c5ab4:
	mov_s r0,0x842148
L_8c5aba:
	bl.d L_8e2884
L_8c5abe:
	mov_s r1,r14
L_8c5ac0:
	ldb_s r1,[r14,0xb]
L_8c5ac2:
	ldb_s r0,[r14,0xa]
L_8c5ac4:
	bl.d L_8e26a4
L_8c5ac8:
	bmsk_s r1,r1,0x5
L_8c5aca:
	ld_s r2,[r14,0x18]
L_8c5acc:
	breq_s r2,0,L_8c5ad8
L_8c5ace:
	ld_s r0,[r14,0x1c]
L_8c5ad0:
	mov_s r13,0x0
L_8c5ad2:
	jl_s.d [r2]
L_8c5ad4:
	mov_s r1,r13
L_8c5ad6:
	st_s r13,[r14,0x18]
	.global L_8c5ad8
L_8c5ad8:
	ld_s r13,[r14,0x20]
L_8c5ada:
	breq_s r13,0,L_8c5afc
L_8c5adc:
	ld_s r15,[sp,0x4]
L_8c5ade:
	bl.d L_8cbffc
L_8c5ae2:
	ldb_s r0,[r14,0xa]
L_8c5ae4:
	mov_s r2,r0
L_8c5ae6:
	mov_s r0,r15
L_8c5ae8:
	jl_s.d [r13]
L_8c5aea:
	ldb_s r1,[r14,0x11]
L_8c5aec:
	b_s L_8c5b02
	.global L_8c5aee
L_8c5aee:
	mov_s r0,blink
L_8c5af0:
	mov_s r1,0x11d6
L_8c5af6:
	bl L_8c9b28
L_8c5afa:
	b_s L_8c5aa8
	.global L_8c5afc
L_8c5afc:
	bl.d L_8cb10c
L_8c5b00:
	ld_s r0,[sp,0x4]
	.global L_8c5b02
L_8c5b02:
	b.d L_8c024c
L_8c5b06:
	add_s sp,sp,0x8
