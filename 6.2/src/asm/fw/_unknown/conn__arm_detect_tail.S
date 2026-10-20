/* conn__arm_detect_tail @ 0x8e0104, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detectors
 * Зовёт сам: __ld_r13_to_r13_ret, detector__arm_timer, ll_detector__is_armed_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__arm_detect_tail
conn__arm_detect_tail:
	.global L_8e0104
L_8e0104:
	push_s blink
L_8e0106:
	push_s r13
L_8e0108:
	bl.d L_8da378
L_8e010c:
	mov_s r13,r0
L_8e010e:
	cmp_s r0,0x0
L_8e0110:
	bl.ne.d L_8e7e8c
L_8e0114:
	mov.ne r0,r13
L_8e0118:
	b L_8c025c
