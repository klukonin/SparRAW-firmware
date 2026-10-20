/* handle_packet_splitmac @ 0x8f3ba4, 248 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   handle_packet_splitmac failed, CONN OBJ is NULL. DST MAC ADDR-%04X%08X
 *   handle_packet_splitmac disassoc
 *   HOST SW TX: DST MAC: ADDR-%04X%08X
 *   handle_packet_splitmac assoc response
 * Зовут его: wmi_sw_tx_req
 * Зовёт сам: SW_TX_MGMT_API__send_packet, TX_API__alloc_tx_payload, TX_API__free_memory, __ld_r20_to_r13_ret, __st_r20_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit2, handle_packet__args, memcpy_fw, mid_list__by_mid_fw, mid_list__find_by
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global handle_packet_splitmac
handle_packet_splitmac:
	.global L_8f3ba4
L_8f3ba4:
	push_s blink
L_8f3ba6:
	bl L_8c01cc
L_8f3baa:
	mov_s r14,r0
L_8f3bac:
	mov_s r13,r1
L_8f3bae:
	mov_s r20,r2
L_8f3bb0:
	mov_s r19,r3
L_8f3bb2:
	mov_s r15,0x0
L_8f3bb4:
	stw.a r15,[sp,-0x4]
L_8f3bb8:
	bl.d L_8cc3dc
L_8f3bbc:
	mov_s r0,r3
L_8f3bbe:
	mov_s r17,r0
L_8f3bc0:
	bl.d L_8cc024
L_8f3bc4:
	mov_s r1,r14
L_8f3bc6:
	mov.f r16,r0
L_8f3bca:
	bne_s L_8f3bde
L_8f3bcc:
	ldw_s r2,[r14,0x4]
L_8f3bce:
	mov_s r1,0x100dcd0
L_8f3bd4:
	mov_s r0,0x1b
L_8f3bd6:
	bl.d L_8dcc80
L_8f3bda:
	ld_s r3,[r14]
L_8f3bdc:
	b_s L_8f3c96
	.global L_8f3bde
L_8f3bde:
	ldw_s r0,[r13]
L_8f3be0:
	lsr_s r0,r0,0x4
L_8f3be2:
	bmsk_s r0,r0,0x3
L_8f3be4:
	breq r0,0x1,L_8f3c2e
L_8f3be8:
	brne r0,0xa,L_8f3c96
L_8f3bec:
	mov_s r1,0x100dd18
L_8f3bf2:
	bl.d L_8dcba8
L_8f3bf6:
	mov_s r0,0x2b
L_8f3bf8:
	ldw_s r2,[r14,0x4]
L_8f3bfa:
	mov_s r1,0x100dd38
L_8f3c00:
	mov_s r0,0x1b
L_8f3c02:
	bl.d L_8dcc80
L_8f3c06:
	ld_s r3,[r14]
L_8f3c08:
	mov r4,0x38e50
L_8f3c10:
	mov_s r0,r14
L_8f3c12:
	mov_s r1,r19
L_8f3c14:
	mov_s r2,r13
L_8f3c16:
	bl.d L_8e577c
L_8f3c1a:
	mov_s r3,r20
L_8f3c1c:
	add3 r0,r16,0x1e
L_8f3c20:
	mov_s r1,0xc
L_8f3c22:
	mov_s r2,r15
L_8f3c24:
	mov_s r3,r15
L_8f3c26:
	bl.d L_8d9b6c
L_8f3c2a:
	mov_s r4,r15
L_8f3c2c:
	b_s L_8f3c96
	.global L_8f3c2e
L_8f3c2e:
	mov_s r1,0x100dd5c
L_8f3c34:
	bl.d L_8dcba8
L_8f3c38:
	mov_s r0,0x2b
L_8f3c3a:
	bl L_8c3414
L_8f3c3e:
	mov_s r1,sp
L_8f3c40:
	mov_s r18,r0
L_8f3c42:
	mov_s r2,r17
L_8f3c44:
	mov_s r3,r13
L_8f3c46:
	bl.d L_8ea0a0
L_8f3c4a:
	mov r4,r20
L_8f3c4e:
	ldw r17,[sp]
L_8f3c52:
	mov_s r0,r13
L_8f3c54:
	mov_s r1,r18
L_8f3c56:
	bl.d L_8c0380
L_8f3c5a:
	mov_s r2,r17
L_8f3c5c:
	bl.d L_8cb10c
L_8f3c60:
	mov_s r0,r18
L_8f3c62:
	add3 r0,r16,0x1e
L_8f3c66:
	mov_s r1,0xa
L_8f3c68:
	mov_s r2,r13
L_8f3c6a:
	mov_s r3,r15
L_8f3c6c:
	bl.d L_8d9b6c
L_8f3c70:
	mov_s r4,r15
L_8f3c72:
	ldw_s r2,[r14,0x4]
L_8f3c74:
	mov_s r1,0x100dd38
L_8f3c7a:
	mov_s r0,0x1b
L_8f3c7c:
	bl.d L_8dcc80
L_8f3c80:
	ld_s r3,[r14]
L_8f3c82:
	mov r4,0x38e50
L_8f3c8a:
	mov_s r0,r14
L_8f3c8c:
	mov_s r1,r19
L_8f3c8e:
	mov_s r2,r13
L_8f3c90:
	bl.d L_8e577c
L_8f3c94:
	mov_s r3,r17
	.global L_8f3c96
L_8f3c96:
	b.d L_8c0224
L_8f3c9a:
	add_s sp,sp,0x4
