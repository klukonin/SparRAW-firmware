/* background_bi_step @ 0x93c6d8, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: background_task__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bi__state_from_g800600, uc_pm__enter_idle, uc_tsf_elapsed
 * Глобалы (через gp): 0x80057c, 0x800580, 0x800588
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global background_bi_step
background_bi_step:
	.global L_93c6d8
L_93c6d8:
	push_s blink
L_93c6da:
	bl L_920234
L_93c6de:
	ld_s r0,[gp,0x60]
L_93c6e0:
	mov_s r14,0x1
L_93c6e2:
	breq r0,0x0,L_93c7a2
L_93c6e6:
	bl L_9282b4
L_93c6ea:
	mov_s r13,0x8014a4
L_93c6f0:
	brne r0,0x1,L_93c6fc
L_93c6f4:
	ld_s r0,[gp,-0x4c]
L_93c6f6:
	breq_s r0,0,L_93c6fc
L_93c6f8:
	ld_s r0,[r13,0x10]
L_93c6fa:
	brne_s r0,0,L_93c702
	.global L_93c6fc
L_93c6fc:
	mov_s r14,0x0
L_93c6fe:
	st_s r14,[r13,0x14]
L_93c700:
	b_s L_93c7a2
	.global L_93c702
L_93c702:
	mov_s r0,0xf000001
L_93c708:
	mov_s r32,r0
L_93c70a:
	st.ab r0,[r25,0x4]
L_93c70e:
	bclr r25,r25,0xa
L_93c712:
	ld_s r0,[gp,-0x44]
L_93c714:
	and r0,r0,0xfffff0ff
L_93c71c:
	bset r1,r0,0x8
L_93c720:
	bset_s r1,r1,0x9
L_93c722:
	or r0,r0,0x1d000300
L_93c72a:
	st.as r1,[gp,-0x11]
L_93c72e:
	mov_s r32,r0
L_93c730:
	st.ab r0,[r25,0x4]
L_93c734:
	bclr r25,r25,0xa
L_93c738:
	nop_s
L_93c73a:
	nop_s
L_93c73c:
	nop_s
L_93c73e:
	bclr.f 0x0,r41,0x1e
L_93c742:
	beq_s L_93c74c
L_93c744:
	mov_s r0,0x1
	.global L_93c746
L_93c746:
	st_s r0,[r13,0x14]
L_93c748:
	mov_s r14,0x0
L_93c74a:
	b_s L_93c7a2
	.global L_93c74c
L_93c74c:
	mov_s r0,r42
L_93c74e:
	btst_s r0,0x13
L_93c750:
	mov_s r0,0x2
L_93c752:
	bne_s L_93c746
L_93c754:
	ld_s r0,[r13,0x1c]
L_93c756:
	brne_s r0,0,L_93c798
L_93c758:
	bl.d L_92483c
L_93c75c:
	ld_s r0,[r13,0x8]
L_93c75e:
	ld.as r1,[gp,0x15]
L_93c762:
	cmp_s r0,r1
L_93c764:
	mov.cs r0,0x3
L_93c768:
	blo_s L_93c746
L_93c76a:
	mov_s r14,0x1
L_93c76c:
	mov_s r1,0x0
L_93c76e:
	b_s L_93c792
	.global L_93c770
L_93c770:
	asl_s r0,r1,0x2
L_93c772:
	add2_s r0,r0,r0
L_93c774:
	add_s r0,r0,0x857e38
L_93c77a:
	ldb_s r2,[r0,0x4]
L_93c77c:
	brne_s r2,0,L_93c782
L_93c77e:
	ldb_s r2,[r0,0x5]
L_93c780:
	breq_s r2,0,L_93c790
	.global L_93c782
L_93c782:
	ldw_s r2,[r0,0x2]
L_93c784:
	ld_s r0,[gp,0x58]
L_93c786:
	brhs r2,r0,L_93c790
L_93c78a:
	mov_s r0,0x4
L_93c78c:
	st_s r0,[r13,0x14]
L_93c78e:
	mov_s r14,0x0
	.global L_93c790
L_93c790:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_93c792
L_93c792:
	brlo r1,0x8,L_93c770
L_93c796:
	b_s L_93c79a
	.global L_93c798
L_93c798:
	mov_s r14,0x0
	.global L_93c79a
L_93c79a:
	cmp_s r14,0x0
L_93c79c:
	bl.ne.d L_93c7d4
L_93c7a0:
	sub_s.ne r0,r0,r0
	.global L_93c7a2
L_93c7a2:
	b.d L_9202a4
L_93c7a6:
	mov_s r0,r14
