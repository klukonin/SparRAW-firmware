/* scan_mngr__start_dwell_event_cb @ 0x8f12c8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::start_dwell_event_cb()
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0
 */
	.section .text.scan_mngr__start_dwell_event_cb,"ax",@progbits
	.global scan_mngr__start_dwell_event_cb
scan_mngr__start_dwell_event_cb:
L_8f12c8:
	/* b_s 0x008f128e */
	.byte 0xe3,0xf1
	.global fwlog_scan_mngr_start_dwell_event_cb
fwlog_scan_mngr_start_dwell_event_cb:
L_8f12ca:
	nop_s
L_8f12cc:
	push_s blink
L_8f12ce:
	push_s r13
L_8f12d0:
	mov_s r13,r0
L_8f12d2:
	mov_s r2,0x1013d8c
L_8f12d8:
	mov_s r0,0x9
L_8f12da:
	bl.d L_8edfb0
L_8f12de:
	mov_s r1,0x2
L_8f12e0:
	mov_s r2,0x0
L_8f12e2:
	st r2,[r13, 0x88]
L_8f12e6:
	ld r0,[r13, 0x84]
L_8f12ea:
	mov_s r1,0x3
L_8f12ec:
	mov_s r3,r2
L_8f12ee:
	bl.d L_8d6a1c
L_8f12f2:
	mov_s r4,r2
L_8f12f4:
	b L_8c033c
