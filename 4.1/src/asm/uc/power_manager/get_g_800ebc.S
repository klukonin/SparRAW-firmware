/* get_g_800ebc @ 0x92b2d4, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi_manager__assert_line42
 */
	.section .text.get_g_800ebc,"ax",@progbits
	.global get_g_800ebc
get_g_800ebc:
L_92b2d4:
	/* brhs r1,0x6,0x0092b2f0 */
	.byte 0x1d,0x09,0x95,0x01
L_92b2d8:
	ld.as r2,[0x800ebc,r1]
