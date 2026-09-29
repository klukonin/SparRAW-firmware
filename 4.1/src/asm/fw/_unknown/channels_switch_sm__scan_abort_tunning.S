/* channels_switch_sm__scan_abort_tunning @ 0x8e8f2c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::scan_abort_tunning() while tuning!!!
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.channels_switch_sm__scan_abort_tunning,"ax",@progbits
	.global channels_switch_sm__scan_abort_tunning
channels_switch_sm__scan_abort_tunning:
	.byte 0x8f
	.byte 0xeb
	.global fwlog_channels_switch_sm_scan_abort_tunning_wh
fwlog_channels_switch_sm_scan_abort_tunning_wh:
L_8e8f2e:
	nop_s
L_8e8f30:
	push_s blink
L_8e8f32:
	push_s r13
L_8e8f34:
	mov_s r13,r0
L_8e8f36:
	mov_s r2,0x10144f0
L_8e8f3c:
	mov_s r0,0x9
L_8e8f3e:
	bl.d L_8edfb0
L_8e8f42:
	mov_s r1,0x2
L_8e8f44:
	mov_s r1,0x20
L_8e8f46:
	ld_s r0,[r13,0x2c]
L_8e8f48:
	b.d L_8c033c
