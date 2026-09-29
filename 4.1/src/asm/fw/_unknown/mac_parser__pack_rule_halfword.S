/* mac_parser__pack_rule_halfword @ 0x8db5bc, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__build_mac_rule, mac_parser__build_wildcard_rule
 * Зовёт сам: __ld_r13_ret, bf_h_s0_w2, bf_h_s4_w2
 */
	.section .text.mac_parser__pack_rule_halfword,"ax",@progbits
	.global mac_parser__pack_rule_halfword
mac_parser__pack_rule_halfword:
	.global L_8db5bc
L_8db5bc:
	push_s blink
L_8db5be:
	push_s r13
L_8db5c0:
	sub_s sp,sp,0x4
L_8db5c2:
	mov_s r2,r0
L_8db5c4:
	mov_s r3,r1
L_8db5c6:
	mov_s r0,0x0
L_8db5c8:
	stw r0,[sp, 0x2]
L_8db5cc:
	add r0,sp,0x2
L_8db5d0:
	mov_s r1,0x1
L_8db5d2:
	bl L_8e82a0
L_8db5d6:
	bl L_8e82d0
L_8db5da:
	ldw r0,[sp, 0x2]
L_8db5de:
	mov_s r13,0x886000
L_8db5e4:
	asl_s r0,r0,0x10
L_8db5e6:
	bset_s r0,r0,0x1f
L_8db5e8:
	mov_s r1,0x886200
L_8db5ee:
	st_s r0,[r1,0x78]
L_8db5f0:
	st_s r3,[r1,0x7c]
L_8db5f2:
	ld_s r0,[r2]
L_8db5f4:
	st.as r0,[r13,0xa0]
L_8db5f8:
	ld_s r0,[r2,0x4]
L_8db5fa:
	st.as r0,[r13,0xa1]
L_8db5fe:
	st 0x40000000,[r1, 0x74]
L_8db606:
	sync
	.global L_8db60a
L_8db60a:
	mov_s r0,0x886200
L_8db610:
	ld_s r0,[r0,0x74]
L_8db612:
	bbit1 r0,0x1d,L_8db60a
L_8db616:
	b.d L_8c033c
L_8db61a:
	add_s sp,sp,0x4
