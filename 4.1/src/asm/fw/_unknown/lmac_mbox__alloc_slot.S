/* lmac_mbox__alloc_slot @ 0x8c2b0c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: install_key_index_stub, lm_main_sm__config_lmac_bf_sm, lmac_if__send_abft_resp_ctrl, lmac_if__send_echo, lmac_if__send_lmac_personality, lmac_if__send_phy_ina_det_cfg, lmac_if__send_selective_neighbor_cfg, lmac_if_send_cmd_0x05_8f1074, lmac_if_send_cmd_0x07, lmac_if_send_cmd_0x08
 * Зовёт сам: basic_if__alloc_mbox_slot
 */
	.section .text.lmac_mbox__alloc_slot,"ax",@progbits
	.global lmac_mbox__alloc_slot
lmac_mbox__alloc_slot:
	.global L_8c2b0c
L_8c2b0c:
	mov_s r0,0x803e3c
L_8c2b12:
	b L_8c2c38
L_8c2b16:
	nop_s
