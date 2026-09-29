/* ba_setup_sm__close_all_timers @ 0x8ea430, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_setup_sm__abort, ba_setup_sm__on_abort
 * Зовёт сам: __ld_r13_ret, ba_setup_sm__close_addba_req_retry_timeout_event, ba_setup_sm__close_addba_resp_timeout, ba_setup_sm__close_ba_setup_global_timeout
 */
	.section .text.ba_setup_sm__close_all_timers,"ax",@progbits
	.global ba_setup_sm__close_all_timers
ba_setup_sm__close_all_timers:
	.global L_8ea430
L_8ea430:
	push_s blink
L_8ea432:
	push_s r13
L_8ea434:
	mov_s r13,r0
L_8ea436:
	ld_s r0,[r0,0x30]
L_8ea438:
	cmp_s r0,0x0
L_8ea43a:
	bl.ne.d L_8ea488
L_8ea43e:
	mov.ne r0,r13
L_8ea442:
	ld_s r0,[r13,0x38]
L_8ea444:
	cmp_s r0,0x0
L_8ea446:
	bl.ne.d L_8ea4b0
L_8ea44a:
	mov.ne r0,r13
L_8ea44e:
	ld_s r0,[r13,0x34]
L_8ea450:
	cmp_s r0,0x0
L_8ea452:
	bl.ne.d L_8ea460
L_8ea456:
	mov.ne r0,r13
L_8ea45a:
	b L_8c033c
L_8ea45e:
	nop_s
