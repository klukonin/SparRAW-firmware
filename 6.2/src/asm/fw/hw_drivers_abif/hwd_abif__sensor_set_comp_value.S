/* hwd_abif__sensor_set_comp_value @ 0x8cfaa0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, rladder__step_code
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sensor_set_comp_value
hwd_abif__sensor_set_comp_value:
	.global L_8cfaa0
L_8cfaa0:
	mov_s r1,0x889300
L_8cfaa6:
	st_s r0,[r1,0x68]
L_8cfaa8:
	j_s [blink]
L_8cfaaa:
	nop_s
