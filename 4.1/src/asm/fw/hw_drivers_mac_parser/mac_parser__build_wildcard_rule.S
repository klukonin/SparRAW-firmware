/* mac_parser__build_wildcard_rule @ 0x8db9e4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__teardown_mac_rules
 * Зовёт сам: bf_h_s4_w5, mac_parser__pack_rule_halfword
 */
	.section .text.mac_parser__build_wildcard_rule,"ax",@progbits
	.global mac_parser__build_wildcard_rule
mac_parser__build_wildcard_rule:
	.global L_8db9e4
L_8db9e4:
	push_s blink
L_8db9e6:
	mov_s r2,r0
L_8db9e8:
	mov_s r0,0x0
L_8db9ea:
	stw.a r0,[sp,-0x8]
L_8db9ee:
	stw r0,[sp, 0x2]
L_8db9f2:
	stw r0,[sp, 0x4]
L_8db9f6:
	mov_s r1,0x1f
L_8db9f8:
	add r0,sp,0x6
L_8db9fc:
	bl L_8e82e8
L_8dba00:
	ldw r0,[sp, 0x6]
L_8dba04:
	bclr_s r0,r0,0x0
L_8dba06:
	stw r0,[sp, 0x6]
L_8dba0a:
	mov_s r0,sp
L_8dba0c:
	bl.d L_8db5bc
L_8dba10:
	mov_s r1,r2
L_8dba12:
	add_s sp,sp,0x8
L_8dba14:
	pop_s blink
L_8dba16:
	j_s [blink]
