/* obj__store3 @ 0x8d5ebc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: obj__store3_wrap
 */
	.section .text.obj__store3,"ax",@progbits
	.global obj__store3
obj__store3:
	.global L_8d5ebc
L_8d5ebc:
	st_s r1,[r0]
L_8d5ebe:
	st_s r2,[r0,0x4]
L_8d5ec0:
	j_s.d [blink]
L_8d5ec2:
	st_s r3,[r0,0x8]
