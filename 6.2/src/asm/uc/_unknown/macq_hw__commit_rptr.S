/* macq_hw__commit_rptr @ 0x92a640, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__disconnect_flush
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq_hw__commit_rptr
macq_hw__commit_rptr:
	.global L_92a640
L_92a640:
	st.a r13,[sp,-0xc]
L_92a644:
	st blink,[sp, 0x4]
L_92a648:
	st_s r14,[sp,0x8]
L_92a64a:
	mov_s r13,r0
L_92a64c:
	asl_s r2,r0,0x3
L_92a64e:
	sub_s r2,r2,r0
L_92a650:
	/* asl_s r2,r2,0x7 */
	.byte 0x07,0xba
L_92a652:
	add r0,r2,0x4409880
L_92a65a:
	lsr r1,r0,0x3
L_92a65e:
	bic r1,r1,0x3
L_92a662:
	ld_s r14,[r1]
L_92a664:
	bmsk_s r0,r0,0x4
L_92a666:
	lsr_s r14,r14,r0
L_92a668:
	extw_s r14,r14
L_92a66a:
	add_s r2,r2,0x44098e0
L_92a670:
	lsr_s r2,r2,0x3
L_92a672:
	st_s r14,[r2]
L_92a674:
	sync
L_92a678:
	bset_s r14,r14,0x1f
L_92a67a:
	asl_s r3,r13,0x3
L_92a67c:
	sub_s r3,r3,r13
L_92a67e:
	/* asl_s r3,r3,0x7 */
	.byte 0x07,0xbb
L_92a680:
	add_s r3,r3,0x44098e0
L_92a686:
	lsr_s r3,r3,0x3
L_92a688:
	st r14,[r3]
L_92a68c:
	sync
L_92a690:
	ld blink,[sp, 0x4]
L_92a694:
	ld_s r14,[sp,0x8]
L_92a696:
	j_s.d [blink]
L_92a698:
	ld.ab r13,[sp,0xc]
