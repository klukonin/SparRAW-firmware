/* sm__defer_call_thunk @ 0x8e70c0, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__kick_channel_switch_sm, wait_sm__action_8e2b8c
 * Зовёт сам: sm__defer_call
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm__defer_call_thunk
sm__defer_call_thunk:
	.global L_8e70c0
L_8e70c0:
	b L_8e7044
