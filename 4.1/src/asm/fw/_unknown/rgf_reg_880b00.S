/* rgf_reg_880b00 @ 0x8d154c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_init__2, hwf_phy_production_loopback_test
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.rgf_reg_880b00,"ax",@progbits
	.global rgf_reg_880b00
rgf_reg_880b00:
	.global L_8d154c
L_8d154c:
	push_s blink
L_8d154e:
	bl L_8c02c4
L_8d1552:
	mov_s r13,r0
L_8d1554:
	mov_s r14,r1
L_8d1556:
	bl.d L_8d14a8
L_8d155a:
	mov_s r0,r1
L_8d155c:
	mov_s r1,0x880b00
L_8d1562:
	ld_s r2,[r1,0x6c]
L_8d1564:
	mov r0,-0x1
L_8d1568:
	asl_s r0,r0,r14
L_8d156a:
	bic_s r2,r2,r0
L_8d156c:
	asl_s r13,r13,r14
L_8d156e:
	or_s r13,r13,r2
L_8d1570:
	st_s r13,[r1,0x6c]
L_8d1572:
	b L_8c0334
L_8d1576:
	nop_s
