/* l2mgr__disconnect_sta @ 0x8c93a0, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Disconnect not-exist STA
 * Зовут его: l2mgr__data_port_open_and_keys, wmi_disconnect_sta
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit0, fw_sysassert_fatal, l2mgr__pending_op_set, l2mgr__send_disconnect_evt, mid__disconnect_cmd, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__disconnect_sta
l2mgr__disconnect_sta:
	.global L_8c93a0
L_8c93a0:
	push_s blink
L_8c93a2:
	bl L_8c01d4
L_8c93a6:
	mov_s r17,r0
L_8c93a8:
	mov_s r16,r1
L_8c93aa:
	mov_s r18,r2
L_8c93ac:
	bl.d L_8e6358
L_8c93b0:
	mov_s r0,0x2
L_8c93b2:
	bl.d L_8cc3dc
L_8c93b6:
	mov_s r0,r17
L_8c93b8:
	mov.f r13,r0
L_8c93bc:
	beq_s L_8c93e6
	.global L_8c93be
L_8c93be:
	mov_s r0,r13
L_8c93c0:
	bl.d L_8cc024
L_8c93c4:
	mov_s r1,r16
L_8c93c6:
	mov.f r1,r0
L_8c93ca:
	bne_s L_8c93f4
L_8c93cc:
	mov_s r1,0x100d5a8
L_8c93d2:
	bl.d L_8dcba8
L_8c93d6:
	mov_s r0,0x1b
L_8c93d8:
	mov_s r0,r16
L_8c93da:
	mov_s r1,0x1
L_8c93dc:
	mov_s r2,0x2
L_8c93de:
	bl.d L_8e538c
L_8c93e2:
	mov_s r3,r17
L_8c93e4:
	b_s L_8c93fe
	.global L_8c93e6
L_8c93e6:
	mov_s r0,blink
L_8c93e8:
	mov_s r1,0x11e1
L_8c93ee:
	bl L_8c9b28
L_8c93f2:
	b_s L_8c93be
	.global L_8c93f4
L_8c93f4:
	mov_s r0,r13
L_8c93f6:
	mov_s r2,0x2
L_8c93f8:
	bl.d L_8c9360
L_8c93fc:
	mov_s r3,r18
	.global L_8c93fe
L_8c93fe:
	b L_8c0234
L_8c9402:
	nop_s
