/* send_sw_packet @ 0x8f0a94, 176 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   send_sw_packet() wmi_cmd_handler_sw_tx_req - ADDR 1: ADDR-%04X%08X
 *   send_sw_packet() wmi_cmd_handler_sw_tx_req - ADDR 2: ADDR-%04X%08X
 *   send_sw_packet() wmi_cmd_handler_sw_tx_req - ADDR 3: ADDR-%04X%08X
 *   DISCOVERY:: SW TX send packet.
 * Зовут его: wmi_handler_sw_tx_req
 * Зовёт сам: SW_TX_MGMT_API__send_packet, __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit2, mgmt_tx__render_probe_resp, mid_list__by_mid
 */
	.section .text.send_sw_packet,"ax",@progbits
	.global send_sw_packet
send_sw_packet:
	.global L_8f0a94
L_8f0a94:
	sub_s sp,sp,0x4
L_8f0a96:
	push_s blink
L_8f0a98:
	bl L_8c02bc
L_8f0a9c:
	stw r3,[sp, 0x14]
L_8f0aa0:
	mov_s r16,r0
L_8f0aa2:
	mov_s r15,r1
L_8f0aa4:
	mov_s r14,r2
L_8f0aa6:
	mov_s r13,r4
L_8f0aa8:
	bl.d L_8ca1b0
L_8f0aac:
	mov_s r0,r13
L_8f0aae:
	mov_s r2,0x1012868
L_8f0ab4:
	ldw_s r0,[r14,0x6]
L_8f0ab6:
	ldw r4,[r14, 0x4]
L_8f0aba:
	asl_s r0,r0,0x10
L_8f0abc:
	or r4,r4,r0
L_8f0ac0:
	mov_s r0,0xb
L_8f0ac2:
	mov_s r1,0x2
L_8f0ac4:
	bl.d L_8edff8
L_8f0ac8:
	ldw_s r3,[r14,0x8]
L_8f0aca:
	mov_s r2,0x10128ac
L_8f0ad0:
	ldw_s r0,[r14,0xc]
L_8f0ad2:
	ldw r4,[r14, 0xa]
L_8f0ad6:
	asl_s r0,r0,0x10
L_8f0ad8:
	or r4,r4,r0
L_8f0adc:
	mov_s r0,0xb
L_8f0ade:
	mov_s r1,0x2
L_8f0ae0:
	bl.d L_8edff8
L_8f0ae4:
	ldw_s r3,[r14,0xe]
L_8f0ae6:
	mov_s r2,0x10128f0
L_8f0aec:
	ldw_s r0,[r14,0x12]
L_8f0aee:
	ldw r4,[r14, 0x10]
L_8f0af2:
	asl_s r0,r0,0x10
L_8f0af4:
	or r4,r4,r0
L_8f0af8:
	mov_s r0,0xb
L_8f0afa:
	mov_s r1,0x2
L_8f0afc:
	bl.d L_8edff8
L_8f0b00:
	ldw_s r3,[r14,0x14]
L_8f0b02:
	ldw_s r0,[r14]
L_8f0b04:
	lsr_s r0,r0,0x4
L_8f0b06:
	bmsk_s r0,r0,0x3
L_8f0b08:
	brne r0,0x5,L_8f0b18
L_8f0b0c:
	add_s r3,sp,0x14
L_8f0b0e:
	mov_s r0,r16
L_8f0b10:
	mov_s r1,r15
L_8f0b12:
	bl.d L_8eb824
L_8f0b16:
	mov_s r2,r14
	.global L_8f0b18
L_8f0b18:
	mov_s r2,0x1012934
L_8f0b1e:
	mov_s r0,0xc
L_8f0b20:
	bl.d L_8edfb0
L_8f0b24:
	mov_s r1,0x2
L_8f0b26:
	mov r4,0x30b44
L_8f0b2e:
	mov_s r0,r15
L_8f0b30:
	mov_s r1,r13
L_8f0b32:
	mov_s r2,r14
L_8f0b34:
	bl.d L_8e0b38
L_8f0b38:
	ldw r3,[sp, 0x14]
L_8f0b3c:
	mov_s r12,0x8
L_8f0b3e:
	b L_8c0326
L_8f0b42:
	nop_s
