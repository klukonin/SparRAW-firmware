/* mac_mode__switch_after_ppdu @ 0x92f340, 192 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__handle_ppdu_report
 * Зовёт сам: __ld_r13_to_r13_ret, mac__set_mode_a000
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global mac_mode__switch_after_ppdu
mac_mode__switch_after_ppdu:
	.global L_92f340
L_92f340:
	push_s blink
L_92f342:
	push_s r13
L_92f344:
	mov_s r13,r0
L_92f346:
	mov_s r0,0x83
L_92f348:
	asl_s r0,r0,0x19
L_92f34a:
	mov_s r32,r0
L_92f34c:
	st.ab r0,[r25,0x4]
L_92f350:
	bclr r25,r25,0xa
L_92f354:
	mov_s r0,0x3d000002
L_92f35a:
	mov_s r32,r0
L_92f35c:
	st.ab r0,[r25,0x4]
L_92f360:
	bclr r25,r25,0xa
L_92f364:
	mov_s r0,0x2
L_92f366:
	mov lp_count,r0
L_92f36a:
	nop_s
L_92f36c:
	lp L_92f374
L_92f370:
	nop_s
L_92f372:
	nop_s
	.global L_92f374
L_92f374:
	mov_s r0,0x3d000100
L_92f37a:
	mov_s r32,r0
L_92f37c:
	st.ab r0,[r25,0x4]
L_92f380:
	bclr r25,r25,0xa
L_92f384:
	mov_s r0,0x1f006000
L_92f38a:
	mov_s r32,r0
L_92f38c:
	st.ab r0,[r25,0x4]
L_92f390:
	bclr r25,r25,0xa
L_92f394:
	bl L_92a754
L_92f398:
	mov_s r0,0x1f000601
L_92f39e:
	mov_s r32,r0
L_92f3a0:
	st.ab r0,[r25,0x4]
L_92f3a4:
	bclr r25,r25,0xa
L_92f3a8:
	mov_s r0,0x3c000200
L_92f3ae:
	mov_s r32,r0
L_92f3b0:
	st.ab r0,[r25,0x4]
L_92f3b4:
	bclr r25,r25,0xa
L_92f3b8:
	mov_s r0,0x38000300
L_92f3be:
	mov_s r32,r0
L_92f3c0:
	st.ab r0,[r25,0x4]
L_92f3c4:
	bclr r25,r25,0xa
L_92f3c8:
	mov_s r0,0x3600003f
L_92f3ce:
	mov_s r32,r0
L_92f3d0:
	st.ab r0,[r25,0x4]
L_92f3d4:
	bclr r25,r25,0xa
L_92f3d8:
	mov_s r0,0x6000103
L_92f3de:
	mov_s r32,r0
L_92f3e0:
	st.ab r0,[r25,0x4]
L_92f3e4:
	bclr r25,r25,0xa
L_92f3e8:
	or r13,r13,0x3f000000
L_92f3f0:
	mov_s r32,r13
L_92f3f2:
	st.ab r13,[r25,0x4]
L_92f3f6:
	bclr r25,r25,0xa
L_92f3fa:
	b L_9202ac
L_92f3fe:
	nop_s
