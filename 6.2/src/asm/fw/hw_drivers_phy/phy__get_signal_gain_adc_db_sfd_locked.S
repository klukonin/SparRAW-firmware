/* phy__get_signal_gain_adc_db_sfd_locked @ 0x8d25d8, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_signal_gain_adc_db_sfd_locked
phy__get_signal_gain_adc_db_sfd_locked:
	.global L_8d25d8
L_8d25d8:
	mov_s r0,0x883800
L_8d25de:
	ld_s r0,[r0,0x30]
L_8d25e0:
	lsr_s r0,r0,0xe
L_8d25e2:
	j_s.d [blink]
L_8d25e4:
	bmsk_s r0,r0,0x6
L_8d25e6:
	nop_s
