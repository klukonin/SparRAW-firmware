/* mac_parser__build_mac_rule @ 0x8db858, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_g_800450
 * Зовёт сам: bf_h_s4_w5, mac_parser__pack_rule_halfword
 */
	.section .text.mac_parser__build_mac_rule,"ax",@progbits
	.global mac_parser__build_mac_rule
mac_parser__build_mac_rule:
	.byte 0x4f
	.byte 0xf2
	.global sub_8db85a
sub_8db85a:
L_8db85a:
	nop_s
	.global L_8db85c
L_8db85c:
	push_s blink
L_8db85e:
	mov_s r4,r1
L_8db860:
	mov_s r1,r2
L_8db862:
	ldw_s r2,[r0]
L_8db864:
	bmsk_s r1,r1,0x4
L_8db866:
	stw.a r2,[sp,-0x8]
L_8db86a:
	ldw_s r2,[r0,0x2]
L_8db86c:
	stw r2,[sp, 0x2]
L_8db870:
	ldw_s r0,[r0,0x4]
L_8db872:
	stw r0,[sp, 0x4]
L_8db876:
	add r0,sp,0x6
L_8db87a:
	bl L_8e82e8
L_8db87e:
	ldw r0,[sp, 0x6]
L_8db882:
	bset_s r0,r0,0x0
L_8db884:
	stw r0,[sp, 0x6]
L_8db888:
	mov_s r0,sp
L_8db88a:
	bl.d L_8db5bc
L_8db88e:
	mov_s r1,r4
L_8db890:
	add_s sp,sp,0x8
L_8db892:
	pop_s blink
L_8db894:
	j_s [blink]
L_8db896:
	nop_s
