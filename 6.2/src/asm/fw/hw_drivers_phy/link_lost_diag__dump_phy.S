/* link_lost_diag__dump_phy @ 0x8d2660, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG PHY: AGC_START=%d    ina_rssi_adc_db=%d    ina_rssi_adc_db_sfd_locked=%d
 *   DEBUG PHY: phy_rx_signal_gain_adc_db=%d    phy_rx_signal_gain_adc_db_sfd_locked=%d
 *   DEBUG PHY: Last recieved Packet LDPC iter header = 0x%x, data_total = 0x%x
 * Зовут его: link_lost_diag__dump_false_alarms
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_phy
link_lost_diag__dump_phy:
	.global L_8d2660
L_8d2660:
	push_s blink
L_8d2662:
	push_s r13
L_8d2664:
	mov_s r0,0x883100
L_8d266a:
	ld_s r2,[r0,0x2c]
L_8d266c:
	mov_s r13,0x883800
L_8d2672:
	ld r3,[r13, -0x100]
L_8d2676:
	mov_s r1,0x101da44
L_8d267c:
	ld r4,[r13, -0xf8]
L_8d2680:
	mov_s r0,0x20
L_8d2682:
	bl.d L_8dcd00
L_8d2686:
	bmsk_s r2,r2,0x5
L_8d2688:
	ld_s r2,[r13,0x30]
L_8d268a:
	ld_s r3,[r13,0x30]
L_8d268c:
	mov_s r1,0x101da94
L_8d2692:
	lsr_s r3,r3,0xe
L_8d2694:
	mov_s r0,0x20
L_8d2696:
	bmsk_s r2,r2,0x6
L_8d2698:
	bl.d L_8dcc80
L_8d269c:
	bmsk_s r3,r3,0x6
L_8d269e:
	ld.as r2,[r13,0xa1]
L_8d26a2:
	mov_s r1,0x101dae8
L_8d26a8:
	ld.as r3,[r13,0xa1]
L_8d26ac:
	extb_s r2,r2
L_8d26ae:
	lsr_s r3,r3,0x8
L_8d26b0:
	bmsk_s r3,r3,0x15
L_8d26b2:
	bl.d L_8dcc80
L_8d26b6:
	mov_s r0,0x20
L_8d26b8:
	b L_8c025c
