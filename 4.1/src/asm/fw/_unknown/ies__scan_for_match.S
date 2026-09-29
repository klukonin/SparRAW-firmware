/* ies__scan_for_match @ 0x8c9874, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__probe_req, find_main_sm__probe_req_in_search
 * Зовёт сам: __ld_r13_ret, ie__next_element, ies__has_ptr
 */
	.section .text.ies__scan_for_match,"ax",@progbits
	.global ies__scan_for_match
ies__scan_for_match:
	.global L_8c9874
L_8c9874:
	push_s blink
L_8c9876:
	push_s r13
L_8c9878:
	mov_s r4,r0
L_8c987a:
	mov_s r13,r1
L_8c987c:
	b_s L_8c988a
	.global L_8c987e
L_8c987e:
	bl.d L_8db1c4
L_8c9882:
	mov_s r0,r4
L_8c9884:
	ldb_s r1,[r0]
L_8c9886:
	breq r13,r1,L_8c9894
	.global L_8c988a
L_8c988a:
	bl.d L_8cb68c
L_8c988e:
	mov_s r0,r4
L_8c9890:
	brne_s r0,0,L_8c987e
L_8c9892:
	mov_s r0,0x0
	.global L_8c9894
L_8c9894:
	b L_8c033c
