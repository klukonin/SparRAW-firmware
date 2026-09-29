/* ba_sm_evt_type @ 0x8d9c4c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    ba_sm_evt_type = %x
 * Зовут его: STREAM_MGR, stream_mgr__addba_req_handler, stream_mgr__addba_rsp_handler, stream_mgr__ba_disable, stream_mgr__delba_handler, stream_mgr__delba_tx_complete, stream_mgr__delete_vring, vring_ba_en__race_check
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_sm__handle_event, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_sm_evt_type
ba_sm_evt_type:
	.global L_8d9c4c
L_8d9c4c:
	push_s blink
L_8d9c4e:
	bl L_8c01d4
L_8d9c52:
	mov_s r13,r0
L_8d9c54:
	mov_s r18,r2
L_8d9c56:
	mov_s r17,r3
L_8d9c58:
	brhs.d r1,0x7,L_8d9c8c
L_8d9c5c:
	mov r16,r4
L_8d9c60:
	ldb.x r1,[0x802448,r1]
L_8d9c68:
	add r0,pcl,0x8
L_8d9c6c:
	add1_s r0,r0,r1
L_8d9c6e:
	j_s [r0]
L_8d9c70:
	mov_s r14,0x0
L_8d9c72:
	b_s L_8d9c9a
L_8d9c74:
	mov_s r14,0x1
L_8d9c76:
	b_s L_8d9c9a
L_8d9c78:
	mov_s r14,0x5
L_8d9c7a:
	b_s L_8d9c9a
L_8d9c7c:
	mov_s r14,0x3
L_8d9c7e:
	b_s L_8d9c9a
L_8d9c80:
	mov_s r14,0x4
L_8d9c82:
	b_s L_8d9c9a
L_8d9c84:
	mov_s r14,0x6
L_8d9c86:
	b_s L_8d9c9a
L_8d9c88:
	mov_s r14,0xa
L_8d9c8a:
	b_s L_8d9c9a
	.global L_8d9c8c
L_8d9c8c:
	mov_s r0,blink
L_8d9c8e:
	mov_s r1,0x129b
L_8d9c94:
	bl.d L_8c9b28
L_8d9c98:
	mov_s r14,0x8
	.global L_8d9c9a
L_8d9c9a:
	mov_s r1,0x1010e48
L_8d9ca0:
	mov_s r0,0x2b
L_8d9ca2:
	bl.d L_8dcc10
L_8d9ca6:
	mov_s r2,r14
L_8d9ca8:
	add r0,r13,0x10
L_8d9cac:
	mov_s r1,r14
L_8d9cae:
	mov_s r2,r18
L_8d9cb0:
	mov_s r3,r17
L_8d9cb2:
	bl.d L_8d9b6c
L_8d9cb6:
	mov r4,r16
L_8d9cba:
	b L_8c0234
L_8d9cbe:
	nop_s
