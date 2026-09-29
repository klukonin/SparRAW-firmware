/* bf_w_s16_w5 @ 0x8e83d8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if_send_cmd_0x07, rf_chain__program_sector_desc, tx_desc__build_b
 * Зовёт сам: bf_word_set
 */
	.section .text.bf_w_s16_w5,"ax",@progbits
	.global bf_w_s16_w5
bf_w_s16_w5:
	.global L_8e83d8
L_8e83d8:
	mov r10,0x10
L_8e83dc:
	b.d L_8e8910
L_8e83e0:
	mov r11,0x4
