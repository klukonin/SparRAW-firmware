/* maintain_sm__release_radio_after_bf_evt @ 0x8e2520, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm::release_radio_after_bf_evt()  remove_request 0x%x
 * Зовут его: maintain_sm__action_8c48f8, maintain_sm__action_8c494c, maintain_sm__action_8f9a78
 * Зовёт сам: RADIO_MGR__remove_request, __ld_r13_to_r13_ret, fw_log_emit1, radio_mgr__call_method_10
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__release_radio_after_bf_evt
maintain_sm__release_radio_after_bf_evt:
	.global L_8e2520
L_8e2520:
	push_s blink
L_8e2522:
	push_s r13
L_8e2524:
	ld_s r2,[r0,0x24]
L_8e2526:
	mov_s r13,r0
L_8e2528:
	breq_s r2,0,L_8e254e
L_8e252a:
	ld_s r0,[r13,0x28]
L_8e252c:
	brne_s r0,0,L_8e2542
L_8e252e:
	mov_s r1,0x1014588
L_8e2534:
	bl.d L_8dcc10
L_8e2538:
	mov_s r0,0x20
L_8e253a:
	bl.d L_8e2798
L_8e253e:
	ld_s r0,[r13,0x24]
L_8e2540:
	b_s L_8e2548
	.global L_8e2542
L_8e2542:
	bl.d L_8ea800
L_8e2546:
	mov_s r0,r2
	.global L_8e2548
L_8e2548:
	mov_s r0,0x0
L_8e254a:
	st_s r0,[r13,0x24]
L_8e254c:
	st_s r0,[r13,0x28]
	.global L_8e254e
L_8e254e:
	b L_8c025c
L_8e2552:
	nop_s
