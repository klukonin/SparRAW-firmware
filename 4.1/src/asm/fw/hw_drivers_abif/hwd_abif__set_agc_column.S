/* hwd_abif__set_agc_column @ 0x8cc050, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_vga_coarse, hwf_calib_bb_gain_rows
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__set_agc_field
 */
	.section .text.hwd_abif__set_agc_column,"ax",@progbits
	.global hwd_abif__set_agc_column
hwd_abif__set_agc_column:
	.global L_8cc050
L_8cc050:
	push_s blink
L_8cc052:
	bl L_8c02b8
L_8cc056:
	mov_s r17,r0
L_8cc058:
	mov_s r16,r1
L_8cc05a:
	mov_s r15,r2
L_8cc05c:
	mov_s r14,0x1
L_8cc05e:
	mov_s r13,0x4
	.global L_8cc060
L_8cc060:
	sub_s r0,r15,0x1
L_8cc062:
	ldb_s r3,[r0,r14]
L_8cc064:
	mov_s r0,r17
L_8cc066:
	mov_s r1,r14
L_8cc068:
	bl.d L_8cc3c8
L_8cc06c:
	mov_s r2,r16
L_8cc06e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8cc070:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cc072:
	brhs.d r13,0x1,L_8cc060
L_8cc076:
	extb_s r14,r14
L_8cc078:
	b L_8c031c
