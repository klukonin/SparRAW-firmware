/* TX_API__callback_and_release @ 0x8c4ca8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::callback_and_release() - flushing(0x%x)
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 * Зовут его: TX_API__flush_pending_peer_pm_connection
 * Зовёт сам: FWQ_TX_AVAILABILITY__remove_packet, TX_API__free_memory, __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__by_cid, fw_log__emit1, fw_sysassert_fatal, llist__remove
 */
	.section .text.TX_API__callback_and_release,"ax",@progbits
	.global TX_API__callback_and_release
TX_API__callback_and_release:
	.global L_8c4ca8
L_8c4ca8:
	push_s blink
L_8c4caa:
	bl.d L_8c02c0
L_8c4cae:
	mov_s r1,0x2
L_8c4cb0:
	sub_s sp,sp,0x8
L_8c4cb2:
	mov_s r13,r0
L_8c4cb4:
	mov_s r2,0x1014dd0
L_8c4cba:
	mov_s r0,0x7
L_8c4cbc:
	bl.d L_8edfcc
L_8c4cc0:
	mov_s r3,r13
L_8c4cc2:
	mov_s r14,sp
L_8c4cc4:
	breq_s r13,0,L_8c4cfe
	.global L_8c4cc6
L_8c4cc6:
	st_s r13,[r14]
L_8c4cc8:
	add r0,r13,0x1c
L_8c4ccc:
	st_s r0,[r14,0x4]
L_8c4cce:
	mov_s r0,0xff
L_8c4cd0:
	stb_s r0,[r13,0x11]
L_8c4cd2:
	mov_s r0,0x842404
L_8c4cd8:
	bl.d L_8de4ec
L_8c4cdc:
	mov_s r1,r13
L_8c4cde:
	ldb_s r1,[r13,0xb]
L_8c4ce0:
	ldb_s r0,[r13,0xa]
L_8c4ce2:
	bl.d L_8de304
L_8c4ce6:
	bmsk_s r1,r1,0x5
L_8c4ce8:
	ld_s r14,[r13,0x18]
L_8c4cea:
	breq_s r14,0,L_8c4d14
L_8c4cec:
	ld_s r15,[sp,0x4]
L_8c4cee:
	bl.d L_8c9e44
L_8c4cf2:
	ldb_s r0,[r13,0xa]
L_8c4cf4:
	mov_s r2,r0
L_8c4cf6:
	mov_s r0,r15
L_8c4cf8:
	jl_s.d [r14]
L_8c4cfa:
	ldb_s r1,[r13,0x11]
L_8c4cfc:
	b_s L_8c4d1a
	.global L_8c4cfe
L_8c4cfe:
	mov_s r0,blink
L_8c4d00:
	mov_s r2,0x1014d54
L_8c4d06:
	mov_s r1,0x11d6
L_8c4d0c:
	bl.d L_8c82c0
L_8c4d10:
	mov_s r3,0xaa
L_8c4d12:
	b_s L_8c4cc6
	.global L_8c4d14
L_8c4d14:
	bl.d L_8c94c4
L_8c4d18:
	ld_s r0,[sp,0x4]
	.global L_8c4d1a
L_8c4d1a:
	b.d L_8c032c
L_8c4d1e:
	add_s sp,sp,0x8
