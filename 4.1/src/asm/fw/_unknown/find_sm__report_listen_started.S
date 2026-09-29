/* find_sm__report_listen_started @ 0x8d7e98, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: find_main_sm__on_start_listen, find_sm__start_listen
 * Зовёт сам: l2mgr__send_listen_started
 */
	.section .text.find_sm__report_listen_started,"ax",@progbits
	.global find_sm__report_listen_started
find_sm__report_listen_started:
	.global L_8d7e98
L_8d7e98:
	push_s blink
L_8d7e9a:
	ld_s r1,[r0,0xc]
L_8d7e9c:
	brne_s r1,0,L_8d7ea8
L_8d7e9e:
	ld_s r1,[r0,0x6c]
L_8d7ea0:
	mov_s r0,0x0
L_8d7ea2:
	bl.d L_8f0610
L_8d7ea6:
	ldb_s r1,[r1,0x10]
	.global L_8d7ea8
L_8d7ea8:
	pop_s blink
L_8d7eaa:
	j_s [blink]
