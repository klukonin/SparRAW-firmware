/* rx_pkt_srvs__dispatch @ 0x8df11c, 236 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX SRVS: pkt for mid %d type %d len %d
 *   RX SRVS: MGMT Handler pkt for mid %d %x
 *   RX MGMT: ERROR Handler pkt for mid %d
 *   rx_pkt_srvs.cpp
 * Зовут его: tail_rx_pkt_srvs__dispatch, tail_rx_pkt_srvs__dispatch_8e8570
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit1, fw_log__emit2, fw_log__emit3, fw_sysassert_fatal, hwd_phy__rgf_883000_8cf4c8, log_hexdump, mgmt_buf__free, rx_mgmt_srvs__distribute, rx_pkt__lookup_handler, rx_pkt__mid_accepts
 * Глобалы (через gp): 0x800448
 */
	.section .text.rx_pkt_srvs__dispatch,"ax",@progbits
	.global rx_pkt_srvs__dispatch
rx_pkt_srvs__dispatch:
	.global L_8df11c
L_8df11c:
	push_s blink
L_8df11e:
	bl L_8c02bc
L_8df122:
	mov_s r16,r0
L_8df124:
	ld_s r0,[r1,0x14]
L_8df126:
	mov_s r14,r1
L_8df128:
	st_s r0,[r1,0x8]
L_8df12a:
	mov_s r13,0x0
L_8df12c:
	st_s r13,[r1,0x10]
L_8df12e:
	add_s r1,r1,0x37
L_8df130:
	bl.d L_8c9f74
L_8df134:
	mov_s r0,r16
L_8df136:
	ld_s r0,[gp,-0x13c]
L_8df138:
	ld r5,[r14, 0x30]
L_8df13c:
	breq_s r0,0,L_8df14e
L_8df13e:
	ld_s r0,[r14,0x14]
L_8df140:
	bl.d L_8c7f90
L_8df144:
	mov_s r1,r5
L_8df146:
	bl.d L_8c9538
L_8df14a:
	mov_s r0,r14
L_8df14c:
	b_s L_8df204
	.global L_8df14e
L_8df14e:
	ld_s r0,[r14,0x8]
L_8df150:
	ldw_s r0,[r0]
L_8df152:
	lsr_s r0,r0,0x2
L_8df154:
	brhs.d r5,0x18,L_8df186
L_8df158:
	bmsk r4,r0,0x1
L_8df15c:
	mov_s r2,0x1010b30
L_8df162:
	mov_s r0,0xd
L_8df164:
	mov_s r1,r13
L_8df166:
	bl.d L_8ee034
L_8df16a:
	ldb r3,[r14, 0x35]
L_8df16e:
	ld_s r0,[r14,0x14]
L_8df170:
	bl.d L_8c7f90
L_8df174:
	ld_s r1,[r14,0x30]
L_8df176:
	bl.d L_8c9538
L_8df17a:
	mov_s r0,r14
L_8df17c:
	ld_s r0,[gp,0x2d8]
L_8df17e:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8df180:
	st.as r0,[gp,0xb6]
L_8df184:
	b_s L_8df204
	.global L_8df186
L_8df186:
	breq r4,0x0,L_8df1a0
L_8df18a:
	breq r4,0x1,L_8df1ca
L_8df18e:
	breq r4,0x2,L_8df1c0
L_8df192:
	brne r4,0x3,L_8df1ca
L_8df196:
	mov_s r0,r16
L_8df198:
	bl.d L_8defec
L_8df19c:
	mov_s r1,r14
L_8df19e:
	b_s L_8df204
	.global L_8df1a0
L_8df1a0:
	mov_s r2,0x1010b58
L_8df1a6:
	ld r4,[r14, 0x14]
L_8df1aa:
	mov_s r0,0xd
L_8df1ac:
	mov_s r1,0x2
L_8df1ae:
	bl.d L_8edff8
L_8df1b2:
	ldb r3,[r14, 0x35]
L_8df1b6:
	mov_s r0,r16
L_8df1b8:
	bl.d L_8df014
L_8df1bc:
	mov_s r1,r14
L_8df1be:
	b_s L_8df204
	.global L_8df1c0
L_8df1c0:
	mov_s r0,r16
L_8df1c2:
	bl.d L_8def44
L_8df1c6:
	mov_s r1,r14
L_8df1c8:
	b_s L_8df204
	.global L_8df1ca
L_8df1ca:
	mov_s r2,0x1010b80
L_8df1d0:
	mov_s r0,0xd
L_8df1d2:
	mov_s r1,0x2
L_8df1d4:
	bl.d L_8edfcc
L_8df1d8:
	ldb r3,[r14, 0x35]
L_8df1dc:
	bl.d L_8c9538
L_8df1e0:
	mov_s r0,r14
L_8df1e2:
	ld_s r0,[r14,0x14]
L_8df1e4:
	bl.d L_8c7f90
L_8df1e8:
	ld_s r1,[r14,0x30]
L_8df1ea:
	bl.d L_8cf4c8
L_8df1ee:
	mov_s r0,0x0
L_8df1f0:
	mov_s r0,blink
L_8df1f2:
	mov_s r2,0x1010aec
L_8df1f8:
	mov_s r1,0x117c
L_8df1fe:
	bl.d L_8c82c0
L_8df202:
	mov_s r3,0x9d
	.global L_8df204
L_8df204:
	b L_8c0324
