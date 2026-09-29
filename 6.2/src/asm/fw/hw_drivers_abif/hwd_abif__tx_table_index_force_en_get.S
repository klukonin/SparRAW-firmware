/* hwd_abif__tx_table_index_force_en_get @ 0x8cfeec, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_index_force_en_get
hwd_abif__tx_table_index_force_en_get:
	.global L_8cfeec
L_8cfeec:
	mov_s r0,0x88a000
L_8cfef2:
	ld_s r0,[r0]
L_8cfef4:
	j_s.d [blink]
L_8cfef6:
	bmsk_s r0,r0,0x0
