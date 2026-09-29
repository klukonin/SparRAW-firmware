/* gp0__arm_usec @ 0x928318, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm6
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global gp0__arm_usec
gp0__arm_usec:
	.global L_928318
L_928318:
	st.a r13,[sp,-0x8]
L_92831c:
	st_s r14,[sp,0x4]
L_92831e:
	mov_s r14,blink
L_928320:
	mulu64 r1,0xa5
L_928324:
	mov_s r3,0x52
L_928326:
	asl_s r3,r3,0x18
L_928328:
	mov_s r13,mlo
L_92832a:
	mov_s r32,r3
L_92832c:
	st.ab r3,[r25,0x4]
L_928330:
	bclr r25,r25,0xa
L_928334:
	mov_s r1,0x52
L_928336:
	asl_s r1,r1,0x18
L_928338:
	mov r32,r1
L_92833c:
	st.ab r1,[r25,0x4]
L_928340:
	bclr r25,r25,0xa
L_928344:
	mov_s r2,0x49000040
L_92834a:
	mov_s r32,r2
L_92834c:
	st.ab r2,[r25,0x4]
L_928350:
	bclr r25,r25,0xa
L_928354:
	or r13,r13,0x4f000000
L_92835c:
	mov r32,r13
L_928360:
	st.ab r13,[r25,0x4]
L_928364:
	bclr r25,r25,0xa
L_928368:
	mov_s r0,0x52000408
L_92836e:
	mov_s r32,r0
L_928370:
	st.ab r0,[r25,0x4]
L_928374:
	bclr r25,r25,0xa
L_928378:
	mov_s blink,r14
L_92837a:
	ld_s r14,[sp,0x4]
L_92837c:
	j.d [blink]
L_928380:
	ld.ab r13,[sp,0x8]
