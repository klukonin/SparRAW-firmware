/* psc__set_two_flags @ 0x8cad48, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete
 */
	.section .text.psc__set_two_flags,"ax",@progbits
	.global psc__set_two_flags
psc__set_two_flags:
	.global L_8cad48
L_8cad48:
	mov_s r0,0x1
L_8cad4a:
	stb_s r0,[r1]
L_8cad4c:
	j_s.d [blink]
L_8cad4e:
	stb_s r0,[r1,0x1]
