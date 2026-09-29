/* ies__has_buffer @ 0x8cb668, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: app_ie__print_ies, find_main_sm__probe_req, find_main_sm__probe_req_in_search, ies_block__find_ie
 */
	.section .text.ies__has_buffer,"ax",@progbits
	.global ies__has_buffer
ies__has_buffer:
	.global L_8cb668
L_8cb668:
	ld_s r0,[r0,0x4]
L_8cb66a:
	sub.f r0,r0,0x0
L_8cb66e:
	j_s.d [blink]
L_8cb670:
	mov.ne r0,0x1
