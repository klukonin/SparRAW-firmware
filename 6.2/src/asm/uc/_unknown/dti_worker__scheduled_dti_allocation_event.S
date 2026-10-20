/* dti_worker__scheduled_dti_allocation_event @ 0x934854, 324 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   dti_worker::scheduled_dti_allocation_event: starting slot id=%d at tsf_low=0x%x
 *   dti_worker::scheduled_dti_allocation_event: closing slot at tsf_low=0x%x
 * Зовут его: dti_alloc__scheduled_event_thunk
 * Зовёт сам: memset0_words_uc, uc_divmod_signed, uc_evt__send_29_sync, uc_log__emit1, uc_log__emit2, uc_send_evt__ps_awake_peer
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global dti_worker__scheduled_dti_allocation_event
dti_worker__scheduled_dti_allocation_event:
	.global L_934854
L_934854:
	st.a r13,[sp,-0x18]
L_934858:
	st blink,[sp, 0x4]
L_93485c:
	st_s r14,[sp,0x8]
L_93485e:
	st_s r15,[sp,0xc]
L_934860:
	st r16,[sp, 0x10]
L_934864:
	st r17,[sp, 0x14]
L_934868:
	sub_s sp,sp,0x10
L_93486a:
	mov_s r15,r0
L_93486c:
	mov_s r14,0x887000
L_934872:
	ld.as r17,[r14,-0x52]
L_934876:
	mov_s r0,sp
L_934878:
	bl.d L_920a84
L_93487c:
	mov r1,0xc
L_934880:
	mov_s r13,0x857200
L_934886:
	ldb r6,[r13, 0x66]
L_93488a:
	brne r6,0x0,L_934918
L_93488e:
	ld r14,[r14, -0x74]
L_934892:
	mov_s r1,0x1
L_934894:
	stw r14,[sp, 0xc]
L_934898:
	ldb r0,[r13, 0x67]
L_93489c:
	stb r1,[r13, 0x66]
L_9348a0:
	add r0,r0,0x1
L_9348a4:
	bl.d L_9203e8
L_9348a8:
	ldb r1,[r13, 0x65]
L_9348ac:
	extw r16,r14
L_9348b0:
	stb r1,[r13, 0x67]
L_9348b4:
	mov_s r1,0x1001df4
L_9348ba:
	mov_s r0,0x21
L_9348bc:
	bmsk r2,r14,0x3
L_9348c0:
	bl.d L_92d27c
L_9348c4:
	mov r3,r17
L_9348c8:
	bbit0 r16,0x7,L_9348e8
L_9348cc:
	ldb r5,[sp, 0xd]
L_9348d0:
	mov r7,0x1f000601
L_9348d8:
	stb r5,[sp, 0x2]
L_9348dc:
	mov r32,r7
L_9348e0:
	st.ab r7,[r25,0x4]
L_9348e4:
	bclr r25,r25,0xa
	.global L_9348e8
L_9348e8:
	bbit0 r16,0x6,L_934970
L_9348ec:
	mov_s r2,0x1
L_9348ee:
	st_s r2,[r15]
L_9348f0:
	mov r4,0x6
L_9348f4:
	st r4,[sp, 0x8]
L_9348f8:
	bl.d L_92757c
L_9348fc:
	mov r0,sp
L_934900:
	add_s sp,sp,0x10
L_934902:
	ld blink,[sp, 0x4]
L_934906:
	ld_s r14,[sp,0x8]
L_934908:
	ld_s r15,[sp,0xc]
L_93490a:
	ld r16,[sp, 0x10]
L_93490e:
	ld r17,[sp, 0x14]
L_934912:
	j_s.d [blink]
L_934914:
	ld.ab r13,[sp,0x18]
	.global L_934918
L_934918:
	mov_s r14,0x0
L_93491a:
	stb r14,[r13, 0x66]
L_93491e:
	mov_s r1,0x1001e44
L_934924:
	mov r0,0x21
L_934928:
	bl.d L_92d1d0
L_93492c:
	mov r2,r17
L_934930:
	ld_s r3,[r15]
L_934932:
	breq_s r3,0,L_934970
L_934934:
	st_s r14,[r15]
L_934936:
	add_s r0,sp,0xc
L_934938:
	bl.d L_920a84
L_93493c:
	mov r1,0x4
L_934940:
	bl.d L_9277ac
L_934944:
	add r0,sp,0xc
L_934948:
	mov r4,0x6
L_93494c:
	st r4,[sp, 0x8]
L_934950:
	bl.d L_92757c
L_934954:
	mov r0,sp
L_934958:
	add_s sp,sp,0x10
L_93495a:
	ld blink,[sp, 0x4]
L_93495e:
	ld_s r14,[sp,0x8]
L_934960:
	ld_s r15,[sp,0xc]
L_934962:
	ld r16,[sp, 0x10]
L_934966:
	ld r17,[sp, 0x14]
L_93496a:
	j_s.d [blink]
L_93496c:
	ld.ab r13,[sp,0x18]
	.global L_934970
L_934970:
	mov r4,0x6
L_934974:
	st r4,[sp, 0x8]
L_934978:
	bl.d L_92757c
L_93497c:
	mov r0,sp
L_934980:
	add_s sp,sp,0x10
L_934982:
	ld blink,[sp, 0x4]
L_934986:
	ld_s r14,[sp,0x8]
L_934988:
	ld_s r15,[sp,0xc]
L_93498a:
	ld r16,[sp, 0x10]
L_93498e:
	ld r17,[sp, 0x14]
L_934992:
	j_s.d [blink]
L_934994:
	ld.ab r13,[sp,0x18]
