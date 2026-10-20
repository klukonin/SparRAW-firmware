/* qh__write_by_flags_fw @ 0x8dd90c, 348 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: qh__write_or_conn_alloc
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bits__set32_s0_w12, bits__set32_s16_w12, bits__set32_s4_w12, fw_sysassert_fatal, macq_desc__read, macq_desc__read_typed, macq_desc__write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global qh__write_by_flags_fw
qh__write_by_flags_fw:
	.global L_8dd90c
L_8dd90c:
	push_s blink
L_8dd90e:
	bl L_8c01d4
L_8dd912:
	sub_s sp,sp,0x30
L_8dd914:
	mov_s r18,r0
L_8dd916:
	mov_s r15,r1
L_8dd918:
	and r0,r1,0x21
L_8dd91c:
	cmp_s r0,0x21
L_8dd91e:
	mov_s r13,r2
L_8dd920:
	mov_s r16,r3
L_8dd922:
	beq_s L_8dda5a
	.global L_8dd924
L_8dd924:
	bbit0 r15,0x4,L_8dd97a
L_8dd928:
	mov_s r0,sp
L_8dd92a:
	mov_s r1,r18
L_8dd92c:
	mov_s r2,0x2
L_8dd92e:
	mov_s r3,0x0
L_8dd930:
	mov_s r17,r3
L_8dd932:
	bl.d L_8c50f8
L_8dd936:
	mov r4,0x1
L_8dd93a:
	ld_s r1,[sp,0x4]
L_8dd93c:
	add3 r14,r13,0x8
L_8dd940:
	bmsk_s r1,r1,0xb
L_8dd942:
	add_s r0,r14,0x4
L_8dd944:
	bl.d L_8ed340
L_8dd948:
	stb r17,[r14, 0x6]
L_8dd94c:
	sub r0,r16,0x1
L_8dd950:
	stb_s r0,[r14,0xa]
L_8dd952:
	add_s r1,r1,r16
L_8dd954:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8dd956:
	bmsk_s r1,r1,0xb
L_8dd958:
	add r0,r14,0x8
L_8dd95c:
	bl.d L_8ed340
L_8dd960:
	mov_s r2,0x2
L_8dd962:
	mov_s r0,r14
L_8dd964:
	mov_s r1,r18
L_8dd966:
	mov_s r3,0x3
L_8dd968:
	mov r4,0x0
L_8dd96c:
	mov r5,0x0
L_8dd970:
	mov r6,0x0
L_8dd974:
	bl.d L_8c5010
L_8dd978:
	mov_s r7,r3
	.global L_8dd97a
L_8dd97a:
	btst_s r15,0x0
L_8dd97c:
	mov.ne r0,r13
L_8dd980:
	mov.ne r1,r18
L_8dd984:
	mov.ne r2,0x2
L_8dd988:
	sub_s.ne r3,r3,r3
L_8dd98a:
	mov.ne r4,r3
L_8dd98e:
	mov.ne r5,r3
L_8dd992:
	mov.ne r6,r3
L_8dd996:
	bl.ne.d L_8c5010
L_8dd99a:
	mov.ne r7,0x1
L_8dd99e:
	bbit0 r15,0x1,L_8dd9bc
L_8dd9a2:
	add r0,r13,0x10
L_8dd9a6:
	mov_s r1,r18
L_8dd9a8:
	mov_s r2,0x2
L_8dd9aa:
	mov_s r3,0x0
L_8dd9ac:
	mov_s r4,r3
L_8dd9ae:
	mov_s r5,r3
L_8dd9b0:
	mov r6,0x1
L_8dd9b4:
	bl.d L_8c5010
L_8dd9b8:
	mov r7,r6
	.global L_8dd9bc
L_8dd9bc:
	bbit0 r15,0x2,L_8dd9d8
L_8dd9c0:
	add r0,r13,0x20
L_8dd9c4:
	mov_s r1,r18
L_8dd9c6:
	mov_s r2,0x2
L_8dd9c8:
	mov_s r3,0x0
L_8dd9ca:
	mov_s r4,r3
L_8dd9cc:
	mov_s r5,r3
L_8dd9ce:
	mov_s r6,r2
L_8dd9d0:
	bl.d L_8c5010
L_8dd9d4:
	mov r7,0x1
	.global L_8dd9d8
L_8dd9d8:
	bbit0 r15,0x3,L_8dd9f6
L_8dd9dc:
	add r0,r13,0x30
L_8dd9e0:
	mov_s r1,r18
L_8dd9e2:
	mov_s r2,0x2
L_8dd9e4:
	mov_s r3,0x0
L_8dd9e6:
	mov_s r4,r3
L_8dd9e8:
	mov_s r5,r3
L_8dd9ea:
	mov r6,0x3
L_8dd9ee:
	bl.d L_8c5010
L_8dd9f2:
	mov r7,0x1
	.global L_8dd9f6
L_8dd9f6:
	bbit0 r15,0x5,L_8dda54
L_8dd9fa:
	mov_s r14,sp
L_8dd9fc:
	mov_s r0,r14
L_8dd9fe:
	mov_s r1,r18
L_8dda00:
	mov_s r2,0x2
L_8dda02:
	mov_s r3,0x0
L_8dda04:
	mov_s r4,r3
L_8dda06:
	mov r5,0x1
L_8dda0a:
	bl.d L_8c4f1c
L_8dda0e:
	mov r6,0x4
L_8dda12:
	ldw_s r0,[r13,0x6]
L_8dda14:
	stw r0,[sp, 0x6]
L_8dda18:
	ldw_s r0,[r13,0x4]
L_8dda1a:
	stw r0,[sp, 0x4]
L_8dda1e:
	ld_s r1,[r13,0x8]
L_8dda20:
	add_s r0,sp,0x8
L_8dda22:
	bmsk_s r1,r1,0xb
L_8dda24:
	bl.d L_8ed340
L_8dda28:
	mov_s r2,0x2
L_8dda2a:
	ld_s r1,[r13,0xc]
L_8dda2c:
	add_s r0,sp,0xc
L_8dda2e:
	lsr_s r1,r1,0x4
L_8dda30:
	bmsk_s r1,r1,0xb
L_8dda32:
	bl.d L_8ed4f0
L_8dda36:
	mov_s r3,0x0
L_8dda38:
	ld_s r1,[r13,0xc]
L_8dda3a:
	mov_s r5,r3
L_8dda3c:
	lsr_s r1,r1,0x10
L_8dda3e:
	bmsk_s r1,r1,0xb
L_8dda40:
	bl.d L_8ed3e8
L_8dda44:
	mov_s r4,r3
L_8dda46:
	mov_s r0,r14
L_8dda48:
	mov_s r1,r18
L_8dda4a:
	mov_s r6,r3
L_8dda4c:
	bl.d L_8c5010
L_8dda50:
	mov r7,0x1
	.global L_8dda54
L_8dda54:
	b.d L_8c0234
L_8dda58:
	add_s sp,sp,0x30
	.global L_8dda5a
L_8dda5a:
	mov_s r0,blink
L_8dda5c:
	mov_s r1,0x1585
L_8dda62:
	bl L_8c9b28
L_8dda66:
	b_s L_8dd924
