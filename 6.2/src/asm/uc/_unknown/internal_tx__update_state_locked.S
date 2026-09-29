/* internal_tx__update_state_locked @ 0x9272e0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4
 * Зовёт сам: __ld_r13_to_r13_ret, internal_tx__clear_pending_bit, uc_res_vote__release
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__update_state_locked
internal_tx__update_state_locked:
	.global L_9272e0
L_9272e0:
	push_s blink
L_9272e2:
	push_s r13
L_9272e4:
	lr r13,[0xa]
L_9272e8:
	bclr r1,r13,0x1
L_9272ec:
	flag r1
L_9272f0:
	ld.as r1,[gp,-0x16]
L_9272f4:
	breq_s r1,0,L_9272fe
L_9272f6:
	bclr r1,r1,r0
L_9272fa:
	st.as r1,[gp,-0x16]
	.global L_9272fe
L_9272fe:
	brne_s r1,0,L_92730c
L_927300:
	bl.d L_92bd70
L_927304:
	mov_s r0,0x4
L_927306:
	bl.d L_92bb94
L_92730a:
	mov_s r0,0x4
	.global L_92730c
L_92730c:
	lr r0,[0xa]
L_927310:
	bic r13,r13,-0x3
L_927314:
	or_s r13,r13,r0
L_927316:
	flag r13
L_92731a:
	b L_9202ac
L_92731e:
	nop_s
