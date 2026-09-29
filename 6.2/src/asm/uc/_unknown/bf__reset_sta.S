/* bf__reset_sta @ 0x92210c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_clear_all_sta, ucode_cmd_0x05_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, bf__clear_pending_and_notify, bf_req__dequeue_head, bf_sm__set_sta_state, memset0_words_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__reset_sta
bf__reset_sta:
	.global L_92210c
L_92210c:
	push_s blink
L_92210e:
	bl L_92022c
L_922112:
	mov_s r14,r0
L_922114:
	mov_s r15,0x801ffc
L_92211a:
	ld r0,[r15, 0xb4]
L_92211e:
	mov_s r16,r1
L_922120:
	mov_s r13,0x0
L_922122:
	bbit0 r0,r14,L_92213c
L_922126:
	mov_s r0,r14
L_922128:
	bl.d L_92b220
L_92212c:
	mov_s r1,r13
L_92212e:
	bl.d L_9258b0
L_922132:
	mov_s r0,r14
L_922134:
	mov_s r0,r13
L_922136:
	bl.d L_921b38
L_92213a:
	mov_s r1,r13
	.global L_92213c
L_92213c:
	asl_s r0,r14,0x2
L_92213e:
	add2_s r0,r0,r0
L_922140:
	add r1,r0,0x857e49
L_922148:
	stb_s r13,[r1]
L_92214a:
	add_s r0,r0,r15
L_92214c:
	bl.d L_920a84
L_922150:
	mov_s r1,0x14
L_922152:
	cmp r16,0x1
L_922156:
	mov.eq r0,r14
L_92215a:
	bl.eq.d L_92b220
L_92215e:
	mov.eq r1,0x11
L_922162:
	b L_920294
L_922166:
	nop_s
