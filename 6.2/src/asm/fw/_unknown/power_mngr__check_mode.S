/* power_mngr__check_mode @ 0x8e24e0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, channels_switch_sm__switch_to_channel, conn_main_sm__action_8c3c60, conn_main_sm__action_8c9050
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_rfc_tx_power_cfg, phy__load_88416c_table, regd__is_country_not_jp, regd__is_country_us, regd__is_unset_or_jp, rf__set_889494_low_nibble
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global power_mngr__check_mode
power_mngr__check_mode:
	.global L_8e24e0
L_8e24e0:
	push_s blink
L_8e24e2:
	bl L_8c01e4
L_8e24e6:
	ldb r1,[gp, 0xce]
L_8e24ea:
	mov_s r13,0x0
L_8e24ec:
	cmp_s r1,0x1
L_8e24ee:
	cmp.ne r0,0x1
L_8e24f2:
	mov.ne r14,r13
L_8e24f6:
	bne_s L_8e2508
L_8e24f8:
	bl L_8da3d8
L_8e24fc:
	bl L_8da3bc
L_8e2500:
	bl.d L_8da658
L_8e2504:
	mov_s r13,r0
L_8e2506:
	mov_s r14,r0
	.global L_8e2508
L_8e2508:
	bl.d L_8d46e4
L_8e250c:
	mov_s r0,0x1
L_8e250e:
	bl.d L_8d46b8
L_8e2512:
	mov_s r0,r13
L_8e2514:
	bl.d L_8d4070
L_8e2518:
	mov_s r0,r14
L_8e251a:
	b L_8c0254
L_8e251e:
	nop_s
