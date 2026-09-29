/* mac_parser__write_rule @ 0x8dbb00, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_mac_parser__set_rx_filter, mac_parser__install_default_rules, mac_parser__rule_a, mac_parser__rule_b, mac_parser_step_a, mac_parser_step_b
 * Зовёт сам: __ld_r13_ret, bf_h_s0_w2, bf_h_s4_w2
 */
	.section .text.mac_parser__write_rule,"ax",@progbits
	.global mac_parser__write_rule
mac_parser__write_rule:
	.global L_8dbb00
L_8dbb00:
	push_s blink
L_8dbb02:
	push_s r13
L_8dbb04:
	sub_s sp,sp,0x4
L_8dbb06:
	mov_s r3,r0
L_8dbb08:
	mov_s r13,r1
L_8dbb0a:
	mov_s r0,0x0
L_8dbb0c:
	stw r0,[sp, 0x2]
L_8dbb10:
	add r0,sp,0x2
L_8dbb14:
	mov_s r1,0x1
L_8dbb16:
	bl L_8e82a0
L_8dbb1a:
	bmsk r1,r2,0x1
L_8dbb1e:
	bl L_8e82d0
L_8dbb22:
	ldw r0,[sp, 0x2]
L_8dbb26:
	mov_s r1,0x886280
L_8dbb2c:
	asl_s r0,r0,0x10
L_8dbb2e:
	bset_s r0,r0,0x1f
L_8dbb30:
	st_s r0,[r1,0x10]
L_8dbb32:
	st_s r13,[r1,0x14]
L_8dbb34:
	ld_s r0,[r3]
L_8dbb36:
	st_s r0,[r1,0x18]
L_8dbb38:
	ld_s r0,[r3,0x4]
L_8dbb3a:
	st_s r0,[r1,0x1c]
L_8dbb3c:
	st 0x40000000,[r1, 0xc]
L_8dbb44:
	sync
	.global L_8dbb48
L_8dbb48:
	mov_s r0,0x886280
L_8dbb4e:
	ld_s r0,[r0,0xc]
L_8dbb50:
	bbit1 r0,0x1d,L_8dbb48
L_8dbb54:
	b.d L_8c033c
L_8dbb58:
	add_s sp,sp,0x4
L_8dbb5a:
	nop_s
