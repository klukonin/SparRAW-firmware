/* find_main_sm__stop_searching @ 0x8f17f8, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_main_sm::stop_searching()
 * Зовёт сам: __ld_r13_ret, find_main_sm__stop, find_mngr__del_discovery_bcon, fw_log__emit0
 */
	.section .text.find_main_sm__stop_searching,"ax",@progbits
	.global find_main_sm__stop_searching
find_main_sm__stop_searching:
L_8f17f8:
	push_s blink
L_8f17fa:
	push_s r13
L_8f17fc:
	mov_s r13,r0
L_8f17fe:
	mov_s r2,0x1014728
L_8f1804:
	mov_s r0,0xc
L_8f1806:
	bl.d L_8edfb0
L_8f180a:
	mov_s r1,0x2
L_8f180c:
	bl.d L_8c771c
L_8f1810:
	ld_s r0,[r13,0x34]
L_8f1812:
	bl.d L_8f1730
L_8f1816:
	mov_s r0,r13
L_8f1818:
	b L_8c033c
