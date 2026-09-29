/* basic_sm__dispatch_loop @ 0x9287ec, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_sm.cpp
 * Зовут его: bi_ap_mon_if__trigger, bi_ap_mon_if__trigger_bhi_to_dti
 * Зовёт сам: uc_sysassert
 */
	.section .text.basic_sm__dispatch_loop,"ax",@progbits
	.global basic_sm__dispatch_loop
basic_sm__dispatch_loop:
	.global L_9287ec
L_9287ec:
	st.a r13,[sp,-0x20]
L_9287f0:
	st blink,[sp, 0x4]
L_9287f4:
	st_s r14,[sp,0x8]
L_9287f6:
	st_s r15,[sp,0xc]
L_9287f8:
	st r16,[sp, 0x10]
L_9287fc:
	st r17,[sp, 0x14]
L_928800:
	st r18,[sp, 0x18]
L_928804:
	st r19,[sp, 0x1c]
L_928808:
	mov_s r15,r0
L_92880a:
	mov_s r18,r1
L_92880c:
	ld r8,[r0, 0x4]
L_928810:
	mov_s r14,r3
L_928812:
	mov_s r17,r2
L_928814:
	brne.d r8,0x0,L_9288c8
L_928818:
	mov r13,r4
	.global L_92881c
L_92881c:
	st r18,[r15, 0x8]
L_928820:
	st r17,[r15, 0xc]
L_928824:
	st_s r14,[r15,0x10]
L_928826:
	st_s r13,[r15,0x14]
L_928828:
	mov r7,0x1
L_92882c:
	st r7,[r15, 0x4]
L_928830:
	mov r19,0x0
L_928834:
	b.d L_928848
L_928838:
	mov r16,r19
	.global L_92883c
L_92883c:
	ld r18,[r15, 0x8]
L_928840:
	ld r17,[r15, 0xc]
L_928844:
	ld_s r14,[r15,0x10]
L_928846:
	ld_s r13,[r15,0x14]
	.global L_928848
L_928848:
	ldb r6,[r15, 0x2]
L_92884c:
	st r19,[r15, 0x4]
L_928850:
	ldb_s r1,[r15]
L_928852:
	mulu64 r6,r18
L_928856:
	ld_s r2,[r15,0x18]
L_928858:
	add_s r1,r1,mlo
L_92885a:
	add2_s r1,r1,r1
L_92885c:
	add_s r1,r1,r2
L_92885e:
	ldb_s r3,[r1,0x4]
L_928860:
	add r16,r16,0x1
L_928864:
	stb_s r3,[r15]
L_928866:
	ldb r5,[r1, 0x1]
L_92886a:
	ldb r9,[r1]
L_92886e:
	asl r5,r5,0x8
L_928872:
	or r9,r9,r5
L_928876:
	ldb r5,[r1, 0x2]
L_92887a:
	mov_s r0,r15
L_92887c:
	asl r5,r5,0x10
L_928880:
	or r9,r9,r5
L_928884:
	ldb r5,[r1, 0x3]
L_928888:
	mov_s r2,r14
L_92888a:
	asl r5,r5,0x18
L_92888e:
	or r9,r9,r5
L_928892:
	mov_s r1,r17
L_928894:
	jl.d [r9]
L_928898:
	mov r3,r13
L_92889c:
	brhs r16,0x14,L_9288e0
	.global L_9288a0
L_9288a0:
	ld r4,[r15, 0x4]
L_9288a4:
	breq r4,0x1,L_92883c
L_9288a8:
	ld blink,[sp, 0x4]
L_9288ac:
	ld_s r14,[sp,0x8]
L_9288ae:
	ld_s r15,[sp,0xc]
L_9288b0:
	ld r16,[sp, 0x10]
L_9288b4:
	ld r17,[sp, 0x14]
L_9288b8:
	ld r18,[sp, 0x18]
L_9288bc:
	ld r19,[sp, 0x1c]
L_9288c0:
	j.d [blink]
L_9288c4:
	ld.ab r13,[sp,0x20]
	.global L_9288c8
L_9288c8:
	mov_s r0,blink
L_9288ca:
	mov_s r2,0x1002a54
L_9288d0:
	mov_s r1,0x32
L_9288d2:
	bset_s r1,r1,0xc
L_9288d4:
	bl.d L_925548
L_9288d8:
	mov r3,0x30
L_9288dc:
	b L_92881c
	.global L_9288e0
L_9288e0:
	mov_s r0,blink
L_9288e2:
	mov_s r2,0x1002a54
L_9288e8:
	mov_s r1,0x31
L_9288ea:
	bset_s r1,r1,0xc
L_9288ec:
	bl.d L_925548
L_9288f0:
	mov r3,0x2a
L_9288f4:
	b_s L_9288a0
L_9288f6:
	nop_s
