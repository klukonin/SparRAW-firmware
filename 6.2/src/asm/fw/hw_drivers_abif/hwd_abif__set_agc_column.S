/* hwd_abif__set_agc_column @ 0x8cf080, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_coarse, hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__rx_table_config_vga_dc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__set_agc_column
hwd_abif__set_agc_column:
	.global L_8cf080
L_8cf080:
	push_s blink
L_8cf082:
	bl L_8c01d8
L_8cf086:
	mov_s r17,r0
L_8cf088:
	mov_s r16,r1
L_8cf08a:
	mov_s r15,r2
L_8cf08c:
	mov_s r14,0x1
L_8cf08e:
	mov_s r13,0x4
	.global L_8cf090
L_8cf090:
	sub_s r0,r15,0x1
L_8cf092:
	ldb_s r3,[r0,r14]
L_8cf094:
	mov_s r0,r17
L_8cf096:
	mov_s r1,r14
L_8cf098:
	bl.d L_8cf36c
L_8cf09c:
	mov_s r2,r16
L_8cf09e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cf0a0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cf0a2:
	brhs.d r13,0x1,L_8cf090
L_8cf0a6:
	extb_s r14,r14
L_8cf0a8:
	b L_8c023c
