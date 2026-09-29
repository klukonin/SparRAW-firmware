/* fwq_tx__long_retry_handler @ 0x8d9408, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fwq_tx::long_retry_handler add_packet for packet 0x%x
 *   fwq_tx::long_retry_handler add_packet but connection is pending flush
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, fwq_tx__enqueue, llist__remove
 */
	.section .text.fwq_tx__long_retry_handler,"ax",@progbits
	.global fwq_tx__long_retry_handler
fwq_tx__long_retry_handler:
L_8d9408:
	push_s blink
L_8d940a:
	bl L_8c02c4
L_8d940e:
	mov_s r14,r0
L_8d9410:
	mov_s r13,r1
L_8d9412:
	mov_s r0,0x0
L_8d9414:
	st_s r0,[r1,0x14]
L_8d9416:
	ld_s r1,[r14,0x14]
L_8d9418:
	breq_s r1,0,L_8d942a
L_8d941a:
	ldb_s r2,[r13,0xa]
L_8d941c:
	mov_s r1,0x1
L_8d941e:
	asl.f 0x0,0x1,r2
L_8d9426:
	mov.ne r0,r1
	.global L_8d942a
L_8d942a:
	extb.f 0x0,r0
L_8d942e:
	bne_s L_8d9458
L_8d9430:
	mov_s r2,0x1015764
L_8d9436:
	mov_s r0,0x7
L_8d9438:
	mov_s r1,0x2
L_8d943a:
	bl.d L_8edfcc
L_8d943e:
	mov_s r3,r13
L_8d9440:
	add3 r0,r14,0x8
L_8d9444:
	bl.d L_8de4ec
L_8d9448:
	mov_s r1,r13
L_8d944a:
	ldb_s r2,[r13,0xb]
L_8d944c:
	mov_s r0,r14
L_8d944e:
	lsr_s r2,r2,0x6
L_8d9450:
	bl.d L_8c2460
L_8d9454:
	mov_s r1,r13
L_8d9456:
	b_s L_8d9468
	.global L_8d9458
L_8d9458:
	mov_s r2,0x101579c
L_8d945e:
	mov_s r0,0x7
L_8d9460:
	mov_s r1,0x1
L_8d9462:
	bl.d L_8edfcc
L_8d9466:
	mov_s r3,r13
	.global L_8d9468
L_8d9468:
	b L_8c0334
