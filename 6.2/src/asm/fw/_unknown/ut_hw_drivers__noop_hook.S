/* ut_hw_drivers__noop_hook @ 0x8d1b28, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers__noop_hook
ut_hw_drivers__noop_hook:
	.global L_8d1b28
L_8d1b28:
	j_s [blink]
L_8d1b2a:
	nop_s
