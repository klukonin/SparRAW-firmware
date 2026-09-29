/* mac_mode_step_b @ 0x922ec8, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__mode_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, brp__build_tx_params, get_g_804010, mac__program_4f_52, mac_mode__wait_ppdu_and_kick, mac_mode_program_a, uc_wait_event1_or_event4
 */
	.section .text.mac_mode_step_b,"ax",@progbits
	.global mac_mode_step_b
mac_mode_step_b:
	.global L_922ec8
L_922ec8:
	push_s blink
L_922eca:
	bl.d L_920214
L_922ece:
	mov_s r1,0x4
L_922ed0:
	mov_s r0,0x5a3c
L_922ed6:
	bl.d L_924840
L_922eda:
	mov_s r14,0x0
	.global L_922edc
L_922edc:
	bl L_922f60
L_922ee0:
	mov_s r0,0x49000040
L_922ee6:
	mov_s r32,r0
L_922ee8:
	st.ab r0,[r25,0x4]
L_922eec:
	bclr r25,r25,0xa
L_922ef0:
	mov_s r0,0x80
L_922ef2:
	bset_s r0,r0,0xc
L_922ef4:
	mov_s r1,0x40
L_922ef6:
	bl.d L_9318f4
L_922efa:
	mov_s r2,0x0
L_922efc:
	mov_s r0,r42
L_922efe:
	bbit0 r0,0xc,L_922f42
L_922f02:
	bl L_922e74
L_922f06:
	mov_s r0,r36
L_922f08:
	bbit0 r0,0x19,L_922f36
L_922f0c:
	bl L_928fa0
L_922f10:
	breq_s r0,0,L_922f36
L_922f12:
	mov_s r1,0x8014d8
L_922f18:
	ldb_s r0,[r1,0x2]
L_922f1a:
	mov_s r13,0x800734
L_922f20:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922f22:
	extb_s r0,r0
L_922f24:
	stb_s r0,[r1,0x2]
L_922f26:
	bl.d L_92ab1c
L_922f2a:
	ldb_s r0,[r13,0xc]
L_922f2c:
	st_s r0,[r13,0x14]
L_922f2e:
	bbit1 r0,0x3,L_922edc
L_922f32:
	mov_s r0,0x1
L_922f34:
	b_s L_922f3e
	.global L_922f36
L_922f36:
	mov_s r0,r37
L_922f38:
	bbit0 r0,0x18,L_922edc
	.global L_922f3c
L_922f3c:
	mov_s r0,0x0
	.global L_922f3e
L_922f3e:
	b L_920284
	.global L_922f42
L_922f42:
	mov_s r0,r54
L_922f44:
	bbit0 r0,0x6,L_922f3c
L_922f48:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_922f4a:
	extb_s r14,r14
L_922f4c:
	brne r14,0x3,L_922edc
L_922f50:
	mov_s r1,0x801090
L_922f56:
	ldw_s r0,[r1,0xe]
L_922f58:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922f5a:
	extw_s r0,r0
L_922f5c:
	stw_s r0,[r1,0xe]
L_922f5e:
	b_s L_922f3c
