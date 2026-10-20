/* parse_wilocity_vs_get_netowork_mode @ 0x8df824, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_netowork_mode Not found.
 *   parse_wilocity_vs_get_netowork_mode network = %x ([%x][%x])
 * Зовут его: mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit3, parse_wilocity_vs__find_tlv
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global parse_wilocity_vs_get_netowork_mode
parse_wilocity_vs_get_netowork_mode:
	.global L_8df824
L_8df824:
	push_s blink
L_8df826:
	push_s r13
L_8df828:
	bl.d L_8df7ac
L_8df82c:
	mov_s r2,0x2
L_8df82e:
	mov.f r13,r0
L_8df832:
	bne_s L_8df844
L_8df834:
	mov_s r1,0x100c814
L_8df83a:
	bl.d L_8dcba8
L_8df83e:
	mov_s r0,0x2b
L_8df840:
	mov_s r0,0x40
L_8df842:
	b_s L_8df85a
	.global L_8df844
L_8df844:
	ldb_s r2,[r13,0x4]
L_8df846:
	mov_s r1,0x100c844
L_8df84c:
	ldb r4,[r13, 0x5]
L_8df850:
	mov_s r0,0x2b
L_8df852:
	bl.d L_8dcd00
L_8df856:
	mov_s r3,r2
L_8df858:
	ldb_s r0,[r13,0x4]
	.global L_8df85a
L_8df85a:
	b L_8c025c
L_8df85e:
	nop_s
