/* link_stats__get_cid @ 0x8c9d7c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__collect, link_stats__report, maintain_sm__check_bad_link, maintain_sm__on_consecutive_high_per
 * Зовёт сам: lm__get_cid
 */
	.section .text.link_stats__get_cid,"ax",@progbits
	.global link_stats__get_cid
link_stats__get_cid:
	.global L_8c9d7c
L_8c9d7c:
	b.d L_8c9d74
L_8c9d80:
	ld_s r0,[r0,0x2c]
L_8c9d82:
	nop_s
