/* bi_sm__action_923a5c @ 0x923a5c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_sm__action_923a5c
bi_sm__action_923a5c:
	.global L_923a5c
L_923a5c:
	push_s r13
L_923a5e:
	mov_s r13,blink
L_923a60:
	mov_s r2,0xcaf440
L_923a66:
	mov_s r32,r2
L_923a68:
	st.ab r2,[r25,0x4]
L_923a6c:
	bclr r25,r25,0xa
L_923a70:
	mov_s r1,0x802ec0
L_923a76:
	ldw_s r0,[r1,0xc]
L_923a78:
	mov_s blink,r13
L_923a7a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_923a7c:
	stw_s r0,[r1,0xc]
L_923a7e:
	j_s.d [blink]
L_923a80:
	pop_s r13
L_923a82:
	nop_s
