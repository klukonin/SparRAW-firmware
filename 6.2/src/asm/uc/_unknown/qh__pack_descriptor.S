/* qh__pack_descriptor @ 0x92420c, 316 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: qh__write_by_flags
 * Зовёт сам: qh__reset_desc_window, qh__wait_desc_window_ready
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global qh__pack_descriptor
qh__pack_descriptor:
	.global L_92420c
L_92420c:
	st.a r13,[sp,-0x20]
L_924210:
	st blink,[sp, 0x4]
L_924214:
	st_s r14,[sp,0x8]
L_924216:
	st_s r15,[sp,0xc]
L_924218:
	st r16,[sp, 0x10]
L_92421c:
	st r17,[sp, 0x14]
L_924220:
	st r18,[sp, 0x18]
L_924224:
	st r19,[sp, 0x1c]
L_924228:
	sub_s sp,sp,0x8
L_92422a:
	mov_s r15,r0
L_92422c:
	mov r19,r4
L_924230:
	mov r16,r6
L_924234:
	mov r17,0x0
L_924238:
	stw r17,[sp, 0x4]
L_92423c:
	stw r17,[sp, 0x6]
L_924240:
	st r17,[sp]
L_924244:
	ld r6,[sp, 0x4]
L_924248:
	bmsk r4,r2,0x2
L_92424c:
	ror r6,r6,0x4
L_924250:
	bic r6,r6,0x7
L_924254:
	or r4,r4,r6
L_924258:
	ror r4,r4,0x1c
L_92425c:
	sub r2,r2,0x1
L_924260:
	bic r4,r4,0x3
L_924264:
	brhs.d r2,0x6,L_924298
L_924268:
	st r4,[sp, 0x4]
L_92426c:
	ld.as r6,[0x8017ec,r2]
L_924274:
	j [r6]
L_924278:
	bmsk_s r3,r3,0x1
L_92427a:
	bmsk_s r1,r1,0x4
L_92427c:
	ror r3,r3,0x2
L_924280:
	bic r3,r3,0x1f
L_924284:
	or_s r1,r1,r3
L_924286:
	ror r1,r1,0x1c
L_92428a:
	st_s r1,[sp,0x0]
L_92428c:
	b.d L_924298
L_924290:
	mov r17,0x1
L_924294:
	st r19,[sp]
	.global L_924298
L_924298:
	bl.d L_924480
L_92429c:
	mov r13,0x0
L_9242a0:
	ldw r3,[sp, 0x4]
L_9242a4:
	mov r18,0x886800
L_9242ac:
	asl r3,r3,0x10
L_9242b0:
	st.as r3,[r18,-0x7d]
L_9242b4:
	brlo r5,0x1,L_924324
	.global L_9242b8
L_9242b8:
	mov r14,r5
L_9242bc:
	breq.d r17,0x0,L_9242d0
L_9242c0:
	add r2,r13,r19
L_9242c4:
	ld_s r3,[sp,0x0]
L_9242c6:
	bmsk_s r2,r2,0x1
L_9242c8:
	bic r3,r3,0x3
L_9242cc:
	or r2,r2,r3
	.global L_9242d0
L_9242d0:
	st.as r2,[r18,-0x7c]
L_9242d4:
	ldb r8,[gp, -0xde]
L_9242d8:
	brne.d r8,0x0,L_9242e8
L_9242dc:
	st_s r2,[sp,0x0]
L_9242de:
	st.as 0xc0000000,[r18,-0x7e]
L_9242e6:
	b_s L_9242f0
	.global L_9242e8
L_9242e8:
	st.as 0x40000000,[r18,-0x7e]
	.global L_9242f0
L_9242f0:
	sync
	.global L_9242f4
L_9242f4:
	ld.as r7,[r18,-0x7e]
L_9242f8:
	bbit1 r7,0x1d,L_9242f4
L_9242fc:
	cmp r16,0x0
L_924300:
	mov.hi lp_count,r16
L_924304:
	mov.hi r9,0x886614
L_92430c:
	lphi L_924318
L_924310:
	ld.ab r5,[r9,0x4]
L_924314:
	st.ab r5,[r15,0x4]
	.global L_924318
L_924318:
	sub r5,r14,0x1
L_92431c:
	brhs.d r5,0x1,L_9242b8
L_924320:
	add r13,r13,0x1
	.global L_924324
L_924324:
	bl L_9246b0
L_924328:
	add_s sp,sp,0x8
L_92432a:
	ld blink,[sp, 0x4]
L_92432e:
	ld_s r14,[sp,0x8]
L_924330:
	ld_s r15,[sp,0xc]
L_924332:
	ld r16,[sp, 0x10]
L_924336:
	ld r17,[sp, 0x14]
L_92433a:
	ld r18,[sp, 0x18]
L_92433e:
	ld r19,[sp, 0x1c]
L_924342:
	j_s.d [blink]
L_924344:
	ld.ab r13,[sp,0x20]
