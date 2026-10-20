/* rx__arm_window_b @ 0x923280, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_responder_flow_enter
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x800578
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__arm_window_b
rx__arm_window_b:
	.global L_923280
L_923280:
	push_s blink
L_923282:
	mov_s r0,0x0
L_923284:
	bset_s r0,r0,0x10
L_923286:
	bl.d L_9366e8
L_92328a:
	mov_s r1,0x0
L_92328c:
	ldb_s r0,[gp,-0xf2]
L_92328e:
	brne_s r0,0,L_9232ac
L_923290:
	ldb_s r0,[gp,-0xf9]
L_923292:
	bmsk_s r0,r0,0x0
L_923294:
	bset_s r0,r0,0x19
L_923296:
	bset_s r0,r0,0x1c
L_923298:
	bset_s r0,r0,0x1d
L_92329a:
	mov_s r32,r0
L_92329c:
	st.ab r0,[r25,0x4]
L_9232a0:
	bclr r25,r25,0xa
L_9232a4:
	ldb_s r0,[gp,-0xf9]
L_9232a6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9232a8:
	stb r0,[gp, -0xf9]
	.global L_9232ac
L_9232ac:
	ld_s r0,[gp,0x50]
L_9232ae:
	mov_s r1,0x8022c8
L_9232b4:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9232b6:
	st.as r0,[gp,0x14]
L_9232ba:
	ld_s r0,[r1,0x3c]
L_9232bc:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9232be:
	st_s r0,[r1,0x3c]
L_9232c0:
	mov_s r0,0x2011000
L_9232c6:
	mov_s r32,r0
L_9232c8:
	st.ab r0,[r25,0x4]
L_9232cc:
	bclr r25,r25,0xa
L_9232d0:
	pop_s blink
L_9232d2:
	j_s [blink]
