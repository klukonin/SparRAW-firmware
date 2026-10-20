/* perform_bti_pm_cfg @ 0x92ac60, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   perform_bti_pm_cfg() - force wakeup
 * Зовут его: bi__decide_beacon_kind
 * Зовёт сам: aw__set_new_tbtt, perform_shallow_sleep
 */
	.section .text.perform_bti_pm_cfg,"ax",@progbits
	.global perform_bti_pm_cfg
perform_bti_pm_cfg:
	.global L_92ac60
L_92ac60:
	st.a r13,[sp,-0x10]
L_92ac64:
	st blink,[sp, 0x4]
L_92ac68:
	st_s r14,[sp,0x8]
L_92ac6a:
	mov_s r14,0x800fcc
L_92ac70:
	ldb r9,[r14, 0x68]
L_92ac74:
	mov_s r13,r0
L_92ac76:
	st_s r15,[sp,0xc]
L_92ac78:
	breq.d r9,0x0,L_92acd4
L_92ac7c:
	mov_s r15,0x0
L_92ac7e:
	brne r1,0x1,L_92acd4
L_92ac82:
	mov r5,0x80209c
L_92ac8a:
	ldb r2,[r5, 0x4]
L_92ac8e:
	mov r6,0x1002cac
L_92ac96:
	bbit0 r2,0x2,L_92acc4
L_92ac9a:
	bmsk r6,r6,0x13
L_92ac9e:
	ld r7,[r5]
L_92aca2:
	or r6,r6,0xa2000000
L_92acaa:
	extb r8,r7
L_92acae:
	mov_s r0,0x8020b0
L_92acb4:
	add2 r0,r0,r8
L_92acb8:
	st r6,[r0]
L_92acbc:
	add r7,r7,0x1
L_92acc0:
	st r7,[r5]
	.global L_92acc4
L_92acc4:
	mov_s r0,r13
L_92acc6:
	mov_s r1,0x0
L_92acc8:
	mov_s r2,0x1
L_92acca:
	mov_s r3,r2
L_92accc:
	bl.d L_92af4c
L_92acd0:
	mov r4,r2
	.global L_92acd4
L_92acd4:
	bl.d L_930770
L_92acd8:
	mov r0,r13
L_92acdc:
	ld.as r8,[r13,0x50]
L_92ace0:
	st.as r15,[r13,0x50]
L_92ace4:
	rsub.f r8,r8,0x1
L_92ace8:
	ldb r5,[r14, 0x68]
L_92acec:
	mov.cs r8,0x0
L_92acf0:
	ld r6,[r13, 0x20]
L_92acf4:
	norm r5,r5
L_92acf8:
	brne.d r6,0x1,L_92ad24
L_92acfc:
	rsub r4,r5,0x1e
L_92ad00:
	mov_s r0,r13
L_92ad02:
	mov_s r1,0x0
L_92ad04:
	mov r2,0x1
	.global L_92ad08
L_92ad08:
	mov r3,0x1
L_92ad0c:
	bl.d L_92af4c
L_92ad10:
	mov r4,r3
L_92ad14:
	ld blink,[sp, 0x4]
L_92ad18:
	ld_s r14,[sp,0x8]
L_92ad1a:
	ld_s r15,[sp,0xc]
L_92ad1c:
	j.d [blink]
L_92ad20:
	ld.ab r13,[sp,0x10]
	.global L_92ad24
L_92ad24:
	brne r6,0x2,L_92ad88
L_92ad28:
	asl r4,r4,0x2
L_92ad2c:
	add2 r4,r4,r4
L_92ad30:
	ldb r1,[r4,0x857849]
L_92ad38:
	cmp r1,0x0
L_92ad3c:
	cmp.eq r8,0x0
L_92ad40:
	mov.eq r0,r13
L_92ad44:
	mov.eq r1,0x1
L_92ad48:
	beq.d L_92ad08
L_92ad4c:
	mov.eq r2,0x0
L_92ad50:
	breq r8,0x0,L_92ad70
L_92ad54:
	ld.as r4,[gp,-0x26]
L_92ad58:
	ld blink,[sp, 0x4]
L_92ad5c:
	add r4,r4,0x1
L_92ad60:
	st.as r4,[gp,-0x26]
L_92ad64:
	ld_s r14,[sp,0x8]
L_92ad66:
	ld_s r15,[sp,0xc]
L_92ad68:
	j.d [blink]
L_92ad6c:
	ld.ab r13,[sp,0x10]
	.global L_92ad70
L_92ad70:
	ld.as r3,[gp,-0x2c]
L_92ad74:
	ld blink,[sp, 0x4]
L_92ad78:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_92ad7a:
	st.as r3,[gp,-0x2c]
L_92ad7e:
	ld_s r14,[sp,0x8]
L_92ad80:
	ld_s r15,[sp,0xc]
L_92ad82:
	j_s.d [blink]
L_92ad84:
	ld.ab r13,[sp,0x10]
	.global L_92ad88
L_92ad88:
	ld blink,[sp, 0x4]
L_92ad8c:
	ld_s r14,[sp,0x8]
L_92ad8e:
	ld_s r15,[sp,0xc]
L_92ad90:
	j.d [blink]
L_92ad94:
	ld.ab r13,[sp,0x10]
