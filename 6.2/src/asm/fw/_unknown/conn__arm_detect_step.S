/* conn__arm_detect_step @ 0x8e00e8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detectors
 * Зовёт сам: __ld_r13_to_r13_ret, detector__arm_timer, ka_detector__is_enabled, periodic_service__run
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__arm_detect_step
conn__arm_detect_step:
	.global L_8e00e8
L_8e00e8:
	push_s blink
L_8e00ea:
	push_s r13
L_8e00ec:
	bl.d L_8da214
L_8e00f0:
	mov_s r13,r0
L_8e00f2:
	breq_s r0,0,L_8e0100
L_8e00f4:
	bl.d L_8cdc18
L_8e00f8:
	mov_s r0,r13
L_8e00fa:
	bl.d L_8e7e8c
L_8e00fe:
	mov_s r0,r13
	.global L_8e0100
L_8e0100:
	b L_8c025c
