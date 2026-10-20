/* regd__is_country_us @ 0x8d7550, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: regulatory_domain_set_tx_gain_offset, rf__apply_tx_power
 * Глобалы (через gp): 0x8001fc
 */
	.section .text.regd__is_country_us,"ax",@progbits
	.global regd__is_country_us
regd__is_country_us:
	.global L_8d7550
L_8d7550:
	ld_s r0,[gp,-0xb4]
L_8d7552:
	mov_s r1,0x0
L_8d7554:
	brne_s r0,0,L_8d7560
L_8d7556:
	ldw_s r0,[gp,0x8c]
L_8d7558:
	breq r0,0x5553,L_8d7564
	.global L_8d7560
L_8d7560:
	mov_s r0,r1
L_8d7562:
	b_s L_8d7566
	.global L_8d7564
L_8d7564:
	mov_s r0,0x1
	.global L_8d7566
L_8d7566:
	j_s.d [blink]
L_8d7568:
	extb_s r0,r0
L_8d756a:
	nop_s
