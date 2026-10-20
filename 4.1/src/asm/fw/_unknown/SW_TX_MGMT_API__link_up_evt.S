/* SW_TX_MGMT_API__link_up_evt @ 0x8d7ae0, 244 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовут его: SW_TX_MGMT_API__send_packet, l2_mgr__link_up_evt
 * Зовёт сам: SW_TX_MGMT_API__packet_release, __ld_r15_to_r13_ret, __st_r15_to_r13, conn_mgr__link_up_evt, fw_log__emit0, fw_log__emit1, fw_log__emit2, set_g_8000c0_x2, tx_api__send_mgmt
 * Глобалы (через gp): 0x80017c, 0x800238
 */
	.section .text.SW_TX_MGMT_API__link_up_evt,"ax",@progbits
	.global SW_TX_MGMT_API__link_up_evt
SW_TX_MGMT_API__link_up_evt:
	.global L_8d7ae0
L_8d7ae0:
	push_s blink
L_8d7ae2:
	bl L_8c02c0
L_8d7ae6:
	sub_s sp,sp,0x8
L_8d7ae8:
	mov_s r15,r0
L_8d7aea:
	mov_s r13,r1
L_8d7aec:
	mov_s r2,0x1015530
L_8d7af2:
	mov_s r0,0x7
L_8d7af4:
	bl.d L_8edfb0
L_8d7af8:
	mov_s r1,0x2
L_8d7afa:
	ld.as r1,[gp,-0x2c]
L_8d7afe:
	breq r1,0x0,L_8d7bce
L_8d7b02:
	ldb_s r2,[r15,0x8]
L_8d7b04:
	ldb_s r0,[gp,0xc8]
L_8d7b06:
	brne r2,r0,L_8d7bce
L_8d7b0a:
	st_s r1,[sp,0x0]
L_8d7b0c:
	add_s r1,r1,0x1c
L_8d7b0e:
	st_s r1,[sp,0x4]
L_8d7b10:
	brne r13,0x1,L_8d7b56
L_8d7b14:
	ldb r0,[r15, 0x40]
L_8d7b18:
	brne r0,0x0,L_8d7bce
L_8d7b1c:
	mov_s r2,0x1015554
L_8d7b22:
	mov_s r0,0x7
L_8d7b24:
	bl.d L_8edfb0
L_8d7b28:
	mov_s r1,0x2
L_8d7b2a:
	ld_s r2,[r15,0xc]
L_8d7b2c:
	mov_s r1,0x2
L_8d7b2e:
	ld_s r0,[sp,0x4]
L_8d7b30:
	ldb_s r2,[r2,0x10]
L_8d7b32:
	bl.d L_8db394
L_8d7b36:
	ld.as r3,[gp,0x3]
L_8d7b3a:
	mov_s r2,0x1015578
L_8d7b40:
	mov_s r0,0x7
L_8d7b42:
	bl.d L_8edfb0
L_8d7b46:
	mov_s r1,0x2
L_8d7b48:
	mov_s r0,r15
L_8d7b4a:
	bl.d L_8d7bdc
L_8d7b4e:
	mov_s r1,r13
L_8d7b50:
	bl L_8de5b8
L_8d7b54:
	b_s L_8d7bce
	.global L_8d7b56
L_8d7b56:
	mov_s r2,0x10155b0
L_8d7b5c:
	mov_s r0,0x7
L_8d7b5e:
	bl.d L_8edfb0
L_8d7b62:
	mov_s r1,0x2
L_8d7b64:
	mov_s r13,0x1
L_8d7b66:
	ld_s r0,[r15,0xc]
L_8d7b68:
	st_s r13,[r15,0x3c]
L_8d7b6a:
	add r0,r0,0x234
L_8d7b6e:
	ld_s r1,[r0,0x8]
L_8d7b70:
	ld_s r1,[r1,0x78]
L_8d7b72:
	mov_s r14,0x0
L_8d7b74:
	brne_s r1,0,L_8d7b7a
L_8d7b76:
	ld_s r0,[r0,0x70]
L_8d7b78:
	breq_s r0,0,L_8d7b7c
	.global L_8d7b7a
L_8d7b7a:
	mov_s r14,0x1
	.global L_8d7b7c
L_8d7b7c:
	extb.f 0x0,r14
L_8d7b80:
	mov_s r14,0x1
L_8d7b82:
	ldb r3,[r15, 0x40]
L_8d7b86:
	sub.eq r14,r14,r14
L_8d7b8a:
	brne_s r3,0,L_8d7bc0
L_8d7b8c:
	mov_s r2,0x10155cc
L_8d7b92:
	mov_s r0,0x7
L_8d7b94:
	mov_s r1,0x2
L_8d7b96:
	bl.d L_8edff8
L_8d7b9a:
	mov_s r4,r15
L_8d7b9c:
	ld_s r0,[gp,-0xb0]
L_8d7b9e:
	mov r5,0x24a64
L_8d7ba6:
	ldw r4,[r0, 0x8]
L_8d7baa:
	mov_s r0,r15
L_8d7bac:
	ld_s r3,[sp,0x4]
L_8d7bae:
	mov_s r1,r14
L_8d7bb0:
	mov_s r2,0x1
L_8d7bb2:
	bl.d L_8e0c44
L_8d7bb6:
	mov r6,0x0
L_8d7bba:
	stb r13,[r15, 0x40]
L_8d7bbe:
	b_s L_8d7bce
	.global L_8d7bc0
L_8d7bc0:
	mov_s r2,0x10155fc
L_8d7bc6:
	mov_s r0,0x7
L_8d7bc8:
	bl.d L_8edfcc
L_8d7bcc:
	mov_s r1,0x2
	.global L_8d7bce
L_8d7bce:
	b.d L_8c032c
L_8d7bd2:
	add_s sp,sp,0x8
