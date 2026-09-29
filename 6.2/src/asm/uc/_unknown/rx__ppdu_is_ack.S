/* rx__ppdu_is_ack @ 0x92e260, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__wait_ack
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__ppdu_is_ack
rx__ppdu_is_ack:
	.global L_92e260
L_92e260:
	push_s blink
L_92e262:
	mov_s r0,0x0
L_92e264:
	bset_s r0,r0,0x10
L_92e266:
	bl.d L_9366e8
L_92e26a:
	mov_s r1,0x0
L_92e26c:
	ldb_s r0,[gp,-0xf2]
L_92e26e:
	brne_s r0,0,L_92e28c
L_92e270:
	ldb_s r0,[gp,-0xf9]
L_92e272:
	bmsk_s r0,r0,0x0
L_92e274:
	bset_s r0,r0,0x19
L_92e276:
	bset_s r0,r0,0x1c
L_92e278:
	bset_s r0,r0,0x1d
L_92e27a:
	mov_s r32,r0
L_92e27c:
	st.ab r0,[r25,0x4]
L_92e280:
	bclr r25,r25,0xa
L_92e284:
	ldb_s r0,[gp,-0xf9]
L_92e286:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e288:
	stb r0,[gp, -0xf9]
	.global L_92e28c
L_92e28c:
	ld_s r0,[gp,0x50]
L_92e28e:
	mov_s r1,0x8022c8
L_92e294:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e296:
	st.as r0,[gp,0x14]
L_92e29a:
	ld_s r0,[r1,0x3c]
L_92e29c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e29e:
	st_s r0,[r1,0x3c]
L_92e2a0:
	mov_s r0,0x2011000
L_92e2a6:
	mov_s r32,r0
L_92e2a8:
	st.ab r0,[r25,0x4]
L_92e2ac:
	bclr r25,r25,0xa
L_92e2b0:
	mov_s r0,r36
L_92e2b2:
	bic r0,r0,-0x101
L_92e2b6:
	pop_s blink
L_92e2b8:
	j_s [blink]
L_92e2ba:
	nop_s
