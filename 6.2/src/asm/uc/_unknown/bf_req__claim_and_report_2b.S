/* bf_req__claim_and_report_2b @ 0x924e9c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, bf_req__try_claim, uc_evt__send_2b, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_req__claim_and_report_2b
bf_req__claim_and_report_2b:
	.global L_924e9c
L_924e9c:
	push_s blink
L_924e9e:
	push_s r13
L_924ea0:
	mov_s r13,r0
L_924ea2:
	bl.d L_936184
L_924ea6:
	mov_s r1,0x5
L_924ea8:
	breq_s r0,0,L_924eb4
	.global L_924eaa
L_924eaa:
	bl.d L_92783c
L_924eae:
	ldb_s r0,[r13,0xc]
L_924eb0:
	b L_9202ac
	.global L_924eb4
L_924eb4:
	mov_s r0,blink
L_924eb6:
	bl.d L_926618
L_924eba:
	mov_s r1,0xf5
L_924ebc:
	b_s L_924eaa
L_924ebe:
	nop_s
