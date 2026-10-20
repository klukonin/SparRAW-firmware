/* bf_sm__on_brp_resp @ 0x922e9c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__dispatch_by_state
 * Зовёт сам: __ld_r13_to_r13_ret, bf_sm__brp_noop_hook_a, bf_sm__brp_noop_hook_b, bf_sm__set_state, brp_responder_flow_enter, g_80212c__reset
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__on_brp_resp
bf_sm__on_brp_resp:
	.global L_922e9c
L_922e9c:
	push_s blink
L_922e9e:
	push_s r13
L_922ea0:
	mov_s r13,r0
L_922ea2:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_922ea4:
	add2_s r0,r0,r0
L_922ea6:
	mov_s r2,0x802000
L_922eac:
	ld_s r0,[r2,r0]
L_922eae:
	mov_s r1,0x1
L_922eb0:
	breq_s r0,0,L_922ebe
L_922eb2:
	cmp_s r0,0x33
L_922eb4:
	mov.eq r13,r1
L_922eb8:
	mov.ne r13,0x2
L_922ebc:
	b_s L_922ed2
	.global L_922ebe
L_922ebe:
	mov_s r0,r13
L_922ec0:
	bl.d L_92af2c
L_922ec4:
	mov_s r1,0xa
L_922ec6:
	bl L_935208
L_922eca:
	bl.d L_922eec
L_922ece:
	mov_s r0,r13
L_922ed0:
	mov_s r13,0x0
	.global L_922ed2
L_922ed2:
	breq_s r13,0,L_922ee6
L_922ed4:
	bl L_93cc8c
L_922ed8:
	bl L_92b1d8
L_922edc:
	mov_s r1,0x0
L_922ede:
	mov_s r0,0x80216c
L_922ee4:
	stw_s r1,[r0,0x24]
	.global L_922ee6
L_922ee6:
	b.d L_9202ac
L_922eea:
	mov_s r0,r13
