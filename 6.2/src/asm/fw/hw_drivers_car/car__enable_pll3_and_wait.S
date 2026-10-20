/* car__enable_pll3_and_wait @ 0x8d0320, 184 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: car__enable_pll3_and_wait_on, hwd__wait_pll_lock
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, car__get_pll3_status_bit3, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global car__enable_pll3_and_wait
car__enable_pll3_and_wait:
	.global L_8d0320
L_8d0320:
	push_s blink
L_8d0322:
	bl L_8c01dc
L_8d0326:
	mov_s r13,0x880c00
L_8d032c:
	ld_s r1,[r13,0x60]
L_8d032e:
	bset_s r1,r1,0x3
L_8d0330:
	st_s r1,[r13,0x60]
L_8d0332:
	mov_s r1,0x880a80
L_8d0338:
	ld_s r2,[r1,0x3c]
L_8d033a:
	breq r0,0x0,L_8d03bc
L_8d033e:
	bbit1 r2,0x1,L_8d038a
L_8d0342:
	ld_s r0,[r1,0x3c]
L_8d0344:
	bset_s r0,r0,0x1
L_8d0346:
	st_s r0,[r1,0x3c]
L_8d0348:
	mov r0,0x3e8
	.global L_8d034c
L_8d034c:
	ld_s r15,[r13,0x60]
L_8d034e:
	bl.d L_8d0188
L_8d0352:
	mov_s r16,r0
L_8d0354:
	mov_s r14,r0
L_8d0356:
	btst_s r15,0x3
L_8d0358:
	cmp.eq r14,0x1
L_8d035c:
	bne_s L_8d0366
L_8d035e:
	sub r0,r16,0x1
L_8d0362:
	brhs r0,0x1,L_8d034c
	.global L_8d0366
L_8d0366:
	btst_s r15,0x3
L_8d0368:
	cmp.eq r14,0x1
L_8d036c:
	bne_s L_8d0386
L_8d036e:
	mov_s r1,0x101f7a4
L_8d0374:
	bl.d L_8dcba8
L_8d0378:
	mov_s r0,0x0
L_8d037a:
	mov_s r0,blink
L_8d037c:
	mov_s r1,0x132b
L_8d0382:
	bl L_8c9b28
	.global L_8d0386
L_8d0386:
	brne r14,0x1,L_8d0394
	.global L_8d038a
L_8d038a:
	ld_s r0,[r13,0x60]
L_8d038c:
	bset_s r0,r0,0x3
L_8d038e:
	st_s r0,[r13,0x60]
L_8d0390:
	b L_8c0244
	.global L_8d0394
L_8d0394:
	mov_s r1,0x1418
L_8d039a:
	mov_s r0,blink
L_8d039c:
	b_s L_8d03b6
	.global L_8d039e
L_8d039e:
	bbit1 r0,0x3,L_8d038a
L_8d03a2:
	mov_s r1,0x101f7a4
L_8d03a8:
	bl.d L_8dcba8
L_8d03ac:
	mov_s r0,0x0
L_8d03ae:
	mov_s r0,blink
L_8d03b0:
	mov_s r1,0x132c
	.global L_8d03b6
L_8d03b6:
	bl L_8c9b28
L_8d03ba:
	b_s L_8d038a
	.global L_8d03bc
L_8d03bc:
	bbit0 r2,0x1,L_8d038a
L_8d03c0:
	ld_s r0,[r1,0x3c]
L_8d03c2:
	mov lp_count,0x3e8
L_8d03c6:
	bclr_s r0,r0,0x1
L_8d03c8:
	st_s r0,[r1,0x3c]
L_8d03ca:
	lp L_8d03d6
L_8d03ce:
	ld_s r0,[r13,0x60]
L_8d03d0:
	btst_s r0,0x3
L_8d03d2:
	bne_s L_8d039e
L_8d03d4:
	nop_s
	.global L_8d03d6
L_8d03d6:
	b_s L_8d039e
