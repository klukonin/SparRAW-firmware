/* conn__teardown_mac_rules @ 0x8f10d8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__abort
 * Зовёт сам: __ld_r13_ret, conn__cancel_retry_timer, lmac_if_send_cmd_0x05_8f1074, mac_parser__build_wildcard_rule, mac_parser__clear_rule, mid_list__remove_entry
 */
	.section .text.conn__teardown_mac_rules,"ax",@progbits
	.global conn__teardown_mac_rules
conn__teardown_mac_rules:
	.global L_8f10d8
L_8f10d8:
	push_s blink
L_8f10da:
	push_s r13
L_8f10dc:
	mov_s r13,r0
L_8f10de:
	bl.d L_8f1074
L_8f10e2:
	mov_s r1,0x1
L_8f10e4:
	bl.d L_8db9e4
L_8f10e8:
	ldb_s r0,[r13,0x8]
L_8f10ea:
	ldb_s r0,[r13,0x8]
L_8f10ec:
	bl.d L_8dba18
L_8f10f0:
	mov_s r1,0x7
L_8f10f2:
	bl.d L_8c5b30
L_8f10f6:
	mov_s r0,r13
L_8f10f8:
	ld_s r0,[r13,0xc]
L_8f10fa:
	bl.d L_8d7970
L_8f10fe:
	mov_s r1,r13
L_8f1100:
	b L_8c033c
