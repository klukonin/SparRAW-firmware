/* mac__fill_mode_nibbles @ 0x9294d8, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac__fill_mode_nibbles
mac__fill_mode_nibbles:
	.global L_9294d8
L_9294d8:
	st.a r13,[sp,-0x8]
L_9294dc:
	st_s r14,[sp,0x4]
L_9294de:
	mov_s r14,blink
L_9294e0:
	mov.f r13,r0
L_9294e4:
	cmp.ne r13,0x1
L_9294e8:
	cmp.ne r13,0x2
L_9294ec:
	beq L_9294f8
L_9294f0:
	breq r13,0x3,L_929558
L_9294f4:
	brne r13,0x4,L_929558
	.global L_9294f8
L_9294f8:
	asl r5,r13,0x4
L_9294fc:
	or r5,r5,r13
L_929500:
	asl r4,r13,0x8
L_929504:
	or r4,r4,r5
L_929508:
	asl r3,r13,0xc
L_92950c:
	or r3,r3,r4
L_929510:
	asl r2,r13,0x10
L_929514:
	or_s r2,r2,r3
L_929516:
	asl r1,r13,0x14
L_92951a:
	or_s r1,r1,r2
L_92951c:
	asl r0,r13,0x18
L_929520:
	or_s r0,r0,r1
L_929522:
	asl_s r13,r13,0x1c
L_929524:
	or_s r0,r0,r13
L_929526:
	mov r7,0x886000
L_92952e:
	st r0,[r7, 0xfc]
L_929532:
	st.as r0,[r7,0x40]
L_929536:
	bmsk r6,r0,0x13
L_92953a:
	st.as r6,[r7,0x41]
L_92953e:
	st.as r0,[r7,0x42]
L_929542:
	st.as r0,[r7,0x43]
L_929546:
	bmsk_s r0,r0,0x17
L_929548:
	st.as r0,[r7,0x44]
L_92954c:
	mov_s blink,r14
L_92954e:
	ld_s r14,[sp,0x4]
L_929550:
	j.d [blink]
L_929554:
	ld.ab r13,[sp,0x8]
	.global L_929558
L_929558:
	mov_s r0,blink
L_92955a:
	mov_s r1,0x12db
L_929560:
	bl L_926618
L_929564:
	b_s L_9294f8
L_929566:
	nop_s
