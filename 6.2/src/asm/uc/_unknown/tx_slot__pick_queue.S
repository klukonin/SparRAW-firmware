/* tx_slot__pick_queue @ 0x9396f4, 252 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_slot__dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, uc_divmod_unsigned, uc_sysassert
 * Глобалы (через gp): 0x8005ec, 0x8005f0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global tx_slot__pick_queue
tx_slot__pick_queue:
	.global L_9396f4
L_9396f4:
	push_s blink
L_9396f6:
	bl L_92022c
L_9396fa:
	mov_s r14,r0
L_9396fc:
	mov_s r16,r1
L_9396fe:
	mov_s r0,0xf000001
L_939704:
	mov_s r32,r0
L_939706:
	st.ab r0,[r25,0x4]
L_93970a:
	bclr r25,r25,0xa
L_93970e:
	ld_s r0,[gp,-0x44]
L_939710:
	and r0,r0,0xfffff0ff
L_939718:
	st.as r0,[gp,-0x11]
L_93971c:
	or r0,r0,0x1d000000
L_939724:
	mov_s r32,r0
L_939726:
	st.ab r0,[r25,0x4]
L_93972a:
	bclr r25,r25,0xa
L_93972e:
	nop_s
L_939730:
	nop_s
L_939732:
	nop_s
L_939734:
	lsr r13,r41,0x8
L_939738:
	bmsk_s r13,r13,0x3
L_93973a:
	lsr r15,r41,0x10
L_93973e:
	bmsk_s r15,r15,0x4
L_939740:
	st_s r15,[r14]
L_939742:
	brhs.d r13,0x7,L_939752
L_939746:
	sub_s r14,r13,0x1
L_939748:
	mov_s r0,r14
L_93974a:
	bl.d L_9203e0
L_93974e:
	mov_s r1,0x3
L_939750:
	b_s L_939756
	.global L_939752
L_939752:
	bmsk r1,r14,0x0
	.global L_939756
L_939756:
	cmp_s r13,0x0
L_939758:
	mov.eq r0,0x0
L_93975c:
	beq_s L_9397ea
L_93975e:
	brne r16,0x1,L_9397e8
L_939762:
	brhs r14,0x8,L_9397e0
L_939766:
	ldb.x r14,[0x801a8c,r14]
L_93976e:
	add r0,pcl,0xc
L_939772:
	add1_s r0,r0,r14
L_939774:
	/* j_s.d r0 */
	.byte 0x20,0x78
L_939776:
	/* _add_s r15,0x1 */
	.byte 0x01,0xe7
L_939778:
	mov_s r0,0x8029f8
L_93977e:
	sub3 r2,r0,0x10
L_939782:
	add2_s r2,r2,r1
L_939784:
	st r15,[r2, 0x84]
L_939788:
	ld_s r2,[r0,0x4]
L_93978a:
	ld_s r1,[r0,0x8]
L_93978c:
	bset_s r2,r2,0x18
L_93978e:
	asl_s r1,r1,0x8
L_939790:
	bset_s r2,r2,0x1c
L_939792:
	ld_s r0,[r0,0xc]
L_939794:
	or_s r1,r1,r2
	.global L_939796
L_939796:
	asl_s r0,r0,0x10
L_939798:
	or_s r0,r0,r1
L_93979a:
	b_s L_9397d4
L_93979c:
	mov_s r0,0x8029f8
L_9397a2:
	sub3 r2,r0,0x10
L_9397a6:
	add2_s r2,r2,r1
L_9397a8:
	st r15,[r2, 0x90]
L_9397ac:
	ld_s r2,[r0,0x10]
L_9397ae:
	ld_s r1,[r0,0x14]
L_9397b0:
	bset_s r2,r2,0x19
L_9397b2:
	bset_s r2,r2,0x1c
L_9397b4:
	asl_s r1,r1,0x8
L_9397b6:
	or_s r1,r1,r2
L_9397b8:
	ld_s r0,[r0,0x18]
L_9397ba:
	b_s L_939796
L_9397bc:
	add2 r0,gp,r1
L_9397c0:
	st.as r15,[r0,0x31]
L_9397c4:
	ld_s r0,[gp,0xc4]
L_9397c6:
	ld.as r1,[gp,0x32]
L_9397ca:
	bset_s r0,r0,0x18
L_9397cc:
	bset_s r0,r0,0x19
L_9397ce:
	bset_s r0,r0,0x1c
L_9397d0:
	asl_s r1,r1,0x8
L_9397d2:
	or_s r0,r0,r1
	.global L_9397d4
L_9397d4:
	mov_s r32,r0
L_9397d6:
	st.ab r0,[r25,0x4]
L_9397da:
	bclr r25,r25,0xa
L_9397de:
	b_s L_9397e8
	.global L_9397e0
L_9397e0:
	mov_s r0,blink
L_9397e2:
	bl.d L_926618
L_9397e6:
	mov_s r1,0x8e
	.global L_9397e8
L_9397e8:
	mov_s r0,0x1
	.global L_9397ea
L_9397ea:
	b L_920294
L_9397ee:
	nop_s
