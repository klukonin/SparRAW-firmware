/* queue_sel__get_qset4 @ 0x92b4b4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 */
	.section .text.queue_sel__get_qset4,"ax",@progbits
	.global queue_sel__get_qset4
queue_sel__get_qset4:
	.global L_92b4b4
L_92b4b4:
	st.a r13,[sp,-0x8]
L_92b4b8:
	st_s r14,[sp,0x4]
L_92b4ba:
	mov_s r14,blink
L_92b4bc:
	mov_s r13,r0
L_92b4be:
	mov_s r2,0xf000001
L_92b4c4:
	mov r32,r2
L_92b4c8:
	st.ab r2,[r25,0x4]
L_92b4cc:
	bclr r25,r25,0xa
L_92b4d0:
	ld.as r1,[gp,-0x11]
L_92b4d4:
	and r1,r1,0xfffff0ff
L_92b4dc:
	bset r0,r1,0x8
L_92b4e0:
	or r1,r1,0x1d000100
L_92b4e8:
	st.as r0,[gp,-0x11]
L_92b4ec:
	mov r32,r1
L_92b4f0:
	st.ab r1,[r25,0x4]
L_92b4f4:
	bclr r25,r25,0xa
L_92b4f8:
	nop_s
L_92b4fa:
	nop_s
L_92b4fc:
	nop_s
L_92b4fe:
	lsr r3,r41,0x18
L_92b502:
	bmsk_s r3,r3,0x4
L_92b504:
	st_s r3,[r13]
L_92b506:
	lsr r0,r41,0x1f
L_92b50a:
	mov_s blink,r14
L_92b50c:
	ld_s r14,[sp,0x4]
L_92b50e:
	j_s.d [blink]
L_92b510:
	ld.ab r13,[sp,0x8]
