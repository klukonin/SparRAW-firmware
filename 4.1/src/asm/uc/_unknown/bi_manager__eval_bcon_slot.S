/* bi_manager__eval_bcon_slot @ 0x9262e0, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__rx_bi_flow
 */
	.section .text.bi_manager__eval_bcon_slot,"ax",@progbits
	.global bi_manager__eval_bcon_slot
bi_manager__eval_bcon_slot:
	.global L_9262e0
L_9262e0:
	ldb r3,[r0, 0x5]
L_9262e4:
	brge.d r3,0x5,L_92634c
L_9262e8:
	mov r8,0x0
L_9262ec:
	ldb r7,[r0, 0x4]
	.global L_9262f0
L_9262f0:
	ld r6,[r0]
L_9262f4:
	bbit0 r6,r7,L_92631c
L_9262f8:
	bmsk r7,r7,0x2
L_9262fc:
	stb r7,[r1]
L_926300:
	ldb r8,[r0, 0x4]
L_926304:
	mov r9,0x1
L_926308:
	cmp r8,0x8
L_92630c:
	sub.ge r9,r9,r9
L_926310:
	st r9,[r2]
L_926314:
	ldb r7,[r0, 0x4]
L_926318:
	mov r8,0x1
	.global L_92631c
L_92631c:
	add r7,r7,0x1
L_926320:
	extb r7,r7
L_926324:
	brne.d r7,0x10,L_926340
L_926328:
	stb r7,[r0, 0x4]
L_92632c:
	mov r7,0x0
L_926330:
	ldb r4,[r0, 0x5]
L_926334:
	stb r7,[r0, 0x4]
L_926338:
	add r4,r4,0x1
L_92633c:
	stb r4,[r0, 0x5]
	.global L_926340
L_926340:
	brne r8,0x0,L_92634c
L_926344:
	ldb r5,[r0, 0x5]
L_926348:
	brlt r5,0x5,L_9262f0
	.global L_92634c
L_92634c:
	j.d [blink]
L_926350:
	mov_s r0,r8
L_926352:
	nop_s
