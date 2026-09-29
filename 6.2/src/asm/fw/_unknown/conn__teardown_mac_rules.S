/* conn__teardown_mac_rules @ 0x8f9400, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__abort
 * Зовёт сам: __ld_r13_to_r13_ret, conn__check_field_50, lmac_if__send_sta_cfg_05, mac_parser__build_wildcard_rule, mid_list__remove_entry, stream_mgr__prepare_1f
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__teardown_mac_rules
conn__teardown_mac_rules:
	.global L_8f9400
L_8f9400:
	push_s blink
L_8f9402:
	push_s r13
L_8f9404:
	mov_s r13,r0
L_8f9406:
	bl.d L_8e7604
L_8f940a:
	mov_s r1,0x1
L_8f940c:
	bl.d L_8dfac8
L_8f9410:
	ldb_s r0,[r13,0x8]
L_8f9412:
	ldb_s r0,[r13,0x8]
L_8f9414:
	bl.d L_8dfafc
L_8f9418:
	mov_s r1,0x7
L_8f941a:
	bl.d L_8c68d4
L_8f941e:
	mov_s r0,r13
L_8f9420:
	ld_s r0,[r13,0x18]
L_8f9422:
	bl.d L_8daa8c
L_8f9426:
	mov_s r1,r13
L_8f9428:
	b L_8c025c
