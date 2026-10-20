/* find_sm__report_search_started @ 0x8e00d8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_sm__start_search
 * Зовёт сам: l2mgr__send_search_started
 */
	.section .text.find_sm__report_search_started,"ax",@progbits
	.global find_sm__report_search_started
find_sm__report_search_started:
	.global L_8e00d8
L_8e00d8:
	push_s blink
L_8e00da:
	ld_s r1,[r0,0xc]
L_8e00dc:
	brne_s r1,0,L_8e00e8
L_8e00de:
	ld_s r1,[r0,0x6c]
L_8e00e0:
	mov_s r0,0x0
L_8e00e2:
	bl.d L_8f0a4c
L_8e00e6:
	ldb_s r1,[r1,0x10]
	.global L_8e00e8
L_8e00e8:
	pop_s blink
L_8e00ea:
	j_s [blink]
