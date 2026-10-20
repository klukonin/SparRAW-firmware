/* l2mgr__send_traffic_resume_evt @ 0x8dc494, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TRAFFIC_RESUME_EVENTID status %d, devid %d
 * Зовут его: wmi_handler_traffic_resume
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit2, hwd_pcie__rgf_882b80, operational_if__alloc_evt, operational_if__send_evt, rgf_reg_88b080
 */
	.section .text.l2mgr__send_traffic_resume_evt,"ax",@progbits
	.global l2mgr__send_traffic_resume_evt
l2mgr__send_traffic_resume_evt:
	.global L_8dc494
L_8dc494:
	push_s blink
L_8dc496:
	bl.d L_8c02c4
L_8dc49a:
	mov_s r1,0x5
L_8dc49c:
	mov_s r13,0x0
L_8dc49e:
	mov_s r2,r13
L_8dc4a0:
	mov_s r3,r13
L_8dc4a2:
	bl.d L_8d6a1c
L_8dc4a6:
	mov_s r4,r13
L_8dc4a8:
	bl.d L_8cee78
L_8dc4ac:
	mov_s r0,r13
L_8dc4ae:
	bl.d L_8ce560
L_8dc4b2:
	mov_s r0,r13
L_8dc4b4:
	bl L_8c2b68
L_8dc4b8:
	mov_s r2,0x1002524
L_8dc4be:
	stb_s r13,[r0]
L_8dc4c0:
	mov_s r14,r0
L_8dc4c2:
	ldb r4,[gp, 0xd1]
L_8dc4c6:
	mov_s r0,0xe
L_8dc4c8:
	mov_s r1,0x2
L_8dc4ca:
	bl.d L_8edff8
L_8dc4ce:
	mov_s r3,r13
L_8dc4d0:
	mov_s r0,r14
L_8dc4d2:
	mov_s r1,0x1905
L_8dc4d8:
	mov_s r2,0x1
L_8dc4da:
	ldb r3,[gp, 0xd1]
L_8dc4de:
	mov_s r4,r13
L_8dc4e0:
	bl.d L_8e0874
L_8dc4e4:
	mov_s r5,r13
L_8dc4e6:
	b L_8c0334
L_8dc4ea:
	nop_s
