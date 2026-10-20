/* parse_wilocity_vs_get_version @ 0x8db7bc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_version Not found.
 * Зовут его: set_vendor_specific_version
 * Зовёт сам: fw_log__emit0, parse_wilocity_vs__find_tlv
 */
	.section .text.parse_wilocity_vs_get_version,"ax",@progbits
	.global parse_wilocity_vs_get_version
parse_wilocity_vs_get_version:
	.global L_8db7bc
L_8db7bc:
	push_s blink
L_8db7be:
	bl.d L_8db6cc
L_8db7c2:
	mov_s r2,0x5
L_8db7c4:
	brne_s r0,0,L_8db7d8
L_8db7c6:
	mov_s r2,0x100b364
L_8db7cc:
	mov_s r0,0xb
L_8db7ce:
	bl.d L_8edfb0
L_8db7d2:
	mov_s r1,0x2
L_8db7d4:
	mov_s r0,0x0
L_8db7d6:
	b_s L_8db7da
	.global L_8db7d8
L_8db7d8:
	ldb_s r0,[r0,0x4]
	.global L_8db7da
L_8db7da:
	pop_s blink
L_8db7dc:
	j_s [blink]
L_8db7de:
	nop_s
