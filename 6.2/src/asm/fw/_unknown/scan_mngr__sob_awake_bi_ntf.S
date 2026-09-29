/* scan_mngr__sob_awake_bi_ntf @ 0x8e74d8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::sob_awake_bi_ntf()
 *   swc_psc_sm::sob_started_wd_timeout_cb - Entry
 *   swc_psc_sm::sob_started_wd_timeout_cb - Exit
 * Зовут его: PS_CONNECTION__awake_peer_ntf
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__sob_awake_bi_ntf
scan_mngr__sob_awake_bi_ntf:
	.global L_8e74d8
L_8e74d8:
	push_s blink
L_8e74da:
	push_s r13
L_8e74dc:
	mov_s r13,r0
L_8e74de:
	mov_s r1,0x101662c
L_8e74e4:
	bl.d L_8dcba8
L_8e74e8:
	mov_s r0,0x29
L_8e74ea:
	add3 r0,r13,0x3a
L_8e74ee:
	mov_s r1,0x1
L_8e74f0:
	mov_s r2,0x0
L_8e74f2:
	mov_s r3,r2
L_8e74f4:
	bl.d L_8d9b6c
L_8e74f8:
	mov_s r4,r2
L_8e74fa:
	b L_8c025c
L_8e74fe:
	nop_s
L_8e7500:
	push_s blink
L_8e7502:
	push_s r13
L_8e7504:
	mov_s r13,r0
L_8e7506:
	mov_s r1,0x1017724
L_8e750c:
	bl.d L_8dcba8
L_8e7510:
	mov_s r0,0x29
L_8e7512:
	mov_s r0,r13
L_8e7514:
	mov_s r1,0x3
L_8e7516:
	mov_s r2,0x1
L_8e7518:
	mov_s r3,0x0
L_8e751a:
	bl.d L_8d9b6c
L_8e751e:
	mov_s r4,r3
L_8e7520:
	mov_s r1,0x1017754
L_8e7526:
	bl.d L_8dcba8
L_8e752a:
	mov_s r0,0x29
L_8e752c:
	b L_8c025c
