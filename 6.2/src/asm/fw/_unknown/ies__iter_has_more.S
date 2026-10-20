/* ies__iter_has_more @ 0x8cdcd0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ies__scan_for_match
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ies__iter_has_more
ies__iter_has_more:
	.global L_8cdcd0
L_8cdcd0:
	ld_s r0,[r0]
L_8cdcd2:
	sub.f r0,r0,0x0
L_8cdcd6:
	j_s.d [blink]
L_8cdcd8:
	mov.ne r0,0x1
