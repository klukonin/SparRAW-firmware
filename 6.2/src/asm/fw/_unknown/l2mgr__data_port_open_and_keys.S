/* l2mgr__data_port_open_and_keys @ 0x8f5a84, 552 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   L2MGR Data port open failed stream of CID %d is not idle!!!
 *   SET_KEYS API is sent to UCODE with the following GTK
 *   install_key_handle failed, CID: %d is NULL
 *   install_key_handle: MID %d: stream isn't idle, but continue...
 *   Sent KEY API to UCODE
 *   install_key_handle failed, trigger disconnect for MID %d
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r17_to_r13_ret, __st_r17_to_r13, conn__sec_mode_not_1, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, fw_status__set_state, fw_sysassert_fatal, hexdump_words, install_key__parse_flags, install_key_index_stub
 * Глобалы (через gp): 0x8002a8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__data_port_open_and_keys
l2mgr__data_port_open_and_keys:
	.global L_8f5a84
L_8f5a84:
	push_s blink
L_8f5a86:
	bl L_8c01d8
L_8f5a8a:
	sub_s sp,sp,0x8
L_8f5a8c:
	bl.d L_8ebe64
L_8f5a90:
	mov_s r13,r0
L_8f5a92:
	cmp_s r0,0x0
L_8f5a94:
	beq_s L_8f5b90
L_8f5a96:
	bl.d L_8cce14
L_8f5a9a:
	mov_s r0,r13
L_8f5a9c:
	mov_s r14,r0
L_8f5a9e:
	ld_s r0,[gp,0x124]
L_8f5aa0:
	cmp_s r0,0x0
L_8f5aa2:
	bne_s L_8f5b68
L_8f5aa4:
	bl.d L_8da5f8
L_8f5aa8:
	mov_s r0,r13
L_8f5aaa:
	cmp_s r0,0x0
L_8f5aac:
	beq_s L_8f5b68
L_8f5aae:
	cmp_s r14,0x0
L_8f5ab0:
	beq_s L_8f5b82
	.global L_8f5ab2
L_8f5ab2:
	ldb r16,[r14, 0x4]
L_8f5ab6:
	bl.d L_8ccb68
L_8f5aba:
	mov_s r0,0x2
L_8f5abc:
	mov_s r17,r0
	.global L_8f5abe
L_8f5abe:
	mov_s r0,0x886e80
L_8f5ac4:
	ld_s r15,[r0,0x4c]
L_8f5ac6:
	mov_s r0,0xa0
L_8f5ac8:
	mov lp_count,r0
L_8f5acc:
	nop_s
L_8f5ace:
	lp L_8f5ad6
L_8f5ad2:
	nop_s
L_8f5ad4:
	nop_s
	.global L_8f5ad6
L_8f5ad6:
	bbit1 r15,0x3,L_8f5abe
L_8f5ada:
	ldb_s r0,[r13,0x8]
L_8f5adc:
	bl.d L_8dfafc
L_8f5ae0:
	mov_s r1,r16
L_8f5ae2:
	bl.d L_8c4554
L_8f5ae6:
	mov_s r0,r17
L_8f5ae8:
	bl.d L_8df65c
L_8f5aec:
	mov_s r0,r17
L_8f5aee:
	mov_s r15,sp
L_8f5af0:
	mov_s r0,r15
L_8f5af2:
	mov_s r1,0x2
L_8f5af4:
	mov_s r2,0x1
L_8f5af6:
	mov_s r3,r1
L_8f5af8:
	bl.d L_8c50f8
L_8f5afc:
	mov_s r4,r2
L_8f5afe:
	ld_s r0,[sp,0x0]
L_8f5b00:
	mov_s r1,0x2
L_8f5b02:
	bclr_s r0,r0,0x12
L_8f5b04:
	st_s r0,[sp,0x0]
L_8f5b06:
	mov_s r0,r15
L_8f5b08:
	mov_s r2,0x1
L_8f5b0a:
	mov_s r3,r1
L_8f5b0c:
	mov r4,0x0
L_8f5b10:
	mov r5,r4
L_8f5b14:
	mov r6,r4
L_8f5b18:
	bl.d L_8c5010
L_8f5b1c:
	mov_s r7,r2
L_8f5b1e:
	mov_s r1,0x880c00
L_8f5b24:
	ld_s r0,[r1,0x18]
L_8f5b26:
	or r0,r0,0x9
L_8f5b2a:
	st_s r0,[r1,0x18]
L_8f5b2c:
	mov r0,0x320
L_8f5b30:
	mov lp_count,r0
L_8f5b34:
	nop_s
L_8f5b36:
	lp L_8f5b3e
L_8f5b3a:
	nop_s
L_8f5b3c:
	nop_s
	.global L_8f5b3e
L_8f5b3e:
	mov_s r1,0x880c00
L_8f5b44:
	ld_s r0,[r1,0x18]
L_8f5b46:
	bic r0,r0,0x9
L_8f5b4a:
	st_s r0,[r1,0x18]
L_8f5b4c:
	mov r0,0x320
L_8f5b50:
	mov lp_count,r0
L_8f5b54:
	nop_s
L_8f5b56:
	lp L_8f5b5e
L_8f5b5a:
	nop_s
L_8f5b5c:
	nop_s
	.global L_8f5b5e
L_8f5b5e:
	ldb_s r0,[r13,0x8]
L_8f5b60:
	mov_s r1,r16
L_8f5b62:
	bl.d L_8df9a4
L_8f5b66:
	mov_s r2,0x2
	.global L_8f5b68
L_8f5b68:
	ldb_s r15,[r13,0x8]
L_8f5b6a:
	ld_s r0,[r13,0x18]
L_8f5b6c:
	ldb_s r13,[r0,0x10]
L_8f5b6e:
	breq_s r14,0,L_8f5b78
L_8f5b70:
	ldb_s r0,[r14,0x7]
L_8f5b72:
	bl.d L_8f8ee4
L_8f5b76:
	mov_s r1,r13
	.global L_8f5b78
L_8f5b78:
	mov_s r0,r15
L_8f5b7a:
	bl.d L_8f8854
L_8f5b7e:
	mov_s r1,r13
L_8f5b80:
	b_s L_8f5bae
	.global L_8f5b82
L_8f5b82:
	mov_s r0,blink
L_8f5b84:
	mov_s r1,0x147d
L_8f5b8a:
	bl L_8c9b28
L_8f5b8e:
	b_s L_8f5ab2
	.global L_8f5b90
L_8f5b90:
	mov_s r1,0x100d5c4
L_8f5b96:
	mov_s r0,0xb
L_8f5b98:
	bl.d L_8dcc10
L_8f5b9c:
	ldb_s r2,[r13,0x8]
L_8f5b9e:
	ld_s r0,[r13,0x18]
L_8f5ba0:
	add r14,r13,0x1c
L_8f5ba4:
	ldb_s r0,[r0,0x10]
L_8f5ba6:
	mov_s r1,r14
L_8f5ba8:
	bl.d L_8c93a0
L_8f5bac:
	mov_s r2,0x1
	.global L_8f5bae
L_8f5bae:
	bl.d L_8e8634
L_8f5bb2:
	mov_s r0,0x6
L_8f5bb4:
	b.d L_8c023c
L_8f5bb8:
	add_s sp,sp,0x8
L_8f5bba:
	nop_s
L_8f5bbc:
	push_s blink
L_8f5bbe:
	bl.d L_8cc3dc
L_8f5bc2:
	push_s r13
L_8f5bc4:
	mov_s r13,r0
L_8f5bc6:
	add r13,r13,0x294
L_8f5bca:
	mov_s r1,0x100edd4
L_8f5bd0:
	bl.d L_8dcba8
L_8f5bd4:
	mov_s r0,0x20
L_8f5bd6:
	mov_s r0,r13
L_8f5bd8:
	bl.d L_8c9790
L_8f5bdc:
	mov_s r1,0x10
L_8f5bde:
	ldb_s r3,[r13,0x10]
L_8f5be0:
	mov_s r0,0x8
L_8f5be2:
	mov_s r1,0x4
L_8f5be4:
	mov_s r2,r13
L_8f5be6:
	bl.d L_8f0c98
L_8f5bea:
	mov r4,0x0
L_8f5bee:
	b L_8c025c
L_8f5bf2:
	nop_s
L_8f5bf4:
	push_s blink
L_8f5bf6:
	bl L_8c01d8
L_8f5bfa:
	mov_s r17,r0
L_8f5bfc:
	bl.d L_8cc3dc
L_8f5c00:
	mov_s r16,r1
L_8f5c02:
	mov.f r15,r0
L_8f5c06:
	beq_s L_8f5c24
	.global L_8f5c08
L_8f5c08:
	bl.d L_8cbffc
L_8f5c0c:
	mov_s r0,r16
L_8f5c0e:
	mov.f r13,r0
L_8f5c12:
	bne_s L_8f5c32
L_8f5c14:
	mov_s r1,0x100ee0c
L_8f5c1a:
	mov_s r0,0x10
L_8f5c1c:
	bl.d L_8dcc10
L_8f5c20:
	mov_s r2,r16
L_8f5c22:
	b_s L_8f5ca6
	.global L_8f5c24
L_8f5c24:
	mov_s r0,blink
L_8f5c26:
	mov_s r1,0x16b8
L_8f5c2c:
	bl L_8c9b28
L_8f5c30:
	b_s L_8f5c08
	.global L_8f5c32
L_8f5c32:
	bl L_8da5f8
L_8f5c36:
	breq_s r0,0,L_8f5c80
	.global L_8f5c38
L_8f5c38:
	ld r0,[r13, 0xfc]
L_8f5c3c:
	add r16,r13,0x1c
L_8f5c40:
	add r14,r13,0x30
L_8f5c44:
	breq_s r0,0,L_8f5c8e
L_8f5c46:
	bl.d L_8ebe64
L_8f5c4a:
	mov_s r0,r13
L_8f5c4c:
	brne_s r0,0,L_8f5c5c
L_8f5c4e:
	mov_s r1,0x100ee38
L_8f5c54:
	mov_s r0,0x10
L_8f5c56:
	bl.d L_8dcc10
L_8f5c5a:
	mov_s r2,r17
	.global L_8f5c5c
L_8f5c5c:
	mov_s r0,r14
L_8f5c5e:
	bl.d L_8c9790
L_8f5c62:
	mov_s r1,0x10
L_8f5c64:
	ldb_s r0,[r13,0x8]
L_8f5c66:
	mov_s r1,0x0
L_8f5c68:
	ldb_s r3,[r14,0x10]
L_8f5c6a:
	mov_s r2,r14
L_8f5c6c:
	bl.d L_8f0c98
L_8f5c70:
	mov_s r4,r1
L_8f5c72:
	mov_s r1,0x100ee78
L_8f5c78:
	bl.d L_8dcba8
L_8f5c7c:
	mov_s r0,0x20
L_8f5c7e:
	b_s L_8f5ca6
	.global L_8f5c80
L_8f5c80:
	mov_s r0,blink
L_8f5c82:
	mov_s r1,0x141e
L_8f5c88:
	bl L_8c9b28
L_8f5c8c:
	b_s L_8f5c38
	.global L_8f5c8e
L_8f5c8e:
	mov_s r1,0x100ee90
L_8f5c94:
	mov_s r0,0x10
L_8f5c96:
	bl.d L_8dcc10
L_8f5c9a:
	mov_s r2,r17
L_8f5c9c:
	ldb_s r0,[r15,0x10]
L_8f5c9e:
	mov_s r1,r16
L_8f5ca0:
	bl.d L_8c93a0
L_8f5ca4:
	mov_s r2,0x1
	.global L_8f5ca6
L_8f5ca6:
	b L_8c023c
L_8f5caa:
	nop_s
