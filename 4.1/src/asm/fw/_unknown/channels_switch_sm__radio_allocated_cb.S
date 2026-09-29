/* channels_switch_sm__radio_allocated_cb @ 0x8efc0c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::radio_allocated_cb()
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.channels_switch_sm__radio_allocated_cb,"ax",@progbits
	.global channels_switch_sm__radio_allocated_cb
channels_switch_sm__radio_allocated_cb:
L_8efc0c:
	mov_s r3,0x1
	.global fwlog_channels_switch_sm_radio_allocated_cb
fwlog_channels_switch_sm_radio_allocated_cb:
L_8efc0e:
	nop_s
L_8efc10:
	push_s blink
L_8efc12:
	push_s r13
L_8efc14:
	mov_s r13,r1
L_8efc16:
	mov_s r2,0x101456c
L_8efc1c:
	mov_s r0,0x9
L_8efc1e:
	bl.d L_8edfb0
L_8efc22:
	mov_s r1,0x2
L_8efc24:
	mov_s r0,r13
L_8efc26:
	mov_s r1,0x1
L_8efc28:
	mov_s r2,0x0
L_8efc2a:
	mov_s r3,r2
L_8efc2c:
	bl.d L_8d6a1c
L_8efc30:
	mov_s r4,r2
L_8efc32:
	.byte 0x0d,0x07
