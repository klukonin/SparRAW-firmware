/* hwd_phy__tx_singen_config @ 0x8d3090, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_corr__estimate_and_apply_rx_gain, calib_silent_rssi_sparrow__correction_alg
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_divmod_signed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__tx_singen_config
hwd_phy__tx_singen_config:
	.global L_8d3090
L_8d3090:
	push_s blink
L_8d3092:
	bl L_8c01dc
L_8d3096:
	mov_s r14,r1
L_8d3098:
	mov_s r16,r2
L_8d309a:
	asl r1,r0,0x10
L_8d309e:
	brlt.d r0,0x1,L_8d30aa
L_8d30a2:
	mov r13,0x528
L_8d30a6:
	add_s r0,r1,r13
L_8d30a8:
	b_s L_8d30ae
	.global L_8d30aa
L_8d30aa:
	sub r0,r1,r13
	.global L_8d30ae
L_8d30ae:
	mov_s r1,0xa5
L_8d30b0:
	bl.d L_8c02dc
L_8d30b4:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d30b6:
	mov_s r15,r0
L_8d30b8:
	asl r0,r14,0x10
L_8d30bc:
	cmp_s r14,0x0
L_8d30be:
	add.gt r0,r0,r13
L_8d30c2:
	sub.le r0,r0,r13
L_8d30c6:
	mov_s r1,0xa5
L_8d30c8:
	/* bl.d 0x008c02dc */
	.byte 0x16,0x0a,0xaf,0xf6
L_8d30cc:
	/* _asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d30ce:
	mov_s r2,0x884000
L_8d30d4:
	st r16,[r2, 0x68]
L_8d30d8:
	extw_s r1,r0
L_8d30da:
	ld_s r0,[r2,0x6c]
L_8d30dc:
	asl_s r1,r1,0x10
L_8d30de:
	and r0,r0,0xffff0000
L_8d30e6:
	or_s r0,r0,r15
L_8d30e8:
	extw_s r0,r0
L_8d30ea:
	or_s r0,r0,r1
L_8d30ec:
	st_s r0,[r2,0x6c]
L_8d30ee:
	b L_8c0244
L_8d30f2:
	nop_s
