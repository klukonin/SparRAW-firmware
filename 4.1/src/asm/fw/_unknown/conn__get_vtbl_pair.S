/* conn__get_vtbl_pair @ 0x8c9f60, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__get_vtbl_pair_at28
 */
	.section .text.conn__get_vtbl_pair,"ax",@progbits
	.global conn__get_vtbl_pair
conn__get_vtbl_pair:
	.global L_8c9f60
L_8c9f60:
	ld r2,[r0, 0xd0]
L_8c9f64:
	st_s r2,[r1]
L_8c9f66:
	j_s.d [blink]
L_8c9f68:
	ld r0,[r0, 0xd4]
