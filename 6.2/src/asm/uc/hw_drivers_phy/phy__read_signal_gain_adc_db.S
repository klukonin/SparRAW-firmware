/* phy__read_signal_gain_adc_db @ 0x929b74, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy__signal_gain_adc_in_range
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global phy__read_signal_gain_adc_db
phy__read_signal_gain_adc_db:
	.global L_929b74
L_929b74:
	ld r0,[0x883830]
L_929b7c:
	j.d [blink]
L_929b80:
	bmsk_s r0,r0,0x6
L_929b82:
	nop_s
