/* scan_mngr__kick_scan_state_machine @ 0x8f5d1c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::kick_scan_state_machine() - Non connected scan. Calling the channel switch state machine to start scanning: START_SCAN
 *   scan_mngr::kick_scan_state_machine() - Scan while connected. Kicking the scan while connect state machine to start scanning
 * Зовут его: scan_mngr__resume_scan, scan_mngr__start_scan
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__kick_scan_state_machine
scan_mngr__kick_scan_state_machine:
	.global L_8f5d1c
L_8f5d1c:
	push_s blink
L_8f5d1e:
	push_s r13
L_8f5d20:
	mov_s r13,r0
L_8f5d22:
	ld.as r0,[r0,0x89]
L_8f5d26:
	brne_s r0,0,L_8f5d3e
L_8f5d28:
	mov_s r1,0x10150fc
L_8f5d2e:
	bl.d L_8dcba8
L_8f5d32:
	mov_s r0,0x29
L_8f5d34:
	ld r0,[r13, 0x80]
L_8f5d38:
	mov_s r1,0x0
L_8f5d3a:
	mov_s r2,r1
L_8f5d3c:
	b_s L_8f5d52
	.global L_8f5d3e
L_8f5d3e:
	mov_s r1,0x1015180
L_8f5d44:
	bl.d L_8dcba8
L_8f5d48:
	mov_s r0,0x29
L_8f5d4a:
	add3 r0,r13,0x3a
L_8f5d4e:
	mov_s r1,0x0
L_8f5d50:
	mov_s r2,r13
	.global L_8f5d52
L_8f5d52:
	mov_s r3,0x0
L_8f5d54:
	bl.d L_8d9b6c
L_8f5d58:
	mov_s r4,r3
L_8f5d5a:
	b L_8c025c
L_8f5d5e:
	nop_s
