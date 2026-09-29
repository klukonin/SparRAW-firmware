/* ll_detector__is_armed_b @ 0x8da378, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detect_tail, lm_if__stop_link_b, peer__check_flag_30, tx_ageing_detector__is_enabled, tx_ppdu_ageing_timeout_detector__start_monitoring
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ll_detector__is_armed_b
ll_detector__is_armed_b:
	.global L_8da378
L_8da378:
	ldb r2,[r0, 0x30]
L_8da37c:
	cmp r2,0xff
L_8da380:
	mov_s r1,0x0
L_8da382:
	beq_s L_8da388
L_8da384:
	ld_s r0,[r0,0x34]
L_8da386:
	brne_s r0,0,L_8da38c
	.global L_8da388
L_8da388:
	mov_s r0,r1
L_8da38a:
	b_s L_8da38e
	.global L_8da38c
L_8da38c:
	mov_s r0,0x1
	.global L_8da38e
L_8da38e:
	j_s.d [blink]
L_8da390:
	extb_s r0,r0
L_8da392:
	nop_s
