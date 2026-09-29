/* channels_switch_sm__scan_rm_lock_timeout_cb @ 0x8f0108, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::scan_rm_lock_timeout_cb()
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.channels_switch_sm__scan_rm_lock_timeout_cb,"ax",@progbits
	.global channels_switch_sm__scan_rm_lock_timeout_cb
channels_switch_sm__scan_rm_lock_timeout_cb:
	.byte 0x0f
	.byte 0xe8
	.global fwlog_channels_switch_sm_scan_rm_lock_timeout_
fwlog_channels_switch_sm_scan_rm_lock_timeout_:
L_8f010a:
	nop_s
L_8f010c:
	push_s blink
L_8f010e:
	push_s r13
L_8f0110:
	mov_s r13,r0
L_8f0112:
	mov_s r2,0x1014600
L_8f0118:
	mov_s r0,0x9
L_8f011a:
	bl.d L_8edfb0
L_8f011e:
	mov_s r1,0x1
L_8f0120:
	mov_s r2,0x0
L_8f0122:
	st_s r2,[r13,0x34]
L_8f0124:
	mov_s r0,r13
L_8f0126:
	mov_s r1,0x7
L_8f0128:
	mov_s r3,r2
L_8f012a:
	bl.d L_8d6a1c
L_8f012e:
	mov_s r4,r2
L_8f0130:
	b L_8c033c
