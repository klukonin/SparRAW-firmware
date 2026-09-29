/* link_lost_diag__dump_phy @ 0x8cf988, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG PHY: AGC_START=%d    ina_rssi_adc_db=%d    ina_rssi_adc_db_sfd_locked=%d
 *   DEBUG PHY: phy_rx_signal_gain_adc_db=%d    phy_rx_signal_gain_adc_db_sfd_locked=%d
 *   DEBUG PHY: Last recieved Packet LDPC iter header = 0x%x, data_total = 0x%x
 * Зовут его: link_lost_diag__dump_false_alarms
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit2, fw_log__emit3
 */
	.section .text.link_lost_diag__dump_phy,"ax",@progbits
	.global link_lost_diag__dump_phy
link_lost_diag__dump_phy:
	.global L_8cf988
L_8cf988:
	push_s blink
L_8cf98a:
	bl.d L_8c02c4
L_8cf98e:
	mov_s r1,0x2
L_8cf990:
	mov_s r0,0x883100
L_8cf996:
	ld_s r3,[r0,0x2c]
L_8cf998:
	mov_s r13,0x883800
L_8cf99e:
	ld r4,[r13, -0x100]
L_8cf9a2:
	mov_s r2,0x1018888
L_8cf9a8:
	ld r5,[r13, -0xf8]
L_8cf9ac:
	mov_s r0,0x0
L_8cf9ae:
	bl.d L_8ee034
L_8cf9b2:
	bmsk_s r3,r3,0x5
L_8cf9b4:
	ld_s r3,[r13,0x30]
L_8cf9b6:
	ld_s r14,[r13,0x30]
L_8cf9b8:
	mov_s r2,0x10188d8
L_8cf9be:
	lsr_s r14,r14,0xe
L_8cf9c0:
	mov_s r0,0x0
L_8cf9c2:
	mov_s r1,0x2
L_8cf9c4:
	bmsk_s r3,r3,0x6
L_8cf9c6:
	bl.d L_8edff8
L_8cf9ca:
	bmsk r4,r14,0x6
L_8cf9ce:
	ld.as r3,[r13,0xa1]
L_8cf9d2:
	mov_s r2,0x101892c
L_8cf9d8:
	ld.as r13,[r13,0xa1]
L_8cf9dc:
	extb_s r3,r3
L_8cf9de:
	lsr_s r13,r13,0x8
L_8cf9e0:
	bmsk r4,r13,0x15
L_8cf9e4:
	mov_s r0,0x0
L_8cf9e6:
	bl.d L_8edff8
L_8cf9ea:
	mov_s r1,0x2
L_8cf9ec:
	b L_8c0334
