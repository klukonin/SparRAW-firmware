/* hwd_dma__set_mode_map @ 0x929150, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw__bring_up_phy_dma
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__set_mode_map
hwd_dma__set_mode_map:
	.global L_929150
L_929150:
	st.a r13,[sp,-0x8]
L_929154:
	st_s r14,[sp,0x4]
L_929156:
	mov_s r14,blink
L_929158:
	mov.f r13,r0
L_92915c:
	cmp.ne r13,0x1
L_929160:
	cmp.ne r13,0x2
L_929164:
	beq L_929170
L_929168:
	breq r13,0x3,L_9291c8
L_92916c:
	brne r13,0x4,L_9291c8
	.global L_929170
L_929170:
	asl r5,r13,0x4
L_929174:
	or r5,r5,r13
L_929178:
	asl r4,r13,0x8
L_92917c:
	or r4,r4,r5
L_929180:
	asl r3,r13,0xc
L_929184:
	or r3,r3,r4
L_929188:
	asl r2,r13,0x10
L_92918c:
	or_s r2,r2,r3
L_92918e:
	asl r1,r13,0x14
L_929192:
	or_s r1,r1,r2
L_929194:
	asl r0,r13,0x18
L_929198:
	or_s r0,r0,r1
L_92919a:
	asl_s r13,r13,0x1c
L_92919c:
	or_s r0,r0,r13
L_92919e:
	mov r7,0x880800
L_9291a6:
	st.as r0,[r7,0xfa]
L_9291aa:
	extb r6,r0
L_9291ae:
	st.as r6,[r7,0xfb]
L_9291b2:
	bmsk_s r0,r0,0x1b
L_9291b4:
	st r0,[0x880c0c]
L_9291bc:
	mov_s blink,r14
L_9291be:
	ld_s r14,[sp,0x4]
L_9291c0:
	j.d [blink]
L_9291c4:
	ld.ab r13,[sp,0x8]
	.global L_9291c8
L_9291c8:
	mov_s r0,blink
L_9291ca:
	mov_s r1,0x12dc
L_9291d0:
	bl L_926618
L_9291d4:
	b_s L_929170
L_9291d6:
	nop_s
