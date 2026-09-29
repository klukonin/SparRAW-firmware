/* sm_pring__bind_vring @ 0x8c49a0, 584 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Connect - Queue is not empty: Call 911!!!
 *   PTP Availibilty = %x m_vring_index %d (%d)!!!
 * Зовут его: bitmap__expand_byte4_to_list, sm_pring__notify_vring_state, vring_schd__bind_if_free
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r21_to_r13_ret, __st_r15_to_r13, __st_r21_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit0, fw_log_emit3, fw_sysassert_fatal, hwd_dma__get_rings_with_data, hwd_dma__read_8813c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__bind_vring
sm_pring__bind_vring:
	.global L_8c49a0
L_8c49a0:
	push_s blink
L_8c49a2:
	bl L_8c01c8
L_8c49a6:
	mov_s r14,r0
L_8c49a8:
	mov_s r13,r1
L_8c49aa:
	mov.f r18,r2
L_8c49ae:
	mov_s r21,r3
L_8c49b0:
	mov r20,r4
L_8c49b4:
	mov_s r15,r5
L_8c49b6:
	beq_s L_8c4a2a
	.global L_8c49b8
L_8c49b8:
	ld_s r0,[r14,0x1c]
L_8c49ba:
	brne r0,0x0,L_8c4a38
	.global L_8c49be
L_8c49be:
	brhs r13,0x1f,L_8c4a46
	.global L_8c49c2
L_8c49c2:
	mov_s r0,0x0
L_8c49c4:
	mov_s r17,r0
L_8c49c6:
	st_s r0,[r14,0xc]
L_8c49c8:
	add r0,r13,0x805140
L_8c49d0:
	ldb_s r1,[r0]
L_8c49d2:
	mov_s r16,r0
L_8c49d4:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c49d6:
	extb_s r1,r1
L_8c49d8:
	stb_s r1,[r0]
L_8c49da:
	brne r1,0xa,L_8c4a12
L_8c49de:
	bl L_8d078c
L_8c49e2:
	mov_s r0,0x886f80
L_8c49e8:
	ld_s r0,[r0,0x1c]
L_8c49ea:
	mov_s r0,0x886500
L_8c49f0:
	ld_s r0,[r0,0x48]
L_8c49f2:
	bl.d L_8d0848
L_8c49f6:
	mov_s r0,r13
L_8c49f8:
	bl.d L_8d085c
L_8c49fc:
	mov_s r0,r13
L_8c49fe:
	bl L_8d0828
L_8c4a02:
	bl L_8d081c
L_8c4a06:
	bl L_8dd758
L_8c4a0a:
	bl L_8dd760
L_8c4a0e:
	stb r17,[r16]
	.global L_8c4a12
L_8c4a12:
	ld_s r1,[r14,0x18]
L_8c4a14:
	cmp_s r1,0x4
L_8c4a16:
	bhi L_8c4ba2
L_8c4a1a:
	ldb r1,[0x8023d4,r1]
L_8c4a22:
	add r0,pcl,0xa
L_8c4a26:
	add1_s r0,r0,r1
L_8c4a28:
	j_s [r0]
	.global L_8c4a2a
L_8c4a2a:
	mov_s r0,blink
L_8c4a2c:
	mov_s r1,0x129d
L_8c4a32:
	bl L_8c9b28
L_8c4a36:
	b_s L_8c49b8
	.global L_8c4a38
L_8c4a38:
	mov_s r0,blink
L_8c4a3a:
	mov_s r1,0x129e
L_8c4a40:
	bl L_8c9b28
L_8c4a44:
	b_s L_8c49be
	.global L_8c4a46
L_8c4a46:
	mov_s r0,blink
L_8c4a48:
	mov_s r1,0x1477
L_8c4a4e:
	bl L_8c9b28
L_8c4a52:
	b_s L_8c49c2
L_8c4a54:
	ld_s r0,[r14,0x28]
L_8c4a56:
	cmp_s r0,0x0
L_8c4a58:
	bne_s L_8c4b5e
	.global L_8c4a5a
L_8c4a5a:
	ld_s r0,[r14,0x2c]
L_8c4a5c:
	cmp_s r0,0x0
L_8c4a5e:
	bne_s L_8c4b6c
	.global L_8c4a60
L_8c4a60:
	st_s r15,[r14,0x14]
L_8c4a62:
	extw_s r0,r13
L_8c4a64:
	bl.d L_8da0dc
L_8c4a68:
	stw_s r13,[r14,0x2]
L_8c4a6a:
	mov_s r16,r0
L_8c4a6c:
	bl.d L_8ccfd8
L_8c4a70:
	ldw_s r0,[r14,0x2]
L_8c4a72:
	mov_s r19,r0
L_8c4a74:
	bl.d L_8da15c
L_8c4a78:
	mov_s r1,0x0
L_8c4a7a:
	brne_s r0,0,L_8c4a92
L_8c4a7c:
	mov_s r1,0x100d010
L_8c4a82:
	bl.d L_8dcba8
L_8c4a86:
	mov_s r0,0x7
L_8c4a88:
	mov_s r0,blink
L_8c4a8a:
	mov_s r1,0x95
L_8c4a8c:
	/* bl.d 0x008c9b28 */
	.byte 0x9e,0x08,0xa0,0x02
L_8c4a90:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
	.global L_8c4a92
L_8c4a92:
	bl L_8e9524
L_8c4a96:
	ldw_s r1,[r14,0x4]
L_8c4a98:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8c4a9a:
	st_s r0,[r14,0x30]
L_8c4a9c:
	mov_s r0,r19
L_8c4a9e:
	st r17,[r14, 0x38]
L_8c4aa2:
	bl.d L_8ea9d4
L_8c4aa6:
	ldw_s r2,[r14,0x8]
L_8c4aa8:
	bl L_8ea450
L_8c4aac:
	ldw_s r0,[r14,0x2]
L_8c4aae:
	bl.d L_8ea438
L_8c4ab2:
	mov_s r1,0x1
L_8c4ab4:
	mov_s r0,0x886a00
L_8c4aba:
	ld_s r2,[r0,0x24]
L_8c4abc:
	ldw_s r3,[r14,0x2]
L_8c4abe:
	lsr r13,r2,r3
L_8c4ac2:
	bbit1 r13,0x0,L_8c4ae2
L_8c4ac6:
	mov_s r1,0x100d03c
L_8c4acc:
	mov_s r0,0x7
L_8c4ace:
	bl.d L_8dcd00
L_8c4ad2:
	bmsk r4,r13,0x0
L_8c4ad6:
	mov_s r0,blink
L_8c4ad8:
	mov_s r1,0x12a1
L_8c4ade:
	bl L_8c9b28
	.global L_8c4ae2
L_8c4ae2:
	ldw_s r0,[r14]
L_8c4ae4:
	mov_s r1,r21
L_8c4ae6:
	bl.d L_8d0620
L_8c4aea:
	ldw_s r2,[r14,0x2]
L_8c4aec:
	ld_s r0,[gp,-0x108]
L_8c4aee:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c4af0:
	st.as r0,[gp,-0x42]
L_8c4af4:
	mov_s r0,0x2
L_8c4af6:
	st_s r0,[r14,0x18]
L_8c4af8:
	brne r16,0x0,L_8c4bae
L_8c4afc:
	mov_s r0,0x2a23c
L_8c4b02:
	mov_s r1,r15
L_8c4b04:
	ldw_s r2,[r14]
L_8c4b06:
	mov_s r3,0x1
L_8c4b08:
	mov r4,r18
L_8c4b0c:
	mov r5,0x0
L_8c4b10:
	bl.d L_8e0c0c
L_8c4b14:
	mov r6,r5
L_8c4b18:
	bl.d L_8dd768
L_8c4b1c:
	st_s r0,[r14,0x28]
L_8c4b1e:
	st_s r0,[r14,0x10]
L_8c4b20:
	mov_s r0,0x2a280
L_8c4b26:
	mov_s r1,r15
L_8c4b28:
	ldw_s r2,[r14]
L_8c4b2a:
	mov_s r3,0x1
L_8c4b2c:
	mov r4,r20
L_8c4b30:
	mov r5,0x0
L_8c4b34:
	bl.d L_8e0c0c
L_8c4b38:
	mov r6,r5
L_8c4b3c:
	st_s r0,[r14,0x2c]
L_8c4b3e:
	ldw_s r1,[r14]
L_8c4b40:
	mov_s r0,0x0
L_8c4b42:
	bset r0,r0,r1
L_8c4b46:
	bl.d L_8d0568
L_8c4b4a:
	mov_s r1,0x1
L_8c4b4c:
	ldw_s r0,[r14]
L_8c4b4e:
	mov_s r12,0x1
L_8c4b50:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c4b52:
	asl r0,r12,r0
L_8c4b56:
	bl.d L_8d0538
L_8c4b5a:
	mov_s r1,0x1
L_8c4b5c:
	b_s L_8c4bae
	.global L_8c4b5e
L_8c4b5e:
	mov_s r0,blink
L_8c4b60:
	mov_s r1,0x129f
L_8c4b66:
	bl L_8c9b28
L_8c4b6a:
	b_s L_8c4a5a
	.global L_8c4b6c
L_8c4b6c:
	mov_s r0,blink
L_8c4b6e:
	mov_s r1,0xe6
L_8c4b70:
	bl.d L_8c9b28
L_8c4b74:
	bset_s r1,r1,0xc
L_8c4b76:
	b_s L_8c4a60
L_8c4b78:
	ld_s r0,[r14,0x14]
L_8c4b7a:
	brne r15,r0,L_8c4bae
L_8c4b7e:
	ld_s r0,[r14,0x28]
L_8c4b80:
	brne_s r0,0,L_8c4bae
L_8c4b82:
	mov_s r0,0x2a23c
L_8c4b88:
	mov_s r1,r15
L_8c4b8a:
	ldw_s r2,[r14]
L_8c4b8c:
	mov_s r3,0x1
L_8c4b8e:
	mov r4,r18
L_8c4b92:
	mov r5,0x0
L_8c4b96:
	bl.d L_8e0c0c
L_8c4b9a:
	mov r6,r5
L_8c4b9e:
	st_s r0,[r14,0x28]
L_8c4ba0:
	b_s L_8c4bae
	.global L_8c4ba2
L_8c4ba2:
	mov_s r0,blink
L_8c4ba4:
	mov_s r1,0x12a2
L_8c4baa:
	bl L_8c9b28
	.global L_8c4bae
L_8c4bae:
	b L_8c021c
L_8c4bb2:
	nop_s
	.global L_8c4bb4
L_8c4bb4:
	push_s blink
L_8c4bb6:
	bl L_8c01e0
L_8c4bba:
	sub_s sp,sp,0x4
L_8c4bbc:
	mov_s r15,r2
L_8c4bbe:
	mov_s r14,sp
L_8c4bc0:
	bl.d L_8e5dfc
L_8c4bc4:
	mov_s r0,r14
L_8c4bc6:
	mov_s r13,0x0
L_8c4bc8:
	b_s L_8c4bd6
	.global L_8c4bca
L_8c4bca:
	bl.d L_8df444
L_8c4bce:
	mov_s r0,r14
L_8c4bd0:
	add_s r12,r15,r13
L_8c4bd2:
	stb_s r0,[r12]
L_8c4bd4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8c4bd6
L_8c4bd6:
	bl.d L_8cdcc4
L_8c4bda:
	mov_s r0,r14
L_8c4bdc:
	brne_s r0,0,L_8c4bca
L_8c4bde:
	extb_s r0,r13
L_8c4be0:
	b.d L_8c024c
L_8c4be4:
	add_s sp,sp,0x4
L_8c4be6:
	nop_s
