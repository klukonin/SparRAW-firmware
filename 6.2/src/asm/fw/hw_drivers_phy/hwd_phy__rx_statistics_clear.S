/* hwd_phy__rx_statistics_clear @ 0x8d2ae4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, fw_sysapi_mgr__phy_rx_statistics_cmd_start, link_lost_diag__rx_status, phy_stats__dump
 * Зовёт сам: u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_statistics_clear
hwd_phy__rx_statistics_clear:
	.global L_8d2ae4
L_8d2ae4:
	push_s blink
L_8d2ae6:
	mov_s r1,0x1
L_8d2ae8:
	mov_s r0,0x883900
L_8d2aee:
	st_s r1,[r0,0x60]
L_8d2af0:
	bl L_8e9524
L_8d2af4:
	mov_s r1,0x800524
L_8d2afa:
	st_s r0,[r1]
L_8d2afc:
	pop_s blink
L_8d2afe:
	j_s [blink]
