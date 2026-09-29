/* l2_mgr__pcp_stop @ 0x8f7160, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_stop: m_pcp_cnt = %d
 *   l2_mgr::pcp_stop: last PCP removed
 *   pcp_stop MID[%d] not idle, wrong host flow ... IGNORE
 * Зовут его: low_sme__handle_rf_kill, wmi__host_cmd_dispatch, wmi_pcp_start_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, conn__alloc_and_link__thunk_0_1_0, fw_log_emit0, fw_log_emit1, fw_sysassert_fatal, l2_mgr__has_active_pcp, l2mgr__pending_op_set, low_sme__termination_check, mid__state_is_2_or_3, mid_list__by_mid_fw, mid_list__find_by_kind, pcp_stop__flow
 * Глобалы (через gp): 0x80025a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__pcp_stop
l2_mgr__pcp_stop:
	.global L_8f7160
L_8f7160:
	push_s blink
L_8f7162:
	push_s r13
L_8f7164:
	mov_s r13,r0
L_8f7166:
	bl.d L_8e6358
L_8f716a:
	mov_s r0,0x4
L_8f716c:
	bl.d L_8da488
L_8f7170:
	mov_s r0,r13
L_8f7172:
	breq r0,0x0,L_8f7206
L_8f7176:
	bl.d L_8cc3dc
L_8f717a:
	mov_s r0,r13
L_8f717c:
	mov.f r13,r0
L_8f7180:
	beq_s L_8f71c2
	.global L_8f7182
L_8f7182:
	ldb_s r0,[gp,0xd6]
L_8f7184:
	mov_s r1,0x100f2f8
L_8f718a:
	sub_s r2,r0,0x1
L_8f718c:
	extb_s r2,r2
L_8f718e:
	stb r2,[gp, 0xd6]
L_8f7192:
	bl.d L_8dcc10
L_8f7196:
	mov_s r0,0x2b
L_8f7198:
	bl L_8da47c
L_8f719c:
	brne_s r0,0,L_8f71aa
L_8f719e:
	mov_s r1,0x100f314
L_8f71a4:
	bl.d L_8dcba8
L_8f71a8:
	mov_s r0,0x2b
	.global L_8f71aa
L_8f71aa:
	mov_s r0,r13
L_8f71ac:
	bl.d L_8cc424
L_8f71b0:
	mov_s r1,0x1
L_8f71b2:
	breq_s r0,0,L_8f71d0
L_8f71b4:
	mov_s r1,0x100f338
L_8f71ba:
	bl.d L_8dcba8
L_8f71be:
	mov_s r0,0xb
L_8f71c0:
	b_s L_8f7206
	.global L_8f71c2
L_8f71c2:
	mov_s r0,blink
L_8f71c4:
	mov_s r1,0x16b4
L_8f71ca:
	bl L_8c9b28
L_8f71ce:
	b_s L_8f7182
	.global L_8f71d0
L_8f71d0:
	mov_s r0,0xb
L_8f71d2:
	bl.d L_8e8a14
L_8f71d6:
	mov_s r1,0x0
L_8f71d8:
	bl.d L_8e0878
L_8f71dc:
	mov_s r0,r13
L_8f71de:
	mov_s r0,r13
L_8f71e0:
	bl.d L_8cc424
L_8f71e4:
	mov_s r1,0x2
L_8f71e6:
	cmp_s r0,0x0
L_8f71e8:
	bl.eq L_8da730
L_8f71ec:
	mov_s r0,0xc
L_8f71ee:
	bl.d L_8e8a14
L_8f71f2:
	mov_s r1,0x0
L_8f71f4:
	bl.d L_8e9110
L_8f71f8:
	mov_s r0,0x2
L_8f71fa:
	bl.d L_8cca20
L_8f71fe:
	mov_s r0,0x1
L_8f7200:
	bl.d L_8c8ebc
L_8f7204:
	ldb_s r0,[r0,0x2]
	.global L_8f7206
L_8f7206:
	b L_8c025c
L_8f720a:
	nop_s
