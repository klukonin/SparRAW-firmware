/* conn__get_cid @ 0x8cbed0, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__get_cid_of_obj, lm_if__disable_link_loss_monitoring, lm_if__start_link_loss_monitoring, lm_if__stop_link_loss_monitoring, lm_main_sm__config_lmac_bf_sm, lm_main_sm__linkup_failed, lm_sm__action_8daed8, lm_sm__action_8daf2c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__get_cid
conn__get_cid:
	.global L_8cbed0
L_8cbed0:
	ld_s r0,[r0,0x4]
L_8cbed2:
	j_s.d [blink]
L_8cbed4:
	ldb_s r0,[r0,0x8]
L_8cbed6:
	nop_s
