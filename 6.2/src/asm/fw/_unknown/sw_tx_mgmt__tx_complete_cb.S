/* sw_tx_mgmt__tx_complete_cb @ 0x8e9b1c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW TX MGMT:tx_complete_cb  m_cur_metadata_p=0x%x, metadata_p=0x%x, p_conn=0x%x.
 * Зовёт сам: SW_TX_MGMT_API__packet_release, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3, fw_sysassert_fatal, sw_tx_mgmt__clear_link_ctx
 * Глобалы (через gp): 0x800184
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sw_tx_mgmt__tx_complete_cb
sw_tx_mgmt__tx_complete_cb:
	.global L_8e9b1c
L_8e9b1c:
	push_s blink
L_8e9b1e:
	bl L_8c01dc
L_8e9b22:
	sub_s sp,sp,0x8
L_8e9b24:
	mov.f r14,r0
L_8e9b28:
	mov_s r15,r1
L_8e9b2a:
	mov_s r16,r2
L_8e9b2c:
	mov_s r13,sp
L_8e9b2e:
	beq_s L_8e9b84
	.global L_8e9b30
L_8e9b30:
	st_s r14,[r13,0x4]
L_8e9b32:
	sub r0,r14,0x24
L_8e9b36:
	st_s r0,[r13]
L_8e9b38:
	ld_s r13,[sp,0x0]
L_8e9b3a:
	mov_s r1,0x10189d8
L_8e9b40:
	mov_s r0,0x27
L_8e9b42:
	ld.as r2,[gp,-0x30]
L_8e9b46:
	mov_s r3,r13
L_8e9b48:
	bl.d L_8dcd00
L_8e9b4c:
	mov r4,r16
L_8e9b50:
	ld_s r0,[gp,-0xc0]
L_8e9b52:
	brne r13,r0,L_8e9b92
	.global L_8e9b56
L_8e9b56:
	mov.f r1,r15
L_8e9b5a:
	mov.ne r1,0x1
L_8e9b5e:
	asl_s r1,r1
L_8e9b60:
	ld r2,[r16, 0x18]
L_8e9b64:
	mov_s r0,r14
L_8e9b66:
	ldb_s r2,[r2,0x10]
L_8e9b68:
	bl.d L_8df624
L_8e9b6c:
	ld.as r3,[gp,0x0]
L_8e9b70:
	mov_s r0,0x0
L_8e9b72:
	stb r0,[r16, 0x4c]
L_8e9b76:
	bl.d L_8e2930
L_8e9b7a:
	st r0,[r16, 0x48]
L_8e9b7e:
	b.d L_8c0244
L_8e9b82:
	add_s sp,sp,0x8
	.global L_8e9b84
L_8e9b84:
	mov_s r0,blink
L_8e9b86:
	mov_s r1,0x11e9
L_8e9b8c:
	bl L_8c9b28
L_8e9b90:
	b_s L_8e9b30
	.global L_8e9b92
L_8e9b92:
	mov_s r0,blink
L_8e9b94:
	mov_s r1,0x121a
L_8e9b9a:
	bl L_8c9b28
L_8e9b9e:
	b_s L_8e9b56
