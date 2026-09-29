/* l2_mgr__wmi_cmd_handler_p2p_cfg @ 0x8fb69c, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_p2p_cfg - If connected or in GO mode do nothing if the channel same as requested %d.
 *   l2_mgr::wmi_cmd_handler_p2p_cfg - If connected or in GO mode prevent from config to different channel %d.
 * Зовут его: wmi__p2p_cfg_thunk
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_sysassert_fatal, l2mgr__send_p2p_cfg_done, mid_list__any_in_state2_fw, mid_list__by_mid_fw, p2p_cfg
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_cmd_handler_p2p_cfg
l2_mgr__wmi_cmd_handler_p2p_cfg:
	.global L_8fb69c
L_8fb69c:
	push_s blink
L_8fb69e:
	bl L_8c01dc
L_8fb6a2:
	mov_s r14,r0
L_8fb6a4:
	mov_s r16,r1
L_8fb6a6:
	bl.d L_8cc3dc
L_8fb6aa:
	mov_s r0,r1
L_8fb6ac:
	mov.f r13,r0
L_8fb6b0:
	beq_s L_8fb6e4
	.global L_8fb6b2
L_8fb6b2:
	ldb r0,[r13, 0x9c]
L_8fb6b6:
	brne_s r0,0,L_8fb6be
L_8fb6b8:
	bl L_8c37ac
L_8fb6bc:
	breq_s r0,0,L_8fb718
	.global L_8fb6be
L_8fb6be:
	bl.d L_8cc3dc
L_8fb6c2:
	mov_s r0,r16
L_8fb6c4:
	mov.f r15,r0
L_8fb6c8:
	beq_s L_8fb6f2
	.global L_8fb6ca
L_8fb6ca:
	ldb r0,[r15, 0x94]
L_8fb6ce:
	ldb_s r2,[r14,0x1]
L_8fb6d0:
	brne r0,r2,L_8fb708
L_8fb6d4:
	mov_s r1,0x100dfd0
L_8fb6da:
	bl.d L_8dcc10
L_8fb6de:
	mov_s r0,0x2b
L_8fb6e0:
	mov_s r0,0x0
L_8fb6e2:
	b_s L_8fb700
	.global L_8fb6e4
L_8fb6e4:
	mov_s r0,blink
L_8fb6e6:
	mov_s r1,0x16b9
L_8fb6ec:
	bl L_8c9b28
L_8fb6f0:
	b_s L_8fb6b2
	.global L_8fb6f2
L_8fb6f2:
	mov_s r0,blink
L_8fb6f4:
	mov_s r1,0x1535
L_8fb6fa:
	bl L_8c9b28
L_8fb6fe:
	b_s L_8fb6ca
	.global L_8fb700
L_8fb700:
	bl.d L_8f8684
L_8fb704:
	ldb_s r1,[r13,0x10]
L_8fb706:
	b_s L_8fb732
	.global L_8fb708
L_8fb708:
	mov_s r1,0x100e040
L_8fb70e:
	bl.d L_8dcc10
L_8fb712:
	mov_s r0,0x1b
L_8fb714:
	mov_s r0,0x1
L_8fb716:
	b_s L_8fb700
	.global L_8fb718
L_8fb718:
	ldb r4,[r14]
L_8fb71c:
	mov_s r1,0x1
L_8fb71e:
	cmp r4,0x1
L_8fb722:
	sub_s.ne r1,r1,r1
L_8fb724:
	mov_s r0,r13
L_8fb726:
	add r0,r0,0x234
L_8fb72a:
	ldb_s r2,[r14,0x1]
L_8fb72c:
	bl.d L_8f6d20
L_8fb730:
	ldw_s r3,[r14,0x2]
	.global L_8fb732
L_8fb732:
	b L_8c0244
L_8fb736:
	nop_s
