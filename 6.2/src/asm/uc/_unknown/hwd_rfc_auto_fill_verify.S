/* hwd_rfc_auto_fill_verify @ 0x93e7c4, 256 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_auto_fill_verify(): verification failure: rf_mask=0x%x; sec=%d; sec_val=0x%x
 * Зовут его: rf_utils_auto_fill_uc
 * Зовёт сам: hwd_rfc_read_rgf_uc, uc_log__emit3, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_rfc_auto_fill_verify
hwd_rfc_auto_fill_verify:
	.global L_93e7c4
L_93e7c4:
	st.a r13,[sp,-0x28]
L_93e7c8:
	st blink,[sp, 0x4]
L_93e7cc:
	st_s r14,[sp,0x8]
L_93e7ce:
	st_s r15,[sp,0xc]
L_93e7d0:
	st r16,[sp, 0x10]
L_93e7d4:
	st r17,[sp, 0x14]
L_93e7d8:
	st r18,[sp, 0x18]
L_93e7dc:
	st r19,[sp, 0x1c]
L_93e7e0:
	st r20,[sp, 0x20]
L_93e7e4:
	st r21,[sp, 0x24]
L_93e7e8:
	ld_s r3,[r0,0x8]
L_93e7ea:
	mov_s r20,r1
L_93e7ec:
	mov r17,r0
L_93e7f0:
	breq.d r3,0x0,L_93e868
L_93e7f4:
	mov_s r21,r2
L_93e7f6:
	ld r19,[r17, 0x4]
L_93e7fa:
	breq r19,0x0,L_93e868
L_93e7fe:
	ldb r2,[r17, 0x1]
L_93e802:
	mov_s r14,0x1
L_93e804:
	cmp_s r2,0x1
L_93e806:
	ldb r18,[r17, 0x2]
L_93e80a:
	sub_s.ne r14,r14,r14
L_93e80c:
	ldb r7,[r17, 0x3]
L_93e810:
	asl r14,r14,0xc
L_93e814:
	brlt.d r7,r18,L_93e868
L_93e818:
	add3 r14,r14,0x200
	.global L_93e81c
L_93e81c:
	mov_s r15,0x1
L_93e81e:
	mov r16,0x6
L_93e822:
	mov_s r13,r19
	.global L_93e824
L_93e824:
	ldb r5,[r17, 0xc]
L_93e828:
	tst r5,r15
L_93e82c:
	beq_s L_93e844
L_93e82e:
	mov_s r0,0x0
L_93e830:
	bl.d L_92a1cc
L_93e834:
	mov r1,r14
L_93e838:
	ld r6,[r13]
L_93e83c:
	brne.d r0,r6,L_93e870
L_93e840:
	mov r4,r0
	.global L_93e844
L_93e844:
	asl_s r15,r15
L_93e846:
	extb_s r15,r15
L_93e848:
	sub r16,r16,0x1
L_93e84c:
	add r14,r14,0x4
L_93e850:
	brhs.d r16,0x1,L_93e824
L_93e854:
	add r13,r13,0x4
L_93e858:
	add r18,r18,0x1
L_93e85c:
	ldb r8,[r17, 0x3]
L_93e860:
	extb r18,r18
L_93e864:
	brge r8,r18,L_93e81c
	.global L_93e868
L_93e868:
	b.d L_93e88c
L_93e86c:
	mov r0,0x1
	.global L_93e870
L_93e870:
	mov_s r1,0x1000e14
L_93e876:
	mov_s r0,0x0
L_93e878:
	mov r2,r20
L_93e87c:
	bl.d L_92d338
L_93e880:
	mov r3,r18
L_93e884:
	brne r21,0x0,L_93e8b4
	.global L_93e888
L_93e888:
	mov r0,0x0
	.global L_93e88c
L_93e88c:
	ld blink,[sp, 0x4]
L_93e890:
	ld_s r14,[sp,0x8]
L_93e892:
	ld_s r15,[sp,0xc]
L_93e894:
	ld r16,[sp, 0x10]
L_93e898:
	ld r17,[sp, 0x14]
L_93e89c:
	ld r18,[sp, 0x18]
L_93e8a0:
	ld r19,[sp, 0x1c]
L_93e8a4:
	ld r20,[sp, 0x20]
L_93e8a8:
	ld r21,[sp, 0x24]
L_93e8ac:
	j.d [blink]
L_93e8b0:
	ld.ab r13,[sp,0x28]
	.global L_93e8b4
L_93e8b4:
	mov_s r0,blink
L_93e8b6:
	mov_s r1,0x1567
L_93e8bc:
	bl L_926618
L_93e8c0:
	b_s L_93e888
L_93e8c2:
	nop_s
