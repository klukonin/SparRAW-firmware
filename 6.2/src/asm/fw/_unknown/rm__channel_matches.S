/* rm__channel_matches @ 0x8da394, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_primary_non_locked
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm__channel_matches
rm__channel_matches:
	.global L_8da394
L_8da394:
	push_s r13
L_8da396:
	ld_s r13,[r0]
L_8da398:
	ld_s r3,[r1]
L_8da39a:
	mov_s r2,0x0
L_8da39c:
	brne r13,r3,L_8da3a8
L_8da3a0:
	ld_s r13,[r0,0x4]
L_8da3a2:
	ld_s r3,[r1,0x4]
L_8da3a4:
	breq r13,r3,L_8da3ac
	.global L_8da3a8
L_8da3a8:
	mov_s r0,r2
L_8da3aa:
	b_s L_8da3b6
	.global L_8da3ac
L_8da3ac:
	ld_s r3,[r0,0xc]
L_8da3ae:
	ld_s r0,[r1,0xc]
L_8da3b0:
	brne r3,r0,L_8da3a8
L_8da3b4:
	mov_s r0,0x1
	.global L_8da3b6
L_8da3b6:
	extb_s r0,r0
L_8da3b8:
	j_s.d [blink]
L_8da3ba:
	pop_s r13
