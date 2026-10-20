/* mac__program_886e0c_20b @ 0x92b6a8, 284 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd__apply_mac_cfg
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, mac__build_qset_mask, mac__replicate_bit_mask
 */
	.section .text.mac__program_886e0c_20b,"ax",@progbits
	.global mac__program_886e0c_20b
mac__program_886e0c_20b:
	.global L_92b6a8
L_92b6a8:
	push_s blink
L_92b6aa:
	bl L_920210
L_92b6ae:
	sub_s sp,sp,0x8
L_92b6b0:
	bl.d L_92bacc
L_92b6b4:
	mov_s r13,r0
L_92b6b6:
	st_s r0,[sp,0x0]
L_92b6b8:
	bl.d L_92b908
L_92b6bc:
	mov_s r0,r13
L_92b6be:
	st_s r0,[sp,0x4]
L_92b6c0:
	ldb_s r14,[r13,0x1]
L_92b6c2:
	mov_s r15,0x886e00
L_92b6c8:
	ldb_s r3,[r13]
L_92b6ca:
	asl_s r14,r14,0x18
L_92b6cc:
	ldb_s r1,[r13,0x5]
L_92b6ce:
	asl_s r3,r3,0x10
L_92b6d0:
	ldb_s r2,[r13,0x4]
L_92b6d2:
	or_s r3,r3,r14
L_92b6d4:
	ldb_s r0,[r13,0x3]
L_92b6d6:
	asl_s r1,r1,0x8
L_92b6d8:
	ldb r4,[r13, 0x6]
L_92b6dc:
	or_s r2,r2,r3
L_92b6de:
	ldb r5,[r13, 0x8]
L_92b6e2:
	or_s r1,r1,r2
L_92b6e4:
	ldb r6,[r13, 0x2]
L_92b6e8:
	asl_s r0,r0,0x8
L_92b6ea:
	ldb r7,[r13, 0x7]
L_92b6ee:
	ldb r9,[r13, 0x9]
L_92b6f2:
	asl r2,r7,0x18
L_92b6f6:
	ldb r8,[r13, 0xb]
L_92b6fa:
	ldb r10,[r13, 0xa]
L_92b6fe:
	st_s r1,[r15,0x8]
L_92b700:
	asl r1,r4,0x10
L_92b704:
	or_s r1,r1,r2
L_92b706:
	or r1,r1,r6
L_92b70a:
	or_s r0,r0,r1
L_92b70c:
	st_s r0,[r15,0xc]
L_92b70e:
	asl r0,r9,0x8
L_92b712:
	or r0,r0,r5
L_92b716:
	asl r1,r10,0x10
L_92b71a:
	or_s r0,r0,r1
L_92b71c:
	asl r1,r8,0x18
L_92b720:
	or_s r0,r0,r1
L_92b722:
	st_s r0,[r15,0x10]
L_92b724:
	ldb_s r2,[r13,0xd]
L_92b726:
	ldb_s r0,[r13,0x12]
L_92b728:
	asl_s r2,r2,0x8
L_92b72a:
	ldb_s r3,[r13,0xc]
L_92b72c:
	asl_s r0,r0,0x10
L_92b72e:
	ldb_s r14,[r13,0xf]
L_92b730:
	or_s r3,r3,r2
L_92b732:
	ldb_s r1,[r13,0x11]
L_92b734:
	or_s r3,r3,r0
L_92b736:
	ldb r4,[r13, 0x13]
L_92b73a:
	asl_s r14,r14,0x8
L_92b73c:
	ldb r5,[r13, 0xe]
L_92b740:
	asl r0,r4,0x18
L_92b744:
	ldb_s r13,[r13,0x10]
L_92b746:
	or r14,r14,r5
L_92b74a:
	asl_s r13,r13,0x10
L_92b74c:
	or_s r0,r0,r3
L_92b74e:
	asl_s r1,r1,0x18
L_92b750:
	or_s r14,r14,r13
L_92b752:
	st_s r0,[r15,0x14]
L_92b754:
	or_s r1,r1,r14
L_92b756:
	st_s r1,[r15,0x18]
L_92b758:
	ld_s r0,[sp,0x0]
L_92b75a:
	or r0,r0,0x35000000
L_92b762:
	mov_s r32,r0
L_92b764:
	st.ab r0,[r25,0x4]
L_92b768:
	bclr r25,r25,0xa
L_92b76c:
	ld_s r0,[sp,0x4]
L_92b76e:
	or r0,r0,0x39000000
L_92b776:
	mov_s r32,r0
L_92b778:
	st.ab r0,[r25,0x4]
L_92b77c:
	bclr r25,r25,0xa
L_92b780:
	mov_s r0,0x38000200
L_92b786:
	mov_s r32,r0
L_92b788:
	st.ab r0,[r25,0x4]
L_92b78c:
	bclr r25,r25,0xa
L_92b790:
	mov_s r0,0x3c000200
L_92b796:
	mov_s r32,r0
L_92b798:
	st.ab r0,[r25,0x4]
L_92b79c:
	bclr r25,r25,0xa
L_92b7a0:
	mov_s r0,0x886e00
L_92b7a6:
	st 0xbe41190,[r0, 0x1c]
L_92b7ae:
	mov_s r0,0x4e00000d
L_92b7b4:
	mov_s r32,r0
L_92b7b6:
	st.ab r0,[r25,0x4]
L_92b7ba:
	bclr r25,r25,0xa
L_92b7be:
	b.d L_92027c
L_92b7c2:
	add_s sp,sp,0x8
