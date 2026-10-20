/* parse_wilocity_vs_get_features_version_tracking @ 0x8df7e8, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_features_version_tracking Not found.
 *   parse_wilocity_vs_get_features_version_tracking features_version_tracking = %x ([%x][%x])
 * Зовут его: discovery__init_probe_entry
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit3, parse_wilocity_vs__find_tlv
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global parse_wilocity_vs_get_features_version_tracking
parse_wilocity_vs_get_features_version_tracking:
	.global L_8df7e8
L_8df7e8:
	push_s blink
L_8df7ea:
	push_s r13
L_8df7ec:
	bl.d L_8df7ac
L_8df7f0:
	mov_s r2,0x7
L_8df7f2:
	mov.f r3,r0
L_8df7f6:
	bne_s L_8df808
L_8df7f8:
	mov_s r1,0x100c77c
L_8df7fe:
	bl.d L_8dcba8
L_8df802:
	mov_s r0,0x2b
L_8df804:
	mov_s r13,0x0
L_8df806:
	b_s L_8df81e
	.global L_8df808
L_8df808:
	ldw_s r13,[r3,0x4]
L_8df80a:
	mov_s r1,0x100c7b8
L_8df810:
	ldb r4,[r3, 0x5]
L_8df814:
	mov_s r0,0x2b
L_8df816:
	mov_s r2,r13
L_8df818:
	bl.d L_8dcd00
L_8df81c:
	ldb_s r3,[r3,0x4]
	.global L_8df81e
L_8df81e:
	b.d L_8c025c
L_8df822:
	mov_s r0,r13
