/* ageing_detector__start_service @ 0x8de800, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__start_detector_services
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ageing_detector__get_state, periodic_service__start
 */
	.section .text.ageing_detector__start_service,"ax",@progbits
	.global ageing_detector__start_service
ageing_detector__start_service:
	.global L_8de800
L_8de800:
	push_s blink
L_8de802:
	bl L_8c02c4
L_8de806:
	mov_s r13,r0
L_8de808:
	bl.d L_8d71a0
L_8de80c:
	mov_s r14,r1
L_8de80e:
	breq_s r0,0,L_8de81e
L_8de810:
	cmp_s r14,0x0
L_8de812:
	mov_s r0,r13
L_8de814:
	mov_s r1,0x0
L_8de816:
	mov.eq r1,0x2
L_8de81a:
	bl L_8e2570
	.global L_8de81e
L_8de81e:
	b L_8c0334
L_8de822:
	nop_s
