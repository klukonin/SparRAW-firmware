/* brd_if_multi_array__get_block_info @ 0x8c98dc, 368 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    brd_if_multi_array::get_block_info: Access to non-initialized Board File Interface
 *   brd_if_multi_array::get_block_info: Bad arguments
 *   brd_if_multi_array::get_block_info(): Block index =%d exceeeds number of section's blocks = %d
 *   brd_if_multi_array::get_block_info: rf_chip_id=%d should be less than MAX_RF_ARRAYS_NUM=%d
 *   brd_if_multi_array::get_block_info: Block boundary is inconsistent with parent section boundary. block_end=%d, section_end=%d, is_last_block_of_section=%d
 *   brd_if_multi_array.cpp
 *   SYSTEM
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, brd_if__clear_block_info, brd_if__pick_block, brd_if__section_info__print2log, brd_if_multi_array__physical_section_header_u__print2log, fw_div_unsigned, fw_log__emit0, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, stub_ret_8e70d0
 */
	.section .text.brd_if_multi_array__get_block_info,"ax",@progbits
	.global brd_if_multi_array__get_block_info
brd_if_multi_array__get_block_info:
L_8c98dc:
	add_s sp,sp,0x8
	.global fwlog_brd_if_multi_array_get_block_info_Block_
fwlog_brd_if_multi_array_get_block_info_Block_:
L_8c98de:
	nop_s
L_8c98e0:
	push_s blink
L_8c98e2:
	bl L_8c02b0
L_8c98e6:
	mov_s r16,r0
L_8c98e8:
	ld_s r0,[r0,0xc]
L_8c98ea:
	mov_s r15,r2
L_8c98ec:
	mov_s r14,r1
L_8c98ee:
	mov_s r13,r3
L_8c98f0:
	brne_s r0,0,L_8c9904
L_8c98f2:
	mov_s r2,0x10098b0
L_8c98f8:
	mov_s r0,0x0
L_8c98fa:
	bl.d L_8edfb0
L_8c98fe:
	mov_s r1,r0
L_8c9900:
	mov_s r13,0x0
L_8c9902:
	b_s L_8c9a46
	.global L_8c9904
L_8c9904:
	cmp_s r13,0x0
L_8c9906:
	cmp.ne r14,0x0
L_8c990a:
	bne_s L_8c991e
L_8c990c:
	mov_s r2,0x1009904
L_8c9912:
	mov_s r13,0x0
L_8c9914:
	mov_s r0,r13
L_8c9916:
	bl.d L_8edfb0
L_8c991a:
	mov_s r1,r13
L_8c991c:
	b_s L_8c9a46
	.global L_8c991e
L_8c991e:
	bl.d L_8c5a0c
L_8c9922:
	mov_s r0,r13
L_8c9924:
	ld r1,[r16, 0x4]
L_8c9928:
	ld_s r0,[r14,0x8]
L_8c992a:
	add_s r1,r1,0x8
L_8c992c:
	ld r4,[r14, 0x4]
L_8c9930:
	add_s r0,r0,r1
L_8c9932:
	brlo.d r15,r4,L_8c9956
L_8c9936:
	add r17,r0,0x8
L_8c993a:
	mov_s r2,0x1009938
L_8c9940:
	mov_s r0,0x0
L_8c9942:
	mov_s r1,r0
L_8c9944:
	mov_s r3,r15
	.global L_8c9946
L_8c9946:
	bl.d L_8edff8
L_8c994a:
	mov_s r13,r0
L_8c994c:
	mov_s r0,r14
L_8c994e:
	bl.d L_8dcd34
L_8c9952:
	mov_s r1,0x0
L_8c9954:
	b_s L_8c9a46
	.global L_8c9956
L_8c9956:
	mov_s r0,r16
L_8c9958:
	mov_s r1,r15
L_8c995a:
	bl.d L_8c9a4c
L_8c995e:
	ldb r2,[r17]
L_8c9962:
	extb r19,r0
L_8c9966:
	brlt r19,0x1,L_8c997c
L_8c996a:
	mov_s r2,0x1009998
L_8c9970:
	mov_s r0,0x0
L_8c9972:
	mov_s r1,r0
L_8c9974:
	mov_s r3,r19
L_8c9976:
	mov r4,0x1
L_8c997a:
	b_s L_8c9946
	.global L_8c997c
L_8c997c:
	ld r0,[r17]
L_8c9980:
	ld r4,[r14, 0x8]
L_8c9984:
	extb_s r1,r0
L_8c9986:
	cmp_s r1,0x0
L_8c9988:
	mov_s r1,0x1
L_8c998a:
	sub_s.ne r1,r1,r1
L_8c998c:
	cmp_s r1,0x0
L_8c998e:
	sub_s.ne r2,r2,r2
L_8c9990:
	mov.eq r2,r15
L_8c9994:
	lsr_s r0,r0,0x8
L_8c9996:
	bmsk_s r0,r0,0xb
L_8c9998:
	asl r16,r0,0x2
L_8c999c:
	mov_s r3,r16
L_8c999e:
	mulu64 r3,r2
L_8c99a2:
	add r2,r4,0x10
L_8c99a6:
	add r18,r2,mlo
L_8c99aa:
	add2 r3,r18,r0
L_8c99ae:
	ld_s r0,[r14,0xc]
L_8c99b0:
	cmp_s r1,0x0
L_8c99b2:
	add r4,r4,r0
L_8c99b6:
	mov.ne r5,0x1
L_8c99ba:
	bne_s L_8c99ca
L_8c99bc:
	ld_s r0,[r14,0x4]
L_8c99be:
	mov r5,0x1
L_8c99c2:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8c99c4:
	cmp_s r15,r0
L_8c99c6:
	sub.ne r5,r5,r5
	.global L_8c99ca
L_8c99ca:
	brlo r4,r3,L_8c99d8
L_8c99ce:
	cmp r5,0x0
L_8c99d2:
	cmp.ne r3,r4
L_8c99d6:
	beq_s L_8c9a0a
	.global L_8c99d8
L_8c99d8:
	mov_s r2,0x10099f4
L_8c99de:
	mov_s r0,0x0
L_8c99e0:
	bl.d L_8ee034
L_8c99e4:
	mov_s r1,r0
L_8c99e6:
	mov_s r0,r14
L_8c99e8:
	bl.d L_8dcd34
L_8c99ec:
	mov_s r1,0x0
L_8c99ee:
	mov_s r0,r17
L_8c99f0:
	bl.d L_8dcc98
L_8c99f4:
	mov_s r1,0x0
L_8c99f6:
	mov_s r0,blink
L_8c99f8:
	mov_s r2,0x1009220
L_8c99fe:
	mov_s r1,0x1365
L_8c9a04:
	bl.d L_8c82c0
L_8c9a08:
	mov_s r3,0xce
	.global L_8c9a0a
L_8c9a0a:
	ld_s r0,[r14]
L_8c9a0c:
	st_s r15,[r13,0x4]
L_8c9a0e:
	st_s r0,[r13]
L_8c9a10:
	st r19,[r13, 0x8]
L_8c9a14:
	st r16,[r13, 0x14]
L_8c9a18:
	st r18,[r13, 0x10]
L_8c9a1c:
	ld r0,[r17]
L_8c9a20:
	mov_s r1,0x4
L_8c9a22:
	and.f 0x0,r0,0x3000000
L_8c9a2a:
	mov_s r0,0x1
L_8c9a2c:
	sub_s.ne r0,r0,r0
L_8c9a2e:
	add2_s r1,r1,r0
L_8c9a30:
	bl.d L_8c03b4
L_8c9a34:
	mov_s r0,r16
L_8c9a36:
	st_s r0,[r13,0xc]
L_8c9a38:
	bl.d L_8e70d0
L_8c9a3c:
	mov_s r0,r17
L_8c9a3e:
	bl.d L_8e70d4
L_8c9a42:
	mov_s r0,r13
L_8c9a44:
	mov_s r13,0x1
	.global L_8c9a46
L_8c9a46:
	b.d L_8c030c
L_8c9a4a:
	mov_s r0,r13
