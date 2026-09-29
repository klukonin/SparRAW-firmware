/* bf__reset_sta_slot @ 0x92484c, 276 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__abort_unexpected, bf_init_sm
 * Зовёт сам: __ld_r14_to_r13_ret, __ld_r15_to_r13_ret, __st_r14_to_r13, __st_r15_to_r13, bf_req__try_claim, internal_tx__clear_pending_bit, memcpy_uc, memset0_words_uc, ppdu__unpack_desc_word, uc_evt__send_20, uc_evt__send_21, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__reset_sta_slot
bf__reset_sta_slot:
	.global L_92484c
L_92484c:
	push_s blink
L_92484e:
	bl L_920230
L_924852:
	mov_s r13,r0
L_924854:
	asl_s r14,r0,0x2
L_924856:
	add2_s r14,r14,r14
L_924858:
	add_s r14,r14,0x801ffc
L_92485e:
	ld_s r15,[r14,0xc]
L_924860:
	ld_s r0,[gp,-0xb8]
L_924862:
	cmp_s r13,r0
L_924864:
	bl.eq.d L_92bd70
L_924868:
	mov.eq r0,0x3
L_92486c:
	ld_s r0,[r15,0x4]
L_92486e:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_924870:
	st_s r0,[r14,0x10]
L_924872:
	mov_s r0,0x800fec
L_924878:
	st_s r0,[r14,0xc]
L_92487a:
	add2_s r13,r13,r13
L_92487c:
	add_s r13,r13,0x857e38
L_924882:
	ldb_s r0,[r13,0x11]
L_924884:
	mov_s r1,0x800688
L_92488a:
	bclr_s r0,r0,0x6
L_92488c:
	stb_s r0,[r13,0x11]
L_92488e:
	ld_s r0,[r1,0x8]
L_924890:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_924892:
	b.d L_92029c
L_924896:
	st_s r0,[r1,0x8]
L_924898:
	push_s blink
L_92489a:
	bl.d L_920230
L_92489e:
	mov_s r1,0x1
L_9248a0:
	bl.d L_936184
L_9248a4:
	mov_s r14,r0
L_9248a6:
	breq_s r0,0,L_924900
	.global L_9248a8
L_9248a8:
	ld_s r2,[r14,0x58]
L_9248aa:
	mov_s r13,0x857200
L_9248b0:
	mov_s r15,0x857280
L_9248b6:
	breq_s r2,0,L_9248de
L_9248b8:
	brhs r2,0x15,L_9248de
L_9248bc:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_9248be:
	add2 r0,r13,0x29
L_9248c2:
	bl.d L_920330
L_9248c6:
	add2 r1,r14,0x17
L_9248ca:
	ld_s r2,[r14,0x58]
L_9248cc:
	add2 r0,r13,0x3d
L_9248d0:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_9248d2:
	bl.d L_920330
L_9248d6:
	add2 r1,r14,0x2b
L_9248da:
	ld_s r0,[r14,0x58]
L_9248dc:
	st_s r0,[r15,0x20]
	.global L_9248de
L_9248de:
	ld_s r0,[r14,0x14]
L_9248e0:
	ld_s r1,[r14,0x10]
L_9248e2:
	st r0,[r13, 0x94]
L_9248e6:
	st r1,[r13, 0x90]
L_9248ea:
	ld_s r0,[r14,0x1c]
L_9248ec:
	ld_s r1,[r14,0x18]
L_9248ee:
	st r0,[r13, 0x9c]
L_9248f2:
	st r1,[r13, 0x98]
L_9248f6:
	bl.d L_92785c
L_9248fa:
	ldb_s r0,[r14,0xc]
L_9248fc:
	b L_92029c
	.global L_924900
L_924900:
	mov_s r0,blink
L_924902:
	bl.d L_926618
L_924906:
	mov_s r1,0x9a
L_924908:
	b_s L_9248a8
L_92490a:
	nop_s
L_92490c:
	push_s blink
L_92490e:
	bl.d L_920234
L_924912:
	mov_s r1,0x2
L_924914:
	sub_s sp,sp,0x20
L_924916:
	bl.d L_936184
L_92491a:
	mov_s r14,r0
L_92491c:
	breq_s r0,0,L_924954
	.global L_92491e
L_92491e:
	mov_s r0,sp
L_924920:
	bl.d L_920a84
L_924924:
	mov_s r1,0x20
L_924926:
	add_s r1,sp,0x8
L_924928:
	add_s r2,sp,0xc
L_92492a:
	add_s r3,sp,0x10
L_92492c:
	add_s r13,sp,0x14
L_92492e:
	add r5,sp,0x18
L_924932:
	ld_s r0,[r14,0x54]
L_924934:
	mov_s r4,r13
L_924936:
	bl.d L_9297ac
L_92493a:
	add r6,sp,0x1c
L_92493e:
	ld_s r1,[r14,0x18]
L_924940:
	ld_s r0,[r14,0x1c]
L_924942:
	st_s r1,[sp,0x0]
L_924944:
	st_s r0,[sp,0x4]
L_924946:
	mov_s r1,sp
L_924948:
	bl.d L_9278c8
L_92494c:
	ldb_s r0,[r14,0xc]
L_92494e:
	b.d L_9202a4
L_924952:
	add_s sp,sp,0x20
	.global L_924954
L_924954:
	mov_s r0,blink
L_924956:
	bl.d L_926618
L_92495a:
	mov_s r1,0x9b
L_92495c:
	b_s L_92491e
L_92495e:
	nop_s
