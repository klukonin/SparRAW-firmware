/* calib__delta_80161c @ 0x8d3f1c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_battery_phy_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, if_gain__scale_value
 */
	.section .text.calib__delta_80161c,"ax",@progbits
	.global calib__delta_80161c
calib__delta_80161c:
	.global L_8d3f1c
L_8d3f1c:
	push_s blink
L_8d3f1e:
	bl L_8c02c0
L_8d3f22:
	mov_s r15,r1
L_8d3f24:
	mov_s r13,r2
L_8d3f26:
	bl.d L_8d406c
L_8d3f2a:
	mov_s r1,r2
L_8d3f2c:
	mov_s r14,r0
L_8d3f2e:
	mov_s r0,r15
L_8d3f30:
	bl.d L_8d406c
L_8d3f34:
	mov_s r1,r13
L_8d3f36:
	b.d L_8c032c
L_8d3f3a:
	rsub r0,r0,r14
L_8d3f3e:
	nop_s
