/* l2mgr__send_traffic_deferral_evt @ 0x8dc430, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TRAFFIC_DEFERRAL_EVENTID status %d, devid %d
 * Зовут его: tail_l2mgr__send_traffic_deferral_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__inject_event, fw_log__emit2, operational_if__alloc_evt, operational_if__send_evt, rgf_reg_88b080
 * Глобалы (через gp): 0x800188
 */
	.section .text.l2mgr__send_traffic_deferral_evt,"ax",@progbits
	.global l2mgr__send_traffic_deferral_evt
l2mgr__send_traffic_deferral_evt:
	.global L_8dc430
L_8dc430:
	push_s blink
L_8dc432:
	bl L_8c02c4
L_8dc436:
	mov.f r14,r1
L_8dc43a:
	mov_s r1,0x0
L_8dc43c:
	st.as r1,[gp,-0x18]
L_8dc440:
	st.as r1,[gp,0x6]
L_8dc444:
	beq_s L_8dc456
L_8dc446:
	mov_s r2,r1
L_8dc448:
	mov_s r3,r1
L_8dc44a:
	bl.d L_8d6a1c
L_8dc44e:
	mov_s r4,r1
L_8dc450:
	bl.d L_8cee78
L_8dc454:
	mov_s r0,0x1
	.global L_8dc456
L_8dc456:
	bl L_8c2b68
L_8dc45a:
	mov_s r3,0x1
L_8dc45c:
	cmp_s r14,0x0
L_8dc45e:
	mov_s r13,r0
L_8dc460:
	sub_s.ne r3,r3,r3
L_8dc462:
	stb_s r3,[r13]
L_8dc464:
	mov_s r2,0x10024dc
L_8dc46a:
	ldb r4,[gp, 0xd1]
L_8dc46e:
	mov_s r0,0xe
L_8dc470:
	bl.d L_8edff8
L_8dc474:
	mov_s r1,0x2
L_8dc476:
	mov_s r0,r13
L_8dc478:
	mov_s r1,0x1904
L_8dc47e:
	mov_s r2,0x1
L_8dc480:
	ldb r3,[gp, 0xd1]
L_8dc484:
	mov r4,0x0
L_8dc488:
	bl.d L_8e0874
L_8dc48c:
	mov r5,r4
L_8dc490:
	b L_8c0334
