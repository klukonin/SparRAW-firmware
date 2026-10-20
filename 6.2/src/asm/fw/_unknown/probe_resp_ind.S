/* probe_resp_ind @ 0x8f7ae4, 512 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::probe_resp_ind() m_active_probs=%d
 *   probe_resp_ind() directed omni %d rssi %d  tx_sector_snr %d
 *   probe_resp_ind() curr_dband_ptr->conn_ptr->get_bcon_systime() %d
 *   probe_resp_ind() adding new peer_info_array for BSSID ADDR-%04X%08X
 *   probe_resp_ind() peer_info_array full channel %d
 *   probe_resp_ind() found better  snr %d for directed omni %d  bcon_systime %d
 *   probe_resp_ind() found better snr %d for directed omni %d  bcon_systime %d
 *   probe_resp_ind() found better omni for BSSID ADDR-%04X%08X
 * Зовут его: discovery_handle_probe_resp
 * Зовёт сам: TX_API__free_memory, __ld_r15_to_r13_ret, __ld_r23_to_r13_ret, __st_r15_to_r13, __st_r23_to_r13, find_main_sm__bcon_step, fw_log_emit1, fw_log_emit2, fw_log_emit3, l2_mgr__connect_next, scan_mngr__prob_done
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global probe_resp_ind
probe_resp_ind:
	.global L_8f7ae4
L_8f7ae4:
	push_s blink
L_8f7ae6:
	bl L_8c01c0
L_8f7aea:
	mov_s r17,r0
L_8f7aec:
	mov_s r15,r2
L_8f7aee:
	mov_s r16,r3
L_8f7af0:
	mov r18,r4
L_8f7af4:
	mov r20,r5
L_8f7af8:
	mov_s r1,0x1015fac
L_8f7afe:
	mov_s r21,r0
L_8f7b00:
	add r21,r21,0x200
L_8f7b04:
	mov_s r0,0x29
L_8f7b06:
	bl.d L_8dcc10
L_8f7b0a:
	ldb r2,[r21, 0x15]
L_8f7b0e:
	ld r0,[r17, 0x80]
L_8f7b12:
	ldb_s r0,[r0]
L_8f7b14:
	add3 r19,r17,0x10
L_8f7b18:
	brne r0,0x4,L_8f7b30
L_8f7b1c:
	ldb r0,[r21, 0x15]
L_8f7b20:
	breq_s r0,0,L_8f7b30
L_8f7b22:
	mov_s r0,r17
L_8f7b24:
	bl.d L_8f8574
L_8f7b28:
	mov_s r1,r15
L_8f7b2a:
	mov.f r13,r0
L_8f7b2e:
	bne_s L_8f7b34
	.global L_8f7b30
L_8f7b30:
	mov_s r0,0x0
L_8f7b32:
	b_s L_8f7ca6
	.global L_8f7b34
L_8f7b34:
	ld_s r0,[r13,0x44]
L_8f7b36:
	cmp_s r0,0x0
L_8f7b38:
	beq_s L_8f7c7a
L_8f7b3a:
	ldb.x r23,[r0, 0x14]
L_8f7b3e:
	mov_s r1,0x1015fdc
L_8f7b44:
	add r22,r13,0x20
L_8f7b48:
	mov_s r0,0x29
L_8f7b4a:
	ldb r2,[r22, 0x19]
L_8f7b4e:
	mov_s r3,r20
L_8f7b50:
	bl.d L_8dcd00
L_8f7b54:
	mov r4,r23
L_8f7b58:
	ld_s r2,[r13,0x44]
L_8f7b5a:
	mov_s r1,0x1016018
L_8f7b60:
	mov_s r0,0x29
L_8f7b62:
	bl.d L_8dcc10
L_8f7b66:
	ld_s r2,[r2,0x10]
L_8f7b68:
	mov_s r0,r17
L_8f7b6a:
	mov_s r1,r15
L_8f7b6c:
	bl.d L_8e4c24
L_8f7b70:
	mov_s r2,r16
L_8f7b72:
	mov.f r14,r0
L_8f7b76:
	bne_s L_8f7bea
L_8f7b78:
	add3 r14,r17,0x38
L_8f7b7c:
	add_s r14,r14,r16
L_8f7b7e:
	ldb_s r0,[r14,0x4]
L_8f7b80:
	brge r0,0x4,L_8f7bda
L_8f7b84:
	ldw_s r2,[r15,0x4]
L_8f7b86:
	mov_s r1,0x101605c
L_8f7b8c:
	mov_s r0,0x29
L_8f7b8e:
	bl.d L_8dcc80
L_8f7b92:
	ld_s r3,[r15]
L_8f7b94:
	asl r2,r16,0x4
L_8f7b98:
	ldb_s r0,[r14,0x4]
L_8f7b9a:
	add2_s r2,r2,r2
L_8f7b9c:
	asl_s r1,r0,0x2
L_8f7b9e:
	add2_s r1,r1,r1
L_8f7ba0:
	add_s r2,r2,r1
L_8f7ba2:
	ldb r3,[r22, 0x19]
L_8f7ba6:
	add r1,r19,r2
L_8f7baa:
	stb_s r3,[r1,0xa]
L_8f7bac:
	stb r20,[r1, 0xb]
L_8f7bb0:
	ld_s r2,[r13,0x44]
L_8f7bb2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f7bb4:
	ld_s r2,[r2,0x10]
L_8f7bb6:
	extb_s r0,r0
L_8f7bb8:
	st_s r2,[r1,0x14]
L_8f7bba:
	stw r18,[r1, 0xe]
L_8f7bbe:
	stb r23,[r1, 0xd]
L_8f7bc2:
	ldb r2,[r22, 0x19]
L_8f7bc6:
	stb_s r2,[r1,0xc]
L_8f7bc8:
	ld_s r2,[r13,0x44]
L_8f7bca:
	ld_s r2,[r2,0x10]
L_8f7bcc:
	st_s r2,[r1,0x10]
L_8f7bce:
	ld_s r2,[r13,0x8]
L_8f7bd0:
	st_s r2,[r1,0x4]
L_8f7bd2:
	ldw_s r2,[r13,0xc]
L_8f7bd4:
	stw_s r2,[r1,0x8]
L_8f7bd6:
	stb_s r0,[r14,0x4]
L_8f7bd8:
	b_s L_8f7c7a
	.global L_8f7bda
L_8f7bda:
	mov_s r1,0x10160a0
L_8f7be0:
	mov_s r0,0x19
L_8f7be2:
	bl.d L_8dcc10
L_8f7be6:
	mov_s r2,r16
L_8f7be8:
	b_s L_8f7c7a
	.global L_8f7bea
L_8f7bea:
	ldb r3,[r22, 0x19]
L_8f7bee:
	ldb_s r0,[r14,0x8]
L_8f7bf0:
	breq r3,r0,L_8f7c1a
L_8f7bf4:
	ld_s r0,[r13,0x44]
L_8f7bf6:
	mov_s r1,0x10160d4
L_8f7bfc:
	ld r4,[r0, 0x10]
L_8f7c00:
	mov_s r0,0x29
L_8f7c02:
	bl.d L_8dcd00
L_8f7c06:
	mov_s r2,r23
L_8f7c08:
	ldb r0,[r22, 0x19]
L_8f7c0c:
	stb r23,[r14, 0x9]
L_8f7c10:
	stb_s r0,[r14,0x8]
L_8f7c12:
	ld_s r0,[r13,0x44]
L_8f7c14:
	ld_s r0,[r0,0x10]
L_8f7c16:
	st_s r0,[r14,0xc]
L_8f7c18:
	b_s L_8f7c4c
	.global L_8f7c1a
L_8f7c1a:
	ldb.x r0,[r14, 0x9]
L_8f7c1e:
	brlt r23,r0,L_8f7c4c
L_8f7c22:
	ld_s r0,[r13,0x44]
L_8f7c24:
	mov_s r1,0x1016120
L_8f7c2a:
	ld r4,[r0, 0x10]
L_8f7c2e:
	mov_s r0,0x29
L_8f7c30:
	bl.d L_8dcd00
L_8f7c34:
	mov_s r2,r23
L_8f7c36:
	stb r23,[r14, 0x9]
L_8f7c3a:
	ld_s r0,[r13,0x44]
L_8f7c3c:
	ld_s r1,[r0,0x10]
L_8f7c3e:
	st_s r1,[r14,0xc]
L_8f7c40:
	ldb r2,[r22, 0x19]
L_8f7c44:
	ldb_s r0,[r14,0x6]
L_8f7c46:
	brne r2,r0,L_8f7c4c
L_8f7c4a:
	st_s r1,[r14,0x10]
	.global L_8f7c4c
L_8f7c4c:
	ldb.x r0,[r14, 0x7]
L_8f7c50:
	brlt r20,r0,L_8f7c7a
L_8f7c54:
	ldb_s r1,[r14,0x6]
L_8f7c56:
	ldb r0,[r22, 0x19]
L_8f7c5a:
	breq r0,r1,L_8f7c72
L_8f7c5e:
	ldw_s r2,[r15,0x4]
L_8f7c60:
	mov_s r1,0x101616c
L_8f7c66:
	mov_s r0,0x29
L_8f7c68:
	bl.d L_8dcc80
L_8f7c6c:
	ld_s r3,[r15]
L_8f7c6e:
	ldb_s r0,[r14,0x8]
L_8f7c70:
	stb_s r0,[r14,0x6]
	.global L_8f7c72
L_8f7c72:
	ld_s r0,[r14,0xc]
L_8f7c74:
	stb r20,[r14, 0x7]
L_8f7c78:
	st_s r0,[r14,0x10]
	.global L_8f7c7a
L_8f7c7a:
	ldb r0,[r21, 0x15]
L_8f7c7e:
	mov_s r1,0x10161a8
L_8f7c84:
	sub r4,r0,0x1
L_8f7c88:
	extb r4,r4
L_8f7c8c:
	stb r4,[r21, 0x15]
L_8f7c90:
	ldw_s r2,[r15,0x4]
L_8f7c92:
	mov_s r0,0x29
L_8f7c94:
	bl.d L_8dcd00
L_8f7c98:
	ld_s r3,[r15]
L_8f7c9a:
	mov_s r0,r17
L_8f7c9c:
	mov_s r1,0x0
L_8f7c9e:
	bl.d L_8f74c4
L_8f7ca2:
	mov_s r2,r13
L_8f7ca4:
	mov_s r0,0x1
	.global L_8f7ca6
L_8f7ca6:
	b L_8c020c
L_8f7caa:
	nop_s
L_8f7cac:
	push_s blink
L_8f7cae:
	bl L_8c01e0
L_8f7cb2:
	mov_s r15,r0
L_8f7cb4:
	mov_s r14,r1
L_8f7cb6:
	mov_s r13,r2
L_8f7cb8:
	mov_s r1,0x1016f50
L_8f7cbe:
	mov_s r0,0x2d
L_8f7cc0:
	bl.d L_8dcc10
L_8f7cc4:
	mov_s r2,r14
L_8f7cc6:
	cmp_s r14,0x0
L_8f7cc8:
	cmp.ne r13,0x0
L_8f7ccc:
	beq_s L_8f7cda
L_8f7cce:
	mov_s r1,0x843158
L_8f7cd4:
	ld_s r0,[r1,0x18]
L_8f7cd6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8f7cd8:
	st_s r0,[r1,0x18]
	.global L_8f7cda
L_8f7cda:
	bl.d L_8cb10c
L_8f7cde:
	mov_s r0,r15
L_8f7ce0:
	b L_8c024c
