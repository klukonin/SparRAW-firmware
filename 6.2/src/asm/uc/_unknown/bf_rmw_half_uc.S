/* bf_rmw_half_uc @ 0x93ec90, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: txss__set_frame_half_s1_w2
 * Зовёт сам: bf__insert_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bf_rmw_half_uc
bf_rmw_half_uc:
	.global L_93ec90
L_93ec90:
	push_s r12
L_93ec92:
	push_s blink
L_93ec94:
	bl.d L_93ebc0
L_93ec98:
	ldw_s r12,[r0]
L_93ec9a:
	stw_s r12,[r0]
L_93ec9c:
	ld.ab blink,[sp,0x4]
L_93eca0:
	j_s.d [blink]
L_93eca2:
	pop_s r12
