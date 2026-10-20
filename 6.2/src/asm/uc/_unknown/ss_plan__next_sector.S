/* ss_plan__next_sector @ 0x935878, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_txss_sweep_step, txss__set_sweep_param
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ss_plan__next_sector
ss_plan__next_sector:
	.global L_935878
L_935878:
	push_s r13
L_93587a:
	push_s r14
L_93587c:
	breq_s r1,0,L_935882
L_93587e:
	mov_s r2,0x0
L_935880:
	st_s r2,[r1]
	.global L_935882
L_935882:
	mov_s r14,0x802e4c
L_935888:
	ldb_s r13,[r14,0x10]
L_93588a:
	breq_s r13,0,L_9358ac
L_93588c:
	ldb_s r2,[r14,0x15]
L_93588e:
	cmp_s r2,0x40
L_935890:
	beq_s L_9358ac
L_935892:
	mov_s r3,0x802e0c
L_935898:
	sub r3,r3,0x320
L_93589c:
	add_s r3,r3,r2
L_93589e:
	ldb r3,[r3,0x328]
L_9358a6:
	cmp r3,0xff
L_9358aa:
	bne_s L_9358f6
	.global L_9358ac
L_9358ac:
	ldb_s r3,[r14,0x13]
L_9358ae:
	mov_s r2,0x0
L_9358b0:
	brlt.d r3,0x2,L_9358f2
L_9358b4:
	stb_s r2,[r14,0x15]
L_9358b6:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_9358b8:
	extb_s r3,r3
L_9358ba:
	stb_s r3,[r14,0x13]
L_9358bc:
	breq_s r1,0,L_9358c8
L_9358be:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_9358c0:
	extb_s r13,r13
L_9358c2:
	stb_s r13,[r14,0x10]
L_9358c4:
	mov_s r2,0x1
L_9358c6:
	st_s r2,[r1]
	.global L_9358c8
L_9358c8:
	ldb_s r1,[r14,0x15]
L_9358ca:
	mov_s r2,0x802e0c
L_9358d0:
	sub r2,r2,0x320
L_9358d4:
	add_s r2,r2,r1
L_9358d6:
	ldb r2,[r2,0x328]
L_9358de:
	ldb_s r3,[r14,0x14]
L_9358e0:
	stb_s r2,[r14,0x11]
L_9358e2:
	add_s r2,r2,r3
L_9358e4:
	extb_s r2,r2
L_9358e6:
	stb_s r2,[r14,0x12]
L_9358e8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9358ea:
	extb_s r1,r1
L_9358ec:
	stb_s r1,[r14,0x15]
L_9358ee:
	ldb_s r13,[r14,0x10]
L_9358f0:
	b_s L_935906
	.global L_9358f2
L_9358f2:
	mov_s r0,r2
L_9358f4:
	b_s L_935920
	.global L_9358f6
L_9358f6:
	ldb_s r1,[r14,0x14]
L_9358f8:
	stb_s r3,[r14,0x11]
L_9358fa:
	add_s r3,r3,r1
L_9358fc:
	extb_s r3,r3
L_9358fe:
	stb_s r3,[r14,0x12]
L_935900:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_935902:
	extb_s r2,r2
L_935904:
	stb_s r2,[r14,0x15]
	.global L_935906
L_935906:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_935908:
	extb_s r13,r13
L_93590a:
	stb_s r13,[r14,0x10]
L_93590c:
	ldw_s r2,[r0,0x2]
L_93590e:
	ldw_s r1,[r0,0x4]
L_935910:
	add_s r1,r1,r2
L_935912:
	mov_s r2,0x802dec
L_935918:
	ld_s r0,[r2,0x68]
L_93591a:
	sub_s r0,r0,r1
L_93591c:
	st_s r0,[r2,0x68]
L_93591e:
	mov_s r0,0x1
	.global L_935920
L_935920:
	pop_s r14
L_935922:
	j_s.d [blink]
L_935924:
	pop_s r13
L_935926:
	nop_s
