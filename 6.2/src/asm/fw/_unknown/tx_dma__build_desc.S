/* tx_dma__build_desc @ 0x8ea2f0, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__program_args
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bits__set32_s0_w4, bits__set32_s14_w2, bits__set32_s16_w7, bits__set32_s4_w2, dma__set_881b24_bit1, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_dma__build_desc
tx_dma__build_desc:
	.global L_8ea2f0
L_8ea2f0:
	push_s blink
L_8ea2f2:
	bl L_8c01d0
L_8ea2f6:
	mov_s r13,r0
L_8ea2f8:
	mov_s r14,r1
L_8ea2fa:
	mov_s r15,r2
L_8ea2fc:
	mov_s r16,r3
L_8ea2fe:
	mov r17,r4
L_8ea302:
	mov r18,r5
L_8ea306:
	mov r19,r6
L_8ea30a:
	bl.d L_8c1cd8
L_8ea30e:
	mov_s r1,0x10
L_8ea310:
	ldw_s r0,[r14]
L_8ea312:
	bmsk r1,r16,0x3
L_8ea316:
	stw_s r0,[r13]
L_8ea318:
	ldw_s r0,[r14,0x2]
L_8ea31a:
	stw_s r0,[r13,0x2]
L_8ea31c:
	ldw_s r0,[r14,0x4]
L_8ea31e:
	stw_s r0,[r13,0x4]
L_8ea320:
	ldw_s r0,[r15]
L_8ea322:
	stw_s r0,[r13,0x6]
L_8ea324:
	ldw_s r0,[r15,0x2]
L_8ea326:
	stw_s r0,[r13,0x8]
L_8ea328:
	ldw_s r0,[r15,0x4]
L_8ea32a:
	stw_s r0,[r13,0xa]
L_8ea32c:
	add r0,r13,0xc
L_8ea330:
	bl.d L_8ed370
L_8ea334:
	and r2,r19,0x2
L_8ea338:
	bmsk r1,r17,0x1
L_8ea33c:
	bl.d L_8ed4fc
L_8ea340:
	asr_s r2,r2
L_8ea342:
	bmsk r1,r18,0x6
L_8ea346:
	bl L_8ed40c
L_8ea34a:
	bmsk r1,r19,0x0
L_8ea34e:
	asl_s r1,r1
L_8ea350:
	or_s r1,r1,r2
L_8ea352:
	bl L_8ed3c4
L_8ea356:
	bl L_8df5c4
L_8ea35a:
	b L_8c022c
L_8ea35e:
	nop_s
