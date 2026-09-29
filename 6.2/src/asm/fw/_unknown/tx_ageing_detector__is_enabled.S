/* tx_ageing_detector__is_enabled @ 0x8da260, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__start_detect_b, tx_ppdu_ageing_timeout_detector__start_monitoring, tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, ll_detector__is_armed_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_ageing_detector__is_enabled
tx_ageing_detector__is_enabled:
	.global L_8da260
L_8da260:
	push_s blink
L_8da262:
	push_s r13
L_8da264:
	bl.d L_8da378
L_8da268:
	mov_s r13,r0
L_8da26a:
	cmp_s r0,0x0
L_8da26c:
	mov_s r0,0x0
L_8da26e:
	beq_s L_8da29a
L_8da270:
	ldb r0,[r13, 0x30]
L_8da274:
	brge r0,0x8,L_8da29e
	.global L_8da278
L_8da278:
	ldb r1,[r13, 0x30]
L_8da27c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8da27e:
	ld_s r2,[r13,0x34]
L_8da280:
	add3_s r1,r1,r1
L_8da282:
	ld_s r1,[r2,r1]
L_8da284:
	mov_s r0,0x0
L_8da286:
	bbit0 r1,0x0,L_8da298
L_8da28a:
	mov_s r1,0x803c00
L_8da290:
	ld_s r1,[r1,0xc]
L_8da292:
	cmp_s r1,0x0
L_8da294:
	mov.eq r0,0x1
	.global L_8da298
L_8da298:
	extb_s r0,r0
	.global L_8da29a
L_8da29a:
	b L_8c025c
	.global L_8da29e
L_8da29e:
	mov_s r0,blink
L_8da2a0:
	mov_s r1,0x1504
L_8da2a6:
	bl L_8c9b28
L_8da2aa:
	b_s L_8da278
