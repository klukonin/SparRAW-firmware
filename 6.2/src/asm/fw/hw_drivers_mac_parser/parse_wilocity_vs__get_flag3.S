/* parse_wilocity_vs__get_flag3 @ 0x8df8ec, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_resp, mlme_sm_802458__action_8f1080, verify_pbc
 * Зовёт сам: parse_wilocity_vs__find_tlv
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global parse_wilocity_vs__get_flag3
parse_wilocity_vs__get_flag3:
	.global L_8df8ec
L_8df8ec:
	push_s blink
L_8df8ee:
	bl.d L_8df7ac
L_8df8f2:
	mov_s r2,0x3
L_8df8f4:
	cmp_s r0,0x0
L_8df8f6:
	mov.eq r0,0x0
L_8df8fa:
	beq_s L_8df904
L_8df8fc:
	ldb_s r0,[r0,0x4]
L_8df8fe:
	cmp_s r0,0x1
L_8df900:
	mov_s r0,0x1
L_8df902:
	sub_s.ne r0,r0,r0
	.global L_8df904
L_8df904:
	pop_s blink
L_8df906:
	j_s [blink]
