/* bf__trigger_if_pending @ 0x926840, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx_step, tx_initiator_step
 * Зовёт сам: bf__trigger_for_mid
 */
	.section .text.bf__trigger_if_pending,"ax",@progbits
	.global bf__trigger_if_pending
bf__trigger_if_pending:
	.global L_926840
L_926840:
	push_s blink
L_926842:
	asl_s r1,r0,0x2
L_926844:
	add2_s r1,r1,r1
L_926846:
	mov_s r2,0x857849
L_92684c:
	ldb_s r1,[r2,r1]
L_92684e:
	cmp_s r1,0x0
L_926850:
	bl.ne L_92b63c
L_926854:
	pop_s blink
L_926856:
	j_s [blink]
