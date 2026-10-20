/* mac_mode__wait_ppdu_and_kick_b @ 0x92abac, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__await_rx_frame_a
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.mac_mode__wait_ppdu_and_kick_b,"ax",@progbits
	.global mac_mode__wait_ppdu_and_kick_b
mac_mode__wait_ppdu_and_kick_b:
	.global L_92abac
L_92abac:
	push_s blink
L_92abae:
	mov_s r0,0x0
L_92abb0:
	bset_s r0,r0,0x10
L_92abb2:
	bl.d L_931808
L_92abb6:
	mov_s r1,0x0
L_92abb8:
	ldb_s r0,[gp,-0xf3]
L_92abba:
	brne_s r0,0,L_92abd8
L_92abbc:
	ldb_s r0,[gp,-0xf9]
L_92abbe:
	bmsk_s r0,r0,0x0
L_92abc0:
	bset_s r0,r0,0x19
L_92abc2:
	bset_s r0,r0,0x1c
L_92abc4:
	bset_s r0,r0,0x1d
L_92abc6:
	mov_s r32,r0
L_92abc8:
	st.ab r0,[r25,0x4]
L_92abcc:
	bclr r25,r25,0xa
L_92abd0:
	ldb_s r0,[gp,-0xf9]
L_92abd2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92abd4:
	stb r0,[gp, -0xf9]
	.global L_92abd8
L_92abd8:
	ld_s r0,[gp,0x54]
L_92abda:
	mov_s r1,0x801458
L_92abe0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92abe2:
	st.as r0,[gp,0x15]
L_92abe6:
	ld_s r0,[r1,0x38]
L_92abe8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92abea:
	st_s r0,[r1,0x38]
L_92abec:
	mov_s r0,0x2011000
L_92abf2:
	mov_s r32,r0
L_92abf4:
	st.ab r0,[r25,0x4]
L_92abf8:
	bclr r25,r25,0xa
L_92abfc:
	mov_s r0,r36
L_92abfe:
	bic r0,r0,-0x101
L_92ac02:
	pop_s blink
L_92ac04:
	j_s [blink]
L_92ac06:
	nop_s
