/* SW_TX_MGMT_API__link_up_evt @ 0x8dabfc, 232 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW_TX_MGMT_API::link_up_evt() IN
 *   SW TX MGMT failed: LINK UP failed.
 *   SW_TX_MGMT_API::link_up_evt -> conn_mgr::link_up_evt
 *   SW TX MGMT: sending packet.
 *   SW TX MGMT: link_up_evt (%d). -> p_conn=0x%x.
 *   SW TX MGMT: race, linkup not for this TX SW Send don't double send it (%d).
 * Зовут его: SW_TX_MGMT_API__send_packet, WBE_DRIVER__link_down_notif
 * Зовёт сам: SW_TX_MGMT_API__packet_release, __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__link_up_evt, fw_log_emit0, fw_log_emit1, fw_log_emit2, sw_tx_mgmt__clear_link_ctx, tx_api__send_mgmt
 * Глобалы (через gp): 0x800184, 0x80024f
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global SW_TX_MGMT_API__link_up_evt
SW_TX_MGMT_API__link_up_evt:
	.global L_8dabfc
L_8dabfc:
	push_s blink
L_8dabfe:
	bl L_8c01e0
L_8dac02:
	sub_s sp,sp,0x8
L_8dac04:
	mov_s r13,r0
L_8dac06:
	mov_s r14,r1
L_8dac08:
	mov_s r1,0x10188c0
L_8dac0e:
	bl.d L_8dcba8
L_8dac12:
	mov_s r0,0x27
L_8dac14:
	ld.as r1,[gp,-0x30]
L_8dac18:
	breq r1,0x0,L_8dacde
L_8dac1c:
	ldb_s r2,[r13,0x8]
L_8dac1e:
	ldb_s r0,[gp,0xcb]
L_8dac20:
	brne r2,r0,L_8dacde
L_8dac24:
	st_s r1,[sp,0x0]
L_8dac26:
	add_s r1,r1,0x24
L_8dac28:
	st_s r1,[sp,0x4]
L_8dac2a:
	brne r14,0x1,L_8dac6c
L_8dac2e:
	ldb r0,[r13, 0x4c]
L_8dac32:
	brne r0,0x0,L_8dacde
L_8dac36:
	mov_s r1,0x10188e4
L_8dac3c:
	bl.d L_8dcba8
L_8dac40:
	mov_s r0,0x27
L_8dac42:
	ld_s r2,[r13,0x18]
L_8dac44:
	mov_s r1,0x2
L_8dac46:
	ld_s r0,[sp,0x4]
L_8dac48:
	ldb_s r2,[r2,0x10]
L_8dac4a:
	bl.d L_8df624
L_8dac4e:
	ld.as r3,[gp,0x0]
L_8dac52:
	mov_s r1,0x1018908
L_8dac58:
	bl.d L_8dcba8
L_8dac5c:
	mov_s r0,0x27
L_8dac5e:
	mov_s r0,r13
L_8dac60:
	bl.d L_8dad1c
L_8dac64:
	mov_s r1,r14
L_8dac66:
	bl L_8e2930
L_8dac6a:
	b_s L_8dacde
	.global L_8dac6c
L_8dac6c:
	mov_s r1,0x1018940
L_8dac72:
	bl.d L_8dcba8
L_8dac76:
	mov_s r0,0x27
L_8dac78:
	mov_s r14,0x1
L_8dac7a:
	ld_s r0,[r13,0x18]
L_8dac7c:
	st_s r14,[r13,0x48]
L_8dac7e:
	add r0,r0,0x234
L_8dac82:
	ld_s r1,[r0,0x8]
L_8dac84:
	ld_s r1,[r1,0x78]
L_8dac86:
	mov_s r15,0x0
L_8dac88:
	brne_s r1,0,L_8dac8e
L_8dac8a:
	ld_s r0,[r0,0x4c]
L_8dac8c:
	breq_s r0,0,L_8dac90
	.global L_8dac8e
L_8dac8e:
	mov_s r15,0x1
	.global L_8dac90
L_8dac90:
	extb.f 0x0,r15
L_8dac94:
	mov_s r15,0x1
L_8dac96:
	ldb r2,[r13, 0x4c]
L_8dac9a:
	sub.eq r15,r15,r15
L_8dac9e:
	brne_s r2,0,L_8dacd2
L_8daca0:
	mov_s r1,0x101895c
L_8daca6:
	mov_s r0,0x27
L_8daca8:
	bl.d L_8dcc80
L_8dacac:
	mov_s r3,r13
L_8dacae:
	ld_s r0,[gp,-0xc0]
L_8dacb0:
	mov r5,L_8e9b1c-0x8c0000
L_8dacb8:
	ldw r4,[r0, 0x8]
L_8dacbc:
	mov_s r0,r13
L_8dacbe:
	ld_s r3,[sp,0x4]
L_8dacc0:
	mov_s r1,r15
L_8dacc2:
	mov_s r2,0x1
L_8dacc4:
	bl.d L_8e5874
L_8dacc8:
	mov r6,0x0
L_8daccc:
	stb r14,[r13, 0x4c]
L_8dacd0:
	b_s L_8dacde
	.global L_8dacd2
L_8dacd2:
	mov_s r1,0x101898c
L_8dacd8:
	bl.d L_8dcc10
L_8dacdc:
	mov_s r0,0x27
	.global L_8dacde
L_8dacde:
	b.d L_8c024c
L_8dace2:
	add_s sp,sp,0x8
