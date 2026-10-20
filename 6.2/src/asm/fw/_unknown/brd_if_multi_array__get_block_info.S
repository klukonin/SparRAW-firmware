/* brd_if_multi_array__get_block_info @ 0x8cb940, 388 байт.  Сгенерировано gen_asm_tree.py
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
 *   SYSTEM
 * Зовут его: PS_CONNECTION__psc_complete_8e1794, sm_801d64__action_8e175c
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r17_to_r13_ret, __st_r17_to_r13, bitmap__nth_set_bit, brd_if__clear_block_info, brd_if__noop_hook_a, brd_if__noop_hook_b, brd_if__section_info, brd_if_multi_array__physical_section_header_u, fw_divmod_unsigned, fw_log_emit0, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_block_info
brd_if_multi_array__get_block_info:
	.global L_8cb940
L_8cb940:
	push_s blink
L_8cb942:
	push_s r13
L_8cb944:
	sub_s sp,sp,0x8
L_8cb946:
	mov_s r13,r1
L_8cb948:
	mov_s r1,sp
L_8cb94a:
	mov_s r0,0x0
L_8cb94c:
	bl.d L_8e98b4
L_8cb950:
	mov_s r2,r0
L_8cb952:
	brne_s r13,0,L_8cb966
L_8cb954:
	bl.d L_8e98e4
L_8cb958:
	mov_s r0,0x0
L_8cb95a:
	brhs 0x4e20,r0,L_8cb966
L_8cb962:
	ld_s r0,[sp,0x0]
L_8cb964:
	b_s L_8cb970
	.global L_8cb966
L_8cb966:
	bl L_8e9868
L_8cb96a:
	ld_s r1,[sp,0x0]
L_8cb96c:
	asl_s r0,r0,0xa
L_8cb96e:
	add_s r0,r0,r1
	.global L_8cb970
L_8cb970:
	b.d L_8c025c
L_8cb974:
	add_s sp,sp,0x8
L_8cb976:
	nop_s
L_8cb978:
	push_s blink
L_8cb97a:
	bl L_8c01d8
L_8cb97e:
	mov_s r16,r0
L_8cb980:
	ld_s r0,[r0,0x50]
L_8cb982:
	mov_s r15,r2
L_8cb984:
	mov_s r14,r1
L_8cb986:
	mov_s r13,r3
L_8cb988:
	brne_s r0,0,L_8cb99a
L_8cb98a:
	mov_s r1,0x100adb4
L_8cb990:
	bl.d L_8dcba8
L_8cb994:
	mov_s r0,0x0
L_8cb996:
	mov_s r13,0x0
L_8cb998:
	b_s L_8cbabc
	.global L_8cb99a
L_8cb99a:
	cmp_s r13,0x0
L_8cb99c:
	cmp.ne r14,0x0
L_8cb9a0:
	bne_s L_8cb9b2
L_8cb9a2:
	mov_s r1,0x100ae08
L_8cb9a8:
	mov_s r13,0x0
L_8cb9aa:
	bl.d L_8dcba8
L_8cb9ae:
	mov_s r0,r13
L_8cb9b0:
	b_s L_8cbabc
	.global L_8cb9b2
L_8cb9b2:
	bl.d L_8c6790
L_8cb9b6:
	mov_s r0,r13
L_8cb9b8:
	ld r1,[r16, 0x48]
L_8cb9bc:
	ld_s r0,[r14,0x8]
L_8cb9be:
	add_s r1,r1,0x8
L_8cb9c0:
	ld_s r3,[r14,0x4]
L_8cb9c2:
	add_s r0,r0,r1
L_8cb9c4:
	brlo.d r15,r3,L_8cb9e6
L_8cb9c8:
	add r17,r0,0x8
L_8cb9cc:
	mov_s r1,0x100ae3c
L_8cb9d2:
	mov_s r0,0x0
L_8cb9d4:
	mov_s r2,r15
	.global L_8cb9d6
L_8cb9d6:
	bl.d L_8dcc80
L_8cb9da:
	mov_s r13,r0
L_8cb9dc:
	mov_s r0,r14
L_8cb9de:
	bl.d L_8e0fd8
L_8cb9e2:
	mov_s r1,0x0
L_8cb9e4:
	b_s L_8cbabc
	.global L_8cb9e6
L_8cb9e6:
	mov_s r0,r16
L_8cb9e8:
	mov_s r1,r15
L_8cb9ea:
	bl.d L_8cbac4
L_8cb9ee:
	ldb r2,[r17]
L_8cb9f2:
	extb r5,r0
L_8cb9f6:
	brlt r5,0x8,L_8cba08
L_8cb9fa:
	mov_s r1,0x100ae9c
L_8cba00:
	mov_s r0,0x0
L_8cba02:
	mov_s r2,r5
L_8cba04:
	mov_s r3,0x8
L_8cba06:
	b_s L_8cb9d6
	.global L_8cba08
L_8cba08:
	ld r1,[r17]
L_8cba0c:
	mov r4,0x1
L_8cba10:
	extb_s r0,r1
L_8cba12:
	cmp_s r0,0x0
L_8cba14:
	sub.ne r4,r4,r4
L_8cba18:
	cmp r4,0x0
L_8cba1c:
	sub_s.ne r2,r2,r2
L_8cba1e:
	mov.eq r2,r15
L_8cba22:
	lsr_s r1,r1,0x8
L_8cba24:
	bmsk_s r1,r1,0xb
L_8cba26:
	asl_s r0,r1,0x2
L_8cba28:
	ld_s r3,[r14,0x8]
L_8cba2a:
	mulu64 r0,r2
L_8cba2e:
	add r2,r3,0x10
L_8cba32:
	add r6,r2,mlo
L_8cba36:
	add2 r2,r6,r1
L_8cba3a:
	ld_s r1,[r14,0xc]
L_8cba3c:
	cmp r4,0x0
L_8cba40:
	add_s r3,r3,r1
L_8cba42:
	mov.ne r4,0x1
L_8cba46:
	bne_s L_8cba56
L_8cba48:
	ld_s r1,[r14,0x4]
L_8cba4a:
	mov r4,0x1
L_8cba4e:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8cba50:
	cmp_s r15,r1
L_8cba52:
	sub.ne r4,r4,r4
	.global L_8cba56
L_8cba56:
	brlo r3,r2,L_8cba64
L_8cba5a:
	cmp r4,0x0
L_8cba5e:
	cmp.ne r2,r3
L_8cba62:
	beq_s L_8cba84
	.global L_8cba64
L_8cba64:
	mov_s r1,0x100aef8
L_8cba6a:
	mov_s r13,0x0
L_8cba6c:
	bl.d L_8dcd00
L_8cba70:
	mov_s r0,r13
L_8cba72:
	mov_s r0,r14
L_8cba74:
	bl.d L_8e0fd8
L_8cba78:
	mov_s r1,r13
L_8cba7a:
	mov_s r0,r17
L_8cba7c:
	bl.d L_8e0f4c
L_8cba80:
	mov_s r1,r13
L_8cba82:
	b_s L_8cbabc
	.global L_8cba84
L_8cba84:
	ld_s r1,[r14]
L_8cba86:
	st_s r15,[r13,0x4]
L_8cba88:
	st_s r1,[r13]
L_8cba8a:
	st r5,[r13, 0x8]
L_8cba8e:
	st_s r0,[r13,0x14]
L_8cba90:
	st r6,[r13, 0x10]
L_8cba94:
	ld r1,[r17]
L_8cba98:
	mov_s r2,0x1
L_8cba9a:
	and.f 0x0,r1,0x3000000
L_8cbaa2:
	mov_s r1,0x4
L_8cbaa4:
	sub_s.ne r2,r2,r2
L_8cbaa6:
	bl.d L_8c02d4
L_8cbaaa:
	add2_s r1,r1,r2
L_8cbaac:
	st_s r0,[r13,0xc]
L_8cbaae:
	bl.d L_8ebd0c
L_8cbab2:
	mov_s r0,r17
L_8cbab4:
	bl.d L_8ebd10
L_8cbab8:
	mov_s r0,r13
L_8cbaba:
	mov_s r13,0x1
	.global L_8cbabc
L_8cbabc:
	b.d L_8c023c
L_8cbac0:
	mov_s r0,r13
L_8cbac2:
	nop_s
