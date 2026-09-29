/* sw_tx_mgmt__acquire_link @ 0x8d7a20, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW TX MGMT: link acquisition activated.
 *   sw_tx_mgmt.cpp
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 *   SW TX MGMT failed: LINK RESOURCES ARE NOT AVAILABLE.
 * Зовут его: SW_TX_MGMT_API__send_packet
 * Зовёт сам: SW_TX_MGMT_API__packet_release, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_sysassert_fatal, mid__acquire_link, mid_list__by_mid, set_g_8000c0_x2
 * Глобалы (через gp): 0x80017c
 */
	.section .text.sw_tx_mgmt__acquire_link,"ax",@progbits
	.global sw_tx_mgmt__acquire_link
sw_tx_mgmt__acquire_link:
	.global L_8d7a20
L_8d7a20:
	push_s blink
L_8d7a22:
	bl L_8c02c4
L_8d7a26:
	ld_s r0,[gp,-0xb0]
L_8d7a28:
	sub_s sp,sp,0x8
L_8d7a2a:
	breq_s r0,0,L_8d7a68
	.global L_8d7a2c
L_8d7a2c:
	ld.as r13,[gp,-0x2c]
L_8d7a30:
	mov_s r14,sp
L_8d7a32:
	breq_s r13,0,L_8d7a7e
	.global L_8d7a34
L_8d7a34:
	st_s r13,[r14]
L_8d7a36:
	add_s r13,r13,0x1c
L_8d7a38:
	st_s r13,[r14,0x4]
L_8d7a3a:
	ld_s r0,[gp,-0xb0]
L_8d7a3c:
	bl.d L_8ca1b0
L_8d7a40:
	ldw_s r0,[r0,0x12]
L_8d7a42:
	ld.as r1,[gp,-0x2c]
L_8d7a46:
	mov_s r2,0x0
L_8d7a48:
	add_s r1,r1,0xc
L_8d7a4a:
	bl.d L_8d7814
L_8d7a4e:
	mov_s r3,r2
L_8d7a50:
	breq_s r0,0,L_8d7a94
L_8d7a52:
	ldb_s r0,[r0,0x8]
L_8d7a54:
	mov_s r2,0x10154c0
L_8d7a5a:
	stb r0,[gp, 0xc8]
L_8d7a5e:
	mov_s r0,0x7
L_8d7a60:
	bl.d L_8edfb0
L_8d7a64:
	mov_s r1,0x2
L_8d7a66:
	b_s L_8d7ab8
	.global L_8d7a68
L_8d7a68:
	mov_s r0,blink
L_8d7a6a:
	mov_s r2,0x10154e8
L_8d7a70:
	mov_s r1,0x1219
L_8d7a76:
	bl.d L_8c82c0
L_8d7a7a:
	mov_s r3,0x4f
L_8d7a7c:
	b_s L_8d7a2c
	.global L_8d7a7e
L_8d7a7e:
	mov_s r0,blink
L_8d7a80:
	mov_s r2,0x10153e0
L_8d7a86:
	mov_s r1,0x11d6
L_8d7a8c:
	bl.d L_8c82c0
L_8d7a90:
	mov_s r3,0xaa
L_8d7a92:
	b_s L_8d7a34
	.global L_8d7a94
L_8d7a94:
	mov_s r2,0x10154f8
L_8d7a9a:
	mov_s r0,0x7
L_8d7a9c:
	bl.d L_8edfb0
L_8d7aa0:
	mov_s r1,0x1
L_8d7aa2:
	ld.as r2,[gp,-0x2c]
L_8d7aa6:
	mov_s r1,0x1
L_8d7aa8:
	ld_s r0,[sp,0x4]
L_8d7aaa:
	ldw_s r2,[r2,0x12]
L_8d7aac:
	bl.d L_8db394
L_8d7ab0:
	ld.as r3,[gp,0x3]
L_8d7ab4:
	bl L_8de5b8
	.global L_8d7ab8
L_8d7ab8:
	b.d L_8c0334
