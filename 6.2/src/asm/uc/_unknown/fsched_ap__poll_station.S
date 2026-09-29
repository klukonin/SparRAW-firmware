/* fsched_ap__poll_station @ 0x93d1ec, 160 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched_ap__next_station, l1_fixed_sched_ap__ev4_state4
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fsched__cur_entry_byte0
 * Глобалы (через gp): 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched_ap__poll_station
fsched_ap__poll_station:
	.global L_93d1ec
L_93d1ec:
	push_s blink
L_93d1ee:
	bl L_920230
L_93d1f2:
	mov_s r13,r0
L_93d1f4:
	add_s r14,r0,0x1
L_93d1f6:
	ldb r1,[r0, 0x28]
L_93d1fa:
	mov_s r2,0x802610
L_93d200:
	asl_s r0,r1,0x2
L_93d202:
	add1_s r0,r0,r0
L_93d204:
	ld_s r0,[r2,r0]
L_93d206:
	sub.f r0,r0,0x0
L_93d20a:
	mov.ne r0,0x1
L_93d20e:
	extb.f 0x0,r0
L_93d212:
	beq_s L_93d21e
L_93d214:
	mov_s r0,0x1
L_93d216:
	add2_s r1,r1,r1
L_93d218:
	add_s r14,r14,r1
L_93d21a:
	stb_s r0,[r14]
L_93d21c:
	b_s L_93d286
	.global L_93d21e
L_93d21e:
	bl.d L_927dbc
L_93d222:
	mov_s r0,r13
L_93d224:
	asl_s r0,r0,0x10
L_93d226:
	bset r15,r0,0x0
L_93d22a:
	mov_s r0,0x1b001111
L_93d230:
	mov_s r32,r0
L_93d232:
	st.ab r0,[r25,0x4]
L_93d236:
	bclr r25,r25,0xa
L_93d23a:
	bset_s r15,r15,0x19
L_93d23c:
	bset_s r15,r15,0x1a
L_93d23e:
	bset_s r15,r15,0x1c
L_93d240:
	mov_s r32,r15
L_93d242:
	st.ab r15,[r25,0x4]
L_93d246:
	bclr r25,r25,0xa
L_93d24a:
	mov_s r0,0x17
L_93d24c:
	asl_s r0,r0,0x18
L_93d24e:
	mov_s r32,r0
L_93d250:
	st.ab r0,[r25,0x4]
L_93d254:
	bclr r25,r25,0xa
L_93d258:
	nop_s
L_93d25a:
	nop_s
L_93d25c:
	nop_s
	.global L_93d25e
L_93d25e:
	mov_s r0,r43
L_93d260:
	bbit0 r0,0x1f,L_93d25e
L_93d264:
	mov_s r0,r51
L_93d266:
	bmsk r1,r0,0x3
L_93d26a:
	st.as r1,[gp,0x38]
L_93d26e:
	lsr_s r0,r0,0x4
L_93d270:
	st.as r0,[gp,0x39]
L_93d274:
	lsr r0,r43,0x10
L_93d278:
	bmsk r1,r0,0x4
L_93d27c:
	ldb r0,[r13, 0x28]
L_93d280:
	add2_s r0,r0,r0
L_93d282:
	add_s r14,r14,r0
L_93d284:
	stb_s r1,[r14]
	.global L_93d286
L_93d286:
	b L_92029c
L_93d28a:
	nop_s
