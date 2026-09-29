/* channels_switch_sm__channel_switched_cb @ 0x8ea180, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::channel_switched_cb()
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.channels_switch_sm__channel_switched_cb,"ax",@progbits
	.global channels_switch_sm__channel_switched_cb
channels_switch_sm__channel_switched_cb:
L_8ea180:
	mov_s r4,r2
	.global fwlog_channels_switch_sm_channel_switched_cb
fwlog_channels_switch_sm_channel_switched_cb:
L_8ea182:
	nop_s
L_8ea184:
	push_s blink
L_8ea186:
	push_s r13
L_8ea188:
	mov_s r13,r1
L_8ea18a:
	mov_s r2,0x1014598
L_8ea190:
	mov_s r0,0x9
L_8ea192:
	bl.d L_8edfb0
L_8ea196:
	mov_s r1,0x2
L_8ea198:
	mov_s r0,r13
L_8ea19a:
	mov_s r1,0x2
L_8ea19c:
	mov_s r2,0x0
L_8ea19e:
	mov_s r3,r2
L_8ea1a0:
	bl.d L_8d6a1c
L_8ea1a4:
	mov_s r4,r2
L_8ea1a6:
	.byte 0x99,0x01
