/* mac_parser__init @ 0x8db698, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__configure
 * Зовёт сам: __ld_r13_ret, hwd_mac_parser__set_rx_filter, mac_parser__install_default_rules, mac_parser__rule_a, mac_parser__rule_b, mac_parser_step_a, mac_parser_step_b, set_reg_886288
 */
	.section .text.mac_parser__init,"ax",@progbits
	.global mac_parser__init
mac_parser__init:
	.global L_8db698
L_8db698:
	push_s blink
L_8db69a:
	push_s r13
L_8db69c:
	bl.d L_8dba64
L_8db6a0:
	mov_s r13,r0
L_8db6a2:
	bl L_8dbaf0
L_8db6a6:
	bl.d L_8dbe14
L_8db6aa:
	mov_s r0,r13
L_8db6ac:
	bl.d L_8dbd14
L_8db6b0:
	mov_s r0,r13
L_8db6b2:
	bl.d L_8dbd44
L_8db6b6:
	mov_s r0,r13
L_8db6b8:
	bl.d L_8dbb80
L_8db6bc:
	mov_s r0,r13
L_8db6be:
	mov_s r0,r13
L_8db6c0:
	bl.d L_8dbc3c
L_8db6c4:
	mov_s r1,0x0
L_8db6c6:
	b L_8c033c
L_8db6ca:
	nop_s
