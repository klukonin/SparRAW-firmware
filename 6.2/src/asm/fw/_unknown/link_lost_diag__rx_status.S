/* link_lost_diag__rx_status @ 0x8f4680, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RX status: OK, %d packets received during last msec
 *   RX status: no packets received during last msec.
 *   High FALSE ALARM rate is detected: INA ratio is %d/msec.
 *   High FALSE ALARM rate is detected: SFD ratio is %d/msec.
 * Зовут его: link_lost_diag_part2
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit1, hwd_phy__rx_statistics_clear, hwd_phy__rx_statistics_lock, phy__read_rx_counters
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__rx_status
link_lost_diag__rx_status:
	.global L_8f4680
L_8f4680:
	push_s blink
L_8f4682:
	push_s r13
L_8f4684:
	bl.d L_8d2ae4
L_8f4688:
	sub_s sp,sp,0x38
L_8f468a:
	mov_s r0,0x13880
L_8f4690:
	mov lp_count,r0
L_8f4694:
	nop_s
L_8f4696:
	lp L_8f469e
L_8f469a:
	nop_s
L_8f469c:
	nop_s
	.global L_8f469e
L_8f469e:
	bl.d L_8d2b00
L_8f46a2:
	mov_s r13,sp
L_8f46a4:
	bl.d L_8d25e8
L_8f46a8:
	mov_s r0,r13
L_8f46aa:
	ld_s r2,[sp,0x28]
L_8f46ac:
	breq_s r2,0,L_8f46b6
L_8f46ae:
	mov_s r1,0x101b284
L_8f46b4:
	b_s L_8f46e6
	.global L_8f46b6
L_8f46b6:
	mov_s r1,0x101b2b8
L_8f46bc:
	bl.d L_8dcba8
L_8f46c0:
	mov_s r0,0x20
L_8f46c2:
	bl.d L_8d25e8
L_8f46c6:
	mov_s r0,r13
L_8f46c8:
	ld_s r2,[sp,0x1c]
L_8f46ca:
	brlo r2,0x3,L_8f46da
L_8f46ce:
	mov_s r1,0x101b2ec
L_8f46d4:
	bl.d L_8dcc10
L_8f46d8:
	mov_s r0,0x20
	.global L_8f46da
L_8f46da:
	ld_s r2,[sp,0x20]
L_8f46dc:
	brlo r2,0x3,L_8f46ec
L_8f46e0:
	mov_s r1,0x101b328
	.global L_8f46e6
L_8f46e6:
	bl.d L_8dcc10
L_8f46ea:
	mov_s r0,0x20
	.global L_8f46ec
L_8f46ec:
	b.d L_8c025c
L_8f46f0:
	add_s sp,sp,0x38
L_8f46f2:
	nop_s
