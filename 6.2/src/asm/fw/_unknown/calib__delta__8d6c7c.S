/* calib__delta__8d6c7c @ 0x8d6c7c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_battery_phy_step
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, if_gain__scale_value
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib__delta__8d6c7c
calib__delta__8d6c7c:
	.global L_8d6c7c
L_8d6c7c:
	push_s blink
L_8d6c7e:
	bl L_8c01e0
L_8d6c82:
	mov_s r15,r1
L_8d6c84:
	mov_s r13,r2
L_8d6c86:
	bl.d L_8d6dcc
L_8d6c8a:
	mov_s r1,r2
L_8d6c8c:
	mov_s r14,r0
L_8d6c8e:
	mov_s r0,r15
L_8d6c90:
	bl.d L_8d6dcc
L_8d6c94:
	mov_s r1,r13
L_8d6c96:
	b.d L_8c024c
L_8d6c9a:
	rsub r0,r0,r14
L_8d6c9e:
	nop_s
