/* parse_wilocity_vs_get_test_mode @ 0x8db770, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   parse_wilocity_vs_get_test_mode Not found.
 *   parse_wilocity_vs_get_test_mode test mode = %x ([%x][%x])
 * Зовут его: mlme_sm__assoc_req_handle
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_log__emit3, parse_wilocity_vs__find_tlv
 */
	.section .text.parse_wilocity_vs_get_test_mode,"ax",@progbits
	.global parse_wilocity_vs_get_test_mode
parse_wilocity_vs_get_test_mode:
	.global L_8db770
L_8db770:
	push_s blink
L_8db772:
	bl L_8c02c4
L_8db776:
	mov_s r14,0x1
L_8db778:
	bl.d L_8db6cc
L_8db77c:
	mov_s r2,r14
L_8db77e:
	mov.f r13,r0
L_8db782:
	bne_s L_8db796
L_8db784:
	mov_s r2,0x100b290
L_8db78a:
	mov_s r0,0xb
L_8db78c:
	bl.d L_8edfb0
L_8db790:
	mov_s r1,0x2
L_8db792:
	mov_s r0,r14
L_8db794:
	b_s L_8db7b6
	.global L_8db796
L_8db796:
	ldb r4,[r13, 0x4]
L_8db79a:
	mov_s r2,0x100b2bc
L_8db7a0:
	ldb r5,[r13, 0x5]
L_8db7a4:
	mov_s r0,0xb
L_8db7a6:
	mov_s r1,0x2
L_8db7a8:
	bl.d L_8ee034
L_8db7ac:
	ldw_s r3,[r13,0x4]
L_8db7ae:
	ldb_s r0,[r13,0x4]
L_8db7b0:
	cmp_s r0,0x0
L_8db7b2:
	mov.ne r0,0x1
	.global L_8db7b6
L_8db7b6:
	b L_8c0334
L_8db7ba:
	nop_s
