/* psc__set_two_flags @ 0x8cd098, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete_8e1794
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc__set_two_flags
psc__set_two_flags:
	.global L_8cd098
L_8cd098:
	mov_s r0,0x1
L_8cd09a:
	stb_s r0,[r1]
L_8cd09c:
	j_s.d [blink]
L_8cd09e:
	stb_s r0,[r1,0x1]
