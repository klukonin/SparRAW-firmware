/* __st_r24_to_r13 @ 0x8c01bc, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_rfc_read_calibrate, hwf_vga_dc__calibrate, update_rf_xx_gains_tables
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global __st_r24_to_r13
__st_r24_to_r13:
	.global L_8c01bc
L_8c01bc:
	st.a r24,[sp,-0x4]
