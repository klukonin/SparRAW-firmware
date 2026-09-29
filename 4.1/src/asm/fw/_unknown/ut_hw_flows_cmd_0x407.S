/* ut_hw_flows_cmd_0x407 @ 0x8d359c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_phy__rgf_885000_8cf184, hwd_phy__set_885000, hwd_phy_dbg_clk_enable
 */
	.section .text.ut_hw_flows_cmd_0x407,"ax",@progbits
	.global ut_hw_flows_cmd_0x407
ut_hw_flows_cmd_0x407:
	.global L_8d359c
L_8d359c:
	push_s blink
L_8d359e:
	bl L_8c02c4
L_8d35a2:
	mov_s r14,r0
L_8d35a4:
	mov_s r13,r1
L_8d35a6:
	bl.d L_8ceed4
L_8d35aa:
	mov_s r0,0x1
L_8d35ac:
	mov_s r0,r13
L_8d35ae:
	mov_s r1,0x1
L_8d35b0:
	mov_s r2,0x0
L_8d35b2:
	mov_s r3,0x64
L_8d35b4:
	mov_s r4,r3
L_8d35b6:
	bl.d L_8cf140
L_8d35ba:
	mov_s r5,r14
L_8d35bc:
	bl L_8cf184
L_8d35c0:
	b L_8c0334
