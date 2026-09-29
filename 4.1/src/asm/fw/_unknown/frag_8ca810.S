/* frag_8ca810 @ 0x8ca810, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fill_statistics_to_host
 */
	.section .text.frag_8ca810,"ax",@progbits
	.global frag_8ca810
frag_8ca810:
	.global L_8ca810
L_8ca810:
	b.d L_8ca818
L_8ca814:
	add_s r0,r0,0x34
L_8ca816:
	nop_s
	.global L_8ca818
L_8ca818:
	b.d L_8ca820
L_8ca81c:
	add_s r0,r0,0x50
L_8ca81e:
	nop_s
	.global L_8ca820
L_8ca820:
	j_s.d [blink]
L_8ca822:
	ld_s r0,[r0,0x4c]
