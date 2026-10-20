/* ucode_cmd_0x2b_handler @ 0x9360a4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x2b_handler
ucode_cmd_0x2b_handler:
	.global L_9360a4
L_9360a4:
	push_s blink
L_9360a6:
	bl L_920230
L_9360aa:
	mov_s r14,r0
L_9360ac:
	mov_s r15,r1
L_9360ae:
	ld_s r1,[r14]
L_9360b0:
	mov_s r0,0x0
L_9360b2:
	brne r1,0x2,L_9360be
L_9360b6:
	ld_s r1,[r14,0xc]
L_9360b8:
	cmp_s r1,0x2
L_9360ba:
	mov.eq r0,0x1
	.global L_9360be
L_9360be:
	extb.f 0x0,r0
L_9360c2:
	beq_s L_936130
L_9360c4:
	ld_s r0,[gp,-0x44]
L_9360c6:
	add r13,r14,0x18
L_9360ca:
	and r0,r0,0xffff0fff
L_9360d2:
	bset r1,r0,0xc
L_9360d6:
	bset_s r1,r1,0xe
L_9360d8:
	st.as r1,[gp,-0x11]
L_9360dc:
	or r0,r0,0x1d005000
L_9360e4:
	mov_s r32,r0
L_9360e6:
	st.ab r0,[r25,0x4]
L_9360ea:
	bclr r25,r25,0xa
L_9360ee:
	nop_s
L_9360f0:
	nop_s
L_9360f2:
	nop_s
L_9360f4:
	st r40,[r13]
L_9360f8:
	ld_s r0,[gp,-0x44]
L_9360fa:
	and r0,r0,0xffff0fff
L_936102:
	bset r1,r0,0xd
L_936106:
	bset_s r1,r1,0xe
L_936108:
	or r0,r0,0x1d006000
L_936110:
	st.as r1,[gp,-0x11]
L_936114:
	mov_s r32,r0
L_936116:
	st.ab r0,[r25,0x4]
L_93611a:
	bclr r25,r25,0xa
L_93611e:
	nop_s
L_936120:
	nop_s
L_936122:
	nop_s
L_936124:
	st r40,[r13, 0x4]
L_936128:
	st_s r15,[r14,0xc]
L_93612a:
	bl.d L_9216f8
L_93612e:
	mov_s r0,0x0
	.global L_936130
L_936130:
	b L_92029c
