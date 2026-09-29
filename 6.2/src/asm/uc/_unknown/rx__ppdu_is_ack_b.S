/* rx__ppdu_is_ack_b @ 0x92e2bc, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__wait_ack_rf
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__ppdu_is_ack_b
rx__ppdu_is_ack_b:
	.global L_92e2bc
L_92e2bc:
	push_s blink
L_92e2be:
	mov_s r0,0x0
L_92e2c0:
	bset_s r0,r0,0x10
L_92e2c2:
	bl.d L_9366e8
L_92e2c6:
	mov_s r1,0x0
L_92e2c8:
	ldb_s r0,[gp,-0xf2]
L_92e2ca:
	brne_s r0,0,L_92e2e8
L_92e2cc:
	ldb_s r0,[gp,-0xf9]
L_92e2ce:
	bmsk_s r0,r0,0x0
L_92e2d0:
	bset_s r0,r0,0x19
L_92e2d2:
	bset_s r0,r0,0x1c
L_92e2d4:
	bset_s r0,r0,0x1d
L_92e2d6:
	mov_s r32,r0
L_92e2d8:
	st.ab r0,[r25,0x4]
L_92e2dc:
	bclr r25,r25,0xa
L_92e2e0:
	ldb_s r0,[gp,-0xf9]
L_92e2e2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e2e4:
	stb r0,[gp, -0xf9]
	.global L_92e2e8
L_92e2e8:
	ld_s r0,[gp,0x50]
L_92e2ea:
	mov_s r1,0x8022c8
L_92e2f0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e2f2:
	st.as r0,[gp,0x14]
L_92e2f6:
	ld_s r0,[r1,0x3c]
L_92e2f8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e2fa:
	st_s r0,[r1,0x3c]
L_92e2fc:
	mov_s r0,0x2011000
L_92e302:
	mov_s r32,r0
L_92e304:
	st.ab r0,[r25,0x4]
L_92e308:
	bclr r25,r25,0xa
L_92e30c:
	mov_s r0,r36
L_92e30e:
	bic r0,r0,-0x101
L_92e312:
	pop_s blink
L_92e314:
	j_s [blink]
L_92e316:
	nop_s
