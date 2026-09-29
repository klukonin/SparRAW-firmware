/* ut_hw_drivers_cmd_0x203 @ 0x8d03d8, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__pll_bypass
 * Зовёт сам: pcie__toggle_880c50_bit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers_cmd_0x203
ut_hw_drivers_cmd_0x203:
	.global L_8d03d8
L_8d03d8:
	mov_s r1,0x880c00
L_8d03de:
	ld_s r0,[r1,0x50]
L_8d03e0:
	bclr_s r0,r0,0x1
L_8d03e2:
	st_s r0,[r1,0x50]
L_8d03e4:
	b.d L_8d029c
L_8d03e8:
	mov_s r0,0x0
L_8d03ea:
	nop_s
