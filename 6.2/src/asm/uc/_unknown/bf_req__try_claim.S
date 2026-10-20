/* bf_req__try_claim @ 0x936184, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta_slot, bf_req__claim_and_report_23, bf_req__claim_and_report_2b, ucode_cmd_0x20_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_req__try_claim
bf_req__try_claim:
	.global L_936184
L_936184:
	ld_s r2,[r0,0x4]
L_936186:
	mov_s r3,0x0
L_936188:
	breq_s r2,0,L_936192
L_93618a:
	ld_s r2,[r0,0x8]
L_93618c:
	cmp_s r2,0x0
L_93618e:
	mov.eq r3,0x1
	.global L_936192
L_936192:
	extb_s r3,r3
L_936194:
	breq_s r1,0,L_9361a4
L_936196:
	mov_s r2,0x0
L_936198:
	breq_s r3,0,L_9361a2
L_93619a:
	ld_s r3,[r0]
L_93619c:
	cmp_s r1,r3
L_93619e:
	mov.eq r2,0x1
	.global L_9361a2
L_9361a2:
	extb_s r3,r2
	.global L_9361a4
L_9361a4:
	breq_s r3,0,L_9361ac
L_9361a6:
	ld_s r1,[r0,0xc]
L_9361a8:
	brne r1,0x2,L_9361b0
	.global L_9361ac
L_9361ac:
	mov_s r0,0x0
L_9361ae:
	b_s L_9361ba
	.global L_9361b0
L_9361b0:
	mov_s r1,0x1
L_9361b2:
	st_s r1,[r0,0x8]
L_9361b4:
	mov_s r2,0x0
L_9361b6:
	st_s r2,[r0,0x20]
L_9361b8:
	mov_s r0,r1
	.global L_9361ba
L_9361ba:
	j_s [blink]
