/* internal_tx__clear_pending @ 0x9394d0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm2, ucode_cmd_0x0f_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, internal_tx__clear_pending_bit, uc_res_vote__release
 * Глобалы (через gp): 0x800570
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global internal_tx__clear_pending
internal_tx__clear_pending:
	.global L_9394d0
L_9394d0:
	push_s blink
L_9394d2:
	bl L_920234
L_9394d6:
	mov_s r13,r0
L_9394d8:
	lr r14,[0xa]
L_9394dc:
	bclr r0,r14,0x1
L_9394e0:
	flag r0
L_9394e4:
	ld_s r0,[gp,0x48]
L_9394e6:
	breq_s r0,0,L_9394f0
L_9394e8:
	bclr r0,r0,r13
L_9394ec:
	st.as r0,[gp,0x12]
	.global L_9394f0
L_9394f0:
	brne_s r0,0,L_9394fe
L_9394f2:
	bl.d L_92bd70
L_9394f6:
	mov_s r0,0x2
L_9394f8:
	bl.d L_92bb94
L_9394fc:
	mov_s r0,0x2
	.global L_9394fe
L_9394fe:
	lr r0,[0xa]
L_939502:
	bic r14,r14,-0x3
L_939506:
	or_s r14,r14,r0
L_939508:
	flag r14
L_93950c:
	ld_s r0,[gp,0x48]
L_93950e:
	mov_s r1,0x857180
L_939514:
	brhs.d r13,0x8,L_93952a
L_939518:
	st_s r0,[r1,0x44]
L_93951a:
	mov_s r1,0x0
L_93951c:
	asl_s r0,r13,0x2
L_93951e:
	add2_s r0,r0,r0
L_939520:
	add_s r0,r0,0x857e38
L_939526:
	stb_s r1,[r0,0x7]
L_939528:
	stb_s r1,[r0,0x9]
	.global L_93952a
L_93952a:
	b L_9202a4
L_93952e:
	nop_s
