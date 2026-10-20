/* mac__build_qset_mask @ 0x92f738, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__program_886e0c_20b
 * Глобалы (через gp): 0x800554
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__build_qset_mask
mac__build_qset_mask:
	.global L_92f738
L_92f738:
	push_s r13
L_92f73a:
	ld_s r2,[r0,0x2c]
L_92f73c:
	bmsk r0,r2,0x0
L_92f740:
	btst_s r2,0x3
L_92f742:
	mov.eq r1,r0
L_92f746:
	mov.ne r1,0x1
L_92f74a:
	lsr_s r2,r2,0x2
L_92f74c:
	bmsk_s r2,r2,0x0
L_92f74e:
	asl_s r13,r1
L_92f750:
	or_s r13,r13,r2
L_92f752:
	asl_s r3,r1,0x2
L_92f754:
	or_s r3,r3,r13
L_92f756:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_92f758:
	or_s r3,r3,r2
L_92f75a:
	asl_s r2,r1,0x5
L_92f75c:
	or_s r2,r2,r3
L_92f75e:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_92f760:
	or_s r2,r2,r1
L_92f762:
	asl r1,r0,0x9
L_92f766:
	or_s r1,r1,r2
L_92f768:
	asl r2,r0,0xa
L_92f76c:
	or_s r2,r2,r1
L_92f76e:
	asl r1,r0,0xd
L_92f772:
	or_s r1,r1,r2
L_92f774:
	asl r2,r0,0xe
L_92f778:
	or_s r2,r2,r1
L_92f77a:
	asl r1,r0,0x11
L_92f77e:
	or_s r1,r1,r2
L_92f780:
	asl r2,r0,0x12
L_92f784:
	or_s r2,r2,r1
L_92f786:
	asl r1,r0,0x15
L_92f78a:
	or_s r1,r1,r2
L_92f78c:
	asl_s r0,r0,0x16
L_92f78e:
	or_s r0,r0,r1
L_92f790:
	st.as r0,[gp,0xb]
L_92f794:
	j_s.d [blink]
L_92f796:
	pop_s r13
