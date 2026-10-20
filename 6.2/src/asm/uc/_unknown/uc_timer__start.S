/* uc_timer__start @ 0x937354, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__program_13ab6680, mac__program_13ab6680_b
 * Зовёт сам: uc_irq_set_level
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_timer__start
uc_timer__start:
	.global L_937354
L_937354:
	st.a r13,[sp,-0x10]
L_937358:
	st blink,[sp, 0x4]
L_93735c:
	st_s r14,[sp,0x8]
L_93735e:
	st_s r15,[sp,0xc]
L_937360:
	mov_s r8,r0
L_937362:
	asl_s r13,r0,0x4
L_937364:
	add_s r13,r13,0x800738
L_93736a:
	ld r7,[r13, 0x4]
L_93736e:
	mov_s r14,r1
L_937370:
	sr 0x0,[r7]
L_937378:
	ld r4,[r13, 0x8]
L_93737c:
	brne.d r3,0x3,L_9373a4
L_937380:
	sr r2,[r4]
L_937384:
	mov_s r15,0x4
L_937386:
	st_s r15,[r13,0xc]
L_937388:
	sr r15,[r7]
L_93738c:
	ld r5,[r13]
L_937390:
	sr r14,[r5]
L_937394:
	ld blink,[sp, 0x4]
L_937398:
	ld_s r14,[sp,0x8]
L_93739a:
	ld_s r15,[sp,0xc]
L_93739c:
	j.d [blink]
L_9373a0:
	ld.ab r13,[sp,0x10]
	.global L_9373a4
L_9373a4:
	breq_s r3,0,L_9373dc
L_9373a6:
	mov_s r15,0x3
L_9373a8:
	cmp_s r3,0x2
L_9373aa:
	mov_s r1,0x1
L_9373ac:
	add2 r0,0x3,r8
L_9373b4:
	bl.d L_921018
L_9373b8:
	sub.ne r1,r1,r1
L_9373bc:
	st_s r15,[r13,0xc]
L_9373be:
	ld r6,[r13, 0x4]
L_9373c2:
	sr r15,[r6]
L_9373c6:
	ld r5,[r13]
L_9373ca:
	sr r14,[r5]
L_9373ce:
	ld blink,[sp, 0x4]
L_9373d2:
	ld_s r14,[sp,0x8]
L_9373d4:
	ld_s r15,[sp,0xc]
L_9373d6:
	j_s.d [blink]
L_9373d8:
	ld.ab r13,[sp,0x10]
	.global L_9373dc
L_9373dc:
	mov_s r15,0x2
L_9373de:
	st_s r15,[r13,0xc]
L_9373e0:
	sr r15,[r7]
L_9373e4:
	ld r5,[r13]
L_9373e8:
	sr r14,[r5]
L_9373ec:
	ld blink,[sp, 0x4]
L_9373f0:
	ld_s r14,[sp,0x8]
L_9373f2:
	ld_s r15,[sp,0xc]
L_9373f4:
	j.d [blink]
L_9373f8:
	ld.ab r13,[sp,0x10]
