/* softfloat_negate_r3 @ 0x92096c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: abft_responder__tx_ssw
 */
	.section .text.softfloat_negate_r3,"ax",@progbits
	.global softfloat_negate_r3
softfloat_negate_r3:
	.global L_92096c
L_92096c:
	xor r3,r3,0x80000000
