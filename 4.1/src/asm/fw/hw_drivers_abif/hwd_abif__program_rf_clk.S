/* hwd_abif__program_rf_clk @ 0x8cb9dc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__program_rf_clocks, hwm_analog_channel_switch, marlon_r_if_class__init_board_file_inteface
 * Зовёт сам: set_reg_889480
 */
	.section .text.hwd_abif__program_rf_clk,"ax",@progbits
	.global hwd_abif__program_rf_clk
hwd_abif__program_rf_clk:
	.global L_8cb9dc
L_8cb9dc:
	push_s blink
L_8cb9de:
	bl L_8cd1c8
L_8cb9e2:
	mov_s r2,0x889400
L_8cb9e8:
	ld_s r0,[r2,0x1c]
L_8cb9ea:
	mov_s r1,0x889800
L_8cb9f0:
	bic r0,r0,0x3
L_8cb9f4:
	st_s r0,[r2,0x1c]
L_8cb9f6:
	ld_s r0,[r2,0x1c]
L_8cb9f8:
	bset_s r0,r0,0x4
L_8cb9fa:
	st_s r0,[r2,0x1c]
L_8cb9fc:
	ld.as r0,[r1,-0xd7]
L_8cba00:
	bic r0,r0,0x7c0
L_8cba04:
	bset_s r0,r0,0xa
L_8cba06:
	st.as r0,[r1,-0xd7]
L_8cba0a:
	pop_s blink
L_8cba0c:
	j_s [blink]
L_8cba0e:
	nop_s
