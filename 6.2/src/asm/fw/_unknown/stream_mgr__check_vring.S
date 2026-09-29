/* stream_mgr__check_vring @ 0x8caed0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__2, TX_API__free_memory, basic_sm__handle_event, bcn_tx_init_ss_params, conn_mgr__find_reusable_cid, conn_mgr__free_cid_db_element, conn_mgr__ranking_remove, free_dband_info, free_ftm_session, low_sme__check_state_1
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_unsigned, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__check_vring
stream_mgr__check_vring:
	.global L_8caed0
L_8caed0:
	push_s blink
L_8caed2:
	bl L_8c01e4
L_8caed6:
	mov_s r13,r0
L_8caed8:
	ld_s r0,[r0,0xc]
L_8caeda:
	mov_s r14,r1
L_8caedc:
	breq_s r0,0,L_8caf10
	.global L_8caede
L_8caede:
	ld_s r0,[r13,0x4]
L_8caee0:
	rsub r0,r0,r14
L_8caee4:
	bl.d L_8c02d4
L_8caee8:
	ld_s r1,[r13,0x8]
L_8caeea:
	brne_s r1,0,L_8caf1a
	.global L_8caeec
L_8caeec:
	ld_s r0,[r13,0x4]
L_8caeee:
	brlo r14,r0,L_8caf24
L_8caef2:
	ld_s r2,[r13,0x8]
L_8caef4:
	ld_s r1,[r13,0x10]
L_8caef6:
	mulu64 r1,r2
L_8caefa:
	add_s r0,r0,mlo
L_8caefc:
	brhs r14,r0,L_8caf24
	.global L_8caf00
L_8caf00:
	ld_s r0,[r13]
L_8caf02:
	st_s r0,[r14]
L_8caf04:
	ld_s r0,[r13,0xc]
L_8caf06:
	st_s r14,[r13]
L_8caf08:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8caf0a:
	b.d L_8c0254
L_8caf0e:
	st_s r0,[r13,0xc]
	.global L_8caf10
L_8caf10:
	mov_s r0,blink
L_8caf12:
	bl.d L_8c9b28
L_8caf16:
	mov_s r1,0xe7
L_8caf18:
	b_s L_8caede
	.global L_8caf1a
L_8caf1a:
	mov_s r0,blink
L_8caf1c:
	bl.d L_8c9b28
L_8caf20:
	mov_s r1,0xe8
L_8caf22:
	b_s L_8caeec
	.global L_8caf24
L_8caf24:
	mov_s r0,blink
L_8caf26:
	bl.d L_8c9b28
L_8caf2a:
	mov_s r1,0xe9
L_8caf2c:
	b_s L_8caf00
L_8caf2e:
	nop_s
