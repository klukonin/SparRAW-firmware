/* uc_ret_minus1 @ 0x921168, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_ret_minus1,"ax",@progbits
	.global uc_ret_minus1
uc_ret_minus1:
	.byte 0x03
	.byte 0x00
	.global sub_92116a
sub_92116a:
L_92116a:
	j_s.d [blink]
L_92116c:
	mov r0,-0x1
