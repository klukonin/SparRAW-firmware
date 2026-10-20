/* ka_detector__arm @ 0x8dbfd4, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detectors
 * Зовёт сам: __ld_r13_ret, detector__arm_timer, ka_detector__get_state, periodic_service__run
 */
	.section .text.ka_detector__arm,"ax",@progbits
	.global ka_detector__arm
ka_detector__arm:
	.global L_8dbfd4
L_8dbfd4:
	push_s blink
L_8dbfd6:
	push_s r13
L_8dbfd8:
	bl.d L_8d714c
L_8dbfdc:
	mov_s r13,r0
L_8dbfde:
	breq_s r0,0,L_8dbfec
L_8dbfe0:
	bl.d L_8cb600
L_8dbfe4:
	mov_s r0,r13
L_8dbfe6:
	bl.d L_8e2d84
L_8dbfea:
	mov_s r0,r13
	.global L_8dbfec
L_8dbfec:
	b L_8c033c
