/* detector__arm_timer @ 0x8e2d84, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ageing_detector__arm, ageing_detector__rearm, ka_detector__arm, ka_detector__rearm, ka_necessity_detector__start_monitoring, phy_monitor__on_system_state, tx_ppdu_ageing_timeout_detector__start_monitoring
 * Зовёт сам: __ld_r13_ret, fw_read_timer, timer_task__cancel
 */
	.section .text.detector__arm_timer,"ax",@progbits
	.global detector__arm_timer
detector__arm_timer:
	.global L_8e2d84
L_8e2d84:
	push_s blink
L_8e2d86:
	push_s r13
L_8e2d88:
	bl.d L_8e4694
L_8e2d8c:
	mov_s r13,r0
L_8e2d8e:
	bl.d L_8c783c
L_8e2d92:
	mov_s r0,r13
L_8e2d94:
	mov_s r0,0x1
L_8e2d96:
	b.d L_8c033c
L_8e2d9a:
	st_s r0,[r13,0x28]
