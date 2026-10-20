/* ageing_detector__arm @ 0x8dbff0, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detectors
 * Зовёт сам: ageing_detector__is_active, detector__arm_timer
 */
	.section .text.ageing_detector__arm,"ax",@progbits
	.global ageing_detector__arm
ageing_detector__arm:
	.global L_8dbff0
L_8dbff0:
	push_s blink
L_8dbff2:
	bl.d L_8d72cc
L_8dbff6:
	mov_s r3,r0
L_8dbff8:
	cmp_s r0,0x0
L_8dbffa:
	bl.ne.d L_8e2d84
L_8dbffe:
	mov.ne r0,r3
L_8dc002:
	pop_s blink
L_8dc004:
	j_s [blink]
L_8dc006:
	nop_s
