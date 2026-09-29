/* obj__store3 @ 0x8d8fdc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj__store3_thunk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj__store3
obj__store3:
	.global L_8d8fdc
L_8d8fdc:
	st_s r1,[r0]
L_8d8fde:
	st_s r2,[r0,0x4]
L_8d8fe0:
	j_s.d [blink]
L_8d8fe2:
	st_s r3,[r0,0x8]
