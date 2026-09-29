/* car__enable_pll3_and_wait_on @ 0x8d03ec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm__reset_analog_block
 * Зовёт сам: car__enable_pll3_and_wait
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global car__enable_pll3_and_wait_on
car__enable_pll3_and_wait_on:
	.global L_8d03ec
L_8d03ec:
	b.d L_8d0320
L_8d03f0:
	mov_s r0,0x1
L_8d03f2:
	nop_s
