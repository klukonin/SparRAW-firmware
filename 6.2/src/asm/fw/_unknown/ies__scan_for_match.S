/* ies__scan_for_match @ 0x8cb8ec, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__probe_req_in_search, state_sm_8030f4__action_8f76d8
 * Зовёт сам: __ld_r13_to_r13_ret, ie__next_element, ies__iter_has_more
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ies__scan_for_match
ies__scan_for_match:
	.global L_8cb8ec
L_8cb8ec:
	push_s blink
L_8cb8ee:
	push_s r13
L_8cb8f0:
	mov_s r4,r0
L_8cb8f2:
	mov_s r13,r1
L_8cb8f4:
	b_s L_8cb902
	.global L_8cb8f6
L_8cb8f6:
	bl.d L_8df474
L_8cb8fa:
	mov_s r0,r4
L_8cb8fc:
	ldb_s r1,[r0]
L_8cb8fe:
	breq r13,r1,L_8cb90c
	.global L_8cb902
L_8cb902:
	bl.d L_8cdcd0
L_8cb906:
	mov_s r0,r4
L_8cb908:
	brne_s r0,0,L_8cb8f6
L_8cb90a:
	mov_s r0,0x0
	.global L_8cb90c
L_8cb90c:
	b L_8c025c
