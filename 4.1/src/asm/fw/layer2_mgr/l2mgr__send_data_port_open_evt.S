/* l2mgr__send_data_port_open_evt @ 0x8f04b0, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DATA_PORT_OPEN_EVENTID for CID %d.
 * Зовут его: l2mgr__data_port_open
 * Зовёт сам: L2MGR__system_state_evt_handler, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, info_flow__run, memset0_words, mid__state_is_2_or_3, mid_list__by_mid, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_data_port_open_evt,"ax",@progbits
	.global l2mgr__send_data_port_open_evt
l2mgr__send_data_port_open_evt:
	.global L_8f04b0
L_8f04b0:
	push_s blink
L_8f04b2:
	bl L_8c02c0
L_8f04b6:
	mov_s r14,r0
L_8f04b8:
	bl.d L_8c2b68
L_8f04bc:
	mov_s r15,r1
L_8f04be:
	mov_s r13,r0
L_8f04c0:
	bl.d L_8c1a78
L_8f04c4:
	mov_s r1,0x4
L_8f04c6:
	stb_s r14,[r13]
L_8f04c8:
	mov_s r2,0x100c65c
L_8f04ce:
	mov_s r0,0xb
L_8f04d0:
	mov_s r1,0x2
L_8f04d2:
	bl.d L_8edfcc
L_8f04d6:
	mov_s r3,r14
L_8f04d8:
	mov_s r0,r13
L_8f04da:
	mov_s r1,0xc3
L_8f04dc:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8f04de:
	mov_s r2,0x4
L_8f04e0:
	mov_s r3,r15
L_8f04e2:
	mov r4,0x0
L_8f04e6:
	bl.d L_8e0874
L_8f04ea:
	mov r5,r4
L_8f04ee:
	mov_s r0,0x6
L_8f04f0:
	bl.d L_8e3a08
L_8f04f4:
	mov_s r1,r14
L_8f04f6:
	mov_s r0,0x80345c
L_8f04fc:
	ld_s r0,[r0,0xc]
L_8f04fe:
	breq_s r0,0,L_8f0516
L_8f0500:
	bl.d L_8ca1b0
L_8f0504:
	mov_s r0,r15
L_8f0506:
	bl.d L_8d73c4
L_8f050a:
	mov_s r0,r15
L_8f050c:
	cmp_s r0,0x0
L_8f050e:
	bl.ne.d L_8d5374
L_8f0512:
	mov.ne r0,r15
	.global L_8f0516
L_8f0516:
	b L_8c032c
L_8f051a:
	nop_s
