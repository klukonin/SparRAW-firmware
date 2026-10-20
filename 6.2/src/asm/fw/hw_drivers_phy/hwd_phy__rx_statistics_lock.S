/* hwd_phy__rx_statistics_lock @ 0x8d2b00, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, link_lost_diag__rx_status, phy_stats__dump
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_statistics_lock
hwd_phy__rx_statistics_lock:
	.global L_8d2b00
L_8d2b00:
	mov_s r1,0x1
L_8d2b02:
	mov_s r0,0x883900
L_8d2b08:
	st_s r1,[r0,0x5c]
L_8d2b0a:
	j_s [blink]
