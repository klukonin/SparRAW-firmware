/* detector__arm_timer @ 0x8e7e8c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detect_step, conn__arm_detect_tail, ka_necessity_detector__start_monitoring, lm_if__stop_link_a, lm_if__stop_link_b, phy_monitor__on_system_state, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r13_to_r13_ret, timer_task__cancel, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global detector__arm_timer
detector__arm_timer:
	.global L_8e7e8c
L_8e7e8c:
	push_s blink
L_8e7e8e:
	push_s r13
L_8e7e90:
	bl.d L_8e9524
L_8e7e94:
	mov_s r13,r0
L_8e7e96:
	bl.d L_8c8e74
L_8e7e9a:
	mov_s r0,r13
L_8e7e9c:
	mov_s r0,0x1
L_8e7e9e:
	b.d L_8c025c
L_8e7ea2:
	st_s r0,[r13,0x28]
