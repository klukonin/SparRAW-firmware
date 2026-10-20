/* mac_prog__cmd02_body @ 0x921460, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__dispatch
 * Зовёт сам: bi__tsf_delta64, bi_cfg__get_half10
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_prog__cmd02_body
mac_prog__cmd02_body:
	.global L_921460
L_921460:
	st.a r13,[sp,-0x8]
L_921464:
	st_s r14,[sp,0x4]
L_921466:
	mov_s r14,blink
L_921468:
	mov_s r13,0x802ec0
L_92146e:
	ld_s r0,[r13,0x3c]
L_921470:
	bl.d L_924818
L_921474:
	ld r1,[r13, 0x40]
L_921478:
	st_s r0,[r13,0x44]
L_92147a:
	mov_s r0,0x802f68
L_921480:
	bl L_927d04
L_921484:
	ld r8,[r13, 0x44]
L_921488:
	add3 r0,r0,0x3e8
L_92148c:
	brhs r0,r8,L_921498
L_921490:
	ld_s r3,[r13,0x48]
L_921492:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_921494:
	st r3,[r13, 0x48]
	.global L_921498
L_921498:
	ld r4,[r13, 0x4c]
L_92149c:
	ld r6,[r13, 0x3c]
L_9214a0:
	cmp r4,r8
L_9214a4:
	mov.ls r3,r8
L_9214a8:
	mov.hi r3,r4
L_9214ac:
	st_s r3,[r13,0x4c]
L_9214ae:
	ld r5,[r13, 0x40]
L_9214b2:
	mov r7,0x801030
L_9214ba:
	st r6,[r7, 0x80]
L_9214be:
	ldb r1,[r7, 0x50]
L_9214c2:
	st r8,[r7, 0x88]
L_9214c6:
	/* asl_s r1,r1,0x3 */
	.byte 0x03,0xb9
L_9214c8:
	add2_s r1,r1,r1
L_9214ca:
	add r0,r7,0x10
L_9214ce:
	ld_s r2,[r0,r1]
L_9214d0:
	ld_s r3,[r13,0x20]
L_9214d2:
	st r5,[r7, 0x84]
L_9214d6:
	sub_s r3,r3,r2
L_9214d8:
	sub r3,r3,r8
L_9214dc:
	st r3,[r7, 0x9c]
L_9214e0:
	ld_s r3,[r13,0x18]
L_9214e2:
	mov_s r1,0x0
L_9214e4:
	add.f r2,r2,r3
L_9214e8:
	ld r4,[r13, 0x1c]
L_9214ec:
	mov_s blink,r14
L_9214ee:
	adc r4,r4,r1
L_9214f2:
	add.f r2,r2,r8
L_9214f6:
	adc r1,r1,r4
L_9214fa:
	st r2,[r7, 0x94]
L_9214fe:
	st r1,[r7, 0x98]
L_921502:
	ld_s r14,[sp,0x4]
L_921504:
	j.d [blink]
L_921508:
	ld.ab r13,[sp,0x8]
