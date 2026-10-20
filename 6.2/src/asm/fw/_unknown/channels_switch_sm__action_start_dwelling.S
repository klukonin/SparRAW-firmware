/* channels_switch_sm__action_start_dwelling @ 0x8c2354, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::action_start_dwelling() channel_id %d interval %d
 *   channels_switch_sm::action_start_dwelling() reset_active_probs
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit2, scan_mngr__save_initial_passive_scan_info, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__action_start_dwelling
channels_switch_sm__action_start_dwelling:
	.global L_8c2354
L_8c2354:
	push_s blink
L_8c2356:
	push_s r13
L_8c2358:
	mov_s r13,r0
L_8c235a:
	ld_s r1,[r0,0x1c]
L_8c235c:
	ld_s r0,[r0,0x8]
L_8c235e:
	bl.d L_8f81c0
L_8c2362:
	ld_s r1,[r1,0x8]
L_8c2364:
	mov_s r1,0x101736c
L_8c236a:
	ld_s r2,[r13,0x1c]
L_8c236c:
	mov_s r0,0x29
L_8c236e:
	ld_s r3,[r13,0x8]
L_8c2370:
	ld_s r2,[r2,0x8]
L_8c2372:
	bl.d L_8dcc80
L_8c2376:
	ld_s r3,[r3,0x70]
L_8c2378:
	mov_s r1,0x10173b4
L_8c237e:
	bl.d L_8dcba8
L_8c2382:
	mov_s r0,0x29
L_8c2384:
	ld_s r0,[r13,0x8]
L_8c2386:
	mov_s r2,0x0
L_8c2388:
	add r0,r0,0x215
L_8c238c:
	stb_s r2,[r0]
L_8c238e:
	ld_s r1,[r13,0x8]
L_8c2390:
	mov_s r0,L_8c980c-0x8c0000
L_8c2396:
	ld r4,[r1, 0x70]
L_8c239a:
	mov_s r1,r13
L_8c239c:
	mov_s r3,0x1
L_8c239e:
	mov_s r5,r2
L_8c23a0:
	bl.d L_8e0c0c
L_8c23a4:
	mov_s r6,r2
L_8c23a6:
	b.d L_8c025c
L_8c23aa:
	st_s r0,[r13,0x14]
