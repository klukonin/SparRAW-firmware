/* bf__resume_sta_tx @ 0x92bb34, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__clear_pending_and_notify, sta__apply_bf_result
 * Зовёт сам: __ld_r13_to_r13_ret, mac__publish_masks
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf__resume_sta_tx
bf__resume_sta_tx:
	.global L_92bb34
L_92bb34:
	push_s blink
L_92bb36:
	push_s r13
L_92bb38:
	lr r3,[0xa]
L_92bb3c:
	bclr r2,r3,0x1
L_92bb40:
	flag r2
L_92bb44:
	mov_s r2,0x802a90
L_92bb4a:
	add1_s r2,r2,r1
L_92bb4c:
	ldw_s r13,[r2]
L_92bb4e:
	bclr r13,r13,r0
L_92bb52:
	asl_s r0,r1,0x4
L_92bb54:
	add2_s r0,r0,r0
L_92bb56:
	add_s r0,r0,0x801104
L_92bb5c:
	ldw_s r1,[r0,0x2]
L_92bb5e:
	stw_s r13,[r2]
L_92bb60:
	bbit0 r1,0x0,L_92bb80
L_92bb64:
	brne_s r13,0,L_92bb80
L_92bb66:
	ld_s r13,[r0,0x1c]
L_92bb68:
	mov_s r2,0x800400
L_92bb6e:
	ld_s r1,[r2,0x1c]
L_92bb70:
	ld_s r0,[r0,0x18]
L_92bb72:
	or_s r1,r1,r13
L_92bb74:
	st_s r1,[r2,0x1c]
L_92bb76:
	ld_s r1,[r2,0x24]
L_92bb78:
	or_s r0,r0,r1
L_92bb7a:
	bl.d L_93d0ac
L_92bb7e:
	st_s r0,[r2,0x24]
	.global L_92bb80
L_92bb80:
	lr r0,[0xa]
L_92bb84:
	bic r3,r3,-0x3
L_92bb88:
	or_s r3,r3,r0
L_92bb8a:
	flag r3
L_92bb8e:
	b L_9202ac
L_92bb92:
	nop_s
