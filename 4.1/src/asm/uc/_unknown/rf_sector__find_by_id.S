/* rf_sector__find_by_id @ 0x930114, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_flow__handle_frame, rx_funcs__handle_ppdu_report
 */
	.section .text.rf_sector__find_by_id,"ax",@progbits
	.global rf_sector__find_by_id
rf_sector__find_by_id:
	.global L_930114
L_930114:
	push_s r13
L_930116:
	mov_s r1,r0
L_930118:
	mov_s r0,0x0
L_93011a:
	b_s L_93011e
	.global L_93011c
L_93011c:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
	.global L_93011e
L_93011e:
	brge r0,0x8,L_93014a
L_930122:
	asl_s r2,r0,0x3
L_930124:
	add3_s r2,r2,r2
L_930126:
	add_s r2,r2,0x801190
L_93012c:
	ldw_s r13,[r2,0x2c]
L_93012e:
	ldw_s r3,[r1]
L_930130:
	brne r13,r3,L_93011c
L_930134:
	ldw_s r13,[r2,0x2e]
L_930136:
	ldw_s r3,[r1,0x2]
L_930138:
	brne r13,r3,L_93011c
L_93013c:
	ldw_s r13,[r2,0x30]
L_93013e:
	ldw_s r3,[r1,0x4]
L_930140:
	brne r13,r3,L_93011c
L_930144:
	ldw_s r2,[r2,0x2]
L_930146:
	bbit0 r2,0x0,L_93011c
	.global L_93014a
L_93014a:
	j_s.d [blink]
L_93014c:
	pop_s r13
L_93014e:
	nop_s
