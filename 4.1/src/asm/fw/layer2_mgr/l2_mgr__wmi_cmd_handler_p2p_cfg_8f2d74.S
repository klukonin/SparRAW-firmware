/* l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74 @ 0x8f2d74, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_cmd_handler_p2p_cfg - If connected or in GO mode do nothing if the channel same as requested %d.
 *   layer2_mgr.cpp
 *   l2_mgr::wmi_cmd_handler_p2p_cfg - If connected or in GO mode prevent from config to different channel %d.
 * Зовут его: l2_mgr__wmi_cmd_handler_p2p_cfg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_sysassert_fatal, l2mgr__send_p2p_cfg_done, mid_list__any_in_state2, mid_list__by_mid, p2p_cfg
 */
	.section .text.l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74,"ax",@progbits
	.global l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74
l2_mgr__wmi_cmd_handler_p2p_cfg_8f2d74:
	.global L_8f2d74
L_8f2d74:
	push_s blink
L_8f2d76:
	bl L_8c02bc
L_8f2d7a:
	mov_s r14,r0
L_8f2d7c:
	mov_s r16,r1
L_8f2d7e:
	bl.d L_8ca1b0
L_8f2d82:
	mov_s r0,r1
L_8f2d84:
	mov_s r13,r0
L_8f2d86:
	ldb r0,[r0, 0x9c]
L_8f2d8a:
	brne_s r0,0,L_8f2d92
L_8f2d8c:
	bl L_8c307c
L_8f2d90:
	breq_s r0,0,L_8f2dea
	.global L_8f2d92
L_8f2d92:
	bl.d L_8ca1b0
L_8f2d96:
	mov_s r0,r16
L_8f2d98:
	mov.f r15,r0
L_8f2d9c:
	beq_s L_8f2dba
	.global L_8f2d9e
L_8f2d9e:
	ldb r0,[r15, 0x94]
L_8f2da2:
	ldb_s r3,[r14,0x1]
L_8f2da4:
	brne r0,r3,L_8f2dd8
L_8f2da8:
	mov_s r2,0x100cf34
L_8f2dae:
	mov_s r0,0xb
L_8f2db0:
	bl.d L_8edfcc
L_8f2db4:
	mov_s r1,0x2
L_8f2db6:
	mov_s r0,0x0
L_8f2db8:
	b_s L_8f2dd0
	.global L_8f2dba
L_8f2dba:
	mov_s r0,blink
L_8f2dbc:
	mov_s r2,0x100c474
L_8f2dc2:
	mov_s r1,0x40
L_8f2dc4:
	bset_s r1,r1,0xc
L_8f2dc6:
	mov_s r3,0x24
L_8f2dc8:
	bl.d L_8c82c0
L_8f2dcc:
	bset_s r3,r3,0xb
L_8f2dce:
	b_s L_8f2d9e
	.global L_8f2dd0
L_8f2dd0:
	bl.d L_8f033c
L_8f2dd4:
	ldb_s r1,[r13,0x10]
L_8f2dd6:
	b_s L_8f2e04
	.global L_8f2dd8
L_8f2dd8:
	mov_s r2,0x100cfa4
L_8f2dde:
	mov_s r0,0xb
L_8f2de0:
	bl.d L_8edfcc
L_8f2de4:
	mov_s r1,0x1
L_8f2de6:
	mov_s r0,0x1
L_8f2de8:
	b_s L_8f2dd0
	.global L_8f2dea
L_8f2dea:
	ldb r4,[r14]
L_8f2dee:
	mov_s r1,0x1
L_8f2df0:
	cmp r4,0x1
L_8f2df4:
	sub_s.ne r1,r1,r1
L_8f2df6:
	mov_s r0,r13
L_8f2df8:
	add r0,r0,0x234
L_8f2dfc:
	ldb_s r2,[r14,0x1]
L_8f2dfe:
	bl.d L_8ee994
L_8f2e02:
	ldw_s r3,[r14,0x2]
	.global L_8f2e04
L_8f2e04:
	b L_8c0324
