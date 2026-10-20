/* rx_funcs_step @ 0x92fc0c, 304 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__identify_peer, txss_flow_step_b
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, direct_tx__program_cmd34, get_g_80087c, mac__program_tx_common, mac__select_sector_and_wait_b, rx_funcs__send_direct_frame, rx_funcs_substep, uc_spin_until_event
 * Глобалы (через gp): 0x800604, 0x800610, 0x800614
 */
	.section .text.rx_funcs_step,"ax",@progbits
	.global rx_funcs_step
rx_funcs_step:
	.global L_92fc0c
L_92fc0c:
	push_s blink
L_92fc0e:
	bl L_920214
L_92fc12:
	sub_s sp,sp,0x18
L_92fc14:
	mov_s r14,r0
L_92fc16:
	mov_s r13,r1
L_92fc18:
	mov_s r0,0x37000005
L_92fc1e:
	mov_s r32,r0
L_92fc20:
	st.ab r0,[r25,0x4]
L_92fc24:
	bclr r25,r25,0xa
L_92fc28:
	mov_s r0,0x37000002
L_92fc2e:
	mov_s r32,r0
L_92fc30:
	st.ab r0,[r25,0x4]
L_92fc34:
	bclr r25,r25,0xa
L_92fc38:
	mov_s r0,0x801418
L_92fc3e:
	ld_s r0,[r0]
L_92fc40:
	mov_s r1,0x801198
L_92fc46:
	/* asl_s r0,r0,0x3 */
	.byte 0x03,0xb8
L_92fc48:
	add3_s r0,r0,r0
L_92fc4a:
	ld_s r0,[r1,r0]
L_92fc4c:
	or r0,r0,0x3f000000
L_92fc54:
	mov_s r32,r0
L_92fc56:
	st.ab r0,[r25,0x4]
L_92fc5a:
	bclr r25,r25,0xa
L_92fc5e:
	mov_s r0,0x3e
L_92fc60:
	asl_s r0,r0,0x18
L_92fc62:
	mov_s r32,r0
L_92fc64:
	st.ab r0,[r25,0x4]
L_92fc68:
	bclr r25,r25,0xa
L_92fc6c:
	mov_s r0,0x37000020
L_92fc72:
	mov_s r32,r0
L_92fc74:
	st.ab r0,[r25,0x4]
L_92fc78:
	bclr r25,r25,0xa
L_92fc7c:
	mov_s r1,0x801458
L_92fc82:
	ld_s r0,[r1,0xc]
L_92fc84:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92fc86:
	st_s r0,[r1,0xc]
L_92fc88:
	mov_s r0,sp
L_92fc8a:
	mov_s r1,r14
L_92fc8c:
	bl.d L_935814
L_92fc90:
	mov_s r2,r13
L_92fc92:
	mov_s r0,0x10
L_92fc94:
	bl.d L_924ea8
L_92fc98:
	mov_s r1,0x18
L_92fc9a:
	bl L_92a3c0
L_92fc9e:
	mov_s r0,0x2008000
L_92fca4:
	mov_s r32,r0
L_92fca6:
	st.ab r0,[r25,0x4]
L_92fcaa:
	bclr r25,r25,0xa
L_92fcae:
	ld_s r0,[gp,0xdc]
L_92fcb0:
	and r1,r0,0x10
L_92fcb4:
	mov_s r0,0x0
L_92fcb6:
	or.f 0x0,r1,r0
L_92fcba:
	beq_s L_92fcdc
L_92fcbc:
	ld_s r0,[gp,0xe8]
L_92fcbe:
	ld.as r1,[gp,0x3b]
L_92fcc2:
	bic r0,r0,-0x3
L_92fcc6:
	cmp_s r0,0x2
L_92fcc8:
	mov_s r0,0x1
L_92fcca:
	sub_s.ne r0,r0,r0
L_92fccc:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_92fcce:
	or r0,r0,0x19800830
L_92fcd6:
	asl_s r1,r1,0xe
L_92fcd8:
	or_s r0,r0,r1
L_92fcda:
	b_s L_92fce2
	.global L_92fcdc
L_92fcdc:
	mov_s r0,0x19000001
	.global L_92fce2
L_92fce2:
	mov_s r32,r0
L_92fce4:
	st.ab r0,[r25,0x4]
L_92fce8:
	bclr r25,r25,0xa
	.global L_92fcec
L_92fcec:
	mov_s r0,r45
L_92fcee:
	bbit0 r0,0x1f,L_92fcec
L_92fcf2:
	ld_s r0,[gp,0xdc]
L_92fcf4:
	and r1,r0,0x10
L_92fcf8:
	mov_s r0,0x0
L_92fcfa:
	or.f 0x0,r1,r0
L_92fcfe:
	mov_s r0,0x18
L_92fd00:
	asl.ne r0,r0,0x18
L_92fd04:
	mov.eq r0,0x18001000
L_92fd0c:
	mov_s r32,r0
L_92fd0e:
	st.ab r0,[r25,0x4]
L_92fd12:
	bclr r25,r25,0xa
L_92fd16:
	bl.d L_9358ac
L_92fd1a:
	mov_s r0,sp
L_92fd1c:
	bl.d L_931664
L_92fd20:
	mov_s r0,0x6
L_92fd22:
	bl L_930f34
L_92fd26:
	mov_s r0,0x0
L_92fd28:
	bl.d L_9317fc
L_92fd2c:
	bset_s r0,r0,0xf
L_92fd2e:
	bl.d L_931664
L_92fd32:
	mov_s r0,0x5
L_92fd34:
	mov_s r0,0x1
L_92fd36:
	b.d L_920284
L_92fd3a:
	add_s sp,sp,0x18
