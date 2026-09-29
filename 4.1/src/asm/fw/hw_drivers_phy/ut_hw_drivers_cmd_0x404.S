/* ut_hw_drivers_cmd_0x404 @ 0x8cfca8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf_PHY_DIG_LOOPBACK_BER_TEST
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x404,"ax",@progbits
	.global ut_hw_drivers_cmd_0x404
ut_hw_drivers_cmd_0x404:
	.global L_8cfca8
L_8cfca8:
	push_s blink
L_8cfcaa:
	push_s r13
L_8cfcac:
	mov_s r13,r0
L_8cfcae:
	bclr.f r0,r0,0x0
L_8cfcb2:
	bne_s L_8cfcc8
	.global L_8cfcb4
L_8cfcb4:
	mov_s r1,0x883000
L_8cfcba:
	ld_s r0,[r1,0x10]
L_8cfcbc:
	asl_s r13,r13
L_8cfcbe:
	bclr_s r0,r0,0x1
L_8cfcc0:
	or_s r13,r13,r0
L_8cfcc2:
	st_s r13,[r1,0x10]
L_8cfcc4:
	b L_8c033c
	.global L_8cfcc8
L_8cfcc8:
	mov_s r0,blink
L_8cfcca:
	mov_s r2,0x1018690
L_8cfcd0:
	mov_s r1,0xac
L_8cfcd2:
	bl.d L_8c82c0
L_8cfcd6:
	mov_s r3,0xbd
L_8cfcd8:
	b_s L_8cfcb4
L_8cfcda:
	nop_s
