/* hwd_phy__wait_ready_884054 @ 0x8d02ac, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST, hwf_PHY_IF_LOOPBACK_BER_TEST
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.hwd_phy__wait_ready_884054,"ax",@progbits
	.global hwd_phy__wait_ready_884054
hwd_phy__wait_ready_884054:
	.global L_8d02ac
L_8d02ac:
	push_s blink
L_8d02ae:
	mov_s r0,0x884000
L_8d02b4:
	ld_s r0,[r0,0x54]
L_8d02b6:
	extw_s r0,r0
L_8d02b8:
	brne r0,0xffff,L_8d02e4
L_8d02c0:
	mov_s r0,blink
L_8d02c2:
	mov_s r2,0x1018690
L_8d02c8:
	mov_s r1,0xdc
L_8d02ca:
	bset_s r1,r1,0xc
L_8d02cc:
	bl.d L_8c82c0
L_8d02d0:
	mov_s r3,0xfe
L_8d02d2:
	b_s L_8d02e4
	.global L_8d02d4
L_8d02d4:
	mov_s r0,0x50
L_8d02d6:
	mov lp_count,r0
L_8d02da:
	nop_s
L_8d02dc:
	lp L_8d02e4
L_8d02e0:
	nop_s
L_8d02e2:
	nop_s
	.global L_8d02e4
L_8d02e4:
	mov_s r0,0x884080
L_8d02ea:
	ld_s r0,[r0,0x70]
L_8d02ec:
	extw.f 0x0,r0
L_8d02f0:
	bne_s L_8d02d4
L_8d02f2:
	b_s L_8d0304
	.global L_8d02f4
L_8d02f4:
	mov_s r0,0x50
L_8d02f6:
	mov lp_count,r0
L_8d02fa:
	nop_s
L_8d02fc:
	lp L_8d0304
L_8d0300:
	nop_s
L_8d0302:
	nop_s
	.global L_8d0304
L_8d0304:
	mov_s r0,0x884080
L_8d030a:
	ld_s r0,[r0,0x6c]
L_8d030c:
	bmsk.f 0x0,r0,0x15
L_8d0310:
	bne_s L_8d02f4
L_8d0312:
	pop_s blink
L_8d0314:
	j_s [blink]
L_8d0316:
	nop_s
