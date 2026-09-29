/* hwd_abif__config_vga_rows @ 0x8cc07c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_row_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__rgf_88a200_8cc674, hwd_abif_rx_table_config_vga_gain
 */
	.section .text.hwd_abif__config_vga_rows,"ax",@progbits
	.global hwd_abif__config_vga_rows
hwd_abif__config_vga_rows:
	.global L_8cc07c
L_8cc07c:
	push_s blink
L_8cc07e:
	bl L_8c02b8
L_8cc082:
	mov_s r16,r0
L_8cc084:
	mov_s r17,r1
L_8cc086:
	mov_s r14,0x1
L_8cc088:
	mov_s r13,0x4
	.global L_8cc08a
L_8cc08a:
	sub r15,r17,0x20
L_8cc08e:
	add_s r3,r15,r14
L_8cc090:
	mov_s r0,r16
L_8cc092:
	mov_s r1,r14
L_8cc094:
	mov_s r2,0x0
L_8cc096:
	bl.d L_8cc4a0
L_8cc09a:
	ldb_s r3,[r3,0x1f]
L_8cc09c:
	add_s r15,r15,r14
L_8cc09e:
	ldb_s r3,[r15,0x1f]
L_8cc0a0:
	mov_s r0,r16
L_8cc0a2:
	mov_s r1,r14
L_8cc0a4:
	bl.d L_8cc4a0
L_8cc0a8:
	mov_s r2,0x1
L_8cc0aa:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cc0ac:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cc0ae:
	brhs.d r13,0x1,L_8cc08a
L_8cc0b2:
	extb_s r14,r14
L_8cc0b4:
	mov_s r0,0x0
L_8cc0b6:
	bl.d L_8cc674
L_8cc0ba:
	mov_s r1,r0
L_8cc0bc:
	mov_s r0,0x1
L_8cc0be:
	bl.d L_8cc674
L_8cc0c2:
	mov_s r1,r16
L_8cc0c4:
	b L_8c031c
