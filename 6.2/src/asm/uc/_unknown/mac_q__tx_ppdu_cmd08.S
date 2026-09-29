/* mac_q__tx_ppdu_cmd08 @ 0x93a6d8, 200 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x08_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_q__tx_ppdu_cmd08
mac_q__tx_ppdu_cmd08:
	.global L_93a6d8
L_93a6d8:
	push_s blink
L_93a6da:
	bl L_920234
L_93a6de:
	mov_s r13,r0
L_93a6e0:
	ld_s r0,[gp,-0xac]
L_93a6e2:
	cmp_s r0,0x0
L_93a6e4:
	mov_s r14,r1
L_93a6e6:
	beq_s L_93a79c
L_93a6e8:
	mov_s r0,0x886500
L_93a6ee:
	ld_s r0,[r0,0x6c]
L_93a6f0:
	bmsk.f 0x0,r0,0x3
L_93a6f4:
	mov.ne r0,blink
L_93a6f8:
	bl.ne.d L_926618
L_93a6fc:
	mov.ne r1,0x3
L_93a700:
	mov_s r0,0x1c000006
L_93a706:
	mov_s r32,r0
L_93a708:
	st.ab r0,[r25,0x4]
L_93a70c:
	bclr r25,r25,0xa
L_93a710:
	asl_s r0,r13,0x4
L_93a712:
	or r0,r0,0x4600400b
L_93a71a:
	mov_s r32,r0
L_93a71c:
	st.ab r0,[r25,0x4]
L_93a720:
	bclr r25,r25,0xa
L_93a724:
	mov_s r1,0x8022c8
L_93a72a:
	ld_s r0,[r1,0x14]
L_93a72c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_93a72e:
	st_s r0,[r1,0x14]
	.global L_93a730
L_93a730:
	mov_s r0,r53
L_93a732:
	bbit0 r0,0x2,L_93a730
L_93a736:
	ld_s r0,[gp,-0x44]
L_93a738:
	and r0,r0,0xfff0ffff
L_93a740:
	bset r1,r0,0x10
L_93a744:
	or r0,r0,0x1d010000
L_93a74c:
	st.as r1,[gp,-0x11]
L_93a750:
	mov_s r32,r0
L_93a752:
	st.ab r0,[r25,0x4]
L_93a756:
	bclr r25,r25,0xa
L_93a75a:
	nop_s
L_93a75c:
	nop_s
L_93a75e:
	nop_s
	.global L_93a760
L_93a760:
	mov_s r0,r47
L_93a762:
	bbit1 r0,0x0,L_93a760
L_93a766:
	asl_s r14,r14,0x8
L_93a768:
	bset_s r14,r14,0x1a
L_93a76a:
	bset_s r14,r14,0x1e
L_93a76c:
	or_s r13,r13,r14
L_93a76e:
	bset_s r13,r13,0x13
L_93a770:
	bset_s r13,r13,0x15
L_93a772:
	mov_s r32,r13
L_93a774:
	st.ab r13,[r25,0x4]
L_93a778:
	bclr r25,r25,0xa
L_93a77c:
	mov_s r0,0x45000001
L_93a782:
	mov_s r32,r0
L_93a784:
	st.ab r0,[r25,0x4]
L_93a788:
	bclr r25,r25,0xa
L_93a78c:
	mov_s r0,0x460001f1
L_93a792:
	mov_s r32,r0
L_93a794:
	st.ab r0,[r25,0x4]
L_93a798:
	bclr r25,r25,0xa
	.global L_93a79c
L_93a79c:
	b L_9202a4
