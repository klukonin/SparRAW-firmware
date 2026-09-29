/* aw__set_tbtt_offset @ 0x930488, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw__set_new_tbtt
 */
	.section .text.aw__set_tbtt_offset,"ax",@progbits
	.global aw__set_tbtt_offset
aw__set_tbtt_offset:
	.global L_930488
L_930488:
	stw_s r1,[r0,0x10]
L_93048a:
	mul64 r1,0xa5
L_93048e:
	j_s.d [blink]
L_930490:
	st mlo,[r0, 0xc]
