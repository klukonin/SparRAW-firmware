/* brd_if_multi_array__get_chunk_8cbbc4 @ 0x8cbbc4, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_chunk: Access to non-initialized Board File Interface
 *   brd_if_multi_array::get_chunk: Bad arguments
 *   SYSTEM
 * Зовут его: fwq_tx__add_packet, fwq_tx__enable_queue, fwq_tx__flush_by_prio
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r17_to_r13_ret, __ld_r19_to_r13_ret, __st_r17_to_r13, __st_r19_to_r13, brd_if__section_info_reset_thunk, brd_if_multi_array__get_chunk_in_address_data_pairs_format, brd_if_multi_array__get_chunk_in_data_only_format, div_round_up, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_chunk_8cbbc4
brd_if_multi_array__get_chunk_8cbbc4:
	.global L_8cbbc4
L_8cbbc4:
	push_s blink
L_8cbbc6:
	push_s r13
L_8cbbc8:
	mov_s r13,0x0
L_8cbbca:
	breq_s r1,0,L_8cbbe0
L_8cbbcc:
	breq r1,0x1,L_8cbbe4
L_8cbbd0:
	mov_s r0,blink
L_8cbbd2:
	mov_s r1,0x120f
L_8cbbd8:
	bl L_8c9b28
L_8cbbdc:
	mov_s r0,r13
L_8cbbde:
	b_s L_8cbbe6
	.global L_8cbbe0
L_8cbbe0:
	add_s r0,r0,0x18
L_8cbbe2:
	b_s L_8cbbe6
	.global L_8cbbe4
L_8cbbe4:
	add_s r0,r0,0x24
	.global L_8cbbe6
L_8cbbe6:
	b L_8c025c
L_8cbbea:
	nop_s
L_8cbbec:
	push_s blink
L_8cbbee:
	bl L_8c01d8
L_8cbbf2:
	sub_s sp,sp,0x28
L_8cbbf4:
	mov_s r16,r0
L_8cbbf6:
	mov_s r15,r1
L_8cbbf8:
	mov_s r14,r2
L_8cbbfa:
	mov_s r13,0x0
L_8cbbfc:
	mov_s r0,sp
L_8cbbfe:
	mov_s r17,r0
L_8cbc00:
	bl.d L_8c18d0
L_8cbc04:
	mov_s r1,r13
L_8cbc06:
	asl_s r15,r15
L_8cbc08:
	add_s r0,r15,0x3
L_8cbc0a:
	st_s r0,[sp,0x18]
L_8cbc0c:
	/* add_s r15,0x2 */
	.byte 0x02,0xe7
L_8cbc0e:
	st_s r15,[sp,0x1c]
L_8cbc10:
	st_s r14,[sp,0x20]
L_8cbc12:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cbc14:
	st_s r14,[sp,0x24]
L_8cbc16:
	mov_s r14,r13
L_8cbc18:
	b_s L_8cbc24
	.global L_8cbc1a
L_8cbc1a:
	ldb_s r1,[sp,0x14]
L_8cbc1c:
	ld_s r0,[r15,0x20]
L_8cbc1e:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cbc20:
	stb_s r1,[r0]
L_8cbc22:
	extw_s r14,r14
	.global L_8cbc24
L_8cbc24:
	brhs r14,0x2,L_8cbc40
L_8cbc28:
	ld r0,[r16, 0x44]
L_8cbc2c:
	add2 r15,sp,r14
L_8cbc30:
	ld_s r3,[r0,0x8]
L_8cbc32:
	mov_s r0,r16
L_8cbc34:
	ld_s r1,[r15,0x18]
L_8cbc36:
	jl_s.d [r3]
L_8cbc38:
	mov_s r2,r17
L_8cbc3a:
	mov.f r13,r0
L_8cbc3e:
	bne_s L_8cbc1a
	.global L_8cbc40
L_8cbc40:
	mov_s r0,r13
L_8cbc42:
	b.d L_8c023c
L_8cbc46:
	add_s sp,sp,0x28
L_8cbc48:
	push_s blink
L_8cbc4a:
	bl L_8c01d0
L_8cbc4e:
	mov_s r15,r0
L_8cbc50:
	mov_s r13,r1
L_8cbc52:
	mov_s r14,r2
L_8cbc54:
	mov_s r16,r3
L_8cbc56:
	ld_s r0,[r0,0x50]
L_8cbc58:
	mov r17,r5
L_8cbc5c:
	mov r18,r4
L_8cbc60:
	mov r19,r6
L_8cbc64:
	brne_s r0,0,L_8cbc76
L_8cbc66:
	mov_s r1,0x100b21c
	.global L_8cbc6c
L_8cbc6c:
	mov_s r13,0x0
L_8cbc6e:
	bl.d L_8dcba8
L_8cbc72:
	mov_s r0,r13
L_8cbc74:
	b_s L_8cbcd0
	.global L_8cbc76
L_8cbc76:
	cmp r18,0x0
L_8cbc7a:
	cmp.ne r17,0x0
L_8cbc7e:
	cmp.ne r13,0x0
L_8cbc82:
	cmp.ne r14,0x0
L_8cbc86:
	beq_s L_8cbc94
L_8cbc88:
	mov_s r0,r14
L_8cbc8a:
	bl.d L_8cbea0
L_8cbc8e:
	mov_s r1,r17
L_8cbc90:
	brhs r0,r16,L_8cbc9c
	.global L_8cbc94
L_8cbc94:
	mov_s r1,0x100b26c
L_8cbc9a:
	b_s L_8cbc6c
	.global L_8cbc9c
L_8cbc9c:
	ld_s r1,[r15,0x48]
L_8cbc9e:
	ld_s r0,[r13,0x8]
L_8cbca0:
	add_s r1,r1,0x8
L_8cbca2:
	add_s r0,r0,0x8
L_8cbca4:
	ld_s r0,[r0,r1]
L_8cbca6:
	mov_s r2,r14
L_8cbca8:
	and.f 0x0,r0,0x3000000
L_8cbcb0:
	mov_s r0,r15
L_8cbcb2:
	mov_s r1,r13
L_8cbcb4:
	mov_s r3,r16
L_8cbcb6:
	mov r4,r18
L_8cbcba:
	mov r5,r17
L_8cbcbe:
	mov r6,r19
L_8cbcc2:
	bne_s L_8cbcca
L_8cbcc4:
	bl L_8cbcd8
L_8cbcc8:
	b_s L_8cbcce
	.global L_8cbcca
L_8cbcca:
	bl L_8cbd80
	.global L_8cbcce
L_8cbcce:
	mov_s r13,r0
	.global L_8cbcd0
L_8cbcd0:
	b.d L_8c022c
L_8cbcd4:
	mov_s r0,r13
L_8cbcd6:
	nop_s
