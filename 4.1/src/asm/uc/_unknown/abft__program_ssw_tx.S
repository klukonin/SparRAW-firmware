/* abft__program_ssw_tx @ 0x92c528, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw
 */
	.section .text.abft__program_ssw_tx,"ax",@progbits
	.global abft__program_ssw_tx
abft__program_ssw_tx:
	.global L_92c528
L_92c528:
	st.a r13,[sp,-0x8]
L_92c52c:
	st_s r14,[sp,0x4]
L_92c52e:
	mov_s r14,blink
L_92c530:
	mov r13,r1
L_92c534:
	mov r4,0x38000200
L_92c53c:
	mov r32,r4
L_92c540:
	st.ab r4,[r25,0x4]
L_92c544:
	bclr r25,r25,0xa
L_92c548:
	or r13,r13,0x3f000000
L_92c550:
	mov r32,r13
L_92c554:
	st.ab r13,[r25,0x4]
L_92c558:
	bclr r25,r25,0xa
L_92c55c:
	mov_s r2,0x3e
L_92c55e:
	asl_s r2,r2,0x18
L_92c560:
	mov r32,r2
L_92c564:
	st.ab r2,[r25,0x4]
L_92c568:
	bclr r25,r25,0xa
L_92c56c:
	mov_s r3,0x37000020
L_92c572:
	mov_s r32,r3
L_92c574:
	st.ab r3,[r25,0x4]
L_92c578:
	bclr r25,r25,0xa
L_92c57c:
	mov_s r1,0x801458
L_92c582:
	ld_s r0,[r1,0xc]
L_92c584:
	mov_s blink,r14
L_92c586:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92c588:
	st_s r0,[r1,0xc]
L_92c58a:
	ld_s r14,[sp,0x4]
L_92c58c:
	j.d [blink]
L_92c590:
	ld.ab r13,[sp,0x8]
