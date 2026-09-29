/* TX_API__free_memory @ 0x8c94c4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::free_memory p_tx_metadata=0x%06X, allocated=%d, free=%d
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   TX_API::free_memory skipping mem pool free (FWQ_TX_MEM_POLL_ALLOC_ERR)
 * Зовут его: PS_CONNECTION_MGR__psc_req_tx_wb_cb, PS_CONNECTION_MGR__psc_resp_tx_wb_cb, SW_TX_MGMT_API__packet_release, TX_API__callback_and_release, TX_API__handle_completed_packets, conn_disc_sm__disassoc_sent_cb, mgmt_tx__render_probe_resp, mlme_sm__tx_complete_cb, pcp_bcon_wb, probe_req_tx_wb_cb
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit3, fw_sysassert_fatal, mem_pool__free
 */
	.section .text.TX_API__free_memory,"ax",@progbits
	.global TX_API__free_memory
TX_API__free_memory:
	.global L_8c94c4
L_8c94c4:
	push_s blink
L_8c94c6:
	bl L_8c02c4
L_8c94ca:
	mov.f r13,r0
L_8c94ce:
	sub_s sp,sp,0x8
L_8c94d0:
	mov_s r14,sp
L_8c94d2:
	beq_s L_8c950e
	.global L_8c94d4
L_8c94d4:
	st_s r13,[r14,0x4]
L_8c94d6:
	sub_s r13,r13,0x1c
L_8c94d8:
	st_s r13,[r14]
L_8c94da:
	ld_s r14,[sp,0x0]
L_8c94dc:
	ldb_s r0,[r14,0x11]
L_8c94de:
	cmp r0,0xfd
L_8c94e2:
	beq_s L_8c9524
L_8c94e4:
	mov_s r13,0x8425c0
L_8c94ea:
	mov_s r0,r13
L_8c94ec:
	bl.d L_8c9268
L_8c94f0:
	mov_s r1,r14
L_8c94f2:
	ld r4,[r13, 0xc]
L_8c94f6:
	ld_s r13,[r13,0x10]
L_8c94f8:
	mov_s r2,0x1014d14
L_8c94fe:
	sub r5,r13,r4
L_8c9502:
	mov_s r0,0x7
L_8c9504:
	mov_s r1,0x2
L_8c9506:
	bl.d L_8ee034
L_8c950a:
	mov_s r3,r14
L_8c950c:
	b_s L_8c9532
	.global L_8c950e
L_8c950e:
	mov_s r0,blink
L_8c9510:
	mov_s r2,0x1014d54
L_8c9516:
	mov_s r1,0x11e9
L_8c951c:
	bl.d L_8c82c0
L_8c9520:
	mov_s r3,0xab
L_8c9522:
	b_s L_8c94d4
	.global L_8c9524
L_8c9524:
	mov_s r2,0x1014d88
L_8c952a:
	mov_s r0,0x7
L_8c952c:
	bl.d L_8edfb0
L_8c9530:
	mov_s r1,0x2
	.global L_8c9532
L_8c9532:
	b.d L_8c0334
L_8c9536:
	add_s sp,sp,0x8
