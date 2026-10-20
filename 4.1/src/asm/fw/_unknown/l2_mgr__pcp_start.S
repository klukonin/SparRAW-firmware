/* l2_mgr__pcp_start @ 0x8eeec0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::pcp_start: number_of_pcps = %d. is_go %d
 * Зовут его: wmi_handler_bcon_ctrl
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, get_g_8000ac_8e15e0, l2_mgr__pcp_start_flow, mid_list__by_mid
 * Глобалы (через gp): 0x800243, 0x8003d8
 */
	.section .text.l2_mgr__pcp_start,"ax",@progbits
	.global l2_mgr__pcp_start
l2_mgr__pcp_start:
	.global L_8eeec0
L_8eeec0:
	push_s blink
L_8eeec2:
	bl L_8c02bc
L_8eeec6:
	mov_s r16,r0
L_8eeec8:
	mov_s r15,r1
L_8eeeca:
	mov_s r13,r2
L_8eeecc:
	mov_s r14,r3
L_8eeece:
	bl.d L_8e15e0
L_8eeed2:
	mov_s r0,0x3
L_8eeed4:
	mov_s r0,0x9
L_8eeed6:
	bl.d L_8e3a08
L_8eeeda:
	mov_s r1,0x0
L_8eeedc:
	bl.d L_8ca1b0
L_8eeee0:
	mov_s r0,r16
L_8eeee2:
	mov_s r1,r15
L_8eeee4:
	ld.as r2,[gp,0x9a]
L_8eeee8:
	mov_s r3,r13
L_8eeeea:
	bl.d L_8dc544
L_8eeeee:
	mov_s r4,r14
L_8eeef0:
	ldb_s r0,[gp,0xd3]
L_8eeef2:
	mov_s r2,0x100dba8
L_8eeef8:
	add_s r3,r0,0x1
L_8eeefa:
	extb_s r3,r3
L_8eeefc:
	stb r3,[gp, 0xd3]
L_8eef00:
	mov_s r0,0xb
L_8eef02:
	mov_s r1,0x2
L_8eef04:
	bl.d L_8edff8
L_8eef08:
	mov_s r4,r14
L_8eef0a:
	mov_s r0,0xa
L_8eef0c:
	bl.d L_8e3a08
L_8eef10:
	mov_s r1,0x0
L_8eef12:
	b L_8c0324
L_8eef16:
	nop_s
