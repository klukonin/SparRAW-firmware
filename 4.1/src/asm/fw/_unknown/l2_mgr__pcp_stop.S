/* l2_mgr__pcp_stop @ 0x8eef70, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   pcp_stop: m_pcp_cnt = %d
 *   l2_mgr::pcp_stop: last PCP removed
 *   pcp_stop MID[%d] not idle, wrong host flow ... IGNORE
 * Зовут его: host_if__wmi_cmd_dispatch, low_sme__handle_rf_kill, wmi_handler_bcon_ctrl
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r14_to_r13_ret, __st_r14_to_r13, bcast_vring__delete, fw_log__emit0, fw_log__emit1, get_g_8000ac_8e15e0, get_g_800243, low_sme__termination_check, mid__state_is_2_or_3, mid_list__by_mid, mid_list__find_by_kind
 */
	.section .text.l2_mgr__pcp_stop,"ax",@progbits
	.global l2_mgr__pcp_stop
l2_mgr__pcp_stop:
	.global L_8eef70
L_8eef70:
	push_s blink
L_8eef72:
	bl L_8c02c4
L_8eef76:
	mov_s r13,r0
L_8eef78:
	bl.d L_8e15e0
L_8eef7c:
	mov_s r0,0x4
L_8eef7e:
	bl.d L_8d73c4
L_8eef82:
	mov_s r0,r13
L_8eef84:
	breq r0,0x0,L_8ef00e
L_8eef88:
	bl.d L_8ca1b0
L_8eef8c:
	mov_s r0,r13
L_8eef8e:
	ldb r3,[gp, 0xd3]
L_8eef92:
	mov_s r14,r0
L_8eef94:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8eef96:
	extb_s r3,r3
L_8eef98:
	stb r3,[gp, 0xd3]
L_8eef9c:
	mov_s r2,0x100dbdc
L_8eefa2:
	mov_s r0,0xb
L_8eefa4:
	bl.d L_8edfcc
L_8eefa8:
	mov_s r1,0x2
L_8eefaa:
	bl L_8d73b8
L_8eefae:
	brne_s r0,0,L_8eefbe
L_8eefb0:
	mov_s r2,0x100dbf8
L_8eefb6:
	mov_s r0,0xb
L_8eefb8:
	bl.d L_8edfb0
L_8eefbc:
	mov_s r1,0x2
	.global L_8eefbe
L_8eefbe:
	mov_s r0,r14
L_8eefc0:
	bl.d L_8ca1f8
L_8eefc4:
	mov_s r1,0x1
L_8eefc6:
	breq_s r0,0,L_8eefd8
L_8eefc8:
	mov_s r2,0x100dc1c
L_8eefce:
	mov_s r0,0xb
L_8eefd0:
	bl.d L_8edfb0
L_8eefd4:
	mov_s r1,0x0
L_8eefd6:
	b_s L_8ef00e
	.global L_8eefd8
L_8eefd8:
	mov_s r0,0xb
L_8eefda:
	bl.d L_8e3a08
L_8eefde:
	mov_s r1,0x0
L_8eefe0:
	bl.d L_8dc660
L_8eefe4:
	mov_s r0,r14
L_8eefe6:
	mov_s r0,r14
L_8eefe8:
	bl.d L_8ca1f8
L_8eefec:
	mov_s r1,0x2
L_8eefee:
	cmp_s r0,0x0
L_8eeff0:
	bl.eq L_8d762c
L_8eeff4:
	mov_s r0,0xc
L_8eeff6:
	bl.d L_8e3a08
L_8eeffa:
	mov_s r1,0x0
L_8eeffc:
	bl.d L_8e426c
L_8ef000:
	mov_s r0,0x2
L_8ef002:
	bl.d L_8ca7dc
L_8ef006:
	mov_s r0,0x1
L_8ef008:
	bl.d L_8c7884
L_8ef00c:
	ldb_s r0,[r0,0x2]
	.global L_8ef00e
L_8ef00e:
	b L_8c0334
L_8ef012:
	nop_s
