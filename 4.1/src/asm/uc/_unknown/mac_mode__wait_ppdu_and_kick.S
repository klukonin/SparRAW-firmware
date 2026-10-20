/* mac_mode__wait_ppdu_and_kick @ 0x922e74, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode_brp_step, mac_mode_step_b
 * Зовёт сам: uc_wait_event_busy
 * Глобалы (через gp): 0x80057c
 */
	.section .text.mac_mode__wait_ppdu_and_kick,"ax",@progbits
	.global mac_mode__wait_ppdu_and_kick
mac_mode__wait_ppdu_and_kick:
	.global L_922e74
L_922e74:
	push_s blink
L_922e76:
	mov_s r0,0x0
L_922e78:
	bset_s r0,r0,0x10
L_922e7a:
	bl.d L_931808
L_922e7e:
	mov_s r1,0x0
L_922e80:
	ldb_s r0,[gp,-0xf3]
L_922e82:
	brne_s r0,0,L_922ea0
L_922e84:
	ldb_s r0,[gp,-0xf9]
L_922e86:
	bmsk_s r0,r0,0x0
L_922e88:
	bset_s r0,r0,0x19
L_922e8a:
	bset_s r0,r0,0x1c
L_922e8c:
	bset_s r0,r0,0x1d
L_922e8e:
	mov_s r32,r0
L_922e90:
	st.ab r0,[r25,0x4]
L_922e94:
	bclr r25,r25,0xa
L_922e98:
	ldb_s r0,[gp,-0xf9]
L_922e9a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922e9c:
	stb r0,[gp, -0xf9]
	.global L_922ea0
L_922ea0:
	ld_s r0,[gp,0x54]
L_922ea2:
	mov_s r1,0x801458
L_922ea8:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922eaa:
	st.as r0,[gp,0x15]
L_922eae:
	ld_s r0,[r1,0x38]
L_922eb0:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922eb2:
	st_s r0,[r1,0x38]
L_922eb4:
	mov_s r0,0x2011000
L_922eba:
	mov_s r32,r0
L_922ebc:
	st.ab r0,[r25,0x4]
L_922ec0:
	bclr r25,r25,0xa
L_922ec4:
	pop_s blink
L_922ec6:
	j_s [blink]
