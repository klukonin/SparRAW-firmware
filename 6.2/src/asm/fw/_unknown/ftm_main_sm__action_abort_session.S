/* ftm_main_sm__action_abort_session @ 0x8f0568, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ftm_main_sm::action_abort_session()
 * Зовёт сам: ftm__ctx_addr, fw_log_emit0, tof_mgr__ftm_error_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ftm_main_sm__action_abort_session
ftm_main_sm__action_abort_session:
	.global L_8f0568
L_8f0568:
	push_s blink
L_8f056a:
	mov_s r1,0x1019fe0
L_8f0570:
	bl.d L_8dcba8
L_8f0574:
	mov_s r0,0x2b
L_8f0576:
	bl L_8ccf04
L_8f057a:
	bl L_8cb210
L_8f057e:
	pop_s blink
L_8f0580:
	j_s [blink]
L_8f0582:
	nop_s
