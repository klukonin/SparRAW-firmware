/* hwd_phy__rx_agc_steps_disable @ 0x8d2260, 180 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib__setup_loopback_hw, calib__setup_loopback_rx_path, calib_corr__estimate_and_apply_rx_gain, calib_lo_leakage_substep, hwf_calib__release_hw, hwm__apply_channel_config
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 * Глобалы (через gp): 0x800237, 0x800238, 0x800239, 0x80023a
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__rx_agc_steps_disable
hwd_phy__rx_agc_steps_disable:
	.global L_8d2260
L_8d2260:
	push_s blink
L_8d2262:
	bl L_8c01e4
L_8d2266:
	brne r0,0x1,L_8d228a
L_8d226a:
	mov_s r1,0x883180
L_8d2270:
	ld_s r0,[r1,0x40]
L_8d2272:
	bic r0,r0,0x3f
L_8d2276:
	or r0,r0,0x21
L_8d227a:
	st_s r0,[r1,0x40]
L_8d227c:
	ld_s r0,[r1,0x44]
L_8d227e:
	bic r0,r0,0x3f
L_8d2282:
	or r0,r0,0x21
L_8d2286:
	st_s r0,[r1,0x44]
L_8d2288:
	b_s L_8d22e6
	.global L_8d228a
L_8d228a:
	ldb_s r0,[gp,0xb3]
L_8d228c:
	bic.f r0,r0,0x3f
L_8d2290:
	bne_s L_8d22ea
	.global L_8d2292
L_8d2292:
	mov_s r14,0x883180
L_8d2298:
	ld_s r0,[r14,0x40]
L_8d229a:
	bic r1,r0,0x3f
L_8d229e:
	ldb_s r0,[gp,0xb3]
L_8d22a0:
	or_s r0,r0,r1
L_8d22a2:
	st_s r0,[r14,0x40]
L_8d22a4:
	ldb_s r0,[gp,0xb5]
L_8d22a6:
	bic.f r0,r0,0x3f
L_8d22aa:
	bne_s L_8d22f4
	.global L_8d22ac
L_8d22ac:
	ld_s r0,[r14,0x44]
L_8d22ae:
	bic r1,r0,0x3f
L_8d22b2:
	ldb_s r0,[gp,0xb5]
L_8d22b4:
	or_s r0,r0,r1
L_8d22b6:
	st_s r0,[r14,0x44]
L_8d22b8:
	ldb_s r0,[gp,0xb4]
L_8d22ba:
	bic.f r0,r0,0x3f
L_8d22be:
	bne_s L_8d22fe
	.global L_8d22c0
L_8d22c0:
	ld_s r1,[r14,0x40]
L_8d22c2:
	mov_s r13,0xfffff03f
L_8d22c8:
	ldb_s r0,[gp,0xb4]
L_8d22ca:
	and_s r1,r1,r13
L_8d22cc:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8d22ce:
	or_s r0,r0,r1
L_8d22d0:
	st_s r0,[r14,0x40]
L_8d22d2:
	ldb_s r0,[gp,0xb6]
L_8d22d4:
	bic.f r0,r0,0x3f
L_8d22d8:
	bne_s L_8d2308
	.global L_8d22da
L_8d22da:
	ld_s r1,[r14,0x44]
L_8d22dc:
	ldb_s r0,[gp,0xb6]
L_8d22de:
	and_s r1,r1,r13
L_8d22e0:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8d22e2:
	or_s r0,r0,r1
L_8d22e4:
	st_s r0,[r14,0x44]
	.global L_8d22e6
L_8d22e6:
	b L_8c0254
	.global L_8d22ea
L_8d22ea:
	mov_s r0,blink
L_8d22ec:
	bl.d L_8c9b28
L_8d22f0:
	mov_s r1,0xac
L_8d22f2:
	b_s L_8d2292
	.global L_8d22f4
L_8d22f4:
	mov_s r0,blink
L_8d22f6:
	bl.d L_8c9b28
L_8d22fa:
	mov_s r1,0xac
L_8d22fc:
	b_s L_8d22ac
	.global L_8d22fe
L_8d22fe:
	mov_s r0,blink
L_8d2300:
	bl.d L_8c9b28
L_8d2304:
	mov_s r1,0xac
L_8d2306:
	b_s L_8d22c0
	.global L_8d2308
L_8d2308:
	mov_s r0,blink
L_8d230a:
	bl.d L_8c9b28
L_8d230e:
	mov_s r1,0xac
L_8d2310:
	b_s L_8d22da
L_8d2312:
	nop_s
