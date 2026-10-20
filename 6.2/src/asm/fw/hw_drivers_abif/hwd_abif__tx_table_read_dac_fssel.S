/* hwd_abif__tx_table_read_dac_fssel @ 0x8cff4c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   UT_HW_DRIVERS_SUBTYPE_ABIF_TX_TABLE_READ_DAC_FSSEL: dac_fssel=[%d]
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: fw_log_emit1
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_read_dac_fssel
hwd_abif__tx_table_read_dac_fssel:
	.global L_8cff4c
L_8cff4c:
	mov_s r2,0x88a004
L_8cff52:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8cff54:
	ld.as r2,[r2,r0]
L_8cff58:
	bmsk_s r2,r2,0x6
L_8cff5a:
	st_s r2,[r1]
L_8cff5c:
	mov_s r1,0x101f068
L_8cff62:
	b.d L_8dcc10
L_8cff66:
	mov_s r0,0x21
