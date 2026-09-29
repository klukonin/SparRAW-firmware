/* channels_switch_sm__action_radio_tunned @ 0x8e90f4, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_radio_tunned(p1-%d)
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, scan_mngr__sm_ready_for_dwelling
 */
	.section .text.channels_switch_sm__action_radio_tunned,"ax",@progbits
	.global channels_switch_sm__action_radio_tunned
channels_switch_sm__action_radio_tunned:
L_8e90f4:
	add_s sp,sp,0x4
	.global fwlog_channels_switch_sm_action_radio_tunned_p
fwlog_channels_switch_sm_action_radio_tunned_p:
L_8e90f6:
	nop_s
L_8e90f8:
	push_s blink
L_8e90fa:
	push_s r13
L_8e90fc:
	mov_s r13,r0
L_8e90fe:
	mov_s r3,r1
L_8e9100:
	mov_s r2,0x10143f4
L_8e9106:
	mov_s r0,0x9
L_8e9108:
	bl.d L_8edfcc
L_8e910c:
	mov_s r1,0x2
L_8e910e:
	bl.d L_8f0d9c
L_8e9112:
	ld_s r0,[r13,0x2c]
L_8e9114:
	b L_8c033c
