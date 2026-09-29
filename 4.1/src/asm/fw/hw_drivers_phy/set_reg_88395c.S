/* set_reg_88395c @ 0x8cfc9c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST, link_lost_diag__rx_status, phy_monitor__task_step
 */
	.section .text.set_reg_88395c,"ax",@progbits
	.global set_reg_88395c
set_reg_88395c:
	.global L_8cfc9c
L_8cfc9c:
	mov_s r1,0x1
L_8cfc9e:
	mov_s r0,0x883900
L_8cfca4:
	st_s r1,[r0,0x5c]
L_8cfca6:
	j_s [blink]
