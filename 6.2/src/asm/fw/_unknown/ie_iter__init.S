/* ie_iter__init @ 0x8e5de8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: app_ie__find_by_eid, app_ie__print_ies, app_ie__remove_tlv, find_main_sm__probe_req_in_search, ies_block__merge, state_sm_8030f4__action_8f76d8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ie_iter__init
ie_iter__init:
	.global L_8e5de8
L_8e5de8:
	st_s r1,[r0]
L_8e5dea:
	ld_s r1,[r1]
L_8e5dec:
	st_s r1,[r0,0x4]
L_8e5dee:
	mov_s r1,0x0
L_8e5df0:
	j_s.d [blink]
L_8e5df2:
	stw_s r1,[r0,0x8]
