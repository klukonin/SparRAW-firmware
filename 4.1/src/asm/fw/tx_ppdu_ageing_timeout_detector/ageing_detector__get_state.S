/* ageing_detector__get_state @ 0x8d71a0, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_ppdu_ageing_timeout_detector.cpp
 * Зовут его: ageing_detector__start_service, tx_ppdu_ageing_timeout_detector__start_monitoring, tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r13_ret, ageing_detector__is_active, fw_sysassert_fatal
 */
	.section .text.ageing_detector__get_state,"ax",@progbits
	.global ageing_detector__get_state
ageing_detector__get_state:
	.global L_8d71a0
L_8d71a0:
	push_s blink
L_8d71a2:
	push_s r13
L_8d71a4:
	bl.d L_8d72cc
L_8d71a8:
	mov_s r13,r0
L_8d71aa:
	cmp_s r0,0x0
L_8d71ac:
	mov_s r0,0x0
L_8d71ae:
	beq_s L_8d71da
L_8d71b0:
	ldb r0,[r13, 0x30]
L_8d71b4:
	brge r0,0x8,L_8d71de
	.global L_8d71b8
L_8d71b8:
	ldb r1,[r13, 0x30]
L_8d71bc:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8d71be:
	ld_s r2,[r13,0x34]
L_8d71c0:
	add3_s r1,r1,r1
L_8d71c2:
	ld_s r1,[r2,r1]
L_8d71c4:
	mov_s r0,0x0
L_8d71c6:
	bbit0 r1,0x0,L_8d71d8
L_8d71ca:
	mov_s r1,0x80345c
L_8d71d0:
	ld_s r1,[r1,0xc]
L_8d71d2:
	cmp_s r1,0x0
L_8d71d4:
	mov.eq r0,0x1
	.global L_8d71d8
L_8d71d8:
	extb_s r0,r0
	.global L_8d71da
L_8d71da:
	b L_8c033c
	.global L_8d71de
L_8d71de:
	mov_s r0,blink
L_8d71e0:
	mov_s r2,0x1010ff0
L_8d71e6:
	mov_s r1,0x1479
L_8d71ec:
	bl.d L_8c82c0
L_8d71f0:
	mov_s r3,0x9d
L_8d71f2:
	b_s L_8d71b8
