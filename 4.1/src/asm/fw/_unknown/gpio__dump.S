/* gpio__dump @ 0x8d13dc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   GPIO0 = 0x%8X GPIO1 = 0x%8X GPIO2 = 0x%8X
 * Зовут его: SDP__sdp_init__2, hwf_phy_production_loopback_test
 * Зовёт сам: SDP__hwd_sdp_is_defined_mode, SDP__hwd_sdp_is_gpio_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3
 */
	.section .text.gpio__dump,"ax",@progbits
	.global gpio__dump
gpio__dump:
	.global L_8d13dc
L_8d13dc:
	push_s blink
L_8d13de:
	bl L_8c02c4
L_8d13e2:
	mov_s r13,r0
L_8d13e4:
	bl.d L_8d1478
L_8d13e8:
	mov_s r14,r1
L_8d13ea:
	bl.d L_8d14d8
L_8d13ee:
	mov_s r0,r14
L_8d13f0:
	sub_s r1,r14,0x5
L_8d13f2:
	lsr r2,r1,0x3
L_8d13f6:
	bmsk_s r1,r1,0x2
L_8d13f8:
	mov_s r0,0x880068
L_8d13fe:
	add2_s r0,r0,r2
L_8d1400:
	ld_s r3,[r0]
L_8d1402:
	mov_s r2,0xf
L_8d1404:
	asl_s r2,r2,r1
L_8d1406:
	bic_s r3,r3,r2
L_8d1408:
	asl_s r13,r13,r1
L_8d140a:
	or_s r13,r13,r3
L_8d140c:
	st_s r13,[r0]
L_8d140e:
	mov_s r0,0x11
L_8d1410:
	asl_s r0,r0,0x13
L_8d1412:
	ld_s r3,[r0,0x68]
L_8d1414:
	mov_s r2,0x1019d98
L_8d141a:
	ld r4,[r0, 0x6c]
L_8d141e:
	ld r5,[r0, 0x70]
L_8d1422:
	mov_s r0,0x0
L_8d1424:
	bl.d L_8ee034
L_8d1428:
	mov_s r1,0x2
L_8d142a:
	b L_8c0334
L_8d142e:
	nop_s
