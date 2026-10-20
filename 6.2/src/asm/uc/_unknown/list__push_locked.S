/* list__push_locked @ 0x926984, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_evt__queue_put
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global list__push_locked
list__push_locked:
	.global L_926984
L_926984:
	st.a r13,[sp,-0x10]
L_926988:
	st blink,[sp, 0x4]
L_92698c:
	st_s r14,[sp,0x8]
L_92698e:
	st_s r15,[sp,0xc]
L_926990:
	breq.d r1,0x0,L_9269e4
L_926994:
	mov r15,r0
	.global L_926998
L_926998:
	ld r5,[r15]
L_92699c:
	ld r0,[r5]
L_9269a0:
	rsub.f r0,r0,0x1
L_9269a4:
	mov.cs r0,0x0
L_9269a8:
	extb.f 0x0,r0
L_9269ac:
	beq L_9269f4
	.global L_9269b0
L_9269b0:
	lr r14,[0xa]
L_9269b4:
	bclr r2,r14,0x1
L_9269b8:
	flag r2
L_9269bc:
	ld r4,[r15]
L_9269c0:
	mov r7,0x1
L_9269c4:
	st r7,[r4]
L_9269c8:
	ld_s r13,[r15]
L_9269ca:
	ld r6,[r15, 0x8]
L_9269ce:
	add_s r13,r13,0x8
L_9269d0:
	brlo r6,r13,L_926a04
	.global L_9269d4
L_9269d4:
	brne r13,r6,L_926a18
L_9269d8:
	ld r3,[r15, 0x4]
L_9269dc:
	b.d L_926a1c
L_9269e0:
	st r3,[r15]
	.global L_9269e4
L_9269e4:
	mov r0,blink
L_9269e8:
	bl.d L_926618
L_9269ec:
	mov r1,0xca
L_9269f0:
	b L_926998
	.global L_9269f4
L_9269f4:
	mov r0,blink
L_9269f8:
	bl.d L_926618
L_9269fc:
	mov r1,0xcb
L_926a00:
	b L_9269b0
	.global L_926a04
L_926a04:
	mov r0,blink
L_926a08:
	bl.d L_926618
L_926a0c:
	mov r1,0xcc
L_926a10:
	b.d L_9269d4
L_926a14:
	ld r6,[r15, 0x8]
	.global L_926a18
L_926a18:
	st r13,[r15]
	.global L_926a1c
L_926a1c:
	lr r1,[0xa]
L_926a20:
	bic r14,r14,-0x3
L_926a24:
	or_s r14,r14,r1
L_926a26:
	flag r14
L_926a2a:
	ld blink,[sp, 0x4]
L_926a2e:
	ld_s r14,[sp,0x8]
L_926a30:
	ld_s r15,[sp,0xc]
L_926a32:
	j_s.d [blink]
L_926a34:
	ld.ab r13,[sp,0x10]
