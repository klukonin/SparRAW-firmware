/* hwm_analog_channel_switch__thunk_arg1_zero @ 0x8d73ec, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, channels_switch_sm__switch_to_channel
 * Зовёт сам: hwm_analog_channel_switch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwm_analog_channel_switch__thunk_arg1_zero
hwm_analog_channel_switch__thunk_arg1_zero:
	.global L_8d73ec
L_8d73ec:
	mov_s r1,0x0
L_8d73ee:
	b.d L_8d73f4
L_8d73f2:
	mov_s r2,r1
