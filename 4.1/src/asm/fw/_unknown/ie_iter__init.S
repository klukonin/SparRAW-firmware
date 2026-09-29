/* ie_iter__init @ 0x8e112c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: app_ie__print_ies, app_ie__remove_tlv, find_main_sm__probe_req, find_main_sm__probe_req_in_search, ies_block__find_ie, ies_block__merge
 */
	.section .text.ie_iter__init,"ax",@progbits
	.global ie_iter__init
ie_iter__init:
	.global L_8e112c
L_8e112c:
	st_s r1,[r0]
L_8e112e:
	ld_s r1,[r1]
L_8e1130:
	st_s r1,[r0,0x4]
L_8e1132:
	mov_s r1,0x0
L_8e1134:
	j_s.d [blink]
L_8e1136:
	stw_s r1,[r0,0x8]
