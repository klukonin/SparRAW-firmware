/* lm_if__get_cid @ 0x8c9d8c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm__get_cid, lm_if__disable_link_loss_monitoring, lm_if__start_link_loss_monitoring, lm_if__stop_link_loss_monitoring, lm_main_sm__config_lmac_bf_sm, lm_main_sm__linkup_failed, lm_main_sm__on_linkup_req__lm_state_configured, lm_main_sm__on_linkup_req__lm_state_idle
 */
	.section .text.lm_if__get_cid,"ax",@progbits
	.global lm_if__get_cid
lm_if__get_cid:
	.global L_8c9d8c
L_8c9d8c:
	ld_s r0,[r0,0x4]
L_8c9d8e:
	j_s.d [blink]
L_8c9d90:
	ldb_s r0,[r0,0x8]
L_8c9d92:
	nop_s
