/* hwd_phy__dbg_clk_enable_get @ 0x8d1c20, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, channel_estimation_cmd_start, hwd_phy_rx_read_and_parse_brp_ram, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__dbg_clk_enable_get
hwd_phy__dbg_clk_enable_get:
	.global L_8d1c20
L_8d1c20:
	mov_s r0,0x883d00
L_8d1c26:
	ld_s r0,[r0,0x60]
L_8d1c28:
	bxor r0,r0,0x0
L_8d1c2c:
	j_s.d [blink]
L_8d1c2e:
	bmsk_s r0,r0,0x0
