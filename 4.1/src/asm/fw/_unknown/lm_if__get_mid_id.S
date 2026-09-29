/* lm_if__get_mid_id @ 0x8ca1e8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm__get_mid_id
 */
	.section .text.lm_if__get_mid_id,"ax",@progbits
	.global lm_if__get_mid_id
lm_if__get_mid_id:
	.global L_8ca1e8
L_8ca1e8:
	ld_s r0,[r0,0x4]
L_8ca1ea:
	ld_s r0,[r0,0xc]
L_8ca1ec:
	j_s.d [blink]
L_8ca1ee:
	ldb_s r0,[r0,0x10]
