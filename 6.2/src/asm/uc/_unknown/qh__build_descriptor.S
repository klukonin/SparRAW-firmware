/* qh__build_descriptor @ 0x92d428, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: qh__write_by_flags
 * Зовёт сам: qh__read_desc_window
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__build_descriptor
qh__build_descriptor:
	.global L_92d428
L_92d428:
	st.a r13,[sp,-0x10]
L_92d42c:
	st blink,[sp, 0x4]
L_92d430:
	st_s r14,[sp,0x8]
L_92d432:
	st_s r15,[sp,0xc]
L_92d434:
	sub_s sp,sp,0x30
L_92d436:
	mov_s r4,r0
L_92d438:
	mov_s r14,r1
L_92d43a:
	mov_s r13,r2
L_92d43c:
	mov_s r0,sp
L_92d43e:
	mov_s r1,r4
L_92d440:
	mov_s r2,0x2
L_92d442:
	mov_s r15,0x0
L_92d444:
	mov r3,r15
L_92d448:
	bl.d L_92449c
L_92d44c:
	mov r4,0x1
L_92d450:
	ld_s r0,[sp,0x4]
L_92d452:
	stb_s r15,[r13,0x6]
L_92d454:
	bmsk_s r0,r0,0xb
L_92d456:
	ld_s r2,[r13,0x4]
L_92d458:
	mov_s r1,0xfffff000
L_92d45e:
	and_s r2,r2,r1
L_92d460:
	or_s r2,r2,r0
L_92d462:
	st_s r2,[r13,0x4]
L_92d464:
	sub_s r3,r14,0x1
L_92d466:
	stb_s r3,[r13,0xa]
L_92d468:
	add_s r0,r0,r14
L_92d46a:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_92d46c:
	ld_s r2,[r13,0x8]
L_92d46e:
	bmsk_s r0,r0,0xb
L_92d470:
	and_s r1,r1,r2
L_92d472:
	or_s r0,r0,r1
L_92d474:
	st_s r0,[r13,0x8]
L_92d476:
	add_s sp,sp,0x30
L_92d478:
	ld blink,[sp, 0x4]
L_92d47c:
	ld_s r14,[sp,0x8]
L_92d47e:
	ld_s r15,[sp,0xc]
L_92d480:
	j.d [blink]
L_92d484:
	ld.ab r13,[sp,0x10]
