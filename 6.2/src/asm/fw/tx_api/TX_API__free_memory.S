/* TX_API__free_memory @ 0x8cb10c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::free_memory skipping mem pool free (FWQ_TX_MEM_POLL_ALLOC_ERR)
 * Зовут его: SW_TX_MGMT_API__packet_release, TX_API__callback_and_release, TX_API__handle_completed_packets, conn_disc_sm__disassoc_sent_cb, find_main_sm__probe_req_in_search, free_dband_info, handle_packet_splitmac, mgmt_tx__render_probe_resp, pcp_bcon_wb, probe_resp_ind
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal, stream_mgr__check_vring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__free_memory
TX_API__free_memory:
	.global L_8cb10c
L_8cb10c:
	push_s blink
L_8cb10e:
	bl L_8c01e4
L_8cb112:
	mov.f r14,r0
L_8cb116:
	sub_s sp,sp,0x8
L_8cb118:
	mov_s r13,sp
L_8cb11a:
	beq_s L_8cb13a
	.global L_8cb11c
L_8cb11c:
	st_s r14,[r13,0x4]
L_8cb11e:
	sub r14,r14,0x24
L_8cb122:
	st_s r14,[r13]
L_8cb124:
	ld_s r1,[sp,0x0]
L_8cb126:
	ldb_s r0,[r1,0x11]
L_8cb128:
	cmp r0,0xfd
L_8cb12c:
	beq_s L_8cb148
L_8cb12e:
	mov_s r0,0x842304
L_8cb134:
	bl L_8caed0
L_8cb138:
	b_s L_8cb154
	.global L_8cb13a
L_8cb13a:
	mov_s r0,blink
L_8cb13c:
	mov_s r1,0x11e9
L_8cb142:
	bl L_8c9b28
L_8cb146:
	b_s L_8cb11c
	.global L_8cb148
L_8cb148:
	mov_s r1,0x10181d8
L_8cb14e:
	bl.d L_8dcba8
L_8cb152:
	mov_s r0,0x27
	.global L_8cb154
L_8cb154:
	b.d L_8c0254
L_8cb158:
	add_s sp,sp,0x8
L_8cb15a:
	nop_s
