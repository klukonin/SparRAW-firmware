/* ies__has_ptr @ 0x8cb68c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ies__scan_for_match
 */
	.section .text.ies__has_ptr,"ax",@progbits
	.global ies__has_ptr
ies__has_ptr:
	.global L_8cb68c
L_8cb68c:
	ld_s r0,[r0]
L_8cb68e:
	sub.f r0,r0,0x0
L_8cb692:
	j_s.d [blink]
L_8cb694:
	mov.ne r0,0x1
