/* send_sw_packet @ 0x8f8dbc, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   send_sw_packet() wmi_cmd_handler_sw_tx_req - ADDR 1: ADDR-%04X%08X
 *   send_sw_packet() wmi_cmd_handler_sw_tx_req - ADDR 2: ADDR-%04X%08X
 *   send_sw_packet() wmi_cmd_handler_sw_tx_req - ADDR 3: ADDR-%04X%08X
 *   DISCOVERY:: SW TX send packet.
 * Зовут его: wmi_sw_tx_req
 * Зовёт сам: SW_TX_MGMT_API__send_packet, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, fw_log_emit2, mgmt_tx__render_probe_resp
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global send_sw_packet
send_sw_packet:
	.global L_8f8dbc
L_8f8dbc:
	sub_s sp,sp,0x4
L_8f8dbe:
	push_s blink
L_8f8dc0:
	bl L_8c01dc
L_8f8dc4:
	stw r3,[sp, 0x14]
L_8f8dc8:
	mov_s r16,r0
L_8f8dca:
	mov_s r15,r1
L_8f8dcc:
	mov_s r14,r2
L_8f8dce:
	mov_s r13,r4
L_8f8dd0:
	mov_s r1,0x1017018
L_8f8dd6:
	ldw_s r0,[r2,0x6]
L_8f8dd8:
	ldw_s r3,[r2,0x4]
L_8f8dda:
	asl_s r0,r0,0x10
L_8f8ddc:
	or_s r3,r3,r0
L_8f8dde:
	mov_s r0,0x2b
L_8f8de0:
	bl.d L_8dcc80
L_8f8de4:
	ldw_s r2,[r2,0x8]
L_8f8de6:
	mov_s r1,0x101705c
L_8f8dec:
	ldw_s r0,[r14,0xc]
L_8f8dee:
	ldw_s r3,[r14,0xa]
L_8f8df0:
	asl_s r0,r0,0x10
L_8f8df2:
	or_s r3,r3,r0
L_8f8df4:
	mov_s r0,0x2b
L_8f8df6:
	bl.d L_8dcc80
L_8f8dfa:
	ldw_s r2,[r14,0xe]
L_8f8dfc:
	mov_s r1,0x10170a0
L_8f8e02:
	ldw_s r0,[r14,0x12]
L_8f8e04:
	ldw_s r3,[r14,0x10]
L_8f8e06:
	asl_s r0,r0,0x10
L_8f8e08:
	or_s r3,r3,r0
L_8f8e0a:
	mov_s r0,0x2b
L_8f8e0c:
	bl.d L_8dcc80
L_8f8e10:
	ldw_s r2,[r14,0x14]
L_8f8e12:
	ldw_s r0,[r14]
L_8f8e14:
	lsr_s r0,r0,0x4
L_8f8e16:
	bmsk_s r0,r0,0x3
L_8f8e18:
	brne r0,0x5,L_8f8e28
L_8f8e1c:
	add_s r3,sp,0x14
L_8f8e1e:
	mov_s r0,r16
L_8f8e20:
	mov_s r1,r15
L_8f8e22:
	bl.d L_8f2b40
L_8f8e26:
	mov_s r2,r14
	.global L_8f8e28
L_8f8e28:
	mov_s r1,0x10170e4
L_8f8e2e:
	bl.d L_8dcba8
L_8f8e32:
	mov_s r0,0x2c
L_8f8e34:
	mov r4,0x38e50
L_8f8e3c:
	mov_s r0,r15
L_8f8e3e:
	mov_s r1,r13
L_8f8e40:
	mov_s r2,r14
L_8f8e42:
	bl.d L_8e577c
L_8f8e46:
	ldw r3,[sp, 0x14]
L_8f8e4a:
	mov_s r12,0x8
L_8f8e4c:
	b L_8c0246
