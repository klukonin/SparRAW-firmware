/* rx__ppdu_is_cts_c @ 0x92e3e0, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: itx__wait_cts_rf
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__ppdu_is_cts_c
rx__ppdu_is_cts_c:
	.global L_92e3e0
L_92e3e0:
	push_s blink
L_92e3e2:
	mov_s r0,0x0
L_92e3e4:
	bset_s r0,r0,0x10
L_92e3e6:
	bl.d L_9366e8
L_92e3ea:
	mov_s r1,0x0
L_92e3ec:
	ldb_s r0,[gp,-0xf2]
L_92e3ee:
	brne_s r0,0,L_92e40c
L_92e3f0:
	ldb_s r0,[gp,-0xf9]
L_92e3f2:
	bmsk_s r0,r0,0x0
L_92e3f4:
	bset_s r0,r0,0x19
L_92e3f6:
	bset_s r0,r0,0x1c
L_92e3f8:
	bset_s r0,r0,0x1d
L_92e3fa:
	mov_s r32,r0
L_92e3fc:
	st.ab r0,[r25,0x4]
L_92e400:
	bclr r25,r25,0xa
L_92e404:
	ldb_s r0,[gp,-0xf9]
L_92e406:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e408:
	stb r0,[gp, -0xf9]
	.global L_92e40c
L_92e40c:
	ld_s r0,[gp,0x50]
L_92e40e:
	mov_s r1,0x8022c8
L_92e414:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e416:
	st.as r0,[gp,0x14]
L_92e41a:
	ld_s r0,[r1,0x3c]
L_92e41c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92e41e:
	st_s r0,[r1,0x3c]
L_92e420:
	mov_s r0,0x2011000
L_92e426:
	mov_s r32,r0
L_92e428:
	st.ab r0,[r25,0x4]
L_92e42c:
	bclr r25,r25,0xa
L_92e430:
	and r0,r37,0x2
L_92e434:
	pop_s blink
L_92e436:
	j_s [blink]
