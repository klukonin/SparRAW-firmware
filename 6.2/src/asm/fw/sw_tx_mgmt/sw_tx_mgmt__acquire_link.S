/* sw_tx_mgmt__acquire_link @ 0x8dab34, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SW TX MGMT: link acquisition activated.
 *   SW TX MGMT failed: LINK RESOURCES ARE NOT AVAILABLE.
 * Зовут его: SW_TX_MGMT_API__send_packet
 * Зовёт сам: SW_TX_MGMT_API__packet_release, __ld_r14_to_r13_ret, __st_r14_to_r13, find_main_sm__bcon_args, fw_log_emit0, fw_sysassert_fatal, mid_list__by_mid_fw, sw_tx_mgmt__clear_link_ctx
 * Глобалы (через gp): 0x800184
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sw_tx_mgmt__acquire_link
sw_tx_mgmt__acquire_link:
	.global L_8dab34
L_8dab34:
	push_s blink
L_8dab36:
	bl L_8c01e4
L_8dab3a:
	ld_s r0,[gp,-0xc0]
L_8dab3c:
	sub_s sp,sp,0x8
L_8dab3e:
	breq_s r0,0,L_8dab8a
	.global L_8dab40
L_8dab40:
	ld.as r14,[gp,-0x30]
L_8dab44:
	mov_s r13,sp
L_8dab46:
	breq_s r14,0,L_8dab98
	.global L_8dab48
L_8dab48:
	st_s r14,[r13]
L_8dab4a:
	add_s r14,r14,0x24
L_8dab4c:
	st_s r14,[r13,0x4]
L_8dab4e:
	ld_s r0,[gp,-0xc0]
L_8dab50:
	bl.d L_8cc3dc
L_8dab54:
	ldw_s r0,[r0,0x12]
L_8dab56:
	mov.f r13,r0
L_8dab5a:
	beq_s L_8daba6
	.global L_8dab5c
L_8dab5c:
	ld_s r0,[gp,-0xc0]
L_8dab5e:
	mov_s r2,0x0
L_8dab60:
	add r1,r0,0xc
L_8dab64:
	mov_s r0,r13
L_8dab66:
	mov r4,0xffff
L_8dab6e:
	bl.d L_8da8fc
L_8dab72:
	mov_s r3,r2
L_8dab74:
	breq_s r0,0,L_8dabb4
L_8dab76:
	ldb_s r0,[r0,0x8]
L_8dab78:
	mov_s r1,0x1018860
L_8dab7e:
	stb r0,[gp, 0xcb]
L_8dab82:
	bl.d L_8dcba8
L_8dab86:
	mov_s r0,0x27
L_8dab88:
	b_s L_8dabd6
	.global L_8dab8a
L_8dab8a:
	mov_s r0,blink
L_8dab8c:
	mov_s r1,0x1219
L_8dab92:
	bl L_8c9b28
L_8dab96:
	b_s L_8dab40
	.global L_8dab98
L_8dab98:
	mov_s r0,blink
L_8dab9a:
	mov_s r1,0x11d6
L_8daba0:
	bl L_8c9b28
L_8daba4:
	b_s L_8dab48
	.global L_8daba6
L_8daba6:
	mov_s r0,blink
L_8daba8:
	mov_s r1,0x16bc
L_8dabae:
	bl L_8c9b28
L_8dabb2:
	b_s L_8dab5c
	.global L_8dabb4
L_8dabb4:
	mov_s r1,0x1018888
L_8dabba:
	bl.d L_8dcba8
L_8dabbe:
	mov_s r0,0x17
L_8dabc0:
	ld.as r2,[gp,-0x30]
L_8dabc4:
	mov_s r1,0x1
L_8dabc6:
	ld_s r0,[sp,0x4]
L_8dabc8:
	ldw_s r2,[r2,0x12]
L_8dabca:
	bl.d L_8df624
L_8dabce:
	ld.as r3,[gp,0x0]
L_8dabd2:
	bl L_8e2930
	.global L_8dabd6
L_8dabd6:
	b.d L_8c0254
L_8dabda:
	add_s sp,sp,0x8
