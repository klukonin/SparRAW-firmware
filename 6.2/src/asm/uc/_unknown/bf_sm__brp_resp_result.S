/* bf_sm__brp_resp_result @ 0x922e74, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo
 * Зовёт сам: __ld_r13_to_r13_ret, g_80212c__reset
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__brp_resp_result
bf_sm__brp_resp_result:
	.global L_922e74
L_922e74:
	push_s blink
L_922e76:
	push_s r13
L_922e78:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_922e7a:
	add2_s r0,r0,r0
L_922e7c:
	mov_s r1,0x802000
L_922e82:
	ld_s r0,[r1,r0]
L_922e84:
	mov_s r13,0x1
L_922e86:
	cmp_s r0,0x33
L_922e88:
	sub.eq r13,r13,r13
L_922e8c:
	add.f r13,r13,0x1
L_922e90:
	bl.ne L_92b1d8
L_922e94:
	b.d L_9202ac
L_922e98:
	mov_s r0,r13
L_922e9a:
	nop_s
