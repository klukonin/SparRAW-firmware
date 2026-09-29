/* brp__reset_db_b @ 0x9282b0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_w_s15_w6_uc, memset0_words_uc
 */
	.section .text.brp__reset_db_b,"ax",@progbits
	.global brp__reset_db_b
brp__reset_db_b:
	.global L_9282b0
L_9282b0:
	push_s blink
L_9282b2:
	bl.d L_920214
L_9282b6:
	mov_s r1,0xc
L_9282b8:
	mov_s r14,r0
L_9282ba:
	mov_s r13,0x800734
L_9282c0:
	bl.d L_92166c
L_9282c4:
	add r0,r13,0x18
L_9282c8:
	mov_s r0,0x857000
L_9282ce:
	ld_s r1,[r0,0x50]
L_9282d0:
	mov_s r0,r13
L_9282d2:
	bmsk_s r1,r1,0x5
L_9282d4:
	bl L_9379a0
L_9282d8:
	mov_s r0,0x0
L_9282da:
	st_s r0,[r13,0x4]
L_9282dc:
	st_s r0,[r13,0x8]
L_9282de:
	ld_s r0,[r13,0x1c]
L_9282e0:
	stb_s r14,[r13,0x18]
L_9282e2:
	bset_s r0,r0,0x0
L_9282e4:
	st_s r0,[r13,0x1c]
L_9282e6:
	mov_s r1,0x801090
L_9282ec:
	ldw_s r0,[r1,0x16]
L_9282ee:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9282f0:
	extw_s r0,r0
L_9282f2:
	stw_s r0,[r1,0x16]
L_9282f4:
	mov_s r0,0x2011000
L_9282fa:
	mov_s r32,r0
L_9282fc:
	st.ab r0,[r25,0x4]
L_928300:
	bclr r25,r25,0xa
L_928304:
	b L_920284
