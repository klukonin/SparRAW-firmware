/* channels_switch_sm__scan_wd_timeout_cb @ 0x8f0180, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::scan_wd_timeout_cb()
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.channels_switch_sm__scan_wd_timeout_cb,"ax",@progbits
	.global channels_switch_sm__scan_wd_timeout_cb
channels_switch_sm__scan_wd_timeout_cb:
	.byte 0x0f
	.byte 0xe8
	.global fwlog_channels_switch_sm_scan_wd_timeout_cb
fwlog_channels_switch_sm_scan_wd_timeout_cb:
L_8f0182:
	nop_s
L_8f0184:
	push_s blink
L_8f0186:
	push_s r13
L_8f0188:
	mov_s r13,r0
L_8f018a:
	mov_s r2,0x1014630
L_8f0190:
	mov_s r0,0x9
L_8f0192:
	bl.d L_8edfb0
L_8f0196:
	mov_s r1,0x1
L_8f0198:
	mov_s r2,0x0
L_8f019a:
	st_s r2,[r13,0x3c]
L_8f019c:
	mov_s r0,r13
L_8f019e:
	mov_s r1,0x7
L_8f01a0:
	mov_s r3,r2
L_8f01a2:
	bl.d L_8d6a1c
L_8f01a6:
	mov_s r4,r2
L_8f01a8:
	b L_8c033c
