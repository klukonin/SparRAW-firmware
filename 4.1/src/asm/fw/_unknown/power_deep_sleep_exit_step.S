/* power_deep_sleep_exit_step @ 0x8c74cc, 172 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit
 * Зовёт сам: SDP__sdp_drive_value, __ld_r16_to_r13_ret, __st_r16_to_r13, get_g_8000fc, get_g_80035c, hwd_abif__rgf_88ae00, lmac_if__wait_ucode_ack_4, marlon_r_if_class__config_channel, marlon_r_if_class__rf_configure_role_power, power__start_two_timers, power_halt_seq, rf__configure_chain
 * Глобалы (через gp): 0x800324
 */
	.section .text.power_deep_sleep_exit_step,"ax",@progbits
	.global power_deep_sleep_exit_step
power_deep_sleep_exit_step:
	.global L_8c74cc
L_8c74cc:
	push_s blink
L_8c74ce:
	bl L_8c02bc
L_8c74d2:
	mov_s r15,r0
L_8c74d4:
	ld_s r0,[gp,-0xac]
L_8c74d6:
	cmp_s r0,0x1
L_8c74d8:
	sub_s.ne r0,r0,r0
L_8c74da:
	bne_s L_8c7574
L_8c74dc:
	bl L_8ca008
L_8c74e0:
	mov_s r14,r0
L_8c74e2:
	lr r13,[0xa]
L_8c74e6:
	bic r0,r13,0x6
L_8c74ea:
	flag r0
L_8c74ee:
	mov_s r0,0x0
L_8c74f0:
	mov_s r16,r0
L_8c74f2:
	mov_s r1,r14
L_8c74f4:
	ld.as r2,[gp,-0x27]
L_8c74f8:
	mov_s r3,r0
L_8c74fa:
	bl.d L_8d4e10
L_8c74fe:
	mov_s r4,r0
L_8c7500:
	mov_s r0,0x0
L_8c7502:
	bl.d L_8dfe00
L_8c7506:
	mov_s r1,0x7
L_8c7508:
	ld_s r0,[r14]
L_8c750a:
	st.as r16,[gp,-0x2b]
L_8c750e:
	bbit0 r0,0x2,L_8c755a
L_8c7512:
	mov_s r0,0x5dc0
L_8c7518:
	mov lp_count,r0
L_8c751c:
	nop_s
L_8c751e:
	lp L_8c7526
L_8c7522:
	nop_s
L_8c7524:
	nop_s
	.global L_8c7526
L_8c7526:
	bl.d L_8cb9a8
L_8c752a:
	mov_s r0,0x0
L_8c752c:
	mov r16,0x803e84
L_8c7534:
	bl.d L_8de988
L_8c7538:
	mov_s r0,r16
L_8c753a:
	mov_s r0,r16
L_8c753c:
	bl.d L_8c6048
L_8c7540:
	ld.as r1,[gp,0x6d]
L_8c7544:
	mov_s r0,0x0
L_8c7546:
	bl.d L_8d46f4
L_8c754a:
	mov_s r1,r0
L_8c754c:
	bl L_8de9f8
L_8c7550:
	bl L_8d8f44
L_8c7554:
	bl.d L_8cb9a8
L_8c7558:
	mov_s r0,0x1
	.global L_8c755a
L_8c755a:
	cmp_s r15,0x0
L_8c755c:
	bl.ne L_8d7f80
L_8c7560:
	lr r0,[0xa]
L_8c7564:
	bic r13,r13,-0x7
L_8c7568:
	or_s r13,r13,r0
L_8c756a:
	flag r13
L_8c756e:
	bl L_8e46a0
L_8c7572:
	mov_s r0,0x1
	.global L_8c7574
L_8c7574:
	b L_8c0324
