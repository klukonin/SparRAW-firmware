/* ba_sm__pring_id_of_conn @ 0x8c9d84, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__prepare_ba_td
 * Зовёт сам: vring__get_pring_id
 */
	.section .text.ba_sm__pring_id_of_conn,"ax",@progbits
	.global ba_sm__pring_id_of_conn
ba_sm__pring_id_of_conn:
	.global L_8c9d84
L_8c9d84:
	b.d L_8c9d94
L_8c9d88:
	ld r0,[r0, 0xac]
