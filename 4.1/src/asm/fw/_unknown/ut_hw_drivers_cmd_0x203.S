/* ut_hw_drivers_cmd_0x203 @ 0x8cd54c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__pll_bypass
 * Зовёт сам: car__toggle_pll_and_wait
 */
	.section .text.ut_hw_drivers_cmd_0x203,"ax",@progbits
	.global ut_hw_drivers_cmd_0x203
ut_hw_drivers_cmd_0x203:
	.global L_8cd54c
L_8cd54c:
	mov_s r1,0x880c00
L_8cd552:
	ld_s r0,[r1,0x50]
L_8cd554:
	bclr_s r0,r0,0x1
L_8cd556:
	st_s r0,[r1,0x50]
L_8cd558:
	b.d L_8cd3e0
L_8cd55c:
	mov_s r0,0x0
L_8cd55e:
	nop_s
