/* phy__read_signal_gain_adc_db_sfd_locked @ 0x929b84, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__latch_phy_8014e8__930da4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy__read_signal_gain_adc_db_sfd_locked
phy__read_signal_gain_adc_db_sfd_locked:
	.global L_929b84
L_929b84:
	ld r0,[0x883830]
L_929b8c:
	lsr_s r0,r0,0xe
L_929b8e:
	j_s.d [blink]
L_929b90:
	bmsk_s r0,r0,0x6
L_929b92:
	nop_s
