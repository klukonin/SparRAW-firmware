/* SW_TX_MGMT_API__send_packet @ 0x8e0b38, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW_TX_MGMT_API::send_packet() IN
 *   SW TX MGMT: send packet %d bytes, complete cb 0x%x, metadata_p=0x%x.
 *   SW_TX_MGMT_API::send_packet() CALL SW_TX_MGMT_API::link_up_evt(p_conn=0x%x, conn::LINKUP_SUCCESS
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   SW_TX_MGMT_API::send_packet() CALL link_obtain(p_conn=0x%x, conn::LINKUP_SUCCESS
 *   SW failed TX MGMT: NO RESOURCES AVAILABLE.
 * Зовут его: send_sw_packet, wmi_handler_sw_tx_req
 * Зовёт сам: SW_TX_MGMT_API__link_up_evt, SW_TX_MGMT_API__packet_release, __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit0, fw_log__emit1, fw_log__emit3, fw_sysassert_fatal, log_hexdump, memcpy_fw, mid_list__by_mid, mid_list__find_by
 * Глобалы (через gp): 0x80017c
 */
	.section .text.SW_TX_MGMT_API__send_packet,"ax",@progbits
	.global SW_TX_MGMT_API__send_packet
SW_TX_MGMT_API__send_packet:
	.global L_8e0b38
L_8e0b38:
	push_s blink
L_8e0b3a:
	bl L_8c02b0
L_8e0b3e:
	sub_s sp,sp,0x8
L_8e0b40:
	mov_s r19,r0
L_8e0b42:
	mov_s r15,r1
L_8e0b44:
	mov_s r13,r2
L_8e0b46:
	mov_s r16,r3
L_8e0b48:
	mov r18,r4
L_8e0b4c:
	mov_s r2,0x1015310
L_8e0b52:
	mov_s r0,0x7
L_8e0b54:
	bl.d L_8edfb0
L_8e0b58:
	mov_s r1,0x2
L_8e0b5a:
	ld_s r0,[gp,-0xb0]
L_8e0b5c:
	brne r0,0x0,L_8e0c22
L_8e0b60:
	mov_s r0,0x8425c0
L_8e0b66:
	ld_s r1,[r0,0xc]
L_8e0b68:
	ld_s r0,[r0,0x10]
L_8e0b6a:
	cmp_s r1,r0
L_8e0b6c:
	mov_s r0,0x1
L_8e0b6e:
	sub.cs r0,r0,r0
L_8e0b72:
	brne r0,0x0,L_8e0c22
L_8e0b76:
	bl.d L_8ca1b0
L_8e0b7a:
	mov_s r0,r15
L_8e0b7c:
	bl.d L_8c9e74
L_8e0b80:
	mov_s r1,r19
L_8e0b82:
	mov_s r14,r0
L_8e0b84:
	mov_s r0,r13
L_8e0b86:
	bl.d L_8c7f90
L_8e0b8a:
	mov_s r1,r16
L_8e0b8c:
	mov r17,sp
L_8e0b90:
	breq_s r13,0,L_8e0bf6
	.global L_8e0b92
L_8e0b92:
	st r13,[r17, 0x4]
L_8e0b96:
	sub_s r13,r13,0x1c
L_8e0b98:
	st r13,[r17]
L_8e0b9c:
	ld r17,[sp]
L_8e0ba0:
	mov_s r2,0x1015334
L_8e0ba6:
	mov_s r0,0x7
L_8e0ba8:
	mov_s r1,0x2
L_8e0baa:
	mov_s r3,r16
L_8e0bac:
	mov r4,r18
L_8e0bb0:
	bl.d L_8ee034
L_8e0bb4:
	mov r5,r17
L_8e0bb8:
	stw r16,[r17, 0x8]
L_8e0bbc:
	add r0,r17,0xc
L_8e0bc0:
	mov_s r1,r19
L_8e0bc2:
	bl.d L_8c0460
L_8e0bc6:
	mov_s r2,0x6
L_8e0bc8:
	stw r15,[r17, 0x12]
L_8e0bcc:
	st.as r17,[gp,-0x2c]
L_8e0bd0:
	st.as r18,[gp,0x3]
L_8e0bd4:
	breq_s r14,0,L_8e0c0c
L_8e0bd6:
	mov_s r2,0x101537c
L_8e0bdc:
	mov_s r0,0x7
L_8e0bde:
	mov_s r1,0x2
L_8e0be0:
	bl.d L_8edfcc
L_8e0be4:
	mov_s r3,r14
L_8e0be6:
	ldb_s r0,[r14,0x8]
L_8e0be8:
	stb r0,[gp, 0xc8]
L_8e0bec:
	mov_s r0,r14
L_8e0bee:
	bl.d L_8d7ae0
L_8e0bf2:
	mov_s r1,0x0
L_8e0bf4:
	b_s L_8e0c3c
	.global L_8e0bf6
L_8e0bf6:
	mov_s r0,blink
L_8e0bf8:
	mov_s r2,0x10153e0
L_8e0bfe:
	mov_s r1,0x11e9
L_8e0c04:
	bl.d L_8c82c0
L_8e0c08:
	mov_s r3,0xab
L_8e0c0a:
	b_s L_8e0b92
	.global L_8e0c0c
L_8e0c0c:
	mov_s r2,0x1015414
L_8e0c12:
	mov_s r0,0x7
L_8e0c14:
	mov_s r1,0x2
L_8e0c16:
	bl.d L_8edfcc
L_8e0c1a:
	mov_s r3,r14
L_8e0c1c:
	bl L_8d7a20
L_8e0c20:
	b_s L_8e0c3c
	.global L_8e0c22
L_8e0c22:
	mov_s r2,0x1015468
L_8e0c28:
	mov_s r0,0x7
L_8e0c2a:
	bl.d L_8edfb0
L_8e0c2e:
	mov_s r1,0x1
L_8e0c30:
	mov_s r0,r13
L_8e0c32:
	mov_s r1,0x1
L_8e0c34:
	mov_s r2,r15
L_8e0c36:
	bl.d L_8db394
L_8e0c3a:
	mov_s r3,r18
	.global L_8e0c3c
L_8e0c3c:
	b.d L_8c030c
L_8e0c40:
	add_s sp,sp,0x8
L_8e0c42:
	nop_s
