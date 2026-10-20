/* bi_sm__action_92153c @ 0x92153c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_92153c
bi_sm__action_92153c:
	.global L_92153c
L_92153c:
	push_s r13
L_92153e:
	mov_s r13,blink
L_921540:
	mov_s r3,0xcaf661
L_921546:
	mov_s r32,r3
L_921548:
	st.ab r3,[r25,0x4]
L_92154c:
	bclr r25,r25,0xa
L_921550:
	mov_s r2,0x802ec0
L_921556:
	ldw_s r1,[r2,0x10]
L_921558:
	mov_s r0,0x1
L_92155a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92155c:
	stw_s r1,[r2,0x10]
L_92155e:
	st.as r0,[gp,-0x34]
L_921562:
	mov_s blink,r13
L_921564:
	j.d [blink]
L_921568:
	pop_s r13
L_92156a:
	nop_s
