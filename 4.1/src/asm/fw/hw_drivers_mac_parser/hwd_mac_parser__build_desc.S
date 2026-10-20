/* hwd_mac_parser__build_desc @ 0x8db8e8, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac_parser.c
 * Зовут его: mac_parser__configure
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, bf_h_s0_w2, bf_h_s4_w2, bf_h_s4_w5, bf_w_s0_w4, bf_w_s8_w5, fw_sysassert_fatal, memset0_words
 */
	.section .text.hwd_mac_parser__build_desc,"ax",@progbits
	.global hwd_mac_parser__build_desc
hwd_mac_parser__build_desc:
	.global L_8db8e8
L_8db8e8:
	push_s blink
L_8db8ea:
	bl L_8c02b8
L_8db8ee:
	sub_s sp,sp,0x10
L_8db8f0:
	mov_s r16,r0
L_8db8f2:
	mov_s r14,r1
L_8db8f4:
	mov_s r0,0x0
L_8db8f6:
	mov_s r17,r0
L_8db8f8:
	stw r0,[sp, 0x2]
L_8db8fc:
	mov_s r1,0x1
L_8db8fe:
	add r0,sp,0x2
L_8db902:
	bl.d L_8e82a0
L_8db906:
	mov_s r13,r2
L_8db908:
	bmsk r1,r16,0x1
L_8db90c:
	bl L_8e82d0
L_8db910:
	add_s r0,sp,0x4
L_8db912:
	bl.d L_8c1a78
L_8db916:
	mov_s r1,0x8
L_8db918:
	mov_s r1,0x1f
L_8db91a:
	add r0,sp,0xa
L_8db91e:
	bl.d L_8e82e8
L_8db922:
	cmp r16,0x1
L_8db926:
	add_s r0,sp,0xc
L_8db928:
	bl L_8e8564
L_8db92c:
	mov_s r1,r17
L_8db92e:
	bl L_8e8348
L_8db932:
	ldw r0,[sp, 0x2]
L_8db936:
	ld_s r1,[sp,0xc]
L_8db938:
	asl_s r0,r0,0x10
L_8db93a:
	bset_s r0,r0,0x1f
L_8db93c:
	mov_s r2,0x886000
L_8db942:
	mov_s r15,0x886200
L_8db948:
	st.as r0,[r2,0x9e]
L_8db94c:
	mov_s r2,0x886280
L_8db952:
	bclr_s r1,r1,0x4
L_8db954:
	bne_s L_8db95e
L_8db956:
	ld_s r0,[sp,0x4]
L_8db958:
	st_s r0,[r2]
L_8db95a:
	ld_s r0,[sp,0x8]
L_8db95c:
	b_s L_8db962
	.global L_8db95e
L_8db95e:
	st_s r1,[r2]
L_8db960:
	mov_s r0,r17
	.global L_8db962
L_8db962:
	st_s r0,[r2,0x4]
L_8db964:
	brlo r13,r14,L_8db9a0
	.global L_8db968
L_8db968:
	brne r16,0x1,L_8db9c8
L_8db96c:
	brhs r13,0x8,L_8db9b6
	.global L_8db970
L_8db970:
	brlo r13,r14,L_8db99a
L_8db974:
	sub_s r13,r13,r14
L_8db976:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8db978
L_8db978:
	st_s r14,[r15,0x7c]
L_8db97a:
	st 0x40000000,[r15, 0x74]
L_8db982:
	sync
	.global L_8db986
L_8db986:
	mov_s r15,0x886200
L_8db98c:
	ld_s r0,[r15,0x74]
L_8db98e:
	bbit1 r0,0x1d,L_8db986
L_8db992:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8db994:
	/* brhs.d r13,0x1,0x008db978 */
	.byte 0xe5,0x0d,0x75,0x90
L_8db998:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8db99a
L_8db99a:
	b.d L_8c031c
L_8db99e:
	add_s sp,sp,0x10
	.global L_8db9a0
L_8db9a0:
	mov_s r0,blink
L_8db9a2:
	mov_s r2,0x1019b0c
L_8db9a8:
	mov_s r1,0xf
L_8db9aa:
	bset_s r1,r1,0xc
L_8db9ac:
	bl.d L_8c82c0
L_8db9b0:
	mov r3,0x338
L_8db9b4:
	b_s L_8db968
	.global L_8db9b6
L_8db9b6:
	mov_s r0,blink
L_8db9b8:
	mov_s r2,0x1019b0c
L_8db9be:
	mov_s r1,0x10
L_8db9c0:
	bset_s r1,r1,0xc
L_8db9c2:
	mov r3,0x33c
L_8db9c6:
	b_s L_8db9de
	.global L_8db9c8
L_8db9c8:
	cmp_s r13,0x40
L_8db9ca:
	bcs L_8db970
L_8db9ce:
	mov_s r0,blink
L_8db9d0:
	mov_s r2,0x1019b0c
L_8db9d6:
	mov_s r1,0x11
L_8db9d8:
	bset_s r1,r1,0xc
L_8db9da:
	mov r3,0x340
	.global L_8db9de
L_8db9de:
	bl L_8c82c0
L_8db9e2:
	b_s L_8db970
