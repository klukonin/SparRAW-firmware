/* hwf__rladder_calibrate @ 0x8d1898, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, hwf__rf_lo_setup, phy_ber__enable_dig_loopback
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwf_rladder_scan
 */
	.section .text.hwf__rladder_calibrate,"ax",@progbits
	.global hwf__rladder_calibrate
hwf__rladder_calibrate:
	.global L_8d1898
L_8d1898:
	push_s blink
L_8d189a:
	bl.d L_8c02c4
L_8d189e:
	mov_s r1,0xff
L_8d18a0:
	mov_s r14,r0
L_8d18a2:
	mov_s r0,0x0
L_8d18a4:
	bl.d L_8c14b4
L_8d18a8:
	mov_s r2,r14
L_8d18aa:
	mov_s r13,r0
L_8d18ac:
	add_s r0,r0,0x70
L_8d18ae:
	lsr_s r0,r0,0x5
L_8d18b0:
	cmp_s r0,0x20
L_8d18b2:
	mov_s r1,0x20
L_8d18b4:
	mov.cs r1,r0
L_8d18b8:
	extb_s r1,r1
L_8d18ba:
	mov_s r0,0x1
L_8d18bc:
	bl.d L_8c14b4
L_8d18c0:
	mov_s r2,r14
L_8d18c2:
	add_s r0,r0,r13
L_8d18c4:
	b.d L_8c0334
L_8d18c8:
	lsr_s r0,r0
L_8d18ca:
	nop_s
