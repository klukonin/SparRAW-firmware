/* rx__ppdu_is_cts @ 0x92e318, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__wait_cts
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__ppdu_is_cts
rx__ppdu_is_cts:
	.global L_92e318
L_92e318:
	push_s r13
L_92e31a:
	mov_s r13,blink
L_92e31c:
	mov_s r0,0x0
L_92e31e:
	bset_s r0,r0,0x10
L_92e320:
	bl.d L_9366e8
L_92e324:
	mov r1,0x0
L_92e328:
	ldb r3,[gp, -0xf2]
L_92e32c:
	breq r3,0x0,L_92e360
	.global L_92e330
L_92e330:
	ld_s r0,[gp,0x50]
L_92e332:
	mov_s r2,0x8022c8
L_92e338:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e33a:
	ld_s r1,[r2,0x3c]
L_92e33c:
	st.as r0,[gp,0x14]
L_92e340:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_92e342:
	st_s r1,[r2,0x3c]
L_92e344:
	mov_s r3,0x2011000
L_92e34a:
	mov_s r32,r3
L_92e34c:
	st.ab r3,[r25,0x4]
L_92e350:
	bclr r25,r25,0xa
L_92e354:
	and r0,r37,0x2
L_92e358:
	mov_s blink,r13
L_92e35a:
	j_s.d [blink]
L_92e35c:
	ld.ab r13,[sp,0x4]
	.global L_92e360
L_92e360:
	ldb r1,[gp, -0xf9]
L_92e364:
	bmsk_s r1,r1,0x0
L_92e366:
	or r1,r1,0x32000000
L_92e36e:
	mov_s r32,r1
L_92e370:
	st.ab r1,[r25,0x4]
L_92e374:
	bclr r25,r25,0xa
L_92e378:
	ldb r2,[gp, -0xf9]
L_92e37c:
	add r2,r2,0x1
L_92e380:
	b.d L_92e330
L_92e384:
	stb r2,[gp, -0xf9]
