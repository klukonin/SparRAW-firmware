/* hwd_abif__rx_rgf_sar_dc_load @ 0x8cefc8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib_sar_step
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__rx_rgf_sar_dc_load
hwd_abif__rx_rgf_sar_dc_load:
	.global L_8cefc8
L_8cefc8:
	mov_s r1,0x88a200
L_8cefce:
	ld_s r0,[r1,0x4]
L_8cefd0:
	bclr_s r0,r0,0x0
L_8cefd2:
	st_s r0,[r1,0x4]
L_8cefd4:
	ld_s r0,[r1,0x4]
L_8cefd6:
	bset_s r0,r0,0x0
L_8cefd8:
	st_s r0,[r1,0x4]
L_8cefda:
	j_s [blink]
