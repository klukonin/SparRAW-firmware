/* bf_sm_step @ 0x92a924, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__check_sta_timeout, bf_sm__process_request_fifo
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, uc_send_evt__bf_done, uc_send_evt__new_link
 */
	.section .text.bf_sm_step,"ax",@progbits
	.global bf_sm_step
bf_sm_step:
	.global L_92a924
L_92a924:
	push_s blink
L_92a926:
	bl L_920210
L_92a92a:
	sub_s sp,sp,0x2c
L_92a92c:
	st_s r2,[sp,0x8]
L_92a92e:
	mov_s r3,0x857849
L_92a934:
	asl_s r2,r1,0x2
L_92a936:
	add2_s r2,r2,r2
L_92a938:
	ldb_s r13,[r3,r2]
L_92a93a:
	mov_s r2,0x800fb0
L_92a940:
	st_s r13,[r2,0x18]
L_92a942:
	ld_s r3,[r2,0x14]
L_92a944:
	stb_s r1,[sp,0x10]
L_92a946:
	bmsk r14,r3,0x3
L_92a94a:
	stb r14,[sp, 0x26]
L_92a94e:
	bic r3,r3,-0x3f1
L_92a952:
	lsr_s r3,r3,0x4
L_92a954:
	stb r3,[sp, 0x27]
L_92a958:
	brne_s r0,0,L_92a960
L_92a95a:
	ld_s r0,[sp,0xc]
L_92a95c:
	ld_s r14,[sp,0x1c]
L_92a95e:
	b_s L_92a9a8
	.global L_92a960
L_92a960:
	mov_s r0,0x800fcc
L_92a966:
	ldb r0,[r0, 0x68]
L_92a96a:
	mov_s r14,0x1
L_92a96c:
	bbit0 r0,r1,L_92a97a
L_92a970:
	mov_s r0,0x800a50
L_92a976:
	ldb_s r0,[r0,0x2]
L_92a978:
	b_s L_92a984
	.global L_92a97a
L_92a97a:
	mov_s r0,0x800fa0
L_92a980:
	ld_s r0,[r0,0x8]
L_92a982:
	mov_s r14,0x0
	.global L_92a984
L_92a984:
	ldb_s r2,[r2,0x1]
L_92a986:
	mov_s r3,0x80100c
L_92a98c:
	stb r2,[sp, 0x11]
L_92a990:
	mov_s r2,0xff
L_92a992:
	stb r2,[sp, 0x13]
L_92a996:
	ldw_s r2,[r3,0x1c]
L_92a998:
	stw r2,[sp, 0x20]
L_92a99c:
	ldw_s r2,[r3,0x1e]
L_92a99e:
	stw r2,[sp, 0x22]
L_92a9a2:
	ldw_s r2,[r3,0x20]
L_92a9a4:
	stw r2,[sp, 0x24]
	.global L_92a9a8
L_92a9a8:
	mul64 r1,0x3c
L_92a9ac:
	mov_s r3,0x857400
L_92a9b2:
	mov_s r2,mlo
L_92a9b4:
	ld_s r3,[r3,r2]
L_92a9b6:
	ld_s r15,[sp,0x20]
L_92a9b8:
	bmsk_s r3,r3,0x5
L_92a9ba:
	stb r3,[sp, 0x12]
L_92a9be:
	mov_s r3,0x85761c
L_92a9c4:
	ld_s r2,[r3,r2]
L_92a9c6:
	st_s r15,[sp,0x0]
L_92a9c8:
	ld_s r3,[sp,0x10]
L_92a9ca:
	bmsk_s r2,r2,0x5
L_92a9cc:
	cmp_s r1,0x8
L_92a9ce:
	ld_s r15,[sp,0x24]
L_92a9d0:
	stb_s r2,[sp,0x14]
L_92a9d2:
	mov_s r1,r3
L_92a9d4:
	ld_s r2,[sp,0x14]
L_92a9d6:
	mov_s r4,r14
L_92a9d8:
	ld_s r3,[sp,0x8]
L_92a9da:
	mov_s r6,r15
L_92a9dc:
	ld r5,[sp]
L_92a9e0:
	mov_s r7,r13
L_92a9e2:
	beq_s L_92a9ea
L_92a9e4:
	bl L_925bd0
L_92a9e8:
	b_s L_92a9ee
	.global L_92a9ea
L_92a9ea:
	bl L_925c6c
	.global L_92a9ee
L_92a9ee:
	b.d L_92027c
L_92a9f2:
	add_s sp,sp,0x2c
