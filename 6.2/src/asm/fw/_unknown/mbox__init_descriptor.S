/* mbox__init_descriptor @ 0x8f942c, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: debug_mbox__get_or_init, operational_if__mbox_init
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, mem_pool__init, ring__init_desc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mbox__init_descriptor
mbox__init_descriptor:
	.global L_8f942c
L_8f942c:
	push_s blink
L_8f942e:
	bl L_8c01cc
L_8f9432:
	mov_s r14,r0
L_8f9434:
	mov_s r13,r1
L_8f9436:
	mov_s r19,r2
L_8f9438:
	mov_s r15,r3
L_8f943a:
	mov_s r1,r4
L_8f943c:
	mov r16,r5
L_8f9440:
	asl r17,r6,0x3
L_8f9444:
	asl r18,r7,0x3
L_8f9448:
	st_s r2,[r13]
L_8f944a:
	st_s r2,[r13,0x8]
L_8f944c:
	st_s r2,[r13,0xc]
L_8f944e:
	ld_s r0,[sp,0x2c]
L_8f9450:
	stw r17,[r13, 0x6]
L_8f9454:
	stw_s r0,[r13,0x4]
L_8f9456:
	add3 r20,r14,0x9
L_8f945a:
	ld_s r2,[sp,0x2c]
L_8f945c:
	mov_s r0,r20
L_8f945e:
	bl.d L_8c7cf8
L_8f9462:
	ld_s r3,[sp,0x24]
L_8f9464:
	add r0,r14,0x24
L_8f9468:
	mov_s r1,r19
L_8f946a:
	mov_s r2,r17
L_8f946c:
	mov_s r3,r13
L_8f946e:
	mov r4,r20
L_8f9472:
	mov r5,0x1
L_8f9476:
	bl.d L_8d8b00
L_8f947a:
	mov r6,r5
L_8f947e:
	mov r0,0x510
L_8f9482:
	st_s r15,[r13,0x10]
L_8f9484:
	st_s r15,[r13,0x18]
L_8f9486:
	st_s r15,[r13,0x1c]
L_8f9488:
	stw r18,[r13, 0x16]
L_8f948c:
	stw_s r0,[r13,0x14]
L_8f948e:
	add2 r17,r14,0x17
L_8f9492:
	ld_s r2,[sp,0x30]
L_8f9494:
	mov_s r0,r17
L_8f9496:
	mov_s r1,r16
L_8f9498:
	bl.d L_8c7cf8
L_8f949c:
	ld_s r3,[sp,0x28]
L_8f949e:
	add r16,r14,0x4
L_8f94a2:
	add r3,r13,0x10
L_8f94a6:
	mov_s r0,r16
L_8f94a8:
	mov_s r1,r15
L_8f94aa:
	mov_s r2,r18
L_8f94ac:
	mov r4,r17
L_8f94b0:
	mov r5,0x0
L_8f94b4:
	bl.d L_8d8b00
L_8f94b8:
	mov r6,0x1
L_8f94bc:
	mov_s r1,L_8cb07c-0x8c0000
L_8f94c2:
	st r1,[r16, 0x18]
L_8f94c6:
	mov_s r1,0xb10c
L_8f94cc:
	ld_s r0,[sp,0x2c]
L_8f94ce:
	st r1,[r16, 0x1c]
L_8f94d2:
	st_s r0,[r14,0x70]
L_8f94d4:
	ld_s r0,[sp,0x30]
L_8f94d6:
	st_s r0,[r14,0x74]
L_8f94d8:
	ld_s r0,[r14,0x44]
L_8f94da:
	ld_s r1,[r0,0x8]
L_8f94dc:
	jl_s.d [r1]
L_8f94de:
	mov_s r0,r14
L_8f94e0:
	b L_8c0224
