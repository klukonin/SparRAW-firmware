/* ucode_cmd_0x2f_handler @ 0x928168, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_pending__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x2f_handler
ucode_cmd_0x2f_handler:
	.global L_928168
L_928168:
	push_s blink
L_92816a:
	bl L_920230
L_92816e:
	mov_s r14,r0
L_928170:
	mov_s r15,r1
L_928172:
	ld_s r1,[r14]
L_928174:
	mov_s r0,0x0
L_928176:
	brne r1,0x3,L_928182
L_92817a:
	ld_s r1,[r14,0xc]
L_92817c:
	cmp_s r1,0x2
L_92817e:
	mov.eq r0,0x1
	.global L_928182
L_928182:
	extb.f 0x0,r0
L_928186:
	beq_s L_9281f4
L_928188:
	ld_s r0,[gp,-0x44]
L_92818a:
	add r13,r14,0x18
L_92818e:
	and r0,r0,0xffff0fff
L_928196:
	bset r1,r0,0xc
L_92819a:
	bset_s r1,r1,0xe
L_92819c:
	st.as r1,[gp,-0x11]
L_9281a0:
	or r0,r0,0x1d005000
L_9281a8:
	mov_s r32,r0
L_9281aa:
	st.ab r0,[r25,0x4]
L_9281ae:
	bclr r25,r25,0xa
L_9281b2:
	nop_s
L_9281b4:
	nop_s
L_9281b6:
	nop_s
L_9281b8:
	st r40,[r13]
L_9281bc:
	ld_s r0,[gp,-0x44]
L_9281be:
	and r0,r0,0xffff0fff
L_9281c6:
	bset r1,r0,0xd
L_9281ca:
	bset_s r1,r1,0xe
L_9281cc:
	or r0,r0,0x1d006000
L_9281d4:
	st.as r1,[gp,-0x11]
L_9281d8:
	mov_s r32,r0
L_9281da:
	st.ab r0,[r25,0x4]
L_9281de:
	bclr r25,r25,0xa
L_9281e2:
	nop_s
L_9281e4:
	nop_s
L_9281e6:
	nop_s
L_9281e8:
	st r40,[r13, 0x4]
L_9281ec:
	st_s r15,[r14,0xc]
L_9281ee:
	bl.d L_9216f8
L_9281f2:
	mov_s r0,0x0
	.global L_9281f4
L_9281f4:
	b L_92029c
