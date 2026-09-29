/* wmi_handler_fw_ver @ 0x8d9578, 260 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_FW_VER_EVENTID: %d.%d
 *   [NNL].%d.%d
 *   Number of FW capability bit masks: %d
 *   WMI_FW_VER_EVENTID: FW capability bitmask %d = 0x%08X
 *   WMI_FW_VER_EVENT size: %d bytes
 *   host_if.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1, fw_log__emit2, fw_sysassert_fatal, fw_ver__fill_from_regs, memset0_words, obj__set_vtable_801888
 */
	.section .text.wmi_handler_fw_ver,"ax",@progbits
	.global wmi_handler_fw_ver
wmi_handler_fw_ver:
	.global L_8d9578
L_8d9578:
	push_s blink
L_8d957a:
	bl L_8c02b4
L_8d957e:
	mov_s r17,r0
L_8d9580:
	mov_s r18,r1
L_8d9582:
	mov_s r14,0x0
L_8d9584:
	bl.d L_8c2c38
L_8d9588:
	st.a r14,[sp,-0x8]
L_8d958c:
	mov.f r13,r0
L_8d9590:
	add r15,r0,0xa
L_8d9594:
	beq_s L_8d9664
	.global L_8d9596
L_8d9596:
	mov_s r0,r13
L_8d9598:
	bl.d L_8c1a78
L_8d959c:
	mov_s r1,0xa
L_8d959e:
	add_s r1,r13,0x1
L_8d95a0:
	add_s r2,r13,0x2
L_8d95a2:
	add_s r3,r13,0x4
L_8d95a4:
	bl.d L_8ebccc
L_8d95a8:
	mov_s r0,r13
L_8d95aa:
	mov_s r2,0x100617c
L_8d95b0:
	ldb r4,[r13, 0x1]
L_8d95b4:
	mov_s r0,0x0
L_8d95b6:
	mov_s r1,0x2
L_8d95b8:
	bl.d L_8edff8
L_8d95bc:
	ldb_s r3,[r13]
L_8d95be:
	mov_s r2,0x1006198
L_8d95c4:
	ldw r4,[r13, 0x4]
L_8d95c8:
	mov_s r0,0x0
L_8d95ca:
	mov_s r1,0x2
L_8d95cc:
	bl.d L_8edff8
L_8d95d0:
	ldw_s r3,[r13,0x2]
L_8d95d2:
	mov_s r0,sp
L_8d95d4:
	bl.d L_8ebcbc
L_8d95d8:
	add_s r1,sp,0x4
L_8d95da:
	mov_s r2,0x10061a4
L_8d95e0:
	mov_s r0,0x0
L_8d95e2:
	mov_s r1,0x2
L_8d95e4:
	bl.d L_8edfcc
L_8d95e8:
	ldb_s r3,[sp,0x4]
L_8d95ea:
	ldb_s r0,[sp,0x4]
L_8d95ec:
	brlt r0,0x1,L_8d9622
	.global L_8d95f0
L_8d95f0:
	ld_s r0,[sp,0x0]
L_8d95f2:
	add2 r10,r15,r14
L_8d95f6:
	ld.as r1,[r0,r14]
L_8d95fa:
	mov_s r2,0x10061cc
L_8d9600:
	stw r1,[r10]
L_8d9604:
	lsr_s r1,r1,0x10
L_8d9606:
	stw r1,[r10, 0x2]
L_8d960a:
	ld_s r0,[sp,0x0]
L_8d960c:
	mov_s r1,0x2
L_8d960e:
	ld.as r4,[r0,r14]
L_8d9612:
	mov_s r0,0x0
L_8d9614:
	bl.d L_8edff8
L_8d9618:
	mov_s r3,r14
L_8d961a:
	ldb_s r0,[sp,0x4]
L_8d961c:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d961e:
	brlt r14,r0,L_8d95f0
	.global L_8d9622
L_8d9622:
	stb_s r0,[r13,0x6]
L_8d9624:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8d9626:
	add r16,r0,0xa
L_8d962a:
	extw r16,r16
L_8d962e:
	mov_s r2,0x1006204
L_8d9634:
	mov_s r0,0x0
L_8d9636:
	mov_s r1,0x2
L_8d9638:
	bl.d L_8edfcc
L_8d963c:
	mov_s r3,r16
L_8d963e:
	mov_s r0,r17
L_8d9640:
	mov_s r1,r13
L_8d9642:
	mov_s r2,0x0
L_8d9644:
	mov_s r3,0x9004
L_8d964a:
	mov r4,r16
L_8d964e:
	mov r5,r18
L_8d9652:
	mov r6,0x0
L_8d9656:
	bl.d L_8e0460
L_8d965a:
	mov r7,0x0
L_8d965e:
	b.d L_8c0314
L_8d9662:
	add_s sp,sp,0x8
	.global L_8d9664
L_8d9664:
	mov_s r0,blink
L_8d9666:
	mov_s r2,0x1006224
L_8d966c:
	mov_s r1,0x39
L_8d966e:
	bset_s r1,r1,0xc
L_8d9670:
	bl.d L_8c82c0
L_8d9674:
	mov r3,0x20a
L_8d9678:
	b_s L_8d9596
L_8d967a:
	nop_s
