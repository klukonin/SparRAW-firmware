/* frame__bits_set16_s6_w10 @ 0x8ed1cc, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frame__build_addba_req, frame__build_addba_resp
 * Зовёт сам: bf__set_field_u16_le
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__bits_set16_s6_w10
frame__bits_set16_s6_w10:
	.global L_8ed1cc
L_8ed1cc:
	mov r10,0x6
L_8ed1d0:
	b.d L_8edc34
L_8ed1d4:
	mov r11,0x9
