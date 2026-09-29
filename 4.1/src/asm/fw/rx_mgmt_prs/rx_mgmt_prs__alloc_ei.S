/* rx_mgmt_prs__alloc_ei @ 0x8dc82c, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mgmt_parse failed to allocate EI buffer
 *   rx_mgmt_prs.cpp
 * Зовут его: tail_rx_mgmt_prs__alloc_ei
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit0, fw_sysassert_fatal, log_hexdump, rx_mgmt__find_free_ei, rx_mgmt_prs__parse
 * Глобалы (через gp): 0x8003e0
 */
	.section .text.rx_mgmt_prs__alloc_ei,"ax",@progbits
	.global rx_mgmt_prs__alloc_ei
rx_mgmt_prs__alloc_ei:
L_8dc82c:
	st_s r1,[r0,0x44]
	.global fwlog_mgmt_parse_failed_to_allocate_EI_buffer
fwlog_mgmt_parse_failed_to_allocate_EI_buffer:
L_8dc82e:
	nop_s
	.global L_8dc830
L_8dc830:
	push_s blink
L_8dc832:
	bl L_8c02b8
L_8dc836:
	mov_s r17,r0
L_8dc838:
	mov_s r14,r1
L_8dc83a:
	ld_s r15,[r1,0x30]
L_8dc83c:
	ld r16,[r1, 0x14]
L_8dc840:
	bl.d L_8c2bd0
L_8dc844:
	mov_s r13,0x0
L_8dc846:
	st_s r0,[r14,0xc]
L_8dc848:
	brne_s r0,0,L_8dc86e
L_8dc84a:
	mov_s r2,0x1010d00
L_8dc850:
	mov_s r0,0xd
L_8dc852:
	bl.d L_8edfb0
L_8dc856:
	mov_s r1,r13
L_8dc858:
	mov_s r0,blink
L_8dc85a:
	mov_s r2,0x1010c64
L_8dc860:
	mov_s r1,0xa2
L_8dc862:
	bset_s r1,r1,0xc
L_8dc864:
	bl.d L_8c82c0
L_8dc868:
	mov_s r3,0x3f
L_8dc86a:
	mov_s r0,r13
L_8dc86c:
	b_s L_8dc8e4
	.global L_8dc86e
L_8dc86e:
	ldb r0,[r14, 0x34]
L_8dc872:
	breq_s r0,0,L_8dc88c
L_8dc874:
	breq r0,0x1,L_8dc894
L_8dc878:
	mov_s r0,blink
L_8dc87a:
	mov_s r2,0x1010c64
L_8dc880:
	mov_s r1,0xa3
L_8dc882:
	bset_s r1,r1,0xc
L_8dc884:
	bl.d L_8c82c0
L_8dc888:
	mov_s r3,0x4e
L_8dc88a:
	b_s L_8dc89c
	.global L_8dc88c
L_8dc88c:
	mov_s r13,0x18
L_8dc88e:
	ld_s r0,[r14,0x14]
L_8dc890:
	add_s r0,r0,0x18
L_8dc892:
	b_s L_8dc89a
	.global L_8dc894
L_8dc894:
	ld_s r0,[r14,0x14]
L_8dc896:
	mov_s r13,0xa
L_8dc898:
	add_s r0,r0,0xa
	.global L_8dc89a
L_8dc89a:
	st_s r0,[r14,0x14]
	.global L_8dc89c
L_8dc89c:
	ld_s r1,[r14,0x8]
L_8dc89e:
	ldw_s r0,[r1]
L_8dc8a0:
	lsr_s r0,r0,0x4
L_8dc8a2:
	bmsk_s r0,r0,0x3
L_8dc8a4:
	stw_s r0,[r14,0x2c]
L_8dc8a6:
	ldw_s r0,[r1]
L_8dc8a8:
	lsr_s r0,r0,0x2
L_8dc8aa:
	bmsk_s r0,r0,0x1
L_8dc8ac:
	cmp_s r0,0x3
L_8dc8ae:
	mov.ne r0,r16
L_8dc8b2:
	bl.ne.d L_8c7f90
L_8dc8b6:
	mov.ne r1,r15
L_8dc8ba:
	ld_s r3,[r14,0x30]
L_8dc8bc:
	ld_s r0,[r14,0x8]
L_8dc8be:
	ld_s r1,[r14,0x14]
L_8dc8c0:
	ldw_s r15,[r0]
L_8dc8c2:
	sub_s r3,r3,r13
L_8dc8c4:
	lsr r13,r15,0x4
L_8dc8c8:
	lsr_s r15,r15,0x2
L_8dc8ca:
	mov_s r0,r17
L_8dc8cc:
	ld_s r2,[r14,0xc]
L_8dc8ce:
	bmsk r4,r13,0x3
L_8dc8d2:
	bl.d L_8da284
L_8dc8d6:
	bmsk r5,r15,0x1
L_8dc8da:
	ld_s r0,[gp,0x270]
L_8dc8dc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dc8de:
	st.as r0,[gp,0x9c]
L_8dc8e2:
	mov_s r0,0x1
	.global L_8dc8e4
L_8dc8e4:
	b L_8c031c
