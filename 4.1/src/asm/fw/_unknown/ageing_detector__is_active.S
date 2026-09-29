/* ageing_detector__is_active @ 0x8d72cc, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ageing_detector__arm, ageing_detector__configure, ageing_detector__get_state, ageing_detector__rearm, tx_ppdu_ageing_timeout_detector__start_monitoring
 */
	.section .text.ageing_detector__is_active,"ax",@progbits
	.global ageing_detector__is_active
ageing_detector__is_active:
	.global L_8d72cc
L_8d72cc:
	ldb r2,[r0, 0x30]
L_8d72d0:
	cmp r2,0xff
L_8d72d4:
	mov_s r1,0x0
L_8d72d6:
	beq_s L_8d72dc
L_8d72d8:
	ld_s r0,[r0,0x34]
L_8d72da:
	brne_s r0,0,L_8d72e0
	.global L_8d72dc
L_8d72dc:
	mov_s r0,r1
L_8d72de:
	b_s L_8d72e2
	.global L_8d72e0
L_8d72e0:
	mov_s r0,0x1
	.global L_8d72e2
L_8d72e2:
	j_s.d [blink]
L_8d72e4:
	extb_s r0,r0
L_8d72e6:
	nop_s
