/* ucode_cmd_0x33_handler @ 0x93d2a8, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: ps__hold_awake_for_sta
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x33_handler
ucode_cmd_0x33_handler:
	.global L_93d2a8
L_93d2a8:
	push_s r13
L_93d2aa:
	ld r4,[r1]
L_93d2ae:
	mov_s r13,blink
L_93d2b0:
	cmp r4,0x1
L_93d2b4:
	cmp.ne r4,0x0
L_93d2b8:
	bne_s L_93d314
L_93d2ba:
	ld_s r2,[r1,0x4]
L_93d2bc:
	mov r5,0x803180
L_93d2c4:
	brlo r2,0x1388,L_93d2d4
L_93d2cc:
	brhs 0x13880,r2,L_93d2dc
	.global L_93d2d4
L_93d2d4:
	b.d L_93d2f4
L_93d2d8:
	ldb r3,[r5, -0x9c]
	.global L_93d2dc
L_93d2dc:
	stb r4,[r5, -0x9c]
L_93d2e0:
	ld r2,[r1, 0x4]
L_93d2e4:
	extb r3,r4
L_93d2e8:
	mulu64 r2,0xa5
L_93d2ec:
	st mlo,[0x8030e8]
	.global L_93d2f4
L_93d2f4:
	brne_s r3,0,L_93d314
L_93d2f6:
	mov_s r3,0x0
L_93d2f8:
	stb r3,[r5, -0x93]
L_93d2fc:
	stb r3,[r5, -0x94]
L_93d300:
	ldb r1,[r0,0x179]
L_93d308:
	cmp r1,0x1
L_93d30c:
	bl.eq.d L_93d914
L_93d310:
	mov.eq r1,r3
	.global L_93d314
L_93d314:
	mov_s blink,r13
L_93d316:
	j_s.d [blink]
L_93d318:
	pop_s r13
L_93d31a:
	nop_s
