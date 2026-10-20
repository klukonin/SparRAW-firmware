/* mtp_service__dispatch @ 0x92d9d4, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mtp__get_tx_permission, rx_flow__handle_frame
 * Зовёт сам: mtp_queue__byte_by_index, uc_sysassert
 * Глобалы (через gp): 0x8005f4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mtp_service__dispatch
mtp_service__dispatch:
	.global L_92d9d4
L_92d9d4:
	st.a r13,[sp,-0xc]
L_92d9d8:
	st blink,[sp, 0x4]
L_92d9dc:
	st r14,[sp, 0x8]
L_92d9e0:
	asl r13,r0,0x8
L_92d9e4:
	or r13,r13,0x1f0022
L_92d9ec:
	brhs.d r0,0x6,L_92da60
L_92d9f0:
	mov_s r14,0x0
L_92d9f2:
	ld.as r4,[0x801aa8,r0]
L_92d9fa:
	j [r4]
L_92d9fe:
	b.d L_92da6c
L_92da02:
	mov r14,0x103
L_92da06:
	asl r14,r2,0x10
L_92da0a:
	ld.as r8,[gp,0x33]
L_92da0e:
	bbit0 r8,0x1,L_92da48
L_92da12:
	asl r7,r1,0x2
L_92da16:
	add1 r7,r7,r7
L_92da1a:
	ld r5,[r7,0x802610]
L_92da22:
	sub.f r5,r5,0x0
L_92da26:
	mov.ne r5,0x1
L_92da2a:
	extb.f 0x0,r5
L_92da2e:
	beq_s L_92da48
L_92da30:
	bl.d L_92ff68
L_92da34:
	mov r0,r1
L_92da38:
	asl r0,r0,0x8
L_92da3c:
	or r0,r0,0x3
L_92da40:
	b.d L_92da6c
L_92da44:
	or r14,r14,r0
	.global L_92da48
L_92da48:
	cmp r3,0xff
L_92da4c:
	beq L_92da6c
L_92da50:
	asl r6,r3,0x8
L_92da54:
	or r6,r6,0x3
L_92da58:
	b.d L_92da6c
L_92da5c:
	or r14,r14,r6
	.global L_92da60
L_92da60:
	mov r0,blink
L_92da64:
	bl.d L_926618
L_92da68:
	mov r1,0x8c
	.global L_92da6c
L_92da6c:
	mov_s r1,0x1b001111
L_92da72:
	mov_s r32,r1
L_92da74:
	st.ab r1,[r25,0x4]
L_92da78:
	bclr r25,r25,0xa
L_92da7c:
	or r13,r13,0x16000000
L_92da84:
	mov r32,r13
L_92da88:
	st.ab r13,[r25,0x4]
L_92da8c:
	bclr r25,r25,0xa
L_92da90:
	or r14,r14,0x17000000
L_92da98:
	mov r32,r14
L_92da9c:
	st.ab r14,[r25,0x4]
L_92daa0:
	bclr r25,r25,0xa
L_92daa4:
	nop_s
L_92daa6:
	nop_s
L_92daa8:
	nop_s
L_92daaa:
	ld blink,[sp, 0x4]
L_92daae:
	ld_s r14,[sp,0x8]
L_92dab0:
	j.d [blink]
L_92dab4:
	ld.ab r13,[sp,0xc]
