/* mac_mode_brp_step @ 0x922d08, 240 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__mode_step
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, brp__build_tx_params, brp__program_and_measure, get_g_804010, mac__program_4f_52, mac_mode__wait_ppdu_and_kick, mac_mode_program_a, uc_wait_event1_or_event4
 */
	.section .text.mac_mode_brp_step,"ax",@progbits
	.global mac_mode_brp_step
mac_mode_brp_step:
	.global L_922d08
L_922d08:
	push_s blink
L_922d0a:
	bl.d L_920214
L_922d0e:
	mov_s r1,0x4
L_922d10:
	mov_s r0,0x5a3c
L_922d16:
	bl.d L_924840
L_922d1a:
	mov_s r13,0x0
	.global L_922d1c
L_922d1c:
	bl L_922f60
L_922d20:
	mov_s r0,0x800734
L_922d26:
	ld_s r0,[r0,0x10]
L_922d28:
	bbit0 r0,0x0,L_922dde
L_922d2c:
	mov_s r0,0x49000040
L_922d32:
	mov_s r32,r0
L_922d34:
	st.ab r0,[r25,0x4]
L_922d38:
	bclr r25,r25,0xa
L_922d3c:
	mov_s r0,0x80
L_922d3e:
	bset_s r0,r0,0xc
L_922d40:
	mov_s r1,0x40
L_922d42:
	bl.d L_9318f4
L_922d46:
	mov_s r2,0x0
L_922d48:
	mov_s r0,r42
L_922d4a:
	bbit0 r0,0xc,L_922dbe
L_922d4e:
	bl L_922e74
L_922d52:
	mov_s r0,r36
L_922d54:
	bbit0 r0,0x19,L_922db6
L_922d58:
	bl L_928fa0
L_922d5c:
	breq_s r0,0,L_922db6
L_922d5e:
	mov_s r1,0x8014d8
L_922d64:
	ldb_s r0,[r1]
L_922d66:
	mov_s r14,0x800734
L_922d6c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922d6e:
	extb_s r0,r0
L_922d70:
	stb_s r0,[r1]
L_922d72:
	bl.d L_92ab1c
L_922d76:
	ldb_s r0,[r14,0xc]
L_922d78:
	st_s r0,[r14,0x14]
L_922d7a:
	bbit0 r0,0x0,L_922dcc
L_922d7e:
	bl.d L_923930
L_922d82:
	ldb_s r0,[r14,0xc]
L_922d84:
	breq_s r0,0,L_922d9e
L_922d86:
	ld_s r0,[r14,0x10]
L_922d88:
	mov_s r1,0x801090
L_922d8e:
	bset_s r0,r0,0x1
L_922d90:
	bclr_s r0,r0,0x0
L_922d92:
	st_s r0,[r14,0x10]
L_922d94:
	ldw_s r0,[r1,0x10]
L_922d96:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922d98:
	extw_s r0,r0
L_922d9a:
	stw_s r0,[r1,0x10]
L_922d9c:
	b_s L_922dcc
	.global L_922d9e
L_922d9e:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_922da0:
	extb_s r13,r13
L_922da2:
	brne r13,0x4,L_922dcc
L_922da6:
	mov_s r1,0x801090
L_922dac:
	ldw_s r0,[r1,0x12]
L_922dae:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922db0:
	extw_s r0,r0
L_922db2:
	stw_s r0,[r1,0x12]
L_922db4:
	b_s L_922df0
	.global L_922db6
L_922db6:
	mov_s r0,r37
L_922db8:
	bbit0 r0,0x18,L_922dcc
L_922dbc:
	b_s L_922df0
	.global L_922dbe
L_922dbe:
	mov_s r0,r54
L_922dc0:
	bbit0 r0,0x6,L_922df0
L_922dc4:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_922dc6:
	extb_s r13,r13
L_922dc8:
	breq r13,0x4,L_922de2
	.global L_922dcc
L_922dcc:
	mov_s r1,0x800734
L_922dd2:
	ld_s r0,[r1,0x10]
L_922dd4:
	bbit1 r0,0x0,L_922d1c
L_922dd8:
	ld_s r0,[r1,0x14]
L_922dda:
	bbit1 r0,0x2,L_922d1c
	.global L_922dde
L_922dde:
	mov_s r0,0x1
L_922de0:
	b_s L_922df2
	.global L_922de2
L_922de2:
	mov_s r1,0x801090
L_922de8:
	ldw_s r0,[r1,0x14]
L_922dea:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_922dec:
	extw_s r0,r0
L_922dee:
	stw_s r0,[r1,0x14]
	.global L_922df0
L_922df0:
	mov_s r0,0x0
	.global L_922df2
L_922df2:
	b L_920284
L_922df6:
	nop_s
