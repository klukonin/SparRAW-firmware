/* mac_parser__init @ 0x8df778, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__configure
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_mac_parser__set_rx_filter, mac_parser__install_default_rules, mac_parser__rule_a, mac_parser__rule_b, mac_parser__set_default_ctrl, mac_parser_step_a, mac_parser_step_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__init
mac_parser__init:
	.global L_8df778
L_8df778:
	push_s blink
L_8df77a:
	push_s r13
L_8df77c:
	bl.d L_8dfb3c
L_8df780:
	mov_s r13,r0
L_8df782:
	bl L_8dfbc8
L_8df786:
	bl.d L_8dfee4
L_8df78a:
	mov_s r0,r13
L_8df78c:
	bl.d L_8dfde4
L_8df790:
	mov_s r0,r13
L_8df792:
	bl.d L_8dfe14
L_8df796:
	mov_s r0,r13
L_8df798:
	bl.d L_8dfc58
L_8df79c:
	mov_s r0,r13
L_8df79e:
	mov_s r0,r13
L_8df7a0:
	bl.d L_8dfd14
L_8df7a4:
	mov_s r1,0x0
L_8df7a6:
	b L_8c025c
L_8df7aa:
	nop_s
