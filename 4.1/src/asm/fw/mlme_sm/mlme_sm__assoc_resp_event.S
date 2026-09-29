/* mlme_sm__assoc_resp_event @ 0x8e97b0, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ASSOC RESP event.
 *   Assoc Res: Vendor specific Passphrase+++++++++++++++++++
 *   mlme_sm.cpp
 *   Assoc Res: NO Vendor specific +++++++++++++++++++
 *   Save Assoc Resp DMG Capabilities len %d
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, log_hexdump, memcpy_fw, mgmt_pkt__release, mlme__parse_wilocity_vs, mlme_notify, u_schd__cancel, u_schd__schedule
 */
	.section .text.mlme_sm__assoc_resp_event,"ax",@progbits
	.global mlme_sm__assoc_resp_event
mlme_sm__assoc_resp_event:
	.byte 0x4f
	.byte 0xeb
	.global fwlog_Assoc_Res_Vendor_specific_Passphrase
fwlog_Assoc_Res_Vendor_specific_Passphrase:
L_8e97b2:
	nop_s
L_8e97b4:
	push_s blink
L_8e97b6:
	bl L_8c02b8
L_8e97ba:
	sub_s sp,sp,0x4
L_8e97bc:
	mov_s r13,r0
L_8e97be:
	ld_s r0,[gp,-0xe8]
L_8e97c0:
	mov_s r14,r1
L_8e97c2:
	mulu64 r0,0x3e8
L_8e97c6:
	mov_s r2,0x100f4b4
L_8e97cc:
	mov_s r0,0xa
L_8e97ce:
	mov r16,mlo
L_8e97d2:
	bl.d L_8edfb0
L_8e97d6:
	mov_s r1,0x2
L_8e97d8:
	ld_s r0,[r13,0x38]
L_8e97da:
	mov r17,0x0
L_8e97de:
	breq_s r0,0,L_8e97e8
L_8e97e0:
	bl L_8c7794
L_8e97e4:
	st r17,[r13, 0x38]
	.global L_8e97e8
L_8e97e8:
	ld_s r0,[r13,0x3c]
L_8e97ea:
	ld_s r15,[r0,0xc]
L_8e97ec:
	add_s r15,r15,0x48
L_8e97ee:
	ld_s r1,[r15,0x8]
L_8e97f0:
	cmp_s r1,0x1
L_8e97f2:
	mov_s r1,0x1
L_8e97f4:
	sub_s.ne r1,r1,r1
L_8e97f6:
	extb.f 0x0,r1
L_8e97fa:
	beq_s L_8e98ba
L_8e97fc:
	ld_s r0,[r0,0x1c]
L_8e97fe:
	brne r0,0x0,L_8e98ba
L_8e9802:
	stw r17,[sp]
L_8e9806:
	breq_s r14,0,L_8e9844
	.global L_8e9808
L_8e9808:
	ld_s r1,[r14,0xc]
L_8e980a:
	ld r0,[r1, 0xa4]
L_8e980e:
	breq_s r0,0,L_8e985c
L_8e9810:
	add r1,r1,0xa0
L_8e9814:
	mov_s r2,sp
L_8e9816:
	bl.d L_8db748
L_8e981a:
	mov_s r0,r15
L_8e981c:
	mov_s r15,r0
L_8e981e:
	ldw r0,[sp]
L_8e9822:
	cmp_s r0,0x0
L_8e9824:
	cmp.ne r15,0x0
L_8e9828:
	beq_s L_8e986a
L_8e982a:
	mov_s r2,0x100f4c8
L_8e9830:
	mov_s r0,0xa
L_8e9832:
	bl.d L_8edfb0
L_8e9836:
	mov_s r1,0x2
L_8e9838:
	mov_s r0,r15
L_8e983a:
	bl.d L_8c7f90
L_8e983e:
	ldw r1,[sp]
L_8e9842:
	b_s L_8e986a
	.global L_8e9844
L_8e9844:
	mov_s r0,blink
L_8e9846:
	mov_s r2,0x100f220
L_8e984c:
	mov_s r1,0x11fc
L_8e9852:
	bl.d L_8c82c0
L_8e9856:
	mov r3,0x1fc
L_8e985a:
	b_s L_8e9808
	.global L_8e985c
L_8e985c:
	mov_s r2,0x100f504
L_8e9862:
	mov_s r0,0xa
L_8e9864:
	bl.d L_8edfb0
L_8e9868:
	mov_s r1,0x2
	.global L_8e986a
L_8e986a:
	ld_s r3,[r14,0xc]
L_8e986c:
	ld_s r15,[r3,0x74]
L_8e986e:
	breq_s r15,0,L_8e98a0
L_8e9870:
	mov_s r2,0x100f538
L_8e9876:
	mov_s r0,0xa
L_8e9878:
	mov_s r1,0x2
L_8e987a:
	bl.d L_8edfcc
L_8e987e:
	ldb r3,[r3, 0x71]
L_8e9882:
	mov_s r0,r15
L_8e9884:
	ld_s r1,[r14,0xc]
L_8e9886:
	bl.d L_8c7f90
L_8e988a:
	ldb r1,[r1, 0x71]
L_8e988e:
	ld_s r0,[r13,0x3c]
L_8e9890:
	mov_s r1,r15
L_8e9892:
	ld_s r2,[r14,0xc]
L_8e9894:
	add r0,r0,0x187
L_8e9898:
	bl.d L_8c0460
L_8e989c:
	ldb r2,[r2, 0x71]
	.global L_8e98a0
L_8e98a0:
	ld_s r0,[r13,0x3c]
L_8e98a2:
	st_s r14,[r13,0x48]
L_8e98a4:
	ld_s r1,[r0,0xc]
L_8e98a6:
	ld_s r0,[r14,0xc]
L_8e98a8:
	ldw r0,[r0, 0xca]
L_8e98ac:
	stb_s r0,[r1,0x8]
L_8e98ae:
	ld_s r1,[r13,0x3c]
L_8e98b0:
	stb r17,[r1, 0x9]
L_8e98b4:
	bl.d L_8c955c
L_8e98b8:
	mov_s r0,r14
	.global L_8e98ba
L_8e98ba:
	mov_s r0,0x2aa3c
L_8e98c0:
	mov_s r1,r13
L_8e98c2:
	mov_s r2,0x0
L_8e98c4:
	mov_s r3,0x1
L_8e98c6:
	mov r4,r16
L_8e98ca:
	mov_s r5,r2
L_8e98cc:
	bl.d L_8dc92c
L_8e98d0:
	mov_s r6,r2
L_8e98d2:
	st_s r0,[r13,0x38]
L_8e98d4:
	ld_s r1,[r13,0x3c]
L_8e98d6:
	mov_s r0,r13
L_8e98d8:
	ldb_s r1,[r1,0x8]
L_8e98da:
	mov_s r2,0x1
L_8e98dc:
	mov_s r3,0x4
L_8e98de:
	bl.d L_8da490
L_8e98e2:
	mov r4,0x0
L_8e98e6:
	b.d L_8c031c
L_8e98ea:
	add_s sp,sp,0x4
