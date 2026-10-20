/* hwd_abif__config_vga_rows @ 0x8cf0ac, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_row_step
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__rx_table_index_force_mode, hwd_abif_rx_table_config_vga_gain
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__config_vga_rows
hwd_abif__config_vga_rows:
	.global L_8cf0ac
L_8cf0ac:
	push_s blink
L_8cf0ae:
	bl L_8c01d8
L_8cf0b2:
	mov_s r16,r0
L_8cf0b4:
	mov_s r17,r1
L_8cf0b6:
	mov_s r14,0x1
L_8cf0b8:
	mov_s r13,0x4
	.global L_8cf0ba
L_8cf0ba:
	sub r15,r17,0x20
L_8cf0be:
	add_s r3,r15,r14
L_8cf0c0:
	mov_s r0,r16
L_8cf0c2:
	mov_s r1,r14
L_8cf0c4:
	mov_s r2,0x0
L_8cf0c6:
	bl.d L_8cf418
L_8cf0ca:
	ldb_s r3,[r3,0x1f]
L_8cf0cc:
	add_s r15,r15,r14
L_8cf0ce:
	ldb_s r3,[r15,0x1f]
L_8cf0d0:
	mov_s r0,r16
L_8cf0d2:
	mov_s r1,r14
L_8cf0d4:
	bl.d L_8cf418
L_8cf0d8:
	mov_s r2,0x1
L_8cf0da:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cf0dc:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cf0de:
	brhs.d r13,0x1,L_8cf0ba
L_8cf0e2:
	extb_s r14,r14
L_8cf0e4:
	mov_s r0,0x0
L_8cf0e6:
	bl.d L_8cf5a8
L_8cf0ea:
	mov_s r1,r0
L_8cf0ec:
	mov_s r0,0x1
L_8cf0ee:
	bl.d L_8cf5a8
L_8cf0f2:
	mov_s r1,r16
L_8cf0f4:
	b L_8c023c
