/* mac_filter__write_entries @ 0x8df9e8, 224 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__configure
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bits__set16h_s0_w2, bits__set16h_s4_w5, bits__set32_s0_w4, bits__set_s8_w5, fw_sysassert_fatal, mac_filter__bits_set16h_s4_w2, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_filter__write_entries
mac_filter__write_entries:
	.global L_8df9e8
L_8df9e8:
	push_s blink
L_8df9ea:
	bl L_8c01d8
L_8df9ee:
	sub_s sp,sp,0x10
L_8df9f0:
	mov_s r16,r0
L_8df9f2:
	mov_s r14,r1
L_8df9f4:
	mov_s r0,0x0
L_8df9f6:
	mov_s r17,r0
L_8df9f8:
	stw r0,[sp, 0x2]
L_8df9fc:
	mov_s r1,0x1
L_8df9fe:
	add r0,sp,0x2
L_8dfa02:
	bl.d L_8ed2d4
L_8dfa06:
	mov_s r13,r2
L_8dfa08:
	bmsk r1,r16,0x1
L_8dfa0c:
	bl L_8ed304
L_8dfa10:
	add_s r0,sp,0x4
L_8dfa12:
	bl.d L_8c1cd8
L_8dfa16:
	mov_s r1,0x8
L_8dfa18:
	mov_s r1,0x1f
L_8dfa1a:
	add r0,sp,0xa
L_8dfa1e:
	bl.d L_8ed31c
L_8dfa22:
	cmp r16,0x1
L_8dfa26:
	add_s r0,sp,0xc
L_8dfa28:
	bl L_8ed580
L_8dfa2c:
	mov_s r1,r17
L_8dfa2e:
	bl L_8ed370
L_8dfa32:
	ldw r0,[sp, 0x2]
L_8dfa36:
	ld_s r1,[sp,0xc]
L_8dfa38:
	asl_s r0,r0,0x10
L_8dfa3a:
	bset_s r0,r0,0x1f
L_8dfa3c:
	mov_s r2,0x886000
L_8dfa42:
	mov_s r15,0x886200
L_8dfa48:
	st.as r0,[r2,0x9e]
L_8dfa4c:
	mov_s r2,0x886280
L_8dfa52:
	bclr_s r1,r1,0x4
L_8dfa54:
	bne_s L_8dfa5e
L_8dfa56:
	ld_s r0,[sp,0x4]
L_8dfa58:
	st_s r0,[r2]
L_8dfa5a:
	ld_s r0,[sp,0x8]
L_8dfa5c:
	b_s L_8dfa62
	.global L_8dfa5e
L_8dfa5e:
	st_s r1,[r2]
L_8dfa60:
	mov_s r0,r17
	.global L_8dfa62
L_8dfa62:
	st_s r0,[r2,0x4]
L_8dfa64:
	brlo r13,r14,L_8dfaa0
	.global L_8dfa68
L_8dfa68:
	brne r16,0x1,L_8dfab4
L_8dfa6c:
	brhs r13,0x8,L_8dfaac
	.global L_8dfa70
L_8dfa70:
	brlo r13,r14,L_8dfa9a
L_8dfa74:
	sub_s r13,r13,r14
L_8dfa76:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8dfa78
L_8dfa78:
	st_s r14,[r15,0x7c]
L_8dfa7a:
	st 0x40000000,[r15, 0x74]
L_8dfa82:
	sync
	.global L_8dfa86
L_8dfa86:
	mov_s r15,0x886200
L_8dfa8c:
	ld_s r0,[r15,0x74]
L_8dfa8e:
	bbit1 r0,0x1d,L_8dfa86
L_8dfa92:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dfa94:
	/* brhs.d r13,0x1,0x008dfa78 */
	.byte 0xe5,0x0d,0x75,0x90
L_8dfa98:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8dfa9a
L_8dfa9a:
	b.d L_8c023c
L_8dfa9e:
	add_s sp,sp,0x10
	.global L_8dfaa0
L_8dfaa0:
	mov_s r0,blink
L_8dfaa2:
	mov_s r1,0xf
L_8dfaa4:
	bl.d L_8c9b28
L_8dfaa8:
	bset_s r1,r1,0xc
L_8dfaaa:
	b_s L_8dfa68
	.global L_8dfaac
L_8dfaac:
	mov_s r0,blink
L_8dfaae:
	mov_s r1,0x10
L_8dfab0:
	bset_s r1,r1,0xc
L_8dfab2:
	b_s L_8dfac0
	.global L_8dfab4
L_8dfab4:
	cmp_s r13,0x40
L_8dfab6:
	bcs L_8dfa70
L_8dfaba:
	mov_s r0,blink
L_8dfabc:
	mov_s r1,0x11
L_8dfabe:
	bset_s r1,r1,0xc
	.global L_8dfac0
L_8dfac0:
	bl L_8c9b28
L_8dfac4:
	b_s L_8dfa70
L_8dfac6:
	nop_s
