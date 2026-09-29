/* phy__get_signal_gain_adc_db @ 0x8d25cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_signal_gain_adc_db
phy__get_signal_gain_adc_db:
	.global L_8d25cc
L_8d25cc:
	mov_s r0,0x883800
L_8d25d2:
	ld_s r0,[r0,0x30]
L_8d25d4:
	j_s.d [blink]
L_8d25d6:
	bmsk_s r0,r0,0x6
