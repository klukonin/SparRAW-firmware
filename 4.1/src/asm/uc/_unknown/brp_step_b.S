/* brp_step_b @ 0x923870, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__switch_sequence
 * Зовёт сам: __ld_r15_to_r13_ret_uc, __st_r15_to_r13_uc, brp__write_reg_pair
 */
	.section .text.brp_step_b,"ax",@progbits
	.global brp_step_b
brp_step_b:
	.global L_923870
L_923870:
	push_s blink
L_923872:
	bl L_920210
L_923876:
	mov_s r0,0x80102c
L_92387c:
	ldb_s r13,[r0,0x8]
L_92387e:
	b_s L_923928
	.global L_923880
L_923880:
	norm r0,r13
L_923884:
	rsub r14,r0,0x1e
L_923888:
	bclr r13,r13,r14
L_92388c:
	asl_s r15,r14,0x6
L_92388e:
	add1_s r15,r15,r15
L_923890:
	add_s r15,r15,0x4800
L_923896:
	add r0,r15,0x10020
L_92389e:
	lsr_s r0,r0,0x3
L_9238a0:
	bic r0,r0,0x3
L_9238a4:
	/* asl_s r14,r14,0x3 */
	.byte 0x03,0xbe
L_9238a6:
	add1_s r14,r14,r14
L_9238a8:
	add_s r14,r14,0x80078c
L_9238ae:
	bl.d L_92bcac
L_9238b2:
	ld_s r1,[r14]
L_9238b4:
	add r0,r15,0x10000
L_9238bc:
	lsr_s r0,r0,0x3
L_9238be:
	bic r0,r0,0x3
L_9238c2:
	bl.d L_92bcac
L_9238c6:
	ld_s r1,[r14,0x4]
L_9238c8:
	add r0,r15,0x10060
L_9238d0:
	lsr_s r0,r0,0x3
L_9238d2:
	bic r0,r0,0x3
L_9238d6:
	bl.d L_92bcac
L_9238da:
	ld_s r1,[r14,0x8]
L_9238dc:
	add r0,r15,0x10040
L_9238e4:
	lsr_s r0,r0,0x3
L_9238e6:
	bic r0,r0,0x3
L_9238ea:
	bl.d L_92bcac
L_9238ee:
	ld_s r1,[r14,0xc]
L_9238f0:
	add r0,r15,0x100a0
L_9238f8:
	lsr_s r0,r0,0x3
L_9238fa:
	bic r0,r0,0x3
L_9238fe:
	bl.d L_92bcac
L_923902:
	ld_s r1,[r14,0x10]
L_923904:
	add r0,r15,0x10080
L_92390c:
	lsr_s r0,r0,0x3
L_92390e:
	bic r0,r0,0x3
L_923912:
	bl.d L_92bcac
L_923916:
	ld_s r1,[r14,0x14]
L_923918:
	mov_s r1,0x801090
L_92391e:
	ldb_s r0,[r1,0xd]
L_923920:
	extb_s r13,r13
L_923922:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923924:
	extb_s r0,r0
L_923926:
	stb_s r0,[r1,0xd]
	.global L_923928
L_923928:
	brne r13,0x0,L_923880
L_92392c:
	b L_92027c
