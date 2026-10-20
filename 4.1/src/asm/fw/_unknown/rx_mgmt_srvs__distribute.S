/* rx_mgmt_srvs__distribute @ 0x8df014, 212 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX MGMT SRVS: Distribute MLME packet subtype 0x%X to MID %d
 *   Distribute MGMT PROBE pkt mid %d
 *   Distribute ACTION pkt mid %d
 *   Distribute ACTION NO ACK pkt mid %d
 *   <<---- [HOST EVENT] WMI_RX_MGMT_PACKET_EVENTID UNHANDLED MGMT, sub type = 0x%x !!!!
 * Зовут его: rx_pkt_srvs__dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, fw_log__emit2, log_hexdump, mid_list__by_mid, operational_if__send_evt, rx_mgmt__action_no_ack, rx_pkt_handler, stream_mgr__rx_action
 */
	.section .text.rx_mgmt_srvs__distribute,"ax",@progbits
	.global rx_mgmt_srvs__distribute
rx_mgmt_srvs__distribute:
	.global L_8df014
L_8df014:
	push_s blink
L_8df016:
	bl L_8c02c0
L_8df01a:
	ld_s r0,[r1,0x8]
L_8df01c:
	mov_s r13,r1
L_8df01e:
	ldw_s r3,[r0]
L_8df020:
	lsr_s r3,r3,0x4
L_8df022:
	bmsk_s r3,r3,0x3
L_8df024:
	brhs.d r3,0xf,L_8df0b0
L_8df028:
	add r14,r1,0x20
L_8df02c:
	ldb.x r10,[0x802624,r3]
L_8df034:
	add r0,pcl,0xa
L_8df038:
	add1 r0,r0,r10
L_8df03c:
	j_s [r0]
L_8df03e:
	mov_s r2,0x10109c8
L_8df044:
	ldb r4,[r14, 0x15]
L_8df048:
	mov_s r0,0xd
L_8df04a:
	bl.d L_8edff8
L_8df04e:
	mov_s r1,0x2
L_8df050:
	bl.d L_8df208
L_8df054:
	mov_s r0,r13
L_8df056:
	b_s L_8df0e2
L_8df058:
	bl.d L_8ca1b0
L_8df05c:
	ldb_s r0,[r14,0x15]
L_8df05e:
	mov_s r2,0x1010a04
L_8df064:
	mov_s r15,r0
L_8df066:
	mov_s r0,0xd
L_8df068:
	mov_s r1,0x2
L_8df06a:
	bl.d L_8edfcc
L_8df06e:
	ldb_s r3,[r14,0x15]
L_8df070:
	mov_s r0,r15
L_8df072:
	add r0,r0,0x234
L_8df076:
	ld_s r1,[r0]
L_8df078:
	ld_s r2,[r1,0x4]
L_8df07a:
	jl_s.d [r2]
L_8df07c:
	mov_s r1,r13
L_8df07e:
	b_s L_8df0e2
L_8df080:
	mov_s r2,0x1010a28
L_8df086:
	mov_s r0,0xd
L_8df088:
	mov_s r1,0x2
L_8df08a:
	bl.d L_8edfcc
L_8df08e:
	ldb_s r3,[r14,0x15]
L_8df090:
	bl.d L_8c1b44
L_8df094:
	mov_s r0,r13
L_8df096:
	b_s L_8df0e2
L_8df098:
	mov_s r2,0x1010a48
L_8df09e:
	mov_s r0,0xd
L_8df0a0:
	mov_s r1,0x2
L_8df0a2:
	bl.d L_8edfcc
L_8df0a6:
	ldb_s r3,[r14,0x15]
L_8df0a8:
	bl.d L_8c1d5c
L_8df0ac:
	mov_s r0,r13
L_8df0ae:
	b_s L_8df0e2
	.global L_8df0b0
L_8df0b0:
	mov_s r2,0x1010a6c
L_8df0b6:
	mov_s r0,0xd
L_8df0b8:
	bl.d L_8edfcc
L_8df0bc:
	mov_s r1,0x1
L_8df0be:
	ld_s r0,[r13,0x14]
L_8df0c0:
	bl.d L_8c7f90
L_8df0c4:
	ld_s r1,[r13,0x30]
L_8df0c6:
	ld_s r2,[r13,0x30]
L_8df0c8:
	add r0,r13,0x28
L_8df0cc:
	add_s r2,r2,0x10
L_8df0ce:
	extw_s r2,r2
L_8df0d0:
	mov_s r1,0x61
L_8df0d2:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8df0d4:
	ldb_s r3,[r14,0x15]
L_8df0d6:
	mov r4,0x1
L_8df0da:
	bl.d L_8e0874
L_8df0de:
	mov r5,0x0
	.global L_8df0e2
L_8df0e2:
	b L_8c032c
L_8df0e6:
	nop_s
