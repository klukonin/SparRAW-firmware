/* hwd_phy__set_883900 @ 0x8cfc80, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, link_lost_diag__rx_status, phy_monitor__task_step
 * Зовёт сам: fw_read_timer
 */
	.section .text.hwd_phy__set_883900,"ax",@progbits
	.global hwd_phy__set_883900
hwd_phy__set_883900:
	.global L_8cfc80
L_8cfc80:
	push_s blink
L_8cfc82:
	mov_s r1,0x1
L_8cfc84:
	mov_s r0,0x883900
L_8cfc8a:
	st_s r1,[r0,0x60]
L_8cfc8c:
	bl L_8e4694
L_8cfc90:
	mov_s r1,0x8004f4
L_8cfc96:
	st_s r0,[r1]
L_8cfc98:
	pop_s blink
L_8cfc9a:
	j_s [blink]
