/* hwd_abif__tx_table_index_force_val_get @ 0x8cff3c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_calib__acquire_hw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_index_force_val_get
hwd_abif__tx_table_index_force_val_get:
	.global L_8cff3c
L_8cff3c:
	mov_s r0,0x88a000
L_8cff42:
	ld_s r0,[r0]
L_8cff44:
	lsr_s r0,r0
L_8cff46:
	j_s.d [blink]
L_8cff48:
	bmsk_s r0,r0,0x4
L_8cff4a:
	nop_s
