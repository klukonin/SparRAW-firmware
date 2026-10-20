/* mlme__parse_wilocity_vs @ 0x8db748, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__assoc_resp_event
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, parse_wilocity_vs__find_tlv
 */
	.section .text.mlme__parse_wilocity_vs,"ax",@progbits
	.global mlme__parse_wilocity_vs
mlme__parse_wilocity_vs:
	.global L_8db748
L_8db748:
	push_s blink
L_8db74a:
	bl L_8c02c4
L_8db74e:
	mov_s r14,r2
L_8db750:
	mov_s r13,0x0
L_8db752:
	stw_s r13,[r2]
L_8db754:
	bl.d L_8db6cc
L_8db758:
	mov_s r2,0x4
L_8db75a:
	breq_s r0,0,L_8db768
L_8db75c:
	add_s r13,r0,0x4
L_8db75e:
	ldb_s r1,[r0,0x3]
L_8db760:
	ldb_s r2,[r0,0x2]
L_8db762:
	asl_s r1,r1,0x8
L_8db764:
	or_s r2,r2,r1
L_8db766:
	stw_s r2,[r14]
	.global L_8db768
L_8db768:
	b.d L_8c0334
L_8db76c:
	mov_s r0,r13
L_8db76e:
	nop_s
