/* tsf_is_before @ 0x8db268, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: parse_ese
 */
	.section .text.tsf_is_before,"ax",@progbits
	.global tsf_is_before
tsf_is_before:
	.global L_8db268
L_8db268:
	sub_s r1,r1,r2
L_8db26a:
	cmp_s r1,0x80000000
L_8db270:
	mov_s r0,0x1
L_8db272:
	j_s.d [blink]
L_8db274:
	sub.ls r0,r0,r0
