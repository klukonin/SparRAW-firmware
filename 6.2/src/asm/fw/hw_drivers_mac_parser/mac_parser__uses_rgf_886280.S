/* mac_parser__uses_rgf_886280 @ 0x8dfbd8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_mac_parser__set_rx_filter, mac_parser__install_default_rules, mac_parser__rule_a, mac_parser__rule_b, mac_parser_step_a, mac_parser_step_b
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set16h_s0_w2, mac_filter__bits_set16h_s4_w2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__uses_rgf_886280
mac_parser__uses_rgf_886280:
	.global L_8dfbd8
L_8dfbd8:
	push_s blink
L_8dfbda:
	push_s r13
L_8dfbdc:
	sub_s sp,sp,0x4
L_8dfbde:
	mov_s r3,r0
L_8dfbe0:
	mov_s r13,r1
L_8dfbe2:
	mov_s r0,0x0
L_8dfbe4:
	stw r0,[sp, 0x2]
L_8dfbe8:
	add r0,sp,0x2
L_8dfbec:
	mov_s r1,0x1
L_8dfbee:
	bl L_8ed2d4
L_8dfbf2:
	bmsk r1,r2,0x1
L_8dfbf6:
	bl L_8ed304
L_8dfbfa:
	ldw r0,[sp, 0x2]
L_8dfbfe:
	mov_s r1,0x886280
L_8dfc04:
	asl_s r0,r0,0x10
L_8dfc06:
	bset_s r0,r0,0x1f
L_8dfc08:
	st_s r0,[r1,0x10]
L_8dfc0a:
	st_s r13,[r1,0x14]
L_8dfc0c:
	ld_s r0,[r3]
L_8dfc0e:
	st_s r0,[r1,0x18]
L_8dfc10:
	ld_s r0,[r3,0x4]
L_8dfc12:
	st_s r0,[r1,0x1c]
L_8dfc14:
	st 0x40000000,[r1, 0xc]
L_8dfc1c:
	sync
	.global L_8dfc20
L_8dfc20:
	mov_s r0,0x886280
L_8dfc26:
	ld_s r0,[r0,0xc]
L_8dfc28:
	bbit1 r0,0x1d,L_8dfc20
L_8dfc2c:
	b.d L_8c025c
L_8dfc30:
	add_s sp,sp,0x4
L_8dfc32:
	nop_s
