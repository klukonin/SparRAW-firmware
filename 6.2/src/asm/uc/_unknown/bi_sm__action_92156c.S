/* bi_sm__action_92156c @ 0x92156c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_92156c
bi_sm__action_92156c:
	.global L_92156c
L_92156c:
	push_s r13
L_92156e:
	mov_s r13,blink
L_921570:
	mov r5,0xcaf660
L_921578:
	mov r32,r5
L_92157c:
	st.ab r5,[r25,0x4]
L_921580:
	bclr r25,r25,0xa
L_921584:
	mov r4,0x2000010
L_92158c:
	mov r32,r4
L_921590:
	st.ab r4,[r25,0x4]
L_921594:
	bclr r25,r25,0xa
L_921598:
	mov_s r3,0x802ec0
L_92159e:
	ldw_s r1,[r3,0x14]
L_9215a0:
	ldw_s r2,[r3,0x10]
L_9215a2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_9215a4:
	stw_s r1,[r3,0x14]
L_9215a6:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_9215a8:
	stw_s r2,[r3,0x10]
L_9215aa:
	mov_s r0,0x1
L_9215ac:
	st.as r0,[gp,-0x34]
L_9215b0:
	mov_s blink,r13
L_9215b2:
	j_s.d [blink]
L_9215b4:
	pop_s r13
L_9215b6:
	nop_s
