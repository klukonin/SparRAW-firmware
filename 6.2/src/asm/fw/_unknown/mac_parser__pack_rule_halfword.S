/* mac_parser__pack_rule_halfword @ 0x8df6a4, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_parser__build_wildcard_rule, rx_macq__program_desc_848018
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set16h_s0_w2, mac_filter__bits_set16h_s4_w2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_parser__pack_rule_halfword
mac_parser__pack_rule_halfword:
	.global L_8df6a4
L_8df6a4:
	push_s blink
L_8df6a6:
	push_s r13
L_8df6a8:
	sub_s sp,sp,0x4
L_8df6aa:
	mov_s r2,r0
L_8df6ac:
	mov_s r3,r1
L_8df6ae:
	mov_s r0,0x0
L_8df6b0:
	stw r0,[sp, 0x2]
L_8df6b4:
	add r0,sp,0x2
L_8df6b8:
	mov_s r1,0x1
L_8df6ba:
	bl L_8ed2d4
L_8df6be:
	bl L_8ed304
L_8df6c2:
	ldw r0,[sp, 0x2]
L_8df6c6:
	mov_s r13,0x886000
L_8df6cc:
	asl_s r0,r0,0x10
L_8df6ce:
	bset_s r0,r0,0x1f
L_8df6d0:
	mov_s r1,0x886200
L_8df6d6:
	st_s r0,[r1,0x78]
L_8df6d8:
	st_s r3,[r1,0x7c]
L_8df6da:
	ld_s r0,[r2]
L_8df6dc:
	st.as r0,[r13,0xa0]
L_8df6e0:
	ld_s r0,[r2,0x4]
L_8df6e2:
	st.as r0,[r13,0xa1]
L_8df6e6:
	st 0x40000000,[r1, 0x74]
L_8df6ee:
	sync
	.global L_8df6f2
L_8df6f2:
	mov_s r0,0x886200
L_8df6f8:
	ld_s r0,[r0,0x74]
L_8df6fa:
	bbit1 r0,0x1d,L_8df6f2
L_8df6fe:
	b.d L_8c025c
L_8df702:
	add_s sp,sp,0x4
