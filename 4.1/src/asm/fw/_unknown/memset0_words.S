/* memset0_words @ 0x8c1a78, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: FWQ_TX_AVAILABILITY__init, TX_API__alloc_tx_payload, UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, bcn_tx_init_ss_params, boot__clear_object_48, boot__clear_object_4_a, boot__clear_object_4_b, boot__clear_object_tail, calib_mngr__init_schemes, connection__reset_fields
 * Зовёт сам: __ld_r13_ret, memset_fw
 */
	.section .text.memset0_words,"ax",@progbits
	.global memset0_words
memset0_words:
	.global L_8c1a78
L_8c1a78:
	mov.f r2,r1
L_8c1a7c:
	push_s blink
L_8c1a7e:
	push_s r13
L_8c1a80:
	beq_s L_8c1b02
L_8c1a82:
	bmsk.f 0x0,r0,0x1
L_8c1a86:
	bne_s L_8c1a98
L_8c1a88:
	bmsk.f 0x0,r2,0x1
L_8c1a8c:
	bne_s L_8c1a98
L_8c1a8e:
	lsr_s r2,r2,0x2
L_8c1a90:
	brhs r2,0x8,L_8c1aa0
L_8c1a94:
	mov_s r1,0x0
L_8c1a96:
	b_s L_8c1aa6
	.global L_8c1a98
L_8c1a98:
	bl.d L_8da04c
L_8c1a9c:
	mov_s r1,0x0
L_8c1a9e:
	b_s L_8c1b02
	.global L_8c1aa0
L_8c1aa0:
	sub_s r1,r2,0x1
L_8c1aa2:
	lsr_s r1,r1,0x3
L_8c1aa4:
	bmsk_s r2,r2,0x2
	.global L_8c1aa6
L_8c1aa6:
	brhs r2,0x8,L_8c1b02
L_8c1aaa:
	ldb.x r2,[0x8033c4,r2]
L_8c1ab2:
	add r13,pcl,0xc
L_8c1ab6:
	add1_s r13,r13,r2
L_8c1ab8:
	j_s.d [r13]
L_8c1aba:
	mov_s r3,0x0
L_8c1abc:
	mov_s r2,r0
L_8c1abe:
	b_s L_8c1af6
L_8c1ac0:
	mov_s r2,r0
L_8c1ac2:
	b_s L_8c1af2
L_8c1ac4:
	mov_s r2,r0
L_8c1ac6:
	b_s L_8c1aee
L_8c1ac8:
	mov_s r2,r0
L_8c1aca:
	b_s L_8c1aea
L_8c1acc:
	mov_s r2,r0
L_8c1ace:
	b_s L_8c1ae6
L_8c1ad0:
	mov_s r2,r0
L_8c1ad2:
	b_s L_8c1ae2
L_8c1ad4:
	mov_s r2,r0
L_8c1ad6:
	b_s L_8c1ade
L_8c1ad8:
	mov_s r2,r0
	.global L_8c1ada
L_8c1ada:
	st.ab r3,[r2,0x4]
	.global L_8c1ade
L_8c1ade:
	st.ab r3,[r2,0x4]
	.global L_8c1ae2
L_8c1ae2:
	st.ab r3,[r2,0x4]
	.global L_8c1ae6
L_8c1ae6:
	st.ab r3,[r2,0x4]
	.global L_8c1aea
L_8c1aea:
	st.ab r3,[r2,0x4]
	.global L_8c1aee
L_8c1aee:
	st.ab r3,[r2,0x4]
	.global L_8c1af2
L_8c1af2:
	st.ab r3,[r2,0x4]
	.global L_8c1af6
L_8c1af6:
	cmp_s r1,0x0
L_8c1af8:
	st.ab r3,[r2,0x4]
L_8c1afc:
	sub.gt r1,r1,0x1
L_8c1b00:
	bgt_s L_8c1ada
	.global L_8c1b02
L_8c1b02:
	b L_8c033c
L_8c1b06:
	nop_s
	.global L_8c1b08
L_8c1b08:
	j_s [blink]
L_8c1b0a:
	nop_s
