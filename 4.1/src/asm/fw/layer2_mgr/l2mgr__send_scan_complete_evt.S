/* l2mgr__send_scan_complete_evt @ 0x8f0654, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_ACS_PASSIVE_SCAN_COMPLETE_EVENTID dwell_time=%d, num_scan_channels=%d, res_type=%d
 *   layer2_mgr.cpp
 * Зовут его: scan_mngr__scan_done
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit3, fw_sysassert_fatal, get_g_8000ac_8c5c9c, memcpy_fw, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_scan_complete_evt,"ax",@progbits
	.global l2mgr__send_scan_complete_evt
l2mgr__send_scan_complete_evt:
	.global L_8f0654
L_8f0654:
	push_s blink
L_8f0656:
	bl L_8c02b4
L_8f065a:
	sub_s sp,sp,0x3c
L_8f065c:
	mov_s r15,r0
L_8f065e:
	mov_s r18,r1
L_8f0660:
	mov_s r16,r2
L_8f0662:
	mov_s r13,r3
L_8f0664:
	bl.d L_8c2b68
L_8f0668:
	mov r17,r4
L_8f066c:
	mov_s r14,r0
L_8f066e:
	st r16,[r0]
L_8f0672:
	stb_s r13,[r0,0x6]
L_8f0674:
	mov_s r0,0x3
L_8f0676:
	stw_s r0,[r14,0x4]
L_8f0678:
	stb_s r15,[r14,0x7]
L_8f067a:
	mov_s r0,sp
L_8f067c:
	mov_s r1,0x801ecc
L_8f0682:
	bl.d L_8c0460
L_8f0686:
	mov_s r2,0x3c
L_8f0688:
	mov_s r1,0x0
L_8f068a:
	mov_s r2,r1
L_8f068c:
	b_s L_8f06ac
	.global L_8f068e
L_8f068e:
	asl_s r0,r2,0x2
L_8f0690:
	add1_s r0,r0,r0
L_8f0692:
	ld.a r3,[r0,r17]
L_8f0696:
	breq_s r3,0,L_8f06aa
L_8f0698:
	asl_s r3,r1,0x2
L_8f069a:
	add1_s r3,r3,r3
L_8f069c:
	add_s r3,r3,sp
L_8f069e:
	stb_s r2,[r3]
L_8f06a0:
	ld_s r15,[r0,0x4]
L_8f06a2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f06a4:
	stw_s r15,[r3,0x2]
L_8f06a6:
	ld_s r0,[r0,0x8]
L_8f06a8:
	stb_s r0,[r3,0x1]
	.global L_8f06aa
L_8f06aa:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_8f06ac
L_8f06ac:
	brlo r2,0x5,L_8f068e
L_8f06b0:
	brne r13,r1,L_8f0706
	.global L_8f06b4
L_8f06b4:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8f06b6:
	add1_s r13,r13,r13
L_8f06b8:
	extb_s r13,r13
L_8f06ba:
	add r0,r14,0x8
L_8f06be:
	mov_s r1,sp
L_8f06c0:
	bl.d L_8c0460
L_8f06c4:
	mov_s r2,r13
L_8f06c6:
	ldb r4,[r14, 0x6]
L_8f06ca:
	mov_s r2,0x100d44c
L_8f06d0:
	ldw r5,[r14, 0x4]
L_8f06d4:
	mov_s r0,0xb
L_8f06d6:
	mov_s r1,0x2
L_8f06d8:
	bl.d L_8ee034
L_8f06dc:
	ld_s r3,[r14]
L_8f06de:
	add r2,r13,0x8
L_8f06e2:
	extw_s r2,r2
L_8f06e4:
	mov_s r0,r14
L_8f06e6:
	mov_s r1,0x9005
L_8f06ec:
	mov_s r3,r18
L_8f06ee:
	mov r4,0x0
L_8f06f2:
	bl.d L_8e0874
L_8f06f6:
	mov r5,r4
L_8f06fa:
	bl.d L_8c5c9c
L_8f06fe:
	mov_s r0,0x0
L_8f0700:
	b.d L_8c0314
L_8f0704:
	add_s sp,sp,0x3c
	.global L_8f0706
L_8f0706:
	mov_s r0,blink
L_8f0708:
	mov_s r2,0x100c474
L_8f070e:
	mov_s r1,0x4d
L_8f0710:
	mov_s r3,0x91c
L_8f0716:
	/* bl.d 0x008c82c0 */
	.byte 0xae,0x0b,0xef,0xeb
L_8f071a:
	/* _asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8f071c:
	b_s L_8f06b4
L_8f071e:
	nop_s
