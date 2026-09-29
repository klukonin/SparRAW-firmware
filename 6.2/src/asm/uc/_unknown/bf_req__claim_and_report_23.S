/* bf_req__claim_and_report_23 @ 0x9281f8, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, bf_req__try_claim, uc_evt__send_23, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_req__claim_and_report_23
bf_req__claim_and_report_23:
	.global L_9281f8
L_9281f8:
	push_s blink
L_9281fa:
	push_s r13
L_9281fc:
	mov_s r13,r0
L_9281fe:
	bl.d L_936184
L_928202:
	mov_s r1,0x3
L_928204:
	breq_s r0,0,L_928218
	.global L_928206
L_928206:
	ld_s r0,[r13,0xc]
L_928208:
	stb r0,[r13, 0x53]
L_92820c:
	bl.d L_92787c
L_928210:
	add r0,r13,0x30
L_928214:
	b L_9202ac
	.global L_928218
L_928218:
	mov_s r0,blink
L_92821a:
	bl.d L_926618
L_92821e:
	mov_s r1,0xa2
L_928220:
	b_s L_928206
L_928222:
	nop_s
