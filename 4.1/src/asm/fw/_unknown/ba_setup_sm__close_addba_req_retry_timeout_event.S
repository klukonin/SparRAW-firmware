/* ba_setup_sm__close_addba_req_retry_timeout_event @ 0x8ea460, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::close_addba_req_retry_timeout_event delete event.
 * Зовут его: ba_setup_sm__close_all_timers
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, u_schd__cancel
 */
	.section .text.ba_setup_sm__close_addba_req_retry_timeout_event,"ax",@progbits
	.global ba_setup_sm__close_addba_req_retry_timeout_event
ba_setup_sm__close_addba_req_retry_timeout_event:
	.global L_8ea460
L_8ea460:
	push_s blink
L_8ea462:
	push_s r13
L_8ea464:
	mov_s r13,r0
L_8ea466:
	ld_s r0,[r0,0x34]
L_8ea468:
	breq_s r0,0,L_8ea47e
L_8ea46a:
	mov_s r2,0x10102d4
L_8ea470:
	mov_s r0,0x7
L_8ea472:
	bl.d L_8edfb0
L_8ea476:
	mov_s r1,0x2
L_8ea478:
	bl.d L_8c7794
L_8ea47c:
	ld_s r0,[r13,0x34]
	.global L_8ea47e
L_8ea47e:
	mov_s r0,0x0
L_8ea480:
	b.d L_8c033c
L_8ea484:
	st_s r0,[r13,0x34]
L_8ea486:
	nop_s
