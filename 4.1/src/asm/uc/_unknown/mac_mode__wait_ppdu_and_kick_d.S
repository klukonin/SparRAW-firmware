/* mac_mode__wait_ppdu_and_kick_d @ 0x92ac08, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__await_rx_frame_b
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.mac_mode__wait_ppdu_and_kick_d,"ax",@progbits
	.global mac_mode__wait_ppdu_and_kick_d
mac_mode__wait_ppdu_and_kick_d:
	.global L_92ac08
L_92ac08:
	push_s blink
L_92ac0a:
	mov_s r0,0x0
L_92ac0c:
	bset_s r0,r0,0x10
L_92ac0e:
	bl.d L_931808
L_92ac12:
	mov_s r1,0x0
L_92ac14:
	ldb_s r0,[gp,-0xf3]
L_92ac16:
	brne_s r0,0,L_92ac34
L_92ac18:
	ldb_s r0,[gp,-0xf9]
L_92ac1a:
	bmsk_s r0,r0,0x0
L_92ac1c:
	bset_s r0,r0,0x19
L_92ac1e:
	bset_s r0,r0,0x1c
L_92ac20:
	bset_s r0,r0,0x1d
L_92ac22:
	mov_s r32,r0
L_92ac24:
	st.ab r0,[r25,0x4]
L_92ac28:
	bclr r25,r25,0xa
L_92ac2c:
	ldb_s r0,[gp,-0xf9]
L_92ac2e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92ac30:
	stb r0,[gp, -0xf9]
	.global L_92ac34
L_92ac34:
	ld_s r0,[gp,0x54]
L_92ac36:
	mov_s r1,0x801458
L_92ac3c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92ac3e:
	st.as r0,[gp,0x15]
L_92ac42:
	ld_s r0,[r1,0x38]
L_92ac44:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92ac46:
	st_s r0,[r1,0x38]
L_92ac48:
	mov_s r0,0x2011000
L_92ac4e:
	mov_s r32,r0
L_92ac50:
	st.ab r0,[r25,0x4]
L_92ac54:
	bclr r25,r25,0xa
L_92ac58:
	and r0,r37,0x2
L_92ac5c:
	pop_s blink
L_92ac5e:
	j_s [blink]
