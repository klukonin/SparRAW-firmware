/* brp__reset_db @ 0x92822c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__mode_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, bf_w_s15_w6_uc, bf_w_s4_w5_uc, memset0_words_uc
 */
	.section .text.brp__reset_db,"ax",@progbits
	.global brp__reset_db
brp__reset_db:
	.global L_92822c
L_92822c:
	push_s blink
L_92822e:
	bl.d L_920214
L_928232:
	mov_s r1,0xc
L_928234:
	mov_s r14,r0
L_928236:
	mov_s r13,0x800734
L_92823c:
	bl.d L_92166c
L_928240:
	add r0,r13,0xc
L_928244:
	mov_s r0,0x857000
L_92824a:
	ld_s r1,[r0,0x50]
L_92824c:
	mov_s r0,r13
L_92824e:
	bmsk_s r1,r1,0x5
L_928250:
	bl L_9379a0
L_928254:
	ld_s r0,[r13,0x10]
L_928256:
	stb_s r14,[r13,0xc]
L_928258:
	bclr_s r0,r0,0x0
L_92825a:
	bclr_s r0,r0,0x9
L_92825c:
	bset r1,r0,0x0
L_928260:
	bset_s r1,r1,0x9
L_928262:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_928264:
	st_s r1,[r13,0x10]
L_928266:
	mov_s r1,0x0
L_928268:
	add1_s r14,r14,r14
L_92826a:
	st_s r1,[r13,0x4]
L_92826c:
	st_s r1,[r13,0x8]
L_92826e:
	add_s r14,r14,0x800ef4
L_928274:
	ldb_s r1,[r14,0xb]
L_928276:
	bbit1 r1,0x0,L_928282
L_92827a:
	or r0,r0,0x205
L_92827e:
	st_s r0,[r13,0x10]
L_928280:
	b_s L_92829a
	.global L_928282
L_928282:
	ldb_s r0,[r14,0xa]
L_928284:
	brlt r0,0x1,L_92829a
L_928288:
	ld_s r0,[r13,0x14]
L_92828a:
	bset_s r0,r0,0x2
L_92828c:
	ldb_s r1,[r14,0xa]
L_92828e:
	st_s r0,[r13,0x14]
L_928290:
	bmsk_s r1,r1,0x4
L_928292:
	add r0,r13,0x14
L_928296:
	bl L_9379dc
	.global L_92829a
L_92829a:
	mov_s r0,0x2011000
L_9282a0:
	mov_s r32,r0
L_9282a2:
	st.ab r0,[r25,0x4]
L_9282a6:
	bclr r25,r25,0xa
L_9282aa:
	b L_920284
L_9282ae:
	nop_s
