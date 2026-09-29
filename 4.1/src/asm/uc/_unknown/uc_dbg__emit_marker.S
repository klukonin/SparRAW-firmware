/* uc_dbg__emit_marker @ 0x9251ac, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.uc_dbg__emit_marker,"ax",@progbits
	.global uc_dbg__emit_marker
uc_dbg__emit_marker:
L_9251ac:
	push_s r13
L_9251ae:
	mov_s r13,blink
L_9251b0:
	mov_s r2,0xcaf550
L_9251b6:
	mov_s r32,r2
L_9251b8:
	st.ab r2,[r25,0x4]
L_9251bc:
	bclr r25,r25,0xa
L_9251c0:
	mov_s r1,0x801e14
L_9251c6:
	ldw_s r0,[r1,0xe]
L_9251c8:
	mov_s blink,r13
L_9251ca:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_9251cc:
	stw_s r0,[r1,0xe]
L_9251ce:
	j_s.d [blink]
L_9251d0:
	pop_s r13
L_9251d2:
	nop_s
