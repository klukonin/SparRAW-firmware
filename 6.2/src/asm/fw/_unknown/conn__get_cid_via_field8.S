/* conn__get_cid_via_field8 @ 0x8cbec0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__check_bad_link, link_stats__report, maintain_sm__action_8c7348, ts_ring__push_sample
 * Зовёт сам: conn__get_cid_of_obj
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__get_cid_via_field8
conn__get_cid_via_field8:
	.global L_8cbec0
L_8cbec0:
	b.d L_8cbeb8
L_8cbec4:
	ld_s r0,[r0,0x8]
L_8cbec6:
	nop_s
