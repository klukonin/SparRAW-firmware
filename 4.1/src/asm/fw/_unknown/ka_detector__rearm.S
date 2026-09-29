/* ka_detector__rearm @ 0x8e2f8c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task, lm_if__stop_link_loss_monitoring
 * Зовёт сам: __ld_r13_ret, detector__arm_timer, ka_detector__configure, ka_detector__is_active
 */
	.section .text.ka_detector__rearm,"ax",@progbits
	.global ka_detector__rearm
ka_detector__rearm:
	.global L_8e2f8c
L_8e2f8c:
	push_s blink
L_8e2f8e:
	push_s r13
L_8e2f90:
	bl.d L_8d72b0
L_8e2f94:
	mov_s r13,r0
L_8e2f96:
	breq_s r0,0,L_8e2fa4
L_8e2f98:
	bl.d L_8e2d84
L_8e2f9c:
	mov_s r0,r13
L_8e2f9e:
	bl.d L_8c5a70
L_8e2fa2:
	mov_s r0,r13
	.global L_8e2fa4
L_8e2fa4:
	b L_8c033c
