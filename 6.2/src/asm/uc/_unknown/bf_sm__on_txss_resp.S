/* bf_sm__on_txss_resp @ 0x93be28, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__dispatch_by_state
 * Зовёт сам: __ld_r13_to_r13_ret, bf_sm__set_state, bf_txss__reset_report_ctx, g_80212c__reset, txss_resp__flow
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_sm__on_txss_resp
bf_sm__on_txss_resp:
	.global L_93be28
L_93be28:
	push_s blink
L_93be2a:
	push_s r13
L_93be2c:
	mov_s r13,r0
L_93be2e:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_93be30:
	add2_s r0,r0,r0
L_93be32:
	mov_s r1,0x802000
L_93be38:
	ld_s r0,[r1,r0]
L_93be3a:
	breq_s r0,0,L_93be44
L_93be3c:
	breq r0,0x9,L_93be5a
L_93be40:
	mov_s r13,0x2
L_93be42:
	b_s L_93be5c
	.global L_93be44
L_93be44:
	mov_s r0,r13
L_93be46:
	bl.d L_92af2c
L_93be4a:
	mov_s r1,0x4
L_93be4c:
	bl L_92ebfc
L_93be50:
	bl.d L_93bff0
L_93be54:
	mov_s r0,r13
L_93be56:
	mov_s r13,0x0
L_93be58:
	b_s L_93be5c
	.global L_93be5a
L_93be5a:
	mov_s r13,0x1
	.global L_93be5c
L_93be5c:
	cmp_s r13,0x0
L_93be5e:
	bl.ne L_92b1d8
L_93be62:
	b.d L_9202ac
L_93be66:
	mov_s r0,r13
