/* l2_mgr__send_pcp_start_status_evt @ 0x8f0770, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::send_pcp_start_status_evt(WMI_FW_STATUS_FAILURE): number_of_pcps = %d
 *   l2_mgr::send_pcp_start_status_evt: last PCP removed
 *   <<---- [HOST EVENT] WMI_PCP_STARTED_EVENTID for midid %d, status %d  <ts: %d>.
 * Зовут его: l2_mgr__pcp_start_flow
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_read_timer, get_g_8000ac_8c5c9c, get_g_800243, memset0_words, operational_if__alloc_evt, operational_if__send_evt
 * Глобалы (через gp): 0x800243
 */
	.section .text.l2_mgr__send_pcp_start_status_evt,"ax",@progbits
	.global l2_mgr__send_pcp_start_status_evt
l2_mgr__send_pcp_start_status_evt:
	.global L_8f0770
L_8f0770:
	push_s blink
L_8f0772:
	bl L_8c02c0
L_8f0776:
	mov_s r14,r0
L_8f0778:
	bl.d L_8c2b68
L_8f077c:
	mov_s r15,r1
L_8f077e:
	mov_s r13,r0
L_8f0780:
	brne r14,0x1,L_8f07b0
L_8f0784:
	ldb_s r0,[gp,0xd3]
L_8f0786:
	mov_s r2,0x100d574
L_8f078c:
	sub_s r3,r0,0x1
L_8f078e:
	extb_s r3,r3
L_8f0790:
	stb r3,[gp, 0xd3]
L_8f0794:
	mov_s r0,0xb
L_8f0796:
	bl.d L_8edfcc
L_8f079a:
	mov_s r1,0x1
L_8f079c:
	bl L_8d73b8
L_8f07a0:
	brne_s r0,0,L_8f07b0
L_8f07a2:
	mov_s r2,0x100d5c4
L_8f07a8:
	mov_s r0,0xb
L_8f07aa:
	bl.d L_8edfb0
L_8f07ae:
	mov_s r1,0x2
	.global L_8f07b0
L_8f07b0:
	mov_s r0,r13
L_8f07b2:
	bl.d L_8c1a78
L_8f07b6:
	mov_s r1,0x4
L_8f07b8:
	bl.d L_8e4694
L_8f07bc:
	stb_s r14,[r13]
L_8f07be:
	mov_s r5,r0
L_8f07c0:
	mov_s r2,0x100d5f8
L_8f07c6:
	mov_s r0,0xb
L_8f07c8:
	mov_s r1,0x2
L_8f07ca:
	mov_s r3,r15
L_8f07cc:
	bl.d L_8ee034
L_8f07d0:
	mov_s r4,r14
L_8f07d2:
	mov_s r0,r13
L_8f07d4:
	mov_s r1,0x1918
L_8f07da:
	mov_s r2,0x4
L_8f07dc:
	mov_s r3,r15
L_8f07de:
	mov r4,0x0
L_8f07e2:
	bl.d L_8e0874
L_8f07e6:
	mov r5,r4
L_8f07ea:
	bl.d L_8c5c9c
L_8f07ee:
	mov_s r0,0x3
L_8f07f0:
	b L_8c032c
