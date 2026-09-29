/* rx_pkt_srvs__dispatch @ 0x8e3c70, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX SRVS: pkt for mid %d type %d len %d
 *   RX MGMT: ERROR Handler pkt for mid %d
 * Зовут его: bits__set_s8_w5, rx_pkt_srvs__dispatch_default
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit3, mem_pool__free_thunk, rx_mgmt_srvs__distribute, rx_pkt__lookup_handler, rx_pkt__mid_accepts, rx_pkt_srvs__distribute_data
 * Глобалы (через gp): 0x800470
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_pkt_srvs__dispatch
rx_pkt_srvs__dispatch:
	.global L_8e3c70
L_8e3c70:
	push_s blink
L_8e3c72:
	bl L_8c01e4
L_8e3c76:
	mov_s r14,r0
L_8e3c78:
	ld_s r0,[r1,0x14]
L_8e3c7a:
	mov_s r13,r1
L_8e3c7c:
	st_s r0,[r1,0x8]
L_8e3c7e:
	mov_s r0,0x0
L_8e3c80:
	st_s r0,[r1,0x10]
L_8e3c82:
	add_s r1,r1,0x37
L_8e3c84:
	bl.d L_8cc118
L_8e3c88:
	mov_s r0,r14
L_8e3c8a:
	ld_s r0,[gp,-0x154]
L_8e3c8c:
	breq_s r0,0,L_8e3c96
	.global L_8e3c8e
L_8e3c8e:
	bl.d L_8cb15c
L_8e3c92:
	mov_s r0,r13
L_8e3c94:
	b_s L_8e3cf0
	.global L_8e3c96
L_8e3c96:
	ld_s r0,[r13,0x8]
L_8e3c98:
	ld r4,[r13, 0x30]
L_8e3c9c:
	ldw_s r3,[r0]
L_8e3c9e:
	lsr_s r3,r3,0x2
L_8e3ca0:
	brhs.d r4,0x18,L_8e3cc6
L_8e3ca4:
	bmsk_s r3,r3,0x1
L_8e3ca6:
	mov_s r1,0x1013eac
L_8e3cac:
	mov_s r0,0xd
L_8e3cae:
	bl.d L_8dcd00
L_8e3cb2:
	ldb r2,[r13, 0x35]
L_8e3cb6:
	bl.d L_8cb15c
L_8e3cba:
	mov_s r0,r13
L_8e3cbc:
	ld_s r0,[gp,0x2ec]
L_8e3cbe:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e3cc0:
	st.as r0,[gp,0xbb]
L_8e3cc4:
	b_s L_8e3cf0
	.global L_8e3cc6
L_8e3cc6:
	breq_s r3,0,L_8e3cde
L_8e3cc8:
	breq r3,0x1,L_8e3cf4
L_8e3ccc:
	breq r3,0x2,L_8e3ce8
L_8e3cd0:
	brne r3,0x3,L_8e3cf4
L_8e3cd4:
	mov_s r0,r14
L_8e3cd6:
	bl.d L_8e3b7c
L_8e3cda:
	mov_s r1,r13
L_8e3cdc:
	b_s L_8e3cf0
	.global L_8e3cde
L_8e3cde:
	mov_s r0,r14
L_8e3ce0:
	bl.d L_8e3ba4
L_8e3ce4:
	mov_s r1,r13
L_8e3ce6:
	b_s L_8e3cf0
	.global L_8e3ce8
L_8e3ce8:
	mov_s r0,r14
L_8e3cea:
	bl.d L_8e3af4
L_8e3cee:
	mov_s r1,r13
	.global L_8e3cf0
L_8e3cf0:
	b L_8c0254
	.global L_8e3cf4
L_8e3cf4:
	mov_s r1,0x1013ed4
L_8e3cfa:
	mov_s r0,0x2d
L_8e3cfc:
	bl.d L_8dcc10
L_8e3d00:
	ldb r2,[r13, 0x35]
L_8e3d04:
	b_s L_8e3c8e
L_8e3d06:
	nop_s
