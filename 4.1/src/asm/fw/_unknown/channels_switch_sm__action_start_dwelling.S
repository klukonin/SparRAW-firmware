/* channels_switch_sm__action_start_dwelling @ 0x8e9164, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_start_dwelling() channel_id %d interval %d
 *   channels_switch_sm::action_start_dwelling() reset_active_probs
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit2, scan_mngr__save_initial_passive_scan_info, u_schd__schedule
 */
	.section .text.channels_switch_sm__action_start_dwelling,"ax",@progbits
	.global channels_switch_sm__action_start_dwelling
channels_switch_sm__action_start_dwelling:
	.byte 0x8f
	.byte 0xeb
	.global fwlog_channels_switch_sm_action_start_dwelling
fwlog_channels_switch_sm_action_start_dwelling:
L_8e9166:
	nop_s
L_8e9168:
	push_s blink
L_8e916a:
	push_s r13
L_8e916c:
	mov_s r13,r0
L_8e916e:
	ld_s r1,[r0,0x40]
L_8e9170:
	ld_s r0,[r0,0x2c]
L_8e9172:
	bl.d L_8efe98
L_8e9176:
	ld_s r1,[r1,0x8]
L_8e9178:
	mov_s r2,0x1014330
L_8e917e:
	ld_s r0,[r13,0x2c]
L_8e9180:
	ld_s r3,[r13,0x40]
L_8e9182:
	mov_s r1,0x2
L_8e9184:
	ld r4,[r0, 0x70]
L_8e9188:
	mov_s r0,0x9
L_8e918a:
	bl.d L_8edff8
L_8e918e:
	ld_s r3,[r3,0x8]
L_8e9190:
	mov_s r2,0x1014378
L_8e9196:
	mov_s r0,0x9
L_8e9198:
	bl.d L_8edfb0
L_8e919c:
	mov_s r1,0x2
L_8e919e:
	ld_s r0,[r13,0x2c]
L_8e91a0:
	mov_s r2,0x0
L_8e91a2:
	stb r2,[r0, 0x8c]
L_8e91a6:
	ld_s r1,[r13,0x2c]
L_8e91a8:
	mov_s r0,0x2b86c
L_8e91ae:
	ld r4,[r1, 0x70]
L_8e91b2:
	mov_s r1,r13
L_8e91b4:
	mov_s r3,0x1
L_8e91b6:
	mov_s r5,r2
L_8e91b8:
	bl.d L_8dc92c
L_8e91bc:
	mov_s r6,r2
L_8e91be:
	b.d L_8c033c
L_8e91c2:
	st_s r0,[r13,0x38]
