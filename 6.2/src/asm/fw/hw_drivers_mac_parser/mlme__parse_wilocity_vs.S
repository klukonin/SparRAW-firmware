/* mlme__parse_wilocity_vs @ 0x8df860, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm_802458__action_8f0f4c
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, parse_wilocity_vs__find_tlv
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mlme__parse_wilocity_vs
mlme__parse_wilocity_vs:
	.global L_8df860
L_8df860:
	push_s blink
L_8df862:
	bl L_8c01e4
L_8df866:
	mov_s r14,r2
L_8df868:
	mov_s r13,0x0
L_8df86a:
	stw_s r13,[r2]
L_8df86c:
	bl.d L_8df7ac
L_8df870:
	mov_s r2,0x4
L_8df872:
	breq_s r0,0,L_8df880
L_8df874:
	add_s r13,r0,0x4
L_8df876:
	ldb_s r1,[r0,0x3]
L_8df878:
	ldb_s r2,[r0,0x2]
L_8df87a:
	asl_s r1,r1,0x8
L_8df87c:
	or_s r2,r2,r1
L_8df87e:
	stw_s r2,[r14]
	.global L_8df880
L_8df880:
	b.d L_8c0254
L_8df884:
	mov_s r0,r13
L_8df886:
	nop_s
