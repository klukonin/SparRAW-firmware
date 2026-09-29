/* conn__config_txss_and_sta @ 0x8dc4ac, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm_802458__action_8f1080
 * Зовёт сам: __ld_r13_to_r13_ret, lmac_if__send_sta_cfg_05_c, lmac_if_config_txss
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__config_txss_and_sta
conn__config_txss_and_sta:
	.global L_8dc4ac
L_8dc4ac:
	push_s blink
L_8dc4ae:
	push_s r13
L_8dc4b0:
	mov_s r13,r0
L_8dc4b2:
	bl.d L_8db60c
L_8dc4b6:
	ldb_s r0,[r0,0x8]
L_8dc4b8:
	mov_s r2,0x8042c8
L_8dc4be:
	ldb_s r0,[r13,0x8]
L_8dc4c0:
	ldw_s r1,[r13,0xc]
L_8dc4c2:
	bl.d L_8dc3c4
L_8dc4c6:
	ldb_s r2,[r2]
L_8dc4c8:
	b L_8c025c
