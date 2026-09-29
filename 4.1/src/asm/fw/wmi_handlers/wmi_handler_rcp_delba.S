/* wmi_handler_rcp_delba @ 0x8e7d2c, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handlers.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r18_to_r13_ret, __st_r18_to_r13, conn_mgr__by_cid, frame__build_delba, fw_sysassert_fatal, mgmt_tx__begin_frame, mid_list__by_mid, tx_api__send_mgmt
 */
	.section .text.wmi_handler_rcp_delba,"ax",@progbits
	.global wmi_handler_rcp_delba
wmi_handler_rcp_delba:
	.global L_8e7d2c
L_8e7d2c:
	push_s blink
L_8e7d2e:
	bl L_8c02b4
L_8e7d32:
	mov_s r18,r0
L_8e7d34:
	mov_s r0,0x0
L_8e7d36:
	push_s r0
L_8e7d38:
	bl.d L_8ca1b0
L_8e7d3c:
	mov_s r0,r1
L_8e7d3e:
	mov.f r14,r0
L_8e7d42:
	beq_s L_8e7daa
	.global L_8e7d44
L_8e7d44:
	ldb r0,[r18]
L_8e7d48:
	asr r16,r0,0x4
L_8e7d4c:
	bl.d L_8c9e44
L_8e7d50:
	bmsk_s r0,r0,0x3
L_8e7d52:
	bl.d L_8c2c80
L_8e7d56:
	mov_s r15,r0
L_8e7d58:
	mov.f r13,r0
L_8e7d5c:
	mov r17,0xf0
L_8e7d60:
	beq_s L_8e7dbe
	.global L_8e7d62
L_8e7d62:
	breq_s r14,0,L_8e7dd2
	.global L_8e7d64
L_8e7d64:
	breq r15,0x0,L_8e7de6
	.global L_8e7d68
L_8e7d68:
	mov_s r1,sp
L_8e7d6a:
	mov_s r0,r13
L_8e7d6c:
	mov_s r2,r14
L_8e7d6e:
	mov_s r3,r15
L_8e7d70:
	bl.d L_8e4be4
L_8e7d74:
	mov r4,0xd
L_8e7d78:
	ld_s r0,[sp,0x0]
L_8e7d7a:
	mov_s r1,0x0
L_8e7d7c:
	add_s r0,r0,r13
L_8e7d7e:
	and r2,r16,r17
L_8e7d82:
	bl.d L_8ec860
L_8e7d86:
	ldw r3,[r18, 0x2]
L_8e7d8a:
	ld_s r14,[sp,0x0]
L_8e7d8c:
	mov_s r1,0x0
L_8e7d8e:
	add_s r14,r14,r0
L_8e7d90:
	st_s r14,[sp,0x0]
L_8e7d92:
	extw r4,r14
L_8e7d96:
	mov_s r0,r15
L_8e7d98:
	mov_s r2,0x1
L_8e7d9a:
	mov_s r3,r13
L_8e7d9c:
	mov_s r5,r1
L_8e7d9e:
	bl.d L_8e0c44
L_8e7da2:
	mov_s r6,r1
L_8e7da4:
	b.d L_8c0314
L_8e7da8:
	add_s sp,sp,0x4
	.global L_8e7daa
L_8e7daa:
	mov_s r0,blink
L_8e7dac:
	mov_s r2,0x100710c
L_8e7db2:
	mov_s r1,0x6f
L_8e7db4:
	bset_s r1,r1,0xc
L_8e7db6:
	bl.d L_8c82c0
L_8e7dba:
	mov_s r3,0x7b
L_8e7dbc:
	b_s L_8e7d44
	.global L_8e7dbe
L_8e7dbe:
	mov_s r0,blink
L_8e7dc0:
	mov_s r2,0x100710c
L_8e7dc6:
	mov_s r1,0x70
L_8e7dc8:
	bset_s r1,r1,0xc
L_8e7dca:
	bl.d L_8c82c0
L_8e7dce:
	mov_s r3,0x82
L_8e7dd0:
	b_s L_8e7d62
	.global L_8e7dd2
L_8e7dd2:
	mov_s r0,blink
L_8e7dd4:
	mov_s r2,0x100710c
L_8e7dda:
	mov_s r1,0x71
L_8e7ddc:
	bset_s r1,r1,0xc
L_8e7dde:
	bl.d L_8c82c0
L_8e7de2:
	mov_s r3,0x83
L_8e7de4:
	b_s L_8e7d64
	.global L_8e7de6
L_8e7de6:
	mov_s r0,blink
L_8e7de8:
	mov_s r2,0x100710c
L_8e7dee:
	mov_s r1,0x72
L_8e7df0:
	bset_s r1,r1,0xc
L_8e7df2:
	bl.d L_8c82c0
L_8e7df6:
	mov_s r3,0x84
L_8e7df8:
	b_s L_8e7d68
L_8e7dfa:
	nop_s
