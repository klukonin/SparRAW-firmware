/* link_lost_diag__rx_status @ 0x8d4600, 120 байт.  Сгенерировано gen_asm_tree.py
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
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit1, hwd_phy__set_883900, hwd_phy__snapshot_status, set_reg_88395c
 */
	.section .text.link_lost_diag__rx_status,"ax",@progbits
	.global link_lost_diag__rx_status
link_lost_diag__rx_status:
	.global L_8d4600
L_8d4600:
	push_s blink
L_8d4602:
	push_s r13
L_8d4604:
	bl.d L_8cfc80
L_8d4608:
	sub_s sp,sp,0x38
L_8d460a:
	mov_s r0,0x13880
L_8d4610:
	mov lp_count,r0
L_8d4614:
	nop_s
L_8d4616:
	lp L_8d461e
L_8d461a:
	nop_s
L_8d461c:
	nop_s
	.global L_8d461e
L_8d461e:
	bl.d L_8cfc9c
L_8d4622:
	mov_s r13,sp
L_8d4624:
	bl.d L_8cf8e8
L_8d4628:
	mov_s r0,r13
L_8d462a:
	ld_s r3,[sp,0x28]
L_8d462c:
	breq_s r3,0,L_8d4636
L_8d462e:
	mov_s r2,0x1016ae4
L_8d4634:
	b_s L_8d466a
	.global L_8d4636
L_8d4636:
	mov_s r2,0x1016b18
L_8d463c:
	mov_s r0,0x0
L_8d463e:
	bl.d L_8edfb0
L_8d4642:
	mov_s r1,0x2
L_8d4644:
	bl.d L_8cf8e8
L_8d4648:
	mov_s r0,r13
L_8d464a:
	ld_s r3,[sp,0x1c]
L_8d464c:
	brlo r3,0x3,L_8d465e
L_8d4650:
	mov_s r2,0x1016b4c
L_8d4656:
	mov_s r0,0x0
L_8d4658:
	bl.d L_8edfcc
L_8d465c:
	mov_s r1,0x2
	.global L_8d465e
L_8d465e:
	ld_s r3,[sp,0x20]
L_8d4660:
	brlo r3,0x3,L_8d4672
L_8d4664:
	mov_s r2,0x1016b88
	.global L_8d466a
L_8d466a:
	mov_s r0,0x0
L_8d466c:
	bl.d L_8edfcc
L_8d4670:
	mov_s r1,0x2
	.global L_8d4672
L_8d4672:
	b.d L_8c033c
L_8d4676:
	add_s sp,sp,0x38
