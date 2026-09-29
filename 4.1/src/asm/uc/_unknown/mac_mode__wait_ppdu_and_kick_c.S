/* mac_mode__wait_ppdu_and_kick_c @ 0x92359c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_flow_step
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.mac_mode__wait_ppdu_and_kick_c,"ax",@progbits
	.global mac_mode__wait_ppdu_and_kick_c
mac_mode__wait_ppdu_and_kick_c:
	.global L_92359c
L_92359c:
	push_s blink
L_92359e:
	mov_s r0,0x0
L_9235a0:
	bset_s r0,r0,0x10
L_9235a2:
	bl.d L_931808
L_9235a6:
	mov_s r1,0x0
L_9235a8:
	ldb_s r0,[gp,-0xf3]
L_9235aa:
	brne_s r0,0,L_9235c8
L_9235ac:
	ldb_s r0,[gp,-0xf9]
L_9235ae:
	bmsk_s r0,r0,0x0
L_9235b0:
	bset_s r0,r0,0x19
L_9235b2:
	bset_s r0,r0,0x1c
L_9235b4:
	bset_s r0,r0,0x1d
L_9235b6:
	mov_s r32,r0
L_9235b8:
	st.ab r0,[r25,0x4]
L_9235bc:
	bclr r25,r25,0xa
L_9235c0:
	ldb_s r0,[gp,-0xf9]
L_9235c2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9235c4:
	stb r0,[gp, -0xf9]
	.global L_9235c8
L_9235c8:
	ld_s r0,[gp,0x54]
L_9235ca:
	mov_s r1,0x801458
L_9235d0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9235d2:
	st.as r0,[gp,0x15]
L_9235d6:
	ld_s r0,[r1,0x38]
L_9235d8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9235da:
	st_s r0,[r1,0x38]
L_9235dc:
	mov_s r0,0x2011000
L_9235e2:
	mov_s r32,r0
L_9235e4:
	st.ab r0,[r25,0x4]
L_9235e8:
	bclr r25,r25,0xa
L_9235ec:
	pop_s blink
L_9235ee:
	j_s [blink]
