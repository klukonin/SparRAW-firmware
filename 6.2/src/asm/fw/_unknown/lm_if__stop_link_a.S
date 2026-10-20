/* lm_if__stop_link_a @ 0x8e806c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task, lm_if__stop_link_loss_monitoring
 * Зовёт сам: __ld_r13_to_r13_ret, detector__arm_timer, ka__check_peer_state, ll_detector__is_armed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_if__stop_link_a
lm_if__stop_link_a:
	.global L_8e806c
L_8e806c:
	push_s blink
L_8e806e:
	push_s r13
L_8e8070:
	bl.d L_8da35c
L_8e8074:
	mov_s r13,r0
L_8e8076:
	breq_s r0,0,L_8e8084
L_8e8078:
	bl.d L_8e7e8c
L_8e807c:
	mov_s r0,r13
L_8e807e:
	bl.d L_8c67f0
L_8e8082:
	mov_s r0,r13
	.global L_8e8084
L_8e8084:
	b L_8c025c
