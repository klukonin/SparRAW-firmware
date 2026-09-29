/* rf__apply_tx_power @ 0x8de0d8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, calib_mngr__switch_channel, conn_msm__on_ntf_disc_complete, pcp_ap__set_aid
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_rfc_tx_power_cfg, regd__allow_if_not_jp, regd__is_country_us, regd__jp_or_unset, rgf_reg_88416c, rgf_reg_889480
 */
	.section .text.rf__apply_tx_power,"ax",@progbits
	.global rf__apply_tx_power
rf__apply_tx_power:
	.global L_8de0d8
L_8de0d8:
	push_s blink
L_8de0da:
	bl L_8c02c0
L_8de0de:
	ldb r1,[gp, 0xcb]
L_8de0e2:
	mov_s r13,0x0
L_8de0e4:
	cmp_s r1,0x1
L_8de0e6:
	cmp.ne r0,0x1
L_8de0ea:
	mov.ne r15,r13
L_8de0ee:
	mov.ne r14,r13
L_8de0f2:
	bne_s L_8de106
L_8de0f4:
	bl L_8d7380
L_8de0f8:
	bl.d L_8d7364
L_8de0fc:
	mov_s r15,r0
L_8de0fe:
	bl.d L_8d7550
L_8de102:
	mov_s r14,r0
L_8de104:
	mov_s r13,r0
	.global L_8de106
L_8de106:
	bl.d L_8d15f8
L_8de10a:
	mov_s r0,r15
L_8de10c:
	bl.d L_8d15cc
L_8de110:
	mov_s r0,r14
L_8de112:
	bl.d L_8d0e80
L_8de116:
	mov_s r0,r13
L_8de118:
	b L_8c032c
