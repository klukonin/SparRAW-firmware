/* bf_w_s4_w5 @ 0x8e8504, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_indirect__write_entry, rf_chain__program_sector_desc, vring__write_macq_desc, vring_ba__fill_fields
 * Зовёт сам: bf_word_set
 */
	.section .text.bf_w_s4_w5,"ax",@progbits
	.global bf_w_s4_w5
bf_w_s4_w5:
	.global L_8e8504
L_8e8504:
	mov r10,0x4
L_8e8508:
	b.d L_8e8910
L_8e850c:
	mov r11,0x4
