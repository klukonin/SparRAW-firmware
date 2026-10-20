/* ucode_cmd_0x38_handler @ 0x92e4b4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x38_handler
ucode_cmd_0x38_handler:
	.global L_92e4b4
L_92e4b4:
	push_s blink
L_92e4b6:
	bl L_920230
L_92e4ba:
	mov_s r14,r0
L_92e4bc:
	mov_s r15,r1
L_92e4be:
	ld_s r1,[r14]
L_92e4c0:
	mov_s r0,0x0
L_92e4c2:
	brne r1,0x4,L_92e4ce
L_92e4c6:
	ld_s r1,[r14,0xc]
L_92e4c8:
	cmp_s r1,0x2
L_92e4ca:
	mov.eq r0,0x1
	.global L_92e4ce
L_92e4ce:
	extb.f 0x0,r0
L_92e4d2:
	beq_s L_92e540
L_92e4d4:
	ld_s r0,[gp,-0x44]
L_92e4d6:
	add r13,r14,0x18
L_92e4da:
	and r0,r0,0xffff0fff
L_92e4e2:
	bset r1,r0,0xc
L_92e4e6:
	bset_s r1,r1,0xe
L_92e4e8:
	st.as r1,[gp,-0x11]
L_92e4ec:
	or r0,r0,0x1d005000
L_92e4f4:
	mov_s r32,r0
L_92e4f6:
	st.ab r0,[r25,0x4]
L_92e4fa:
	bclr r25,r25,0xa
L_92e4fe:
	nop_s
L_92e500:
	nop_s
L_92e502:
	nop_s
L_92e504:
	st r40,[r13]
L_92e508:
	ld_s r0,[gp,-0x44]
L_92e50a:
	and r0,r0,0xffff0fff
L_92e512:
	bset r1,r0,0xd
L_92e516:
	bset_s r1,r1,0xe
L_92e518:
	or r0,r0,0x1d006000
L_92e520:
	st.as r1,[gp,-0x11]
L_92e524:
	mov_s r32,r0
L_92e526:
	st.ab r0,[r25,0x4]
L_92e52a:
	bclr r25,r25,0xa
L_92e52e:
	nop_s
L_92e530:
	nop_s
L_92e532:
	nop_s
L_92e534:
	st r40,[r13, 0x4]
L_92e538:
	st_s r15,[r14,0xc]
L_92e53a:
	bl.d L_9216f8
L_92e53e:
	mov_s r0,0x0
	.global L_92e540
L_92e540:
	b L_92029c
