/* bf_sm__txss_resp_result @ 0x93bdf0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__process_request_fifo
 * Зовёт сам: __ld_r13_to_r13_ret, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__txss_resp_result
bf_sm__txss_resp_result:
	.global L_93bdf0
L_93bdf0:
	push_s blink
L_93bdf2:
	push_s r13
L_93bdf4:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93bdf6:
	add2_s r0,r0,r0
L_93bdf8:
	mov_s r1,0x802000
L_93bdfe:
	ld_s r0,[r1,r0]
L_93be00:
	mov_s r13,0x0
L_93be02:
	breq r0,0x9,L_93be1a
L_93be06:
	breq r0,0xa,L_93be1e
L_93be0a:
	breq r0,0xb,L_93be22
L_93be0e:
	mov_s r0,blink
L_93be10:
	bl.d L_926618
L_93be14:
	mov_s r1,0x1a
L_93be16:
	mov_s r0,r13
L_93be18:
	b_s L_93be24
	.global L_93be1a
L_93be1a:
	mov_s r0,0x1
L_93be1c:
	b_s L_93be24
	.global L_93be1e
L_93be1e:
	mov_s r0,0x3
L_93be20:
	b_s L_93be24
	.global L_93be22
L_93be22:
	mov_s r0,0x2
	.global L_93be24
L_93be24:
	b L_9202ac
