/* parse_wilocity_vs_get_test_mode @ 0x8df888, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_test_mode Not found.
 *   parse_wilocity_vs_get_test_mode test mode = %x ([%x][%x])
 * Зовут его: mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit3, parse_wilocity_vs__find_tlv
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global parse_wilocity_vs_get_test_mode
parse_wilocity_vs_get_test_mode:
	.global L_8df888
L_8df888:
	push_s blink
L_8df88a:
	bl L_8c01e4
L_8df88e:
	mov_s r14,0x1
L_8df890:
	bl.d L_8df7ac
L_8df894:
	mov_s r2,r14
L_8df896:
	mov.f r13,r0
L_8df89a:
	bne_s L_8df8ac
L_8df89c:
	mov_s r1,0x100c714
L_8df8a2:
	bl.d L_8dcba8
L_8df8a6:
	mov_s r0,0x2b
L_8df8a8:
	mov_s r0,r14
L_8df8aa:
	b_s L_8df8c8
	.global L_8df8ac
L_8df8ac:
	ldb r4,[r13, 0x5]
L_8df8b0:
	mov_s r1,0x100c740
L_8df8b6:
	ldw_s r2,[r13,0x4]
L_8df8b8:
	mov_s r0,0x2b
L_8df8ba:
	bl.d L_8dcd00
L_8df8be:
	ldb_s r3,[r13,0x4]
L_8df8c0:
	ldb_s r0,[r13,0x4]
L_8df8c2:
	cmp_s r0,0x0
L_8df8c4:
	mov.ne r0,0x1
	.global L_8df8c8
L_8df8c8:
	b L_8c0254
