/* stop_find_session @ 0x8f17b8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stop_find_session()
 * Зовут его: l2_mgr__scan_abort, l2mgr__stop_discovery
 * Зовёт сам: __ld_r13_ret, find_mngr__stop, fw_log__emit0
 */
	.section .text.stop_find_session,"ax",@progbits
	.global stop_find_session
stop_find_session:
	.global L_8f17b8
L_8f17b8:
	push_s blink
L_8f17ba:
	push_s r13
L_8f17bc:
	mov_s r13,r0
L_8f17be:
	mov_s r2,0x1012854
L_8f17c4:
	mov_s r0,0xc
L_8f17c6:
	bl.d L_8edfb0
L_8f17ca:
	mov_s r1,0x2
L_8f17cc:
	bl.d L_8e2dfc
L_8f17d0:
	add r0,r13,0xc
L_8f17d4:
	b L_8c033c
