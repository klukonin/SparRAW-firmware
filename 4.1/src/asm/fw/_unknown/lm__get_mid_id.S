/* lm__get_mid_id @ 0x8ca1a8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__OPEN, lm_main_sm__on_maintain_started, maintain_sm__lock_radio, maintain_sm__on_start_maintain
 * Зовёт сам: lm_if__get_mid_id
 */
	.section .text.lm__get_mid_id,"ax",@progbits
	.global lm__get_mid_id
lm__get_mid_id:
	.global L_8ca1a8
L_8ca1a8:
	b.d L_8ca1e8
L_8ca1ac:
	ld_s r0,[r0,0x2c]
L_8ca1ae:
	nop_s
