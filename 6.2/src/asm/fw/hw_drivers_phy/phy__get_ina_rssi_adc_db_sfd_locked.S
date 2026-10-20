/* phy__get_ina_rssi_adc_db_sfd_locked @ 0x8d2654, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__get_ina_rssi_adc_db_sfd_locked
phy__get_ina_rssi_adc_db_sfd_locked:
	.global L_8d2654
L_8d2654:
	mov_s r0,0x883700
L_8d265a:
	ld_s r0,[r0,0x8]
L_8d265c:
	j_s.d [blink]
L_8d265e:
	bmsk_s r0,r0,0x5
