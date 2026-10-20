/* lm__get_cid @ 0x8c9d74, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__FBF_DELAYED, MAINTAIN_SM__OPEN, link_stats__get_cid, maintain__trigger_bf, maintain_sm__on_bf_results, maintain_sm__on_start_maintain, maintain_sm__reset_link_cfg
 * Зовёт сам: lm_if__get_cid
 */
	.section .text.lm__get_cid,"ax",@progbits
	.global lm__get_cid
lm__get_cid:
	.global L_8c9d74
L_8c9d74:
	b.d L_8c9d8c
L_8c9d78:
	ld_s r0,[r0,0x2c]
L_8c9d7a:
	nop_s
