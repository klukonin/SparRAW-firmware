/* TX_API__post_tx_payload @ 0x8e0ce8, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_TX_MGMT_PACKET_EVENTID TX_API::post_tx_payload() 0x%x by blink=0x%x
 * Зовут его: scan_mngr__connect
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit2, fw_sysassert_fatal, low_sme__send_evt2sw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__post_tx_payload
TX_API__post_tx_payload:
	.global L_8e0ce8
L_8e0ce8:
	push_s blink
L_8e0cea:
	bl L_8c01dc
L_8e0cee:
	sub_s sp,sp,0x8
L_8e0cf0:
	mov.f r14,r0
L_8e0cf4:
	mov_s r16,r1
L_8e0cf6:
	mov_s r13,sp
L_8e0cf8:
	beq_s L_8e0d38
	.global L_8e0cfa
L_8e0cfa:
	st_s r14,[r13,0x4]
L_8e0cfc:
	sub r0,r14,0x24
L_8e0d00:
	st_s r0,[r13]
L_8e0d02:
	ld_s r0,[sp,0x0]
L_8e0d04:
	mov_s r3,blink
L_8e0d06:
	ldw_s r13,[r0,0x8]
L_8e0d08:
	mov_s r1,0x10183f4
L_8e0d0e:
	mov_s r0,0x27
L_8e0d10:
	bl.d L_8dcc80
L_8e0d14:
	mov_s r2,r14
L_8e0d16:
	mov_s r0,r14
L_8e0d18:
	mov_s r1,0x1841
L_8e0d1e:
	mov_s r2,r13
L_8e0d20:
	mov_s r3,r16
L_8e0d22:
	mov r4,0x0
L_8e0d26:
	mov r5,0x1
L_8e0d2a:
	bl.d L_8e5474
L_8e0d2e:
	mov r6,r4
L_8e0d32:
	b.d L_8c0244
L_8e0d36:
	add_s sp,sp,0x8
	.global L_8e0d38
L_8e0d38:
	mov_s r0,blink
L_8e0d3a:
	mov_s r1,0x11e9
L_8e0d40:
	bl L_8c9b28
L_8e0d44:
	b_s L_8e0cfa
L_8e0d46:
	nop_s
