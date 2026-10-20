/* discovery__handle_rx_frame @ 0x8c7c80, 352 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery.cpp
 * Зовут его: discovery__rx_pkt_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, discovery__inject_sm_event, dti__parse_ese_at692, find_mngr__detect_discovery_bcon, fw_sysassert_fatal, get_g_800118_8c34e8, mid_list__find_by, scan_mngr__dband_beacon_ind, set_mem_85726c, set_mem_85726c_8e555c, u_schd__reschedule
 */
	.section .text.discovery__handle_rx_frame,"ax",@progbits
	.global discovery__handle_rx_frame
discovery__handle_rx_frame:
	.global L_8c7c80
L_8c7c80:
	push_s blink
L_8c7c82:
	bl L_8c02b8
L_8c7c86:
	mov_s r14,r0
L_8c7c88:
	ld_s r0,[r1,0xc]
L_8c7c8a:
	mov_s r13,r1
L_8c7c8c:
	breq_s r0,0,L_8c7cd6
	.global L_8c7c8e
L_8c7c8e:
	ld_s r0,[r13,0xc]
L_8c7c90:
	ld r0,[r0, 0xc0]
L_8c7c94:
	breq_s r0,0,L_8c7cec
	.global L_8c7c96
L_8c7c96:
	ld r16,[r14, 0x4]
L_8c7c9a:
	ld_s r0,[r13,0xc]
L_8c7c9c:
	ld r0,[r0, 0xc0]
L_8c7ca0:
	add3 r17,r16,0x9
L_8c7ca4:
	ldb_s r2,[r0,0x5]
L_8c7ca6:
	mov_s r3,0x80345c
L_8c7cac:
	lsr r1,r2,0x3
L_8c7cb0:
	ld_s r0,[r3,0x18]
L_8c7cb2:
	lsr_s r2,r2,0x4
L_8c7cb4:
	bmsk_s r1,r1,0x0
L_8c7cb6:
	bmsk_s r2,r2,0x1
L_8c7cb8:
	bbit1 r0,0x9,L_8c7cc0
L_8c7cbc:
	ld_s r0,[r3,0xc]
L_8c7cbe:
	breq_s r0,0,L_8c7cc4
	.global L_8c7cc0
L_8c7cc0:
	mov_s r1,0x1
L_8c7cc2:
	mov_s r2,r1
	.global L_8c7cc4
L_8c7cc4:
	add r0,r14,0xc
L_8c7cc8:
	ld_s r3,[r0,0x64]
L_8c7cca:
	breq_s r3,0,L_8c7d02
L_8c7ccc:
	bl.d L_8c6d68
L_8c7cd0:
	mov_s r1,r13
L_8c7cd2:
	mov_s r15,r0
L_8c7cd4:
	b_s L_8c7d54
	.global L_8c7cd6
L_8c7cd6:
	mov_s r0,blink
L_8c7cd8:
	mov_s r2,0x1012024
L_8c7cde:
	mov_s r1,0x1232
L_8c7ce4:
	bl.d L_8c82c0
L_8c7ce8:
	mov_s r3,0xc1
L_8c7cea:
	b_s L_8c7c8e
	.global L_8c7cec
L_8c7cec:
	mov_s r0,blink
L_8c7cee:
	mov_s r2,0x1012024
L_8c7cf4:
	mov_s r1,0x1233
L_8c7cfa:
	bl.d L_8c82c0
L_8c7cfe:
	mov_s r3,0xc2
L_8c7d00:
	b_s L_8c7c96
	.global L_8c7d02
L_8c7d02:
	ld_s r0,[r14,0x8]
L_8c7d04:
	ld_s r15,[r0,0x6c]
L_8c7d06:
	mov_s r3,0x0
L_8c7d08:
	cmp_s r15,0x0
L_8c7d0a:
	cmp.ne r15,0x3
L_8c7d0e:
	bne_s L_8c7d24
L_8c7d10:
	ldb r3,[r0, 0x8d]
L_8c7d14:
	brne r3,0x1,L_8c7d1e
L_8c7d18:
	ld_s r3,[r0,0x78]
L_8c7d1a:
	breq r3,0x1,L_8c7d22
	.global L_8c7d1e
L_8c7d1e:
	mov_s r3,0x0
L_8c7d20:
	b_s L_8c7d24
	.global L_8c7d22
L_8c7d22:
	mov_s r3,0x1
	.global L_8c7d24
L_8c7d24:
	extb.f 0x0,r3
L_8c7d28:
	bne_s L_8c7d48
L_8c7d2a:
	ld r15,[r17, 0x8]
L_8c7d2e:
	mov_s r3,0x0
L_8c7d30:
	cmp_s r15,0x2
L_8c7d32:
	cmp.ne r15,0x3
L_8c7d36:
	mov.eq r3,0x1
L_8c7d3a:
	extb.f 0x0,r3
L_8c7d3e:
	bne_s L_8c7d52
L_8c7d40:
	cmp_s r1,0x0
L_8c7d42:
	cmp.eq r2,0x0
L_8c7d46:
	beq_s L_8c7d52
	.global L_8c7d48
L_8c7d48:
	bl.d L_8c6dc8
L_8c7d4c:
	mov_s r1,r13
L_8c7d4e:
	mov_s r15,r0
L_8c7d50:
	b_s L_8c7d54
	.global L_8c7d52
L_8c7d52:
	mov_s r15,0x0
	.global L_8c7d54
L_8c7d54:
	ld r0,[r17, 0x4]
L_8c7d58:
	brne r0,0x2,L_8c7dd8
L_8c7d5c:
	add2 r0,r16,0x15
L_8c7d60:
	ld_s r1,[r13,0x8]
L_8c7d62:
	ldb_s r3,[r0]
L_8c7d64:
	ldb_s r2,[r1,0x4]
L_8c7d66:
	brne r3,r2,L_8c7dd8
L_8c7d6a:
	ldb_s r3,[r0,0x1]
L_8c7d6c:
	ldb_s r2,[r1,0x5]
L_8c7d6e:
	brne r3,r2,L_8c7dd8
L_8c7d72:
	ldb_s r3,[r0,0x2]
L_8c7d74:
	ldb_s r2,[r1,0x6]
L_8c7d76:
	brne r3,r2,L_8c7dd8
L_8c7d7a:
	ldb_s r3,[r0,0x3]
L_8c7d7c:
	ldb_s r2,[r1,0x7]
L_8c7d7e:
	brne r3,r2,L_8c7dd8
L_8c7d82:
	ldb_s r3,[r0,0x4]
L_8c7d84:
	ldb_s r2,[r1,0x8]
L_8c7d86:
	brne r3,r2,L_8c7dd8
L_8c7d8a:
	ldb_s r2,[r0,0x5]
L_8c7d8c:
	ldb_s r0,[r1,0x9]
L_8c7d8e:
	brne r2,r0,L_8c7dd8
L_8c7d92:
	/* add_s r1,0x4 */
	.byte 0x04,0xe1
L_8c7d94:
	bl.d L_8c9e74
L_8c7d98:
	ld_s r0,[r14,0x4]
L_8c7d9a:
	mov.f r16,r0
L_8c7d9e:
	ld_s r0,[r14,0x4]
L_8c7da0:
	beq_s L_8c7dd0
L_8c7da2:
	ld_s r1,[r13,0xc]
L_8c7da4:
	ld_s r1,[r1,0x6c]
L_8c7da6:
	add r0,r0,0x2b4
L_8c7daa:
	breq_s r1,0,L_8c7dba
L_8c7dac:
	bl L_8e196c
L_8c7db0:
	ld_s r0,[r14,0x4]
L_8c7db2:
	bl.d L_8db5b4
L_8c7db6:
	mov_s r1,r13
L_8c7db8:
	b_s L_8c7dbe
	.global L_8c7dba
L_8c7dba:
	bl L_8e555c
	.global L_8c7dbe
L_8c7dbe:
	mov_s r0,r16
L_8c7dc0:
	bl.d L_8c3ecc
L_8c7dc4:
	mov_s r1,r13
L_8c7dc6:
	ld_s r0,[r13,0xc]
L_8c7dc8:
	bl.d L_8c34e8
L_8c7dcc:
	ld r0,[r0, 0xac]
	.global L_8c7dd0
L_8c7dd0:
	ld_s r0,[r14,0x4]
L_8c7dd2:
	bl.d L_8e435c
L_8c7dd6:
	ldb_s r0,[r0,0x10]
	.global L_8c7dd8
L_8c7dd8:
	b.d L_8c031c
L_8c7ddc:
	mov_s r0,r15
L_8c7dde:
	nop_s
