/* uc_mailbox__advance @ 0x9258f4, 204 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fw_mailbox.cpp
 * Зовут его: basic_if__post_to_fw_mailbox
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_mailbox__advance,"ax",@progbits
	.global uc_mailbox__advance
uc_mailbox__advance:
	.global L_9258f4
L_9258f4:
	st.a r13,[sp,-0x10]
L_9258f8:
	st blink,[sp, 0x4]
L_9258fc:
	st_s r14,[sp,0x8]
L_9258fe:
	st_s r15,[sp,0xc]
L_925900:
	breq.d r1,0x0,L_925954
L_925904:
	mov r13,r0
	.global L_925908
L_925908:
	ld r6,[r13]
L_92590c:
	ld r1,[r6]
L_925910:
	rsub.f r1,r1,0x1
L_925914:
	mov.cs r1,0x0
L_925918:
	extb.f 0x0,r1
L_92591c:
	beq L_92596c
	.global L_925920
L_925920:
	lr r15,[0xa]
L_925924:
	bclr r3,r15,0x1
L_925928:
	flag r3
L_92592c:
	ld r5,[r13]
L_925930:
	mov r8,0x1
L_925934:
	st r8,[r5]
L_925938:
	ld_s r14,[r13]
L_92593a:
	ld r7,[r13, 0x8]
L_92593e:
	add_s r14,r14,0x8
L_925940:
	brlo r7,r14,L_925984
	.global L_925944
L_925944:
	brne r14,r7,L_9259a0
L_925948:
	ld r4,[r13, 0x4]
L_92594c:
	b.d L_9259a4
L_925950:
	st r4,[r13]
	.global L_925954
L_925954:
	mov_s r0,blink
L_925956:
	mov_s r2,0x1001174
L_92595c:
	mov r1,0xca
L_925960:
	bl.d L_925548
L_925964:
	mov r3,0x95
L_925968:
	b L_925908
	.global L_92596c
L_92596c:
	mov_s r0,blink
L_92596e:
	mov_s r2,0x1001174
L_925974:
	mov r1,0xcb
L_925978:
	bl.d L_925548
L_92597c:
	mov r3,0x96
L_925980:
	b L_925920
	.global L_925984
L_925984:
	mov_s r0,blink
L_925986:
	mov_s r2,0x1001174
L_92598c:
	mov r1,0xcc
L_925990:
	bl.d L_925548
L_925994:
	mov r3,0xb2
L_925998:
	b.d L_925944
L_92599c:
	ld r7,[r13, 0x8]
	.global L_9259a0
L_9259a0:
	st r14,[r13]
	.global L_9259a4
L_9259a4:
	lr r2,[0xa]
L_9259a8:
	bic r15,r15,-0x3
L_9259ac:
	or_s r15,r15,r2
L_9259ae:
	flag r15
L_9259b2:
	ld blink,[sp, 0x4]
L_9259b6:
	ld_s r14,[sp,0x8]
L_9259b8:
	ld_s r15,[sp,0xc]
L_9259ba:
	j_s.d [blink]
L_9259bc:
	ld.ab r13,[sp,0x10]
