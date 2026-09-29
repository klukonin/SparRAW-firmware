/* ut_hw_modes_step @ 0x8d7358, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__correction_alg, hwf_calib__release_hw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__caf_lpbk_mode, hwd_abif__lpbk_mode_switches_config, hwd_abif__txrx_table_index_lpbk_mode
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_modes_step
ut_hw_modes_step:
	.global L_8d7358
L_8d7358:
	push_s blink
L_8d735a:
	bl L_8c01d8
L_8d735e:
	mov_s r16,r0
L_8d7360:
	mov_s r0,r1
L_8d7362:
	bl.d L_8cff68
L_8d7366:
	mov_s r1,r2
L_8d7368:
	mov_s r14,0x88af00
L_8d736e:
	mov_s r0,0xfffff0ff
L_8d7374:
	mov_s r13,0x88ae00
L_8d737a:
	mov_s r15,0x88ae80
L_8d7380:
	mov_s r17,r0
L_8d7382:
	breq r16,0x0,L_8d73b8
L_8d7386:
	ld_s r1,[r14,0x40]
L_8d7388:
	and_s r0,r0,r1
L_8d738a:
	bclr_s r0,r0,0x0
L_8d738c:
	bset_s r0,r0,0xa
L_8d738e:
	bset_s r0,r0,0xb
L_8d7390:
	bclr_s r0,r0,0x4
L_8d7392:
	st_s r0,[r14,0x40]
L_8d7394:
	mov_s r0,0x2
L_8d7396:
	mov_s r1,0x1
L_8d7398:
	bl.d L_8ceb2c
L_8d739c:
	mov_s r2,0x0
L_8d739e:
	ld_s r0,[r13,0x6c]
L_8d73a0:
	bset_s r0,r0,0xb
L_8d73a2:
	bset_s r0,r0,0xc
L_8d73a4:
	bset_s r0,r0,0xd
L_8d73a6:
	st_s r0,[r13,0x6c]
L_8d73a8:
	ld_s r0,[r15,0x30]
L_8d73aa:
	or r0,r0,0x180
L_8d73ae:
	st_s r0,[r15,0x30]
L_8d73b0:
	bl.d L_8ce5e8
L_8d73b4:
	mov_s r0,0x1
L_8d73b6:
	b_s L_8d73e6
	.global L_8d73b8
L_8d73b8:
	bl.d L_8ce5e8
L_8d73bc:
	mov_s r0,0x0
L_8d73be:
	ld_s r0,[r14,0x40]
L_8d73c0:
	mov_s r1,0x2
L_8d73c2:
	and r0,r0,r17
L_8d73c6:
	or r0,r0,0x11
L_8d73ca:
	st_s r0,[r14,0x40]
L_8d73cc:
	mov_s r0,0x3
L_8d73ce:
	bl.d L_8ceb2c
L_8d73d2:
	mov_s r2,0x0
L_8d73d4:
	ld_s r0,[r13,0x6c]
L_8d73d6:
	bclr_s r0,r0,0xb
L_8d73d8:
	bclr_s r0,r0,0xc
L_8d73da:
	bclr_s r0,r0,0xd
L_8d73dc:
	st_s r0,[r13,0x6c]
L_8d73de:
	ld_s r0,[r15,0x30]
L_8d73e0:
	bic r0,r0,0x180
L_8d73e4:
	st_s r0,[r15,0x30]
	.global L_8d73e6
L_8d73e6:
	b L_8c023c
L_8d73ea:
	nop_s
