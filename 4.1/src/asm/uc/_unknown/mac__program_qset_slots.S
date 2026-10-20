/* mac__program_qset_slots @ 0x928308, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rate_search__start_for_sta
 * Зовёт сам: __ld_r13_ret_uc
 */
	.section .text.mac__program_qset_slots,"ax",@progbits
	.global mac__program_qset_slots
mac__program_qset_slots:
	.global L_928308
L_928308:
	push_s blink
L_92830a:
	push_s r13
L_92830c:
	mov_s r0,0x800ac8
L_928312:
	ld_s r0,[r0,0x10]
L_928314:
	breq_s r0,0,L_928366
L_928316:
	mov lp_count,0x4
L_92831a:
	mov_s r13,0x0
L_92831c:
	lp L_928348
L_928320:
	add r1,r13,0x9
L_928324:
	asl_s r1,r1,0x18
L_928326:
	mov_s r0,0x800ac8
L_92832c:
	add2_s r0,r0,r13
L_92832e:
	ldb_s r2,[r0]
L_928330:
	mov_s r0,0x0
L_928332:
	bset r0,r0,r2
L_928336:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_928338:
	or_s r0,r0,r1
L_92833a:
	mov_s r32,r0
L_92833c:
	st.ab r0,[r25,0x4]
L_928340:
	bclr r25,r25,0xa
L_928344:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_928346:
	extb_s r13,r13
	.global L_928348
L_928348:
	ld_s r0,[gp,-0xd8]
L_92834a:
	mov_s r1,0x800994
L_928350:
	ld_s r1,[r1,0x8]
L_928352:
	and_s r0,r0,r1
L_928354:
	or r0,r0,0x80000aa
L_92835c:
	mov_s r32,r0
L_92835e:
	st.ab r0,[r25,0x4]
L_928362:
	bclr r25,r25,0xa
	.global L_928366
L_928366:
	b L_92028c
L_92836a:
	nop_s
