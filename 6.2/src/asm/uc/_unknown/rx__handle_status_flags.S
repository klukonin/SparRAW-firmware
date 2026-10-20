/* rx__handle_status_flags @ 0x939d3c, 332 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_sta__run_txop
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bitstream__push, mac__prepare_txrx_window, memset0_words_uc, rx__program_mac_and_wait, rx_flow__run, sxd_hal__wait_slot2_busy2, tx__cca_check_and_send, tx_mtp_queue_gate
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__handle_status_flags
rx__handle_status_flags:
	.global L_939d3c
L_939d3c:
	push_s blink
L_939d3e:
	bl.d L_920230
L_939d42:
	mov_s r1,0x8
L_939d44:
	sub_s sp,sp,0x8
L_939d46:
	mov_s r13,r0
L_939d48:
	bl.d L_920a84
L_939d4c:
	mov_s r0,sp
L_939d4e:
	mov_s r15,0x0
L_939d50:
	b_s L_939dd6
	.global L_939d52
L_939d52:
	and.f 0x0,r0,0xe00
L_939d5a:
	bne_s L_939d92
L_939d5c:
	bmsk.f 0x0,r0,0x4
L_939d60:
	bne_s L_939dce
L_939d62:
	bbit1 r0,0x7,L_939d9a
L_939d66:
	mov_s r0,0x802978
L_939d6c:
	bl.d L_938b90
L_939d70:
	ld_s r0,[r0,0x78]
L_939d72:
	breq_s r15,0,L_939dcc
L_939d74:
	mov_s r0,sp
L_939d76:
	mov_s r3,0x8021b8
L_939d7c:
	ldb_s r1,[r3,0x9]
L_939d7e:
	mov_s r2,0x0
L_939d80:
	bl.d L_93cd00
L_939d84:
	ld_s r3,[r3,0xc]
L_939d86:
	mov_s r1,0x1
L_939d88:
	mov_s r0,0x8006bc
L_939d8e:
	st_s r1,[r0]
L_939d90:
	b_s L_939dcc
	.global L_939d92
L_939d92:
	bclr_s r0,r0,0x8
L_939d94:
	st.as r0,[gp,0x34]
L_939d98:
	b_s L_939de4
	.global L_939d9a
L_939d9a:
	mov_s r0,0x801498
L_939da0:
	ld_s r0,[r0,0x8]
L_939da2:
	mov_s r14,0x8021b8
L_939da8:
	bbit0 r0,0x9,L_939db0
L_939dac:
	ldb_s r1,[r14,0xb]
L_939dae:
	b_s L_939db2
	.global L_939db0
L_939db0:
	ldb_s r1,[r14,0x9]
	.global L_939db2
L_939db2:
	mov_s r0,sp
L_939db4:
	mov_s r2,0x1
L_939db6:
	bl.d L_93cd00
L_939dba:
	ld_s r3,[r14,0xc]
L_939dbc:
	breq r0,0x1,L_939e24
L_939dc0:
	bl L_939aa4
L_939dc4:
	ld_s r0,[gp,0xd0]
L_939dc6:
	bclr_s r0,r0,0x7
L_939dc8:
	st.as r0,[gp,0x34]
	.global L_939dcc
L_939dcc:
	mov_s r15,0x0
	.global L_939dce
L_939dce:
	ld_s r0,[gp,0xd0]
L_939dd0:
	bmsk.f 0x0,r0,0x4
L_939dd4:
	bne_s L_939e4a
	.global L_939dd6
L_939dd6:
	ld_s r0,[gp,0xd0]
L_939dd8:
	mov_s r1,r0
L_939dda:
	bic r1,r1,-0x141
L_939dde:
	cmp r1,0x100
L_939de2:
	beq_s L_939d52
	.global L_939de4
L_939de4:
	ld_s r0,[r13]
L_939de6:
	mov_s r1,0x857e49
L_939dec:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_939dee:
	add2_s r0,r0,r0
L_939df0:
	ldb_s r0,[r1,r0]
L_939df2:
	brne_s r0,0,L_939e00
L_939df4:
	mov_s r0,0x80141c
L_939dfa:
	ld_s r0,[r0,0x8]
L_939dfc:
	bbit0 r0,0x1,L_939e1e
	.global L_939e00
L_939e00:
	mov_s r0,0x80242c
L_939e06:
	ldw_s r0,[r0,0x8]
L_939e08:
	cmp_s r0,0x0
L_939e0a:
	mov.eq r0,r13
L_939e0e:
	mov.eq r1,0x1
L_939e12:
	mov.eq r2,r1
L_939e16:
	bl.eq.d L_924d00
L_939e1a:
	mov.eq r3,0x0
	.global L_939e1e
L_939e1e:
	b.d L_92029c
L_939e22:
	add_s sp,sp,0x8
	.global L_939e24
L_939e24:
	ld_s r0,[r14,0x20]
L_939e26:
	bbit0 r0,0x3,L_939e3c
L_939e2a:
	ld_s r0,[r13]
L_939e2c:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_939e2e:
	add2_s r0,r0,r0
L_939e30:
	add_s r0,r0,0x857e38
L_939e36:
	ldb_s r1,[r0,0x11]
L_939e38:
	bset_s r1,r1,0x3
L_939e3a:
	stb_s r1,[r0,0x11]
	.global L_939e3c
L_939e3c:
	mov_s r0,r13
L_939e3e:
	mov_s r1,0x1
L_939e40:
	mov_s r2,r1
L_939e42:
	bl.d L_924d00
L_939e46:
	mov_s r3,0x0
L_939e48:
	b_s L_939dd6
	.global L_939e4a
L_939e4a:
	mov_s r0,0x2
L_939e4c:
	bset_s r0,r0,0x19
L_939e4e:
	mov_s r32,r0
L_939e50:
	st.ab r0,[r25,0x4]
L_939e54:
	bclr r25,r25,0xa
L_939e58:
	bl.d L_936cc8
L_939e5c:
	ldw_s r0,[gp,-0x1e]
L_939e5e:
	breq_s r0,0,L_939e70
L_939e60:
	bl.d L_930dd4
L_939e64:
	mov_s r15,0x1
L_939e66:
	mov_s r0,0x8006bc
L_939e6c:
	st_s r15,[r0,0x4]
L_939e6e:
	b_s L_939dd6
	.global L_939e70
L_939e70:
	mov_s r0,r13
L_939e72:
	bl.d L_920b58
L_939e76:
	mov_s r1,0x2
L_939e78:
	mov_s r1,0x802210
L_939e7e:
	ld_s r0,[r1,0xc]
L_939e80:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_939e82:
	st_s r0,[r1,0xc]
L_939e84:
	b_s L_939dd6
L_939e86:
	nop_s
