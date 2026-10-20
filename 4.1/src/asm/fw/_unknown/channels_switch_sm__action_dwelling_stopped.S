/* channels_switch_sm__action_dwelling_stopped @ 0x8e8fd8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_dwelling_stopped() channel_id %d
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, scan_mngr__calculate_passive_scan_info, scan_mngr__sm_dwelling_ended
 */
	.section .text.channels_switch_sm__action_dwelling_stopped,"ax",@progbits
	.global channels_switch_sm__action_dwelling_stopped
channels_switch_sm__action_dwelling_stopped:
L_8e8fd8:
	st_s r0,[r13,0x3c]
	.global fwlog_channels_switch_sm_action_dwelling_stopp
fwlog_channels_switch_sm_action_dwelling_stopp:
L_8e8fda:
	nop_s
L_8e8fdc:
	push_s blink
L_8e8fde:
	push_s r13
L_8e8fe0:
	mov_s r13,r0
L_8e8fe2:
	mov_s r2,0x10143b8
L_8e8fe8:
	ld_s r3,[r0,0x40]
L_8e8fea:
	mov_s r0,0x9
L_8e8fec:
	mov_s r1,0x2
L_8e8fee:
	bl.d L_8edfcc
L_8e8ff2:
	ld_s r3,[r3,0x8]
L_8e8ff4:
	ld_s r1,[r13,0x40]
L_8e8ff6:
	ld_s r0,[r13,0x2c]
L_8e8ff8:
	bl.d L_8ea0d4
L_8e8ffc:
	ld_s r1,[r1,0x8]
L_8e8ffe:
	bl.d L_8f0d18
L_8e9002:
	ld_s r0,[r13,0x2c]
L_8e9004:
	b L_8c033c
