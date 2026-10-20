/* fw_log__emit2 @ 0x8edff8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: BUILDER_push_dmg_parameters, CALIB_MNGR__system_state_evt_handler, FWQ_TX_AVAILABILITY__add_packet, FWQ_TX_AVAILABILITY__remove_packet, POWER_MNGR__init, PS_CONNECTION__assoc_ntf, STREAM_MGR, STREAM_MGR__ADD, SW_TX_MGMT_API__link_up_evt, TX_API__handle_completed_packets
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__commit
 */
	.section .text.fw_log__emit2,"ax",@progbits
	.global fw_log__emit2
fw_log__emit2:
	.global L_8edff8
L_8edff8:
	push_s blink
L_8edffa:
	bl.d L_8c02c0
L_8edffe:
	mov_s r5,r2
L_8ee000:
	mov_s r15,0x843900
L_8ee006:
	add_s r2,r15,0x4
L_8ee008:
	ldb_s r2,[r2,r0]
L_8ee00a:
	mov_s r13,r4
L_8ee00c:
	bbit0 r2,r1,L_8ee030
L_8ee010:
	ld_s r14,[r15]
L_8ee012:
	add_s r2,r14,0x2
L_8ee014:
	bmsk_s r2,r2,0x9
L_8ee016:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8ee018:
	add2 r2,r15,r2
L_8ee01c:
	bmsk_s r14,r14,0x9
L_8ee01e:
	st_s r13,[r2,0x14]
L_8ee020:
	add2_s r15,r15,r14
L_8ee022:
	st_s r3,[r15,0x14]
L_8ee024:
	mov_s r2,r5
L_8ee026:
	mov_s r3,0x2
L_8ee028:
	bl.d L_8ee134
L_8ee02c:
	mov r4,0x0
	.global L_8ee030
L_8ee030:
	b L_8c032c
