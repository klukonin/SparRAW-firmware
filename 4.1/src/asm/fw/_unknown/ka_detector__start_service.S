/* ka_detector__start_service @ 0x8de7dc, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__start_detector_services
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ka_detector__get_state, periodic_service__start
 */
	.section .text.ka_detector__start_service,"ax",@progbits
	.global ka_detector__start_service
ka_detector__start_service:
	.global L_8de7dc
L_8de7dc:
	push_s blink
L_8de7de:
	bl L_8c02c4
L_8de7e2:
	mov_s r13,r0
L_8de7e4:
	bl.d L_8d714c
L_8de7e8:
	mov_s r14,r1
L_8de7ea:
	breq_s r0,0,L_8de7fa
L_8de7ec:
	cmp_s r14,0x0
L_8de7ee:
	mov_s r0,r13
L_8de7f0:
	mov_s r1,0x0
L_8de7f2:
	mov.eq r1,0x2
L_8de7f6:
	bl L_8e2570
	.global L_8de7fa
L_8de7fa:
	b L_8c0334
L_8de7fe:
	nop_s
