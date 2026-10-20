/* softfloat_df_sub @ 0x920960, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: softfloat_df_add
 */
	.section .text.softfloat_df_sub,"ax",@progbits
	.global softfloat_df_sub
softfloat_df_sub:
L_920960:
	xor r1,r1,0x80000000
L_920968:
	b L_920974
