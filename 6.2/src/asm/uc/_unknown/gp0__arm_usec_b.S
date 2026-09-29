/* gp0__arm_usec_b @ 0x928384, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fsched__tx_ctrl_frame, internal_tx__flow_sm2, tx__send_and_await_rx_frame
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global gp0__arm_usec_b
gp0__arm_usec_b:
	.global L_928384
L_928384:
	push_s blink
L_928386:
	push_s r13
L_928388:
	mulu64 r0,0xa5
L_92838c:
	mov_s r0,0x52
L_92838e:
	asl_s r0,r0,0x18
L_928390:
	mov_s r13,mlo
L_928392:
	mov_s r32,r0
L_928394:
	st.ab r0,[r25,0x4]
L_928398:
	bclr r25,r25,0xa
L_92839c:
	mov_s r0,0x52
L_92839e:
	asl_s r0,r0,0x18
L_9283a0:
	mov_s r32,r0
L_9283a2:
	st.ab r0,[r25,0x4]
L_9283a6:
	bclr r25,r25,0xa
L_9283aa:
	mov_s r0,0x49000040
L_9283b0:
	mov_s r32,r0
L_9283b2:
	st.ab r0,[r25,0x4]
L_9283b6:
	bclr r25,r25,0xa
L_9283ba:
	or r13,r13,0x4f000000
L_9283c2:
	mov_s r32,r13
L_9283c4:
	st.ab r13,[r25,0x4]
L_9283c8:
	bclr r25,r25,0xa
L_9283cc:
	mov_s r0,0x52000408
L_9283d2:
	mov_s r32,r0
L_9283d4:
	st.ab r0,[r25,0x4]
L_9283d8:
	bclr r25,r25,0xa
L_9283dc:
	b L_9202ac
