/* ageing_detector__rearm @ 0x8e2fa8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__stop_link_loss_monitoring, tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r13_ret, ageing_detector__configure, ageing_detector__is_active, detector__arm_timer
 */
	.section .text.ageing_detector__rearm,"ax",@progbits
	.global ageing_detector__rearm
ageing_detector__rearm:
	.global L_8e2fa8
L_8e2fa8:
	push_s blink
L_8e2faa:
	push_s r13
L_8e2fac:
	bl.d L_8d72cc
L_8e2fb0:
	mov_s r13,r0
L_8e2fb2:
	breq_s r0,0,L_8e2fc0
L_8e2fb4:
	bl.d L_8e2d84
L_8e2fb8:
	mov_s r0,r13
L_8e2fba:
	bl.d L_8c5acc
L_8e2fbe:
	mov_s r0,r13
	.global L_8e2fc0
L_8e2fc0:
	b L_8c033c
