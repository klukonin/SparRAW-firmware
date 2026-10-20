/* rx_funcs__rx_flow @ 0x933928, 2688 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1__rx_then_check_bf_abort, l1_task__rx_flow_thunk, l1_task__rx_flow_thunk_b, rx_flow__run_and_check_bf_abort
 * Зовёт сам: abif__save_override_restore, bf__abort_unexpected, bf__store_flow_status, bf_metrics__reset_and_stamp, bf_sm__run_sta, itx__report_status_evt, mac__load_tx_key, mac__select_rf_module_cmd31, mac__set_mode_0000, mac_q__tx_ppdu, queue_sel__get_qset4, rs__is_sta_enabled
 * Глобалы (через gp): 0x800528, 0x80053c, 0x8005be, 0x8005f4, 0x8005f8, 0x800608, 0x80060c
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx_funcs__rx_flow
rx_funcs__rx_flow:
	.global L_933928
L_933928:
	st.a r13,[sp,-0x1c]
L_93392c:
	st blink,[sp, 0x4]
L_933930:
	st_s r14,[sp,0x8]
L_933932:
	st_s r15,[sp,0xc]
L_933934:
	st r16,[sp, 0x10]
L_933938:
	st r17,[sp, 0x14]
L_93393c:
	st r18,[sp, 0x18]
L_933940:
	mov r4,0xeeee08
L_933948:
	mov r32,r4
L_93394c:
	st.ab r4,[r25,0x4]
L_933950:
	bclr r25,r25,0xa
L_933954:
	ld r7,[0x800748]
L_93395c:
	lr r7,[r7]
L_933960:
	bmsk r7,r7,0x17
L_933964:
	mov r32,r7
L_933968:
	st.ab r7,[r25,0x4]
L_93396c:
	bclr r25,r25,0xa
L_933970:
	mov_s r14,0x857800
L_933976:
	ld.as r3,[r14,-0x56]
L_93397a:
	cmp_s r3,0x1
L_93397c:
	mov r15,0x1
L_933980:
	bne.d L_9339c0
L_933984:
	sub.ne r17,r17,r17
L_933988:
	mov_s r13,0x80069c
L_93398e:
	ld_s r1,[r13]
L_933990:
	brne_s r1,0,L_9339b8
L_933992:
	ld r4,[0x800698]
L_93399a:
	mov_s r1,0x802408
L_9339a0:
	ld r3,[0x800694]
L_9339a8:
	mov r0,r15
L_9339ac:
	bl.d L_929d20
L_9339b0:
	mov r2,0x7
L_9339b4:
	st r15,[r13]
	.global L_9339b8
L_9339b8:
	mov r17,0x0
L_9339bc:
	st.as r17,[r14,-0x56]
	.global L_9339c0
L_9339c0:
	st.as r17,[gp,-0x1e]
L_9339c4:
	st r17,[0x8006bc]
L_9339cc:
	stb r17,[gp, -0xfb]
L_9339d0:
	stb r17,[gp, -0xfc]
L_9339d4:
	mov r18,0x3
L_9339d8:
	mov r0,0x8
L_9339dc:
	ld r4,[0x802f98]
L_9339e4:
	st.as r0,[gp,0x33]
L_9339e8:
	mov r10,0x0
L_9339ec:
	breq.d r4,0x0,L_933a00
L_9339f0:
	st.as r10,[gp,0x34]
L_9339f4:
	mov_s r0,blink
L_9339f6:
	mov_s r1,0xa1
L_9339f8:
	bl.d L_926618
L_9339fc:
	asl r1,r1,0x5
	.global L_933a00
L_933a00:
	mov r5,0x20c0080
L_933a08:
	mov r32,r5
L_933a0c:
	st.ab r5,[r25,0x4]
L_933a10:
	bclr r25,r25,0xa
L_933a14:
	mov_s r1,0x490001c1
L_933a1a:
	mov_s r32,r1
L_933a1c:
	st.ab r1,[r25,0x4]
L_933a20:
	bclr r25,r25,0xa
L_933a24:
	mov_s r2,0x14
L_933a26:
	asl_s r2,r2,0x18
L_933a28:
	mov r32,r2
L_933a2c:
	st.ab r2,[r25,0x4]
L_933a30:
	bclr r25,r25,0xa
L_933a34:
	bl.d L_9384d4
L_933a38:
	mov r0,0x1
L_933a3c:
	ld.as r7,[gp,-0xb]
L_933a40:
	mov_s r14,0x802978
L_933a46:
	ld r8,[r14, 0x78]
L_933a4a:
	mov_s r13,0x802288
L_933a50:
	st r7,[r8, 0x2c]
L_933a54:
	mov r8,0xff
L_933a58:
	st r8,[r13, 0x4]
L_933a5c:
	mov r5,0x8
L_933a60:
	st r5,[r13]
L_933a64:
	bl.d L_930dd4
L_933a68:
	st r17,[r13, 0x10]
L_933a6c:
	ld.as r11,[gp,0x34]
L_933a70:
	and.f 0x0,r11,0x3001000
L_933a78:
	beq L_933aa8
L_933a7c:
	bl L_932de8
L_933a80:
	mov r6,0x0
L_933a84:
	st.as r6,[gp,0x33]
L_933a88:
	st.as r6,[gp,0x34]
L_933a8c:
	ld blink,[sp, 0x4]
L_933a90:
	ld_s r14,[sp,0x8]
L_933a92:
	ld_s r15,[sp,0xc]
L_933a94:
	ld r16,[sp, 0x10]
L_933a98:
	ld r17,[sp, 0x14]
L_933a9c:
	ld r18,[sp, 0x18]
L_933aa0:
	j.d [blink]
L_933aa4:
	ld.ab r13,[sp,0x1c]
	.global L_933aa8
L_933aa8:
	mov r6,0x2000080
L_933ab0:
	mov r32,r6
L_933ab4:
	st.ab r6,[r25,0x4]
L_933ab8:
	bclr r25,r25,0xa
L_933abc:
	ld r10,[r14, 0x78]
L_933ac0:
	mov r9,0x801104
L_933ac8:
	ld r8,[r10]
L_933acc:
	asl r8,r8,0x4
L_933ad0:
	add2 r8,r8,r8
L_933ad4:
	add r7,r9,r8
L_933ad8:
	add r8,r8,r9
L_933adc:
	ld r6,[r7, 0x1c]
L_933ae0:
	ld r11,[r8, 0x18]
L_933ae4:
	add r9,r9,0x24
L_933ae8:
	or r11,r11,r6
L_933aec:
	st r11,[0x886d98]
L_933af4:
	ld r11,[r14, 0x78]
L_933af8:
	ld r10,[r11]
L_933afc:
	asl r10,r10,0x4
L_933b00:
	add2 r10,r10,r10
L_933b04:
	ld r8,[r9,r10]
L_933b08:
	or r8,r8,0x12000000
L_933b10:
	mov r32,r8
L_933b14:
	st.ab r8,[r25,0x4]
L_933b18:
	bclr r25,r25,0xa
L_933b1c:
	ld r9,[r13, 0x10]
L_933b20:
	btst r9,0x2
L_933b24:
	bne L_933bd8
	.global L_933b28
L_933b28:
	mov r0,0x0
L_933b2c:
	bl.d L_93cfdc
L_933b30:
	mov r1,r0
L_933b34:
	ldw.as r9,[gp,0x66]
L_933b38:
	or r9,r9,0xcb0000
L_933b40:
	mov r32,r9
L_933b44:
	st.ab r9,[r25,0x4]
L_933b48:
	bclr r25,r25,0xa
L_933b4c:
	ld_s r0,[gp,0xcc]
L_933b4e:
	lsr_s r0,r0,0x10
L_933b50:
	or r0,r0,0xcb0000
L_933b58:
	mov r32,r0
L_933b5c:
	st.ab r0,[r25,0x4]
L_933b60:
	bclr r25,r25,0xa
L_933b64:
	ldw.as r1,[gp,0x68]
L_933b68:
	or r1,r1,0xcb0000
L_933b70:
	mov r32,r1
L_933b74:
	st.ab r1,[r25,0x4]
L_933b78:
	bclr r25,r25,0xa
L_933b7c:
	ld.as r2,[gp,0x34]
L_933b80:
	lsr_s r2,r2,0x10
L_933b82:
	or r2,r2,0xcb0000
L_933b8a:
	mov_s r32,r2
L_933b8c:
	st.ab r2,[r25,0x4]
L_933b90:
	bclr r25,r25,0xa
L_933b94:
	mov_s r13,0x8021e0
L_933b9a:
	ld r9,[r13]
L_933b9e:
	and.f 0x0,r9,0x221
L_933ba6:
	beq L_93406c
L_933baa:
	ld_s r0,[gp,-0xd4]
L_933bac:
	and r0,r0,0xfffff0ff
L_933bb4:
	bset_s r0,r0,0x1b
L_933bb6:
	mov_s r32,r0
L_933bb8:
	st.ab r0,[r25,0x4]
L_933bbc:
	bclr r25,r25,0xa
L_933bc0:
	ld r4,[r13]
L_933bc4:
	btst r4,0x0
L_933bc8:
	beq.d L_933f8c
L_933bcc:
	mov r17,0x1
L_933bd0:
	b.d L_933f90
L_933bd4:
	mov r14,0x4
	.global L_933bd8
L_933bd8:
	ld.as r8,[gp,-0x35]
L_933bdc:
	and r8,r8,0xfffff0ff
L_933be4:
	bset r8,r8,0x1b
L_933be8:
	mov r32,r8
L_933bec:
	st.ab r8,[r25,0x4]
L_933bf0:
	bclr r25,r25,0xa
L_933bf4:
	ld_s r3,[r13]
L_933bf6:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_933bf8:
	add2_s r3,r3,r3
L_933bfa:
	add_s r3,r3,0x801104
L_933c00:
	ldb r2,[r3, 0x4b]
L_933c04:
	breq.d r2,0x0,L_933c28
L_933c08:
	mov r17,0x1
L_933c0c:
	bl.d L_9294ac
L_933c10:
	add r0,r3,0x38
L_933c14:
	ld r0,[0x8029f0]
L_933c1c:
	ld r11,[r0, 0xc]
L_933c20:
	bset r11,r11,0xb
L_933c24:
	st r11,[r0, 0xc]
	.global L_933c28
L_933c28:
	mov r7,0x20000400
L_933c30:
	mov r32,r7
L_933c34:
	st.ab r7,[r25,0x4]
L_933c38:
	bclr r25,r25,0xa
L_933c3c:
	b L_933c4c
	.global L_933c40
L_933c40:
	ld.as r1,[gp,0x34]
L_933c44:
	bset r1,r1,0xa
L_933c48:
	st.as r1,[gp,0x34]
	.global L_933c4c
L_933c4c:
	mov r13,0x802288
L_933c54:
	ld r9,[r13, 0x10]
L_933c58:
	bbit0 r9,0x1,L_933c78
L_933c5c:
	ld r0,[0x8029f0]
L_933c64:
	bl L_938b90
L_933c68:
	ld_s r1,[r13,0x10]
L_933c6a:
	mov_s r3,0x1
L_933c6c:
	bclr_s r1,r1,0x1
L_933c6e:
	st_s r1,[r13,0x10]
L_933c70:
	st r3,[0x8006bc]
	.global L_933c78
L_933c78:
	bl L_9364c8
L_933c7c:
	ld.as r2,[gp,0x5]
L_933c80:
	mov r14,r0
L_933c84:
	ld.as r5,[gp,-0x4]
L_933c88:
	sub r3,r0,r2
L_933c8c:
	brhs.d r5,r3,L_933c9c
L_933c90:
	ld.as r1,[gp,0x34]
L_933c94:
	bset r1,r1,0x10
L_933c98:
	st.as r1,[gp,0x34]
	.global L_933c9c
L_933c9c:
	and.f 0x0,r1,0x11600
L_933ca4:
	beq L_933d1c
L_933ca8:
	bbit0 r1,0xc,L_933cb4
L_933cac:
	bl L_932de8
L_933cb0:
	mov r18,r0
	.global L_933cb4
L_933cb4:
	mov r11,0x8006e0
L_933cbc:
	ld r3,[r11]
L_933cc0:
	breq_s r3,0,L_933ce0
L_933cc2:
	mov r8,0x801030
L_933cca:
	ld r6,[r8, 0xa4]
L_933cce:
	sub_s r14,r14,r3
L_933cd0:
	add r6,r6,r14
L_933cd4:
	st r6,[r8, 0xa4]
L_933cd8:
	mov r10,0x0
L_933cdc:
	st r10,[r11]
	.global L_933ce0
L_933ce0:
	ldb r6,[gp, -0xe1]
L_933ce4:
	brlt r6,0x2,L_933d04
L_933ce8:
	bl.d L_9300ac
L_933cec:
	ld r0,[r13]
L_933cf0:
	brne_s r0,0,L_933d04
L_933cf2:
	ld_s r0,[r13]
L_933cf4:
	ldb r7,[0x802194]
L_933cfc:
	btst r7,r0
L_933d00:
	bl.ne L_927764
	.global L_933d04
L_933d04:
	mov r9,0x20000000
L_933d0c:
	mov r32,r9
L_933d10:
	st.ab r9,[r25,0x4]
L_933d14:
	bclr r25,r25,0xa
L_933d18:
	b L_933b28
	.global L_933d1c
L_933d1c:
	mov r7,0x2080002
L_933d24:
	mov r32,r7
L_933d28:
	st.ab r7,[r25,0x4]
L_933d2c:
	bclr r25,r25,0xa
L_933d30:
	mov_s r14,0x802978
L_933d36:
	ld_s r0,[r14,0x78]
L_933d38:
	mov r15,0x0
L_933d3c:
	ld.a r16,[r0,0x4]
L_933d40:
	bl.d L_92e9e8
L_933d44:
	st.as r15,[gp,0x0]
L_933d48:
	cmp r0,0x0
L_933d4c:
	bne.d L_933e88
L_933d50:
	ld r3,[r14, 0x78]
	.global L_933d54
L_933d54:
	mov r7,0x13
L_933d58:
	st r7,[r3, 0x18]
L_933d5c:
	ld_s r0,[r14,0x78]
L_933d5e:
	ld r4,[r0, 0x4]
L_933d62:
	add1 r4,r4,r4
L_933d66:
	ldb r6,[r4,0x802228]
L_933d6e:
	breq r6,0x0,L_933d80
L_933d72:
	ld r6,[r0, 0x18]
L_933d76:
	bset r6,r6,0x6
L_933d7a:
	st r6,[r0, 0x18]
L_933d7e:
	ld_s r0,[r14,0x78]
	.global L_933d80
L_933d80:
	bl L_93db98
L_933d84:
	bl.d L_936d64
L_933d88:
	ldw.as r0,[gp,-0xf]
L_933d8c:
	breq.d r15,0x0,L_933de0
L_933d90:
	mov r13,r0
	.global L_933d94
L_933d94:
	mov r2,r43
L_933d98:
	bbit0 r2,0x1f,L_933d94
L_933d9c:
	mov r5,r51
L_933da0:
	bmsk r3,r5,0x3
L_933da4:
	st.as r3,[gp,0x38]
L_933da8:
	lsr r5,r5,0x4
L_933dac:
	st.as r5,[gp,0x39]
L_933db0:
	mov r7,r43
L_933db4:
	bbit0 r7,0x1b,L_933dcc
L_933db8:
	ld r4,[0x8029f0]
L_933dc0:
	ld r11,[r4, 0xc]
L_933dc4:
	bset r11,r11,0x9
L_933dc8:
	st r11,[r4, 0xc]
	.global L_933dcc
L_933dcc:
	mov r8,0x1b010000
L_933dd4:
	mov r32,r8
L_933dd8:
	st.ab r8,[r25,0x4]
L_933ddc:
	bclr r25,r25,0xa
	.global L_933de0
L_933de0:
	cmp_s r13,0x0
L_933de2:
	beq_s L_933f0c
L_933de4:
	mov r9,0x4
L_933de8:
	st.as r9,[gp,0x33]
L_933dec:
	mov_s r13,0x802288
L_933df2:
	ld_s r0,[r13]
L_933df4:
	bl.d L_930dd4
L_933df8:
	st r0,[r13, 0x4]
L_933dfc:
	ld r4,[r13, 0xc]
L_933e00:
	cmp r4,0x3
L_933e04:
	beq.d L_933ef8
L_933e08:
	mov r16,0x0
	.global L_933e0c
L_933e0c:
	ld r7,[r13, 0x4]
L_933e10:
	ld_s r0,[r13]
L_933e12:
	breq r0,r7,L_933e74
L_933e16:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_933e18:
	add2_s r0,r0,r0
L_933e1a:
	mov_s r14,0x801104
L_933e20:
	add_s r0,r0,r14
L_933e22:
	ldb r4,[r0, 0x4b]
L_933e26:
	mov_s r15,0x802978
L_933e2c:
	breq r4,0x0,L_933e40
L_933e30:
	bl.d L_9294ac
L_933e34:
	add r0,r0,0x38
L_933e38:
	ld_s r2,[r15,0x78]
L_933e3a:
	ld_s r1,[r2,0xc]
L_933e3c:
	bset_s r1,r1,0xb
L_933e3e:
	st_s r1,[r2,0xc]
	.global L_933e40
L_933e40:
	ld r5,[r15, 0x78]
L_933e44:
	ld r10,[r5, 0xc]
L_933e48:
	bclr r10,r10,0x0
L_933e4c:
	st r10,[r5, 0xc]
L_933e50:
	ld_s r3,[r13]
L_933e52:
	st_s r3,[r13,0x4]
L_933e54:
	/* asl_s r3,r3,0x4 */
	.byte 0x04,0xbb
L_933e56:
	add2_s r3,r3,r3
L_933e58:
	add r11,r14,r3
L_933e5c:
	ld r5,[r11, 0x1c]
L_933e60:
	add r14,r14,r3
L_933e64:
	ld r4,[r14, 0x18]
L_933e68:
	or r4,r4,r5
L_933e6c:
	st r4,[0x886d98]
	.global L_933e74
L_933e74:
	st.as r16,[gp,-0x1e]
L_933e78:
	mov r5,r42
L_933e7c:
	btst r5,0x7
L_933e80:
	beq L_933c4c
L_933e84:
	b L_933c40
	.global L_933e88
L_933e88:
	mov r6,0x1
L_933e8c:
	st.as r6,[gp,0x0]
L_933e90:
	ld_s r13,[r3,0x4]
L_933e92:
	cmp_s r13,r16
L_933e94:
	beq_s L_933d54
L_933e96:
	asl_s r13,r13,0x10
L_933e98:
	bset r13,r13,0x0
L_933e9c:
	mov r9,0x1b001111
L_933ea4:
	mov r32,r9
L_933ea8:
	st.ab r9,[r25,0x4]
L_933eac:
	bclr r25,r25,0xa
L_933eb0:
	or r13,r13,0x16000000
L_933eb8:
	mov r32,r13
L_933ebc:
	st.ab r13,[r25,0x4]
L_933ec0:
	bclr r25,r25,0xa
L_933ec4:
	mov r6,0x17000000
L_933ecc:
	mov r32,r6
L_933ed0:
	st.ab r6,[r25,0x4]
L_933ed4:
	bclr r25,r25,0xa
L_933ed8:
	nop_s
L_933eda:
	nop_s
L_933edc:
	nop_s
L_933ede:
	ld r5,[r14, 0x78]
L_933ee2:
	mov_s r15,0x1
L_933ee4:
	ld r2,[r5, 0xc]
L_933ee8:
	bclr r2,r2,0x9
L_933eec:
	st r2,[r5, 0xc]
L_933ef0:
	b.d L_933d54
L_933ef4:
	ld r3,[r14, 0x78]
	.global L_933ef8
L_933ef8:
	mov_s r0,0x80
L_933efa:
	bset_s r0,r0,0x19
L_933efc:
	mov r32,r0
L_933f00:
	st.ab r0,[r25,0x4]
L_933f04:
	bclr r25,r25,0xa
L_933f08:
	b L_933e0c
	.global L_933f0c
L_933f0c:
	ld.as r7,[gp,-0x1e]
L_933f10:
	ldb r6,[0x80296b]
L_933f18:
	add r7,r7,r6
L_933f1c:
	st.as r7,[gp,-0x1e]
L_933f20:
	brlo.d r7,0x1f,L_933f30
L_933f24:
	ld.as r4,[gp,0x34]
L_933f28:
	bset r4,r4,0x10
L_933f2c:
	st.as r4,[gp,0x34]
	.global L_933f30
L_933f30:
	bbit0 r4,0x1,L_933f7c
L_933f34:
	ld r13,[0x8029f0]
L_933f3c:
	bic r4,r4,0x1f
L_933f40:
	bset r4,r4,0x7
L_933f44:
	st.as r4,[gp,0x34]
L_933f48:
	mov r0,0x0
L_933f4c:
	bl.d L_93cfdc
L_933f50:
	mov r1,r0
L_933f54:
	ld r6,[r13, 0xc]
L_933f58:
	btst r6,0x1
L_933f5c:
	mov.ne r0,r13
L_933f60:
	bl.ne.d L_939888
L_933f64:
	mov.ne r1,0x2
L_933f68:
	mov r3,0x802210
L_933f70:
	ld r5,[r3, 0xc]
L_933f74:
	add r5,r5,0x1
L_933f78:
	st r5,[r3, 0xc]
	.global L_933f7c
L_933f7c:
	mov r5,r42
L_933f80:
	btst r5,0x7
L_933f84:
	beq L_933c4c
L_933f88:
	b L_933c40
	.global L_933f8c
L_933f8c:
	mov r14,0xa
	.global L_933f90
L_933f90:
	ld r9,[0x801424]
L_933f98:
	bbit0 r9,0x0,L_933fc4
	.global L_933f9c
L_933f9c:
	mov_s r13,0x802288
L_933fa2:
	ld_s r0,[r13]
L_933fa4:
	bl.d L_92b254
L_933fa8:
	mov r1,r14
L_933fac:
	breq_s r0,0,L_933fd4
L_933fae:
	ld_s r0,[r13]
L_933fb0:
	bl.d L_9357cc
L_933fb4:
	mov r1,0x0
L_933fb8:
	bl.d L_921940
L_933fbc:
	ld r0,[r13]
L_933fc0:
	b L_934074
	.global L_933fc4
L_933fc4:
	mov r0,blink
L_933fc8:
	bl.d L_926618
L_933fcc:
	mov r1,0x74
L_933fd0:
	b L_933f9c
	.global L_933fd4
L_933fd4:
	mov_s r0,0x83
L_933fd6:
	asl_s r0,r0,0x19
L_933fd8:
	mov r32,r0
L_933fdc:
	st.ab r0,[r25,0x4]
L_933fe0:
	bclr r25,r25,0xa
L_933fe4:
	nop_s
L_933fe6:
	nop_s
L_933fe8:
	mov 0x0,0x0
L_933fec:
	mov r4,0x3800033f
L_933ff4:
	mov r32,r4
L_933ff8:
	st.ab r4,[r25,0x4]
L_933ffc:
	bclr r25,r25,0xa
L_934000:
	bl L_93e0dc
L_934004:
	ldw.as r1,[gp,0x4b]
L_934008:
	ldw r4,[0x802968]
L_934010:
	breq r1,r4,L_934040
L_934014:
	stw.as r4,[gp,0x4b]
L_934018:
	or r4,r4,0x1730000
L_934020:
	st r4,[0x886d00]
L_934028:
	sync
L_93402c:
	mov r5,0x38000200
L_934034:
	mov r32,r5
L_934038:
	st.ab r5,[r25,0x4]
L_93403c:
	bclr r25,r25,0xa
	.global L_934040
L_934040:
	nop_s
L_934042:
	nop_s
L_934044:
	nop_s
L_934046:
	mov_s r1,0x1f000601
L_93404c:
	mov r32,r1
L_934050:
	st.ab r1,[r25,0x4]
L_934054:
	bclr r25,r25,0xa
L_934058:
	ld r1,[0x802288]
L_934060:
	bl.d L_92f4bc
L_934064:
	mov r0,0x3
L_934068:
	b L_934074
	.global L_93406c
L_93406c:
	bclr r9,r9,0x1
L_934070:
	st r9,[r13]
	.global L_934074
L_934074:
	ld.as r8,[gp,0x34]
L_934078:
	bbit1 r8,0x9,L_93408c
L_93407c:
	mov_s r2,0x14000100
L_934082:
	mov_s r32,r2
L_934084:
	st.ab r2,[r25,0x4]
L_934088:
	bclr r25,r25,0xa
	.global L_93408c
L_93408c:
	breq r17,0x0,L_9340c4
L_934090:
	ld r5,[0x801474]
L_934098:
	ld.as r9,[gp,-0x35]
L_93409c:
	and r5,r5,r9
L_9340a0:
	bset r5,r5,0x1b
L_9340a4:
	mov r32,r5
L_9340a8:
	st.ab r5,[r25,0x4]
L_9340ac:
	bclr r25,r25,0xa
L_9340b0:
	mov r6,0x2040000
L_9340b8:
	mov r32,r6
L_9340bc:
	st.ab r6,[r25,0x4]
L_9340c0:
	bclr r25,r25,0xa
	.global L_9340c4
L_9340c4:
	ld r5,[0x8013dc]
L_9340cc:
	or r5,r5,0xccc000
L_9340d4:
	mov r32,r5
L_9340d8:
	st.ab r5,[r25,0x4]
L_9340dc:
	bclr r25,r25,0xa
L_9340e0:
	ld.as r9,[gp,0x34]
L_9340e4:
	mov r16,0x857800
L_9340ec:
	mov r14,0x8013d4
L_9340f4:
	bbit0.d r9,0x1f,L_934134
L_9340f8:
	mov_s r13,0x0
L_9340fa:
	ld_s r0,[r14,0xc]
L_9340fc:
	ld r1,[r14, 0x8]
L_934100:
	bl.d L_926c34
L_934104:
	ld r2,[r14, 0x10]
L_934108:
	mov_s r1,0x802408
L_93410e:
	ld r4,[0x800698]
L_934116:
	mov_s r0,r13
L_934118:
	ld r3,[0x800694]
L_934120:
	bl.d L_929d20
L_934124:
	mov r2,0x7
L_934128:
	mov r15,0x80069c
L_934130:
	b L_934384
	.global L_934134
L_934134:
	ld.as r5,[r16,-0x56]
L_934138:
	cmp r5,0x2
L_93413c:
	beq L_934350
	.global L_934140
L_934140:
	ld r6,[r14, 0xc]
L_934144:
	st_s r13,[r14,0x10]
L_934146:
	asl r6,r6,0x2
L_93414a:
	add2 r6,r6,r6
L_93414e:
	add r2,r6,0x802354
L_934156:
	ld.as r3,[gp,0x33]
L_93415a:
	st_s r13,[r2]
L_93415c:
	bic.f r3,r3,-0x7e1
L_934160:
	st r13,[r14, 0x8]
L_934164:
	bne.d L_934178
L_934168:
	st r13,[r14, 0xc]
L_93416c:
	mov r4,0x0
L_934170:
	st.as r4,[gp,0x33]
L_934174:
	st.as r4,[gp,0x34]
	.global L_934178
L_934178:
	mov r8,0x802288
L_934180:
	st r13,[r8, 0xc]
L_934184:
	st r13,[r8, 0x10]
L_934188:
	mov_s r0,0x802978
L_93418e:
	st_s r13,[r0,0xc]
L_934190:
	st_s r13,[r0,0x48]
L_934192:
	mov_s r3,0x83
L_934194:
	asl_s r3,r3,0x12
L_934196:
	mov_s r32,r3
L_934198:
	st.ab r3,[r25,0x4]
L_93419c:
	bclr r25,r25,0xa
L_9341a0:
	ld r5,[0x8006bc]
L_9341a8:
	breq r5,0x1,L_9341bc
L_9341ac:
	ldb r10,[gp, -0xfb]
L_9341b0:
	breq r10,0x1,L_9341bc
L_9341b4:
	ldb r1,[gp, -0xfc]
L_9341b8:
	brne r1,0x1,L_934218
	.global L_9341bc
L_9341bc:
	ld r4,[0x8029f0]
L_9341c4:
	mov r5,0x857e48
L_9341cc:
	ld r13,[r4]
L_9341d0:
	asl r7,r13,0x2
L_9341d4:
	add2 r7,r7,r7
L_9341d8:
	ld r2,[0x802224]
L_9341e0:
	add r7,r7,r5
L_9341e4:
	mov r4,0x0
L_9341e8:
	breq.d r2,0x0,L_934204
L_9341ec:
	stb r4,[r7]
L_9341f0:
	mov_s r3,0x857000
L_9341f6:
	add2_s r3,r3,r13
L_9341f8:
	ld.as r2,[r3,0x61]
L_9341fc:
	add r2,r2,0x1
L_934200:
	st.as r2,[r3,0x61]
	.global L_934204
L_934204:
	bl L_93d28c
L_934208:
	mov r0,0x803134
L_934210:
	bl.d L_936e04
L_934214:
	mov r1,r13
	.global L_934218
L_934218:
	bl L_9364c8
L_93421c:
	bl.d L_93e0dc
L_934220:
	mov r13,r0
L_934224:
	ld.as r4,[gp,-0x11]
L_934228:
	and r4,r4,0xffff0fff
L_934230:
	st.as r4,[gp,-0x11]
L_934234:
	or r4,r4,0x1d000000
L_93423c:
	mov r32,r4
L_934240:
	st.ab r4,[r25,0x4]
L_934244:
	bclr r25,r25,0xa
L_934248:
	nop_s
L_93424a:
	nop_s
L_93424c:
	nop_s
L_93424e:
	bmsk r4,r40,0x2
L_934252:
	cmp r4,0x2
L_934256:
	mov_s r14,0x1
L_934258:
	ld r3,[0x801424]
L_934260:
	sub.ne r14,r14,r14
L_934264:
	bbit1 r3,0x0,L_934278
L_934268:
	ld r1,[0x802288]
L_934270:
	bl.d L_92f4bc
L_934274:
	mov r0,0x2
	.global L_934278
L_934278:
	brne_s r14,0,L_9342ac
L_93427a:
	ld.as r3,[gp,-0x11]
L_93427e:
	and r3,r3,0xffff0fff
L_934286:
	st.as r3,[gp,-0x11]
L_93428a:
	or r3,r3,0x1d000000
L_934292:
	mov_s r32,r3
L_934294:
	st.ab r3,[r25,0x4]
L_934298:
	bclr r25,r25,0xa
L_93429c:
	nop_s
L_93429e:
	nop_s
L_9342a0:
	mov 0x0,0x0
L_9342a4:
	bmsk r1,r40,0x2
L_9342a8:
	breq r1,0x2,L_9342b0
	.global L_9342ac
L_9342ac:
	brne r14,0x1,L_9342f4
	.global L_9342b0
L_9342b0:
	bl L_9364c8
L_9342b4:
	mov r4,0x80063c
L_9342bc:
	ld r10,[r4]
L_9342c0:
	breq.d r10,0x0,L_9342dc
L_9342c4:
	sub r5,r0,r13
L_9342c8:
	ldb r1,[0x800640]
L_9342d0:
	sub r13,r13,r10
L_9342d4:
	brlo r1,r13,L_9342dc
L_9342d8:
	add r5,r5,r13
	.global L_9342dc
L_9342dc:
	mov r6,0x801030
L_9342e4:
	ld r3,[r6, 0xa8]
L_9342e8:
	st r0,[r4]
L_9342ec:
	add r3,r3,r5
L_9342f0:
	st r3,[r6, 0xa8]
	.global L_9342f4
L_9342f4:
	ld r1,[0x8029f0]
L_9342fc:
	ld r4,[0x8014c0]
L_934304:
	ld r7,[r1, 0xc]
L_934308:
	brne.d r4,0x1,L_93438c
L_93430c:
	lsr r8,r7,0xa
L_934310:
	ld_s r2,[r1,0x34]
L_934312:
	cmp_s r2,0x0
L_934314:
	btst.eq r7,0xa
L_934318:
	beq_s L_93438c
L_93431a:
	mov_s r0,0x802f80
L_934320:
	bxor r2,r8,0x0
L_934324:
	bmsk_s r2,r2,0x0
L_934326:
	neg_s r2,r2
L_934328:
	bmsk_s r2,r2,0x1
L_93432a:
	mov_s r1,0x0
L_93432c:
	bl.d L_92845c
L_934330:
	add r2,r2,0x1
L_934334:
	mov_s r0,r18
L_934336:
	ld blink,[sp, 0x4]
L_93433a:
	ld_s r14,[sp,0x8]
L_93433c:
	ld_s r15,[sp,0xc]
L_93433e:
	ld r16,[sp, 0x10]
L_934342:
	ld r17,[sp, 0x14]
L_934346:
	ld r18,[sp, 0x18]
L_93434a:
	j_s.d [blink]
L_93434c:
	ld.ab r13,[sp,0x1c]
	.global L_934350
L_934350:
	mov_s r15,0x80069c
L_934356:
	ld_s r0,[r15]
L_934358:
	breq r0,0x1,L_934364
	.global L_93435c
L_93435c:
	b.d L_934140
L_934360:
	st.as r13,[r16,-0x56]
	.global L_934364
L_934364:
	ld r4,[0x800698]
L_93436c:
	mov_s r1,0x802408
L_934372:
	ld r3,[0x800694]
L_93437a:
	mov_s r0,r13
L_93437c:
	bl.d L_929d20
L_934380:
	mov r2,0x7
	.global L_934384
L_934384:
	b.d L_93435c
L_934388:
	st r13,[r15]
	.global L_93438c
L_93438c:
	ld blink,[sp, 0x4]
L_934390:
	mov_s r0,r18
L_934392:
	ld_s r14,[sp,0x8]
L_934394:
	ld_s r15,[sp,0xc]
L_934396:
	ld r16,[sp, 0x10]
L_93439a:
	ld r17,[sp, 0x14]
L_93439e:
	ld r18,[sp, 0x18]
L_9343a2:
	j_s.d [blink]
L_9343a4:
	ld.ab r13,[sp,0x1c]
