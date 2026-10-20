/* hwd_phy__read_sar_sample @ 0x8d2474, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step, calib_sar_step2, hwd_phy_rx_sar_rssi_measure
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__read_sar_sample
hwd_phy__read_sar_sample:
	.global L_8d2474
L_8d2474:
	mov_s r2,0x885010
L_8d247a:
	add3_s r2,r2,r0
L_8d247c:
	ld_s r3,[r2]
L_8d247e:
	mov_s r2,0x885014
L_8d2484:
	add3_s r2,r2,r0
L_8d2486:
	ld_s r2,[r2]
L_8d2488:
	extw_s r3,r3
L_8d248a:
	asl_s r2,r2,0x10
L_8d248c:
	add_s r2,r2,r3
L_8d248e:
	asr r3,r2,0x1f
L_8d2492:
	st_s r2,[r1]
L_8d2494:
	st_s r3,[r1,0x4]
L_8d2496:
	mov_s r2,0x885050
L_8d249c:
	add3_s r2,r2,r0
L_8d249e:
	ld_s r3,[r2]
L_8d24a0:
	mov_s r2,0x885054
L_8d24a6:
	add3_s r2,r2,r0
L_8d24a8:
	ld_s r0,[r2]
L_8d24aa:
	extw_s r3,r3
L_8d24ac:
	asl_s r0,r0,0x10
L_8d24ae:
	add_s r0,r0,r3
L_8d24b0:
	asr r2,r0,0x1f
L_8d24b4:
	st_s r0,[r1,0x8]
L_8d24b6:
	j_s.d [blink]
L_8d24b8:
	st_s r2,[r1,0xc]
L_8d24ba:
	nop_s
