/* bf_w_s2_w2 @ 0x8e84a4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_indirect__write_entry, mid__set_default_dmg_params, rf_chain__program_sector_desc, vring__write_macq_desc, vring_ba__fill_fields
 * Зовёт сам: bf_word_set
 */
	.section .text.bf_w_s2_w2,"ax",@progbits
	.global bf_w_s2_w2
bf_w_s2_w2:
	.global L_8e84a4
L_8e84a4:
	mov r10,0x2
L_8e84a8:
	b.d L_8e8910
L_8e84ac:
	mov r11,0x1
