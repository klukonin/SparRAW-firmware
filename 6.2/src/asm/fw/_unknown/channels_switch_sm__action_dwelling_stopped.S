/* channels_switch_sm__action_dwelling_stopped @ 0x8c2174, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_dwelling_stopped() channel_id %d
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit1, scan_mngr__calculate_passive_scan_info, scan_mngr__sm_dwelling_ended
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_dwelling_stopped
channels_switch_sm__action_dwelling_stopped:
	.global L_8c2174
L_8c2174:
	push_s blink
L_8c2176:
	push_s r13
L_8c2178:
	mov_s r13,r0
L_8c217a:
	mov_s r1,0x10173f4
L_8c2180:
	ld_s r2,[r0,0x1c]
L_8c2182:
	mov_s r0,0x29
L_8c2184:
	bl.d L_8dcc10
L_8c2188:
	ld_s r2,[r2,0x8]
L_8c218a:
	ld_s r1,[r13,0x1c]
L_8c218c:
	ld_s r0,[r13,0x8]
L_8c218e:
	bl.d L_8f16ec
L_8c2192:
	ld_s r1,[r1,0x8]
L_8c2194:
	bl.d L_8f90e8
L_8c2198:
	ld_s r0,[r13,0x8]
L_8c219a:
	b L_8c025c
L_8c219e:
	nop_s
