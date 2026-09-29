/* mac_ring_disable @ 0x8ea418, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rm_main_sm__enter_step, stream_mgr__build_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_ring_disable
mac_ring_disable:
	.global L_8ea418
L_8ea418:
	push_s r13
L_8ea41a:
	mov_s r2,0x886a00
L_8ea420:
	ld_s r1,[r2,0x1c]
L_8ea422:
	mov_s r13,0x1
L_8ea424:
	mov_s r3,0x0
L_8ea426:
	bset r3,r3,r0
L_8ea42a:
	bic_s r1,r1,r3
L_8ea42c:
	st_s r3,[r2,0x18]
L_8ea42e:
	st_s r1,[r2,0x1c]
L_8ea430:
	st_s r13,[r2,0x20]
L_8ea432:
	j_s.d [blink]
L_8ea434:
	pop_s r13
L_8ea436:
	nop_s
