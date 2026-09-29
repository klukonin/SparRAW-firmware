/* mac__program_tx_result_ctx @ 0x92a4f0, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx__read_tx_result
 */
	.section .text.mac__program_tx_result_ctx,"ax",@progbits
	.global mac__program_tx_result_ctx
mac__program_tx_result_ctx:
	.global L_92a4f0
L_92a4f0:
	st.a r13,[sp,-0xc]
L_92a4f4:
	st blink,[sp, 0x4]
L_92a4f8:
	st_s r14,[sp,0x8]
L_92a4fa:
	asl_s r0,r0,0x10
L_92a4fc:
	bset r14,r0,0x4
L_92a500:
	cmp_s r1,0x0
L_92a502:
	mov r13,0x103
L_92a506:
	mov.eq r13,0x0
L_92a50a:
	mov_s r1,0x1b001111
L_92a510:
	mov r32,r1
L_92a514:
	st.ab r1,[r25,0x4]
L_92a518:
	bclr r25,r25,0xa
L_92a51c:
	or r14,r14,0x16000000
L_92a524:
	mov r32,r14
L_92a528:
	st.ab r14,[r25,0x4]
L_92a52c:
	bclr r25,r25,0xa
L_92a530:
	or r13,r13,0x17000000
L_92a538:
	mov r32,r13
L_92a53c:
	st.ab r13,[r25,0x4]
L_92a540:
	bclr r25,r25,0xa
L_92a544:
	nop_s
L_92a546:
	nop_s
L_92a548:
	nop_s
L_92a54a:
	ld blink,[sp, 0x4]
L_92a54e:
	ld_s r14,[sp,0x8]
L_92a550:
	j.d [blink]
L_92a554:
	ld.ab r13,[sp,0xc]
