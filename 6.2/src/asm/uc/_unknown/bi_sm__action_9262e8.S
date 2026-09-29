/* bi_sm__action_9262e8 @ 0x9262e8, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_9262e8
bi_sm__action_9262e8:
	.global L_9262e8
L_9262e8:
	push_s r13
L_9262ea:
	mov_s r13,blink
L_9262ec:
	mov_s r2,0xcaf550
L_9262f2:
	mov_s r32,r2
L_9262f4:
	st.ab r2,[r25,0x4]
L_9262f8:
	bclr r25,r25,0xa
L_9262fc:
	mov_s r1,0x802ec0
L_926302:
	ldw_s r0,[r1,0xe]
L_926304:
	mov_s blink,r13
L_926306:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_926308:
	stw_s r0,[r1,0xe]
L_92630a:
	j_s.d [blink]
L_92630c:
	pop_s r13
L_92630e:
	nop_s
