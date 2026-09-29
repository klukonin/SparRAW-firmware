/* l2_mgr__high_false_alarm_secondary_lock_cb @ 0x8ebfd0, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::high_false_alarm_secondary_lock_cb()  unlocking radio 0x%x
 *   l2_mgr::high_false_alarm_secondary_lock_cb release secondary. Patish took %d usec
 *   l2_mgr::high_false_alarm_secondary_lock_cb posting check_high_false_alarm_aging_cb
 * Зовёт сам: CALIB_MNGR__system_state_evt_handler, RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit1, fw_read_timer, u_schd__schedule
 * Глобалы (через gp): 0x80034c, 0x800350
 */
	.section .text.l2_mgr__high_false_alarm_secondary_lock_cb,"ax",@progbits
	.global l2_mgr__high_false_alarm_secondary_lock_cb
l2_mgr__high_false_alarm_secondary_lock_cb:
	.byte 0x0f
	.byte 0xea
	.global fwlog_l2_mgr_high_false_alarm_secondary_lock_c
fwlog_l2_mgr_high_false_alarm_secondary_lock_c:
L_8ebfd2:
	nop_s
L_8ebfd4:
	push_s blink
L_8ebfd6:
	bl.d L_8c02c4
L_8ebfda:
	mov_s r0,0x13
L_8ebfdc:
	mov_s r14,r1
L_8ebfde:
	mov_s r13,0x0
L_8ebfe0:
	bl.d L_8e3614
L_8ebfe4:
	mov_s r1,r13
L_8ebfe6:
	mov_s r2,0x100dce0
L_8ebfec:
	mov_s r0,0xc
L_8ebfee:
	mov_s r1,0x2
L_8ebff0:
	bl.d L_8edfcc
L_8ebff4:
	ld.as r3,[gp,-0xf]
L_8ebff8:
	bl.d L_8e54d8
L_8ebffc:
	ld_s r0,[gp,-0x3c]
L_8ebffe:
	bl L_8e4694
L_8ec002:
	mov_s r2,0x100dd24
L_8ec008:
	sub_s r0,r0,r14
L_8ec00a:
	asl_s r3,r0,0x4
L_8ec00c:
	st.as r3,[gp,0x78]
L_8ec010:
	mov_s r0,0xb
L_8ec012:
	bl.d L_8edfcc
L_8ec016:
	mov_s r1,0x2
L_8ec018:
	ld_s r0,[gp,0x1dc]
L_8ec01a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ec01c:
	st.as r0,[gp,0x77]
L_8ec020:
	ld_s r0,[gp,-0x98]
L_8ec022:
	st.as r13,[gp,-0xf]
L_8ec026:
	brne_s r0,0,L_8ec058
L_8ec028:
	mov_s r2,0x100dd78
L_8ec02e:
	mov_s r0,0xb
L_8ec030:
	bl.d L_8edfb0
L_8ec034:
	mov_s r1,0x2
L_8ec036:
	mov_s r0,0x2a1d8
L_8ec03c:
	ld.as r1,[gp,0x77]
L_8ec040:
	mov_s r2,r13
L_8ec042:
	mov_s r3,0x1
L_8ec044:
	mov r4,0x44aa20
L_8ec04c:
	mov_s r5,r13
L_8ec04e:
	bl.d L_8dc92c
L_8ec052:
	mov_s r6,r13
L_8ec054:
	st.as r0,[gp,-0x26]
	.global L_8ec058
L_8ec058:
	b L_8c0334
