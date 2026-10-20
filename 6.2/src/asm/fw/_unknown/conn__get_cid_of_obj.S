/* conn__get_cid_of_obj @ 0x8cbeb8, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__get_cid_via_field8, maintain_sm__action_8c48f8, maintain_sm__action_8cab64, maintain_sm__action_8f2f0c, maintain_sm__action_8f96c4, maintain_sm__reset_rate_params, mlme_sm_802458__action_8c5cfc
 * Зовёт сам: conn__get_cid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__get_cid_of_obj
conn__get_cid_of_obj:
	.global L_8cbeb8
L_8cbeb8:
	b.d L_8cbed0
L_8cbebc:
	ld_s r0,[r0,0x8]
L_8cbebe:
	nop_s
