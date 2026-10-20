/* l2_mgr__link_up_evt @ 0x8eda78, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::link_up_evt() STATUS=%d CID=%d p_conn=0x%x.
 * Зовёт сам: SW_TX_MGMT_API__link_up_evt, __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__link_up_evt, fw_log__emit3, l2mgr__disconnect_done, tail_l2mgr__notify_link_up
 */
	.section .text.l2_mgr__link_up_evt,"ax",@progbits
	.global l2_mgr__link_up_evt
l2_mgr__link_up_evt:
L_8eda78:
	j_s [blink]
	.global fwlog_l2_mgr_link_up_evt_STATUS_d_CID_d_p_conn
fwlog_l2_mgr_link_up_evt_STATUS_d_CID_d_p_conn:
L_8eda7a:
	nop_s
L_8eda7c:
	push_s blink
L_8eda7e:
	bl L_8c02c0
L_8eda82:
	mov_s r15,r0
L_8eda84:
	mov_s r13,r1
L_8eda86:
	ld_s r14,[r0,0x18]
L_8eda88:
	ldb r4,[r0, 0x8]
L_8eda8c:
	mov_s r2,0x100c484
L_8eda92:
	mov_s r0,0xb
L_8eda94:
	mov_s r1,0x2
L_8eda96:
	mov_s r3,r13
L_8eda98:
	bl.d L_8ee034
L_8eda9c:
	mov_s r5,r15
L_8eda9e:
	brne r13,0x1,L_8edab0
L_8edaa2:
	breq_s r14,0,L_8edab0
L_8edaa4:
	mov_s r0,r15
L_8edaa6:
	mov_s r1,0x2
L_8edaa8:
	bl.d L_8eb270
L_8edaac:
	bset_s r1,r1,0x10
L_8edaae:
	b_s L_8edad0
	.global L_8edab0
L_8edab0:
	ld_s r0,[r15,0xc]
L_8edab2:
	mov_s r1,r15
L_8edab4:
	bl.d L_8d7bd4
L_8edab8:
	mov_s r2,r13
L_8edaba:
	mov_s r0,r15
L_8edabc:
	bl.d L_8d7ae0
L_8edac0:
	mov_s r1,r13
L_8edac2:
	cmp_s r14,0x0
L_8edac4:
	mov.ne r0,r15
L_8edac8:
	bl.ne.d L_8d7bdc
L_8edacc:
	mov.ne r1,r13
	.global L_8edad0
L_8edad0:
	b L_8c032c
