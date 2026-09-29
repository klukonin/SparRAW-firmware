/* channels_switch_sm__channel_switched_cb @ 0x8c5ed4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::channel_switched_cb()
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__channel_switched_cb
channels_switch_sm__channel_switched_cb:
	.global L_8c5ed4
L_8c5ed4:
	push_s blink
L_8c5ed6:
	push_s r13
L_8c5ed8:
	mov_s r13,r1
L_8c5eda:
	mov_s r1,0x10175cc
L_8c5ee0:
	bl.d L_8dcba8
L_8c5ee4:
	mov_s r0,0x29
L_8c5ee6:
	mov_s r0,r13
L_8c5ee8:
	mov_s r1,0x2
L_8c5eea:
	mov_s r2,0x0
L_8c5eec:
	mov_s r3,r2
L_8c5eee:
	bl.d L_8d9b6c
L_8c5ef2:
	mov_s r4,r2
L_8c5ef4:
	b L_8c025c
