/* find_main_sm__on_start_listen @ 0x8f194c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, find_mngr__del_discovery_bcon, find_sm__report_listen_started
 */
	.section .text.find_main_sm__on_start_listen,"ax",@progbits
	.global find_main_sm__on_start_listen
find_main_sm__on_start_listen:
L_8f194c:
	push_s blink
L_8f194e:
	push_s r13
L_8f1950:
	mov_s r13,r0
L_8f1952:
	bl.d L_8c771c
L_8f1956:
	ld_s r0,[r0,0x34]
L_8f1958:
	bl.d L_8d7e98
L_8f195c:
	ld_s r0,[r13,0x34]
L_8f195e:
	b L_8c033c
L_8f1962:
	nop_s
