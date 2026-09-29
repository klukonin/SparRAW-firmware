/* vring__reg_write_locked_20 @ 0x8d0508, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__configure_ring, fwq_tx__handle_completion
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reg_write_locked_20
vring__reg_write_locked_20:
	.global L_8d0508
L_8d0508:
	push_s blink
L_8d050a:
	push_s r13
L_8d050c:
	lr r13,[0xa]
L_8d0510:
	bclr r2,r13,0x1
L_8d0514:
	flag r2
L_8d0518:
	mov_s r2,0x881c00
L_8d051e:
	st_s r0,[r2,0x20]
L_8d0520:
	breq_s r1,0,L_8d0526
L_8d0522:
	sync
	.global L_8d0526
L_8d0526:
	lr r0,[0xa]
L_8d052a:
	bic r13,r13,-0x3
L_8d052e:
	or_s r13,r13,r0
L_8d0530:
	flag r13
L_8d0534:
	b L_8c025c
