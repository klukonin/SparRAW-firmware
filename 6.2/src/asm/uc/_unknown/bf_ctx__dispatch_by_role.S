/* bf_ctx__dispatch_by_role @ 0x935a44, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__run_bti_cycle
 * Зовёт сам: abft_responder__respond_flow, mac_mode_kick, uc_spin_until_event4__r0_100
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_ctx__dispatch_by_role
bf_ctx__dispatch_by_role:
	.global L_935a44
L_935a44:
	push_s blink
L_935a46:
	mov_s r2,0x802f14
L_935a4c:
	ldb_s r1,[r2,0x1e]
L_935a4e:
	breq_s r1,0,L_935a58
L_935a50:
	bl L_92c018
L_935a54:
	pop_s blink
L_935a56:
	j_s [blink]
	.global L_935a58
L_935a58:
	ldb_s r1,[r2,0x1f]
L_935a5a:
	breq_s r1,0,L_935a64
L_935a5c:
	bl L_930370
L_935a60:
	pop_s blink
L_935a62:
	j_s [blink]
	.global L_935a64
L_935a64:
	bl L_920b14
L_935a68:
	pop_s blink
L_935a6a:
	j_s [blink]
