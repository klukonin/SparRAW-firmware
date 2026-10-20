/* ba_setup_sm__addba_req_retry_timeout_cb @ 0x8f0a78, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_setup_sm::addba_req_retry_timeout_cb()
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_log_emit0, fw_sysassert_fatal, u_schd__schedule
 * Глобалы (через gp): 0x8002ac
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ba_setup_sm__addba_req_retry_timeout_cb
ba_setup_sm__addba_req_retry_timeout_cb:
	.global L_8f0a78
L_8f0a78:
	push_s blink
L_8f0a7a:
	push_s r13
L_8f0a7c:
	mov_s r13,r0
L_8f0a7e:
	ld_s r0,[r0,0xc]
L_8f0a80:
	brne_s r0,0,L_8f0aa4
	.global L_8f0a82
L_8f0a82:
	ld_s r0,[r13,0x10]
L_8f0a84:
	brne_s r0,0,L_8f0aa0
L_8f0a86:
	mov_s r0,0x30ab4
L_8f0a8c:
	ld.as r4,[gp,0x4a]
L_8f0a90:
	mov_s r1,r13
L_8f0a92:
	mov_s r2,0x0
L_8f0a94:
	mov_s r3,r2
L_8f0a96:
	mov_s r5,r2
L_8f0a98:
	bl.d L_8e0c0c
L_8f0a9c:
	mov_s r6,r2
L_8f0a9e:
	st_s r0,[r13,0x10]
	.global L_8f0aa0
L_8f0aa0:
	b L_8c025c
	.global L_8f0aa4
L_8f0aa4:
	mov_s r0,blink
L_8f0aa6:
	mov_s r1,0x1431
L_8f0aac:
	bl L_8c9b28
L_8f0ab0:
	b_s L_8f0a82
L_8f0ab2:
	nop_s
L_8f0ab4:
	push_s blink
L_8f0ab6:
	push_s r13
L_8f0ab8:
	mov_s r13,r0
L_8f0aba:
	mov_s r1,0x101385c
L_8f0ac0:
	bl.d L_8dcba8
L_8f0ac4:
	mov_s r0,0x25
L_8f0ac6:
	breq_s r13,0,L_8f0adc
	.global L_8f0ac8
L_8f0ac8:
	mov_s r2,0x0
L_8f0aca:
	st_s r2,[r13,0x10]
L_8f0acc:
	mov_s r0,r13
L_8f0ace:
	mov_s r1,0x6
L_8f0ad0:
	mov_s r3,r2
L_8f0ad2:
	bl.d L_8d9b6c
L_8f0ad6:
	mov_s r4,r2
L_8f0ad8:
	b L_8c025c
	.global L_8f0adc
L_8f0adc:
	mov_s r0,blink
L_8f0ade:
	mov_s r1,0x1430
L_8f0ae4:
	bl L_8c9b28
L_8f0ae8:
	b_s L_8f0ac8
L_8f0aea:
	nop_s
