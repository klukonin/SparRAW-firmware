/* mac_mode__enter_idle_seq @ 0x9375cc, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_pm__enter_idle
 * Зовёт сам: __ld_r13_to_r13_ret, mac__set_mode_a000, rfc__issue_cmd_10
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode__enter_idle_seq
mac_mode__enter_idle_seq:
	.global L_9375cc
L_9375cc:
	push_s blink
L_9375ce:
	push_s r13
L_9375d0:
	bl.d L_92a754
L_9375d4:
	mov_s r13,r0
L_9375d6:
	mov_s r0,0x8014a4
L_9375dc:
	ld_s r0,[r0,0x18]
L_9375de:
	bbit0 r0,0x0,L_9375fc
L_9375e2:
	mov_s r0,0x83
L_9375e4:
	asl_s r0,r0,0x19
L_9375e6:
	mov_s r32,r0
L_9375e8:
	st.ab r0,[r25,0x4]
L_9375ec:
	bclr r25,r25,0xa
L_9375f0:
	nop_s
L_9375f2:
	nop_s
L_9375f4:
	nop_s
L_9375f6:
	bl.d L_92f868
L_9375fa:
	ld_s r0,[gp,-0xc]
	.global L_9375fc
L_9375fc:
	mov_s r0,0x3d000001
L_937602:
	mov_s r32,r0
L_937604:
	st.ab r0,[r25,0x4]
L_937608:
	bclr r25,r25,0xa
L_93760c:
	nop_s
L_93760e:
	nop_s
L_937610:
	nop_s
L_937612:
	mov_s r0,0x3d000002
L_937618:
	mov_s r32,r0
L_93761a:
	st.ab r0,[r25,0x4]
L_93761e:
	bclr r25,r25,0xa
L_937622:
	nop_s
L_937624:
	nop_s
L_937626:
	nop_s
L_937628:
	breq r13,0x0,L_937688
L_93762c:
	mov_s r0,0x8014a4
L_937632:
	ld_s r0,[r0,0x1c]
L_937634:
	brne_s r0,0,L_937662
L_937636:
	mov_s r0,0x80212c
L_93763c:
	ldb r0,[r0, 0x68]
L_937640:
	brne_s r0,0,L_937662
L_937642:
	mov_s r0,0x0
L_937644:
	bset_s r0,r0,0x18
L_937646:
	mov_s r32,r0
L_937648:
	st.ab r0,[r25,0x4]
L_93764c:
	bclr r25,r25,0xa
L_937650:
	mov_s r0,0x20c0010
L_937656:
	mov_s r32,r0
L_937658:
	st.ab r0,[r25,0x4]
L_93765c:
	bclr r25,r25,0xa
L_937660:
	b_s L_937688
	.global L_937662
L_937662:
	mov_s r0,0x10
L_937664:
	bset_s r0,r0,0x18
L_937666:
	mov_s r32,r0
L_937668:
	st.ab r0,[r25,0x4]
L_93766c:
	bclr r25,r25,0xa
L_937670:
	mov_s r0,0x83
L_937672:
	asl_s r0,r0,0x12
L_937674:
	mov_s r32,r0
L_937676:
	st.ab r0,[r25,0x4]
L_93767a:
	bclr r25,r25,0xa
L_93767e:
	mov_s r1,0x0
L_937680:
	mov_s r0,0x886d00
L_937686:
	st_s r1,[r0,0x38]
	.global L_937688
L_937688:
	b L_9202ac
