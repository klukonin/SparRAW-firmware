/* fsched__pick_queue_r41 @ 0x9397f0, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_initiator_flow_fixed_scheduling
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fsched__pick_ready_queue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__pick_queue_r41
fsched__pick_queue_r41:
	.global L_9397f0
L_9397f0:
	push_s blink
L_9397f2:
	bl L_920234
L_9397f6:
	mov_s r13,r0
L_9397f8:
	mov_s r0,0x8014a4
L_9397fe:
	ld_s r0,[r0,0x1c]
L_939800:
	brne_s r0,0,L_93980e
L_939802:
	bl.d L_92be90
L_939806:
	mov_s r0,r13
L_939808:
	breq_s r0,0,L_93980e
	.global L_93980a
L_93980a:
	mov_s r0,0x1
L_93980c:
	b_s L_939884
	.global L_93980e
L_93980e:
	ld_s r0,[gp,-0x44]
L_939810:
	and r0,r0,0xfffff0ff
L_939818:
	bset r1,r0,0x8
L_93981c:
	bset_s r1,r1,0x9
L_93981e:
	bset_s r1,r1,0xb
L_939820:
	or r0,r0,0x1d000b00
L_939828:
	st.as r1,[gp,-0x11]
L_93982c:
	mov_s r32,r0
L_93982e:
	st.ab r0,[r25,0x4]
L_939832:
	bclr r25,r25,0xa
L_939836:
	nop_s
L_939838:
	nop_s
L_93983a:
	nop_s
L_93983c:
	mov_s r14,r41
L_93983e:
	ld_s r0,[gp,-0x44]
L_939840:
	and r0,r0,0xfffff0ff
L_939848:
	bset r1,r0,0xa
L_93984c:
	bset_s r1,r1,0xb
L_93984e:
	or r0,r0,0x1d000c00
L_939856:
	st.as r1,[gp,-0x11]
L_93985a:
	mov_s r32,r0
L_93985c:
	st.ab r0,[r25,0x4]
L_939860:
	bclr r25,r25,0xa
L_939864:
	nop_s
L_939866:
	nop_s
L_939868:
	nop_s
L_93986a:
	or r0,r41,r14
L_93986e:
	bmsk.f r0,r0,0x9
L_939872:
	beq_s L_939880
L_939874:
	norm r0,r0
L_939878:
	rsub r1,r0,0x1e
L_93987c:
	st_s r1,[r13]
L_93987e:
	b_s L_93980a
	.global L_939880
L_939880:
	mov_s r0,0x0
L_939882:
	st_s r0,[r13]
	.global L_939884
L_939884:
	b L_9202a4
