/* brp_init__exchange_request @ 0x922928, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_init__flow
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, brp__parse_request_fields, brp_init__tx_request, mac__program_4f_52, rx__arm_window, rx__is_brp_frame, uc_wait_event1_or_event4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp_init__exchange_request
brp_init__exchange_request:
	.global L_922928
L_922928:
	push_s blink
L_92292a:
	bl.d L_920234
L_92292e:
	mov_s r0,0x3a
L_922930:
	mov_s r14,0x0
L_922932:
	bset_s r0,r0,0xd
L_922934:
	bl.d L_924d8c
L_922938:
	mov_s r1,0x4
	.global L_92293a
L_92293a:
	bl L_9229c0
L_92293e:
	mov_s r0,0x49000040
L_922944:
	mov_s r32,r0
L_922946:
	st.ab r0,[r25,0x4]
L_92294a:
	bclr r25,r25,0xa
L_92294e:
	mov_s r0,0x80
L_922950:
	bset_s r0,r0,0xc
L_922952:
	mov_s r1,0x40
L_922954:
	bl.d L_9367e4
L_922958:
	mov_s r2,0x0
L_92295a:
	mov_s r0,r42
L_92295c:
	bbit0 r0,0xc,L_9229a2
L_922960:
	bl L_9228d4
L_922964:
	mov_s r0,r36
L_922966:
	bbit0 r0,0x19,L_922996
L_92296a:
	bl L_92bdbc
L_92296e:
	breq_s r0,0,L_922996
L_922970:
	mov_s r1,0x802348
L_922976:
	ldb_s r0,[r1,0xa]
L_922978:
	mov_s r13,0x800824
L_92297e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922980:
	extb_s r0,r0
L_922982:
	stb_s r0,[r1,0xa]
L_922984:
	bl.d L_92e1e4
L_922988:
	ldb r0,[r13, 0x48]
L_92298c:
	st_s r0,[r13,0x54]
L_92298e:
	bbit1 r0,0x3,L_92293a
L_922992:
	mov_s r0,0x1
L_922994:
	b_s L_92299e
	.global L_922996
L_922996:
	mov_s r0,r37
L_922998:
	bbit0 r0,0x18,L_92293a
	.global L_92299c
L_92299c:
	mov_s r0,0x0
	.global L_92299e
L_92299e:
	b L_9202a4
	.global L_9229a2
L_9229a2:
	mov_s r0,r54
L_9229a4:
	bbit0 r0,0x6,L_92299c
L_9229a8:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_9229aa:
	extb_s r14,r14
L_9229ac:
	brne r14,0x3,L_92293a
L_9229b0:
	mov_s r1,0x801ed4
L_9229b6:
	ldw_s r0,[r1,0xe]
L_9229b8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9229ba:
	extw_s r0,r0
L_9229bc:
	stw_s r0,[r1,0xe]
L_9229be:
	b_s L_92299c
