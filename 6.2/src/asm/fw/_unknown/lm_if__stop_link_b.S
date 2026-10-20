/* lm_if__stop_link_b @ 0x8e8088, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__stop_link_loss_monitoring, tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r13_to_r13_ret, detector__arm_timer, ll_detector__is_armed_b, peer__check_flag_30
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__stop_link_b
lm_if__stop_link_b:
	.global L_8e8088
L_8e8088:
	push_s blink
L_8e808a:
	push_s r13
L_8e808c:
	bl.d L_8da378
L_8e8090:
	mov_s r13,r0
L_8e8092:
	breq_s r0,0,L_8e80a0
L_8e8094:
	bl.d L_8e7e8c
L_8e8098:
	mov_s r0,r13
L_8e809a:
	bl.d L_8c6844
L_8e809e:
	mov_s r0,r13
	.global L_8e80a0
L_8e80a0:
	b L_8c025c
