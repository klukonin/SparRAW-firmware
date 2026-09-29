/* rx_mgmt_srvs__distribute @ 0x8e3ba4, 152 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX MGMT SRVS: Distribute MLME packet subtype 0x%X to MID %d
 *   Distribute MGMT PROBE pkt mid %d
 *   Distribute ACTION NO ACK pkt mid %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID UNHANDLED MGMT, sub type = 0x%x !!!!
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_log_emit2, mid_list__by_mid_fw, rx_mgmt__action_no_ack, rx_pkt_handler, stream_mgr__action
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_mgmt_srvs__distribute
rx_mgmt_srvs__distribute:
	.global L_8e3ba4
L_8e3ba4:
	push_s blink
L_8e3ba6:
	bl L_8c01e4
L_8e3baa:
	ld_s r0,[r1,0x8]
L_8e3bac:
	ldw_s r2,[r0]
L_8e3bae:
	lsr_s r2,r2,0x4
L_8e3bb0:
	bmsk_s r2,r2,0x3
L_8e3bb2:
	brhs.d r2,0xf,L_8e3c2c
L_8e3bb6:
	mov_s r13,r1
L_8e3bb8:
	ldb.x r10,[0x802c58,r2]
L_8e3bc0:
	add r0,pcl,0xa
L_8e3bc4:
	add1 r0,r0,r10
L_8e3bc8:
	j_s [r0]
L_8e3bca:
	mov_s r1,0x1013efc
L_8e3bd0:
	mov_s r0,0x2d
L_8e3bd2:
	bl.d L_8dcc80
L_8e3bd6:
	ldb r3,[r13, 0x35]
L_8e3bda:
	bl.d L_8e3d08
L_8e3bde:
	mov_s r0,r13
L_8e3be0:
	b_s L_8e3c38
L_8e3be2:
	bl.d L_8cc3dc
L_8e3be6:
	ldb r0,[r13, 0x35]
L_8e3bea:
	mov_s r1,0x1013f38
L_8e3bf0:
	mov_s r14,r0
L_8e3bf2:
	mov_s r0,0x2d
L_8e3bf4:
	bl.d L_8dcc10
L_8e3bf8:
	ldb r2,[r13, 0x35]
L_8e3bfc:
	mov_s r0,r14
L_8e3bfe:
	add r0,r0,0x234
L_8e3c02:
	ld_s r1,[r0]
L_8e3c04:
	ld_s r2,[r1,0x4]
L_8e3c06:
	jl_s.d [r2]
L_8e3c08:
	mov_s r1,r13
L_8e3c0a:
	b_s L_8e3c38
L_8e3c0c:
	bl.d L_8c1e08
L_8e3c10:
	mov_s r0,r13
L_8e3c12:
	b_s L_8e3c38
L_8e3c14:
	mov_s r1,0x1013f5c
L_8e3c1a:
	mov_s r0,0x2d
L_8e3c1c:
	bl.d L_8dcc10
L_8e3c20:
	ldb r2,[r13, 0x35]
L_8e3c24:
	bl.d L_8c21e0
L_8e3c28:
	mov_s r0,r13
L_8e3c2a:
	b_s L_8e3c38
	.global L_8e3c2c
L_8e3c2c:
	mov_s r1,0x1013f80
L_8e3c32:
	bl.d L_8dcc10
L_8e3c36:
	mov_s r0,0x1d
	.global L_8e3c38
L_8e3c38:
	b L_8c0254
