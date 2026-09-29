/* rf_if__tx_sectors_vcall_14 @ 0x8cb7f8, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcn_tx_init_ss_params, lmac_if_config_txss, lmac_if_set_ss_sectors_default_cfg_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_if__tx_sectors_vcall_14
rf_if__tx_sectors_vcall_14:
	.global L_8cb7f8
L_8cb7f8:
	ld_s r0,[r0,0x58]
L_8cb7fa:
	ld_s r1,[r0,0x44]
L_8cb7fc:
	ld_s r1,[r1,0x14]
L_8cb7fe:
	j_s [r1]
L_8cb800:
	j_s [blink]
L_8cb802:
	nop_s
