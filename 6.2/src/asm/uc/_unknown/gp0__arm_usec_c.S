/* gp0__arm_usec_c @ 0x9283e0, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global gp0__arm_usec_c
gp0__arm_usec_c:
	.global L_9283e0
L_9283e0:
	push_s blink
L_9283e2:
	push_s r13
L_9283e4:
	mulu64 r0,0xa5
L_9283e8:
	mov_s r0,0x52
L_9283ea:
	asl_s r0,r0,0x18
L_9283ec:
	mov_s r13,mlo
L_9283ee:
	mov_s r32,r0
L_9283f0:
	st.ab r0,[r25,0x4]
L_9283f4:
	bclr r25,r25,0xa
L_9283f8:
	mov_s r0,0x52
L_9283fa:
	asl_s r0,r0,0x18
L_9283fc:
	mov_s r32,r0
L_9283fe:
	st.ab r0,[r25,0x4]
L_928402:
	bclr r25,r25,0xa
L_928406:
	mov_s r0,0x49000040
L_92840c:
	mov_s r32,r0
L_92840e:
	st.ab r0,[r25,0x4]
L_928412:
	bclr r25,r25,0xa
L_928416:
	or r13,r13,0x4f000000
L_92841e:
	mov_s r32,r13
L_928420:
	st.ab r13,[r25,0x4]
L_928424:
	bclr r25,r25,0xa
L_928428:
	mov_s r0,0x52000408
L_92842e:
	mov_s r32,r0
L_928430:
	st.ab r0,[r25,0x4]
L_928434:
	bclr r25,r25,0xa
L_928438:
	b L_9202ac
