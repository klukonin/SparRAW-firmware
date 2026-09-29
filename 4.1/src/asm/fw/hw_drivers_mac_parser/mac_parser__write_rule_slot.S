/* mac_parser__write_rule_slot @ 0x8db61c, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_mac_parser.c
 * Зовут его: mac_parser__clear_rule, mac_parser__set_ba_rule
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bf_h_s0_w2, bf_h_s4_w2, fw_sysassert_fatal
 */
	.section .text.mac_parser__write_rule_slot,"ax",@progbits
	.global mac_parser__write_rule_slot
mac_parser__write_rule_slot:
	.global L_8db61c
L_8db61c:
	push_s blink
L_8db61e:
	bl L_8c02c0
L_8db622:
	sub_s sp,sp,0x4
L_8db624:
	mov_s r14,r0
L_8db626:
	mov_s r15,r1
L_8db628:
	brhs.d r2,0x8,L_8db682
L_8db62c:
	mov_s r13,r2
	.global L_8db62e
L_8db62e:
	mov_s r0,0x0
L_8db630:
	stw r0,[sp, 0x2]
L_8db634:
	add r0,sp,0x2
L_8db638:
	mov_s r1,0x1
L_8db63a:
	bl.d L_8e82a0
L_8db63e:
	add3_s r13,r13,r15
L_8db640:
	mov_s r1,0x2
L_8db642:
	bl L_8e82d0
L_8db646:
	ldw r0,[sp, 0x2]
L_8db64a:
	mov_s r2,0x886000
L_8db650:
	asl_s r0,r0,0x10
L_8db652:
	bset_s r0,r0,0x1f
L_8db654:
	mov_s r1,0x886200
L_8db65a:
	st_s r0,[r1,0x78]
L_8db65c:
	st_s r13,[r1,0x7c]
L_8db65e:
	ld_s r0,[r14]
L_8db660:
	st.as r0,[r2,0xa0]
L_8db664:
	st 0x40000000,[r1, 0x74]
L_8db66c:
	sync
	.global L_8db670
L_8db670:
	mov_s r0,0x886200
L_8db676:
	ld_s r0,[r0,0x74]
L_8db678:
	bbit1 r0,0x1d,L_8db670
L_8db67c:
	b.d L_8c032c
L_8db680:
	add_s sp,sp,0x4
	.global L_8db682
L_8db682:
	mov_s r0,blink
L_8db684:
	mov_s r2,0x1019b0c
L_8db68a:
	mov_s r1,0x12
L_8db68c:
	bset_s r1,r1,0xc
L_8db68e:
	bl.d L_8c82c0
L_8db692:
	mov r3,0x388
L_8db696:
	b_s L_8db62e
