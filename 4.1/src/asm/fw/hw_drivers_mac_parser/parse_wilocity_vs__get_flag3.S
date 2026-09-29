/* parse_wilocity_vs__get_flag3 @ 0x8db7e0, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: discovery_handle_probe_resp, mlme_sm__assoc_req_handle, verify_pbc
 * Зовёт сам: parse_wilocity_vs__find_tlv
 */
	.section .text.parse_wilocity_vs__get_flag3,"ax",@progbits
	.global parse_wilocity_vs__get_flag3
parse_wilocity_vs__get_flag3:
	.global L_8db7e0
L_8db7e0:
	push_s blink
L_8db7e2:
	bl.d L_8db6cc
L_8db7e6:
	mov_s r2,0x3
L_8db7e8:
	cmp_s r0,0x0
L_8db7ea:
	mov.eq r0,0x0
L_8db7ee:
	beq_s L_8db7f8
L_8db7f0:
	ldb_s r0,[r0,0x4]
L_8db7f2:
	cmp_s r0,0x1
L_8db7f4:
	mov_s r0,0x1
L_8db7f6:
	sub_s.ne r0,r0,r0
	.global L_8db7f8
L_8db7f8:
	pop_s blink
L_8db7fa:
	j_s [blink]
