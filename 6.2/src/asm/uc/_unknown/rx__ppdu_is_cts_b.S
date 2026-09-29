/* rx__ppdu_is_cts_b @ 0x92e388, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__wait_cts_b
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__ppdu_is_cts_b
rx__ppdu_is_cts_b:
	.global L_92e388
L_92e388:
	push_s blink
L_92e38a:
	mov_s r0,0x0
L_92e38c:
	bset_s r0,r0,0x10
L_92e38e:
	bl.d L_9366e8
L_92e392:
	mov_s r1,0x0
L_92e394:
	ldb_s r0,[gp,-0xf2]
L_92e396:
	brne_s r0,0,L_92e3b4
L_92e398:
	ldb_s r0,[gp,-0xf9]
L_92e39a:
	bmsk_s r0,r0,0x0
L_92e39c:
	bset_s r0,r0,0x19
L_92e39e:
	bset_s r0,r0,0x1c
L_92e3a0:
	bset_s r0,r0,0x1d
L_92e3a2:
	mov_s r32,r0
L_92e3a4:
	st.ab r0,[r25,0x4]
L_92e3a8:
	bclr r25,r25,0xa
L_92e3ac:
	ldb_s r0,[gp,-0xf9]
L_92e3ae:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e3b0:
	stb r0,[gp, -0xf9]
	.global L_92e3b4
L_92e3b4:
	ld_s r0,[gp,0x50]
L_92e3b6:
	mov_s r1,0x8022c8
L_92e3bc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e3be:
	st.as r0,[gp,0x14]
L_92e3c2:
	ld_s r0,[r1,0x3c]
L_92e3c4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e3c6:
	st_s r0,[r1,0x3c]
L_92e3c8:
	mov_s r0,0x2011000
L_92e3ce:
	mov_s r32,r0
L_92e3d0:
	st.ab r0,[r25,0x4]
L_92e3d4:
	bclr r25,r25,0xa
L_92e3d8:
	and r0,r37,0x2
L_92e3dc:
	pop_s blink
L_92e3de:
	j_s [blink]
