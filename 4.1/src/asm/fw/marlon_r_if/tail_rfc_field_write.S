/* tail_rfc_field_write @ 0x8e8008, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: marlon_r_if__write_verify, marlon_r_if__write_via_rfc
 * Зовёт сам: rfc_field_write
 */
	.section .text.tail_rfc_field_write,"ax",@progbits
	.global tail_rfc_field_write
tail_rfc_field_write:
	.global L_8e8008
L_8e8008:
	mov_s r0,0x0
L_8e800a:
	mov_s r1,r2
L_8e800c:
	b.d L_8d113c
L_8e8010:
	mov_s r2,r3
L_8e8012:
	nop_s
