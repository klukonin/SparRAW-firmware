/* parse_wilocity_vs_get_version @ 0x8df8cc, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_version Not found.
 * Зовут его: set_vendor_specific_version
 * Зовёт сам: fw_log_emit0, parse_wilocity_vs__find_tlv
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global parse_wilocity_vs_get_version
parse_wilocity_vs_get_version:
	.global L_8df8cc
L_8df8cc:
	push_s blink
L_8df8ce:
	bl.d L_8df7ac
L_8df8d2:
	mov_s r2,0x5
L_8df8d4:
	brne_s r0,0,L_8df8e6
L_8df8d6:
	mov_s r1,0x100c880
L_8df8dc:
	bl.d L_8dcba8
L_8df8e0:
	mov_s r0,0x2b
L_8df8e2:
	mov_s r0,0x0
L_8df8e4:
	b_s L_8df8e8
	.global L_8df8e6
L_8df8e6:
	ldb_s r0,[r0,0x4]
	.global L_8df8e8
L_8df8e8:
	pop_s blink
L_8df8ea:
	j_s [blink]
