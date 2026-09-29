/* bi_sm__action_92150c @ 0x92150c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_92150c
bi_sm__action_92150c:
	.global L_92150c
L_92150c:
	push_s r13
L_92150e:
	mov_s r13,blink
L_921510:
	mov_s r3,0xcaf662
L_921516:
	mov_s r32,r3
L_921518:
	st.ab r3,[r25,0x4]
L_92151c:
	bclr r25,r25,0xa
L_921520:
	mov_s r2,0x802ec0
L_921526:
	ldw_s r1,[r2,0x10]
L_921528:
	mov_s r0,0x1
L_92152a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92152c:
	stw_s r1,[r2,0x10]
L_92152e:
	st.as r0,[gp,-0x34]
L_921532:
	mov_s blink,r13
L_921534:
	j.d [blink]
L_921538:
	pop_s r13
L_92153a:
	nop_s
