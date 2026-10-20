/* mac_parser__build_wildcard_rule @ 0x8dfac8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__teardown_mac_rules
 * Зовёт сам: bits__set16h_s4_w5, mac_parser__pack_rule_halfword
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__build_wildcard_rule
mac_parser__build_wildcard_rule:
	.global L_8dfac8
L_8dfac8:
	push_s blink
L_8dfaca:
	mov_s r2,r0
L_8dfacc:
	mov_s r0,0x0
L_8dface:
	stw.a r0,[sp,-0x8]
L_8dfad2:
	stw r0,[sp, 0x2]
L_8dfad6:
	stw r0,[sp, 0x4]
L_8dfada:
	mov_s r1,0x1f
L_8dfadc:
	add r0,sp,0x6
L_8dfae0:
	bl L_8ed31c
L_8dfae4:
	ldw r0,[sp, 0x6]
L_8dfae8:
	bclr_s r0,r0,0x0
L_8dfaea:
	stw r0,[sp, 0x6]
L_8dfaee:
	mov_s r0,sp
L_8dfaf0:
	bl.d L_8df6a4
L_8dfaf4:
	mov_s r1,r2
L_8dfaf6:
	add_s sp,sp,0x8
L_8dfaf8:
	pop_s blink
L_8dfafa:
	j_s [blink]
