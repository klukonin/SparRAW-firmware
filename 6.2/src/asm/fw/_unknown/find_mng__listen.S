/* find_mng__listen @ 0x8dafa8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   find_mng::listen() RX start
 * Зовут его: find_mngr__enter_listen, find_mngr__search_phase_end, find_mngr__session_start
 * Зовёт сам: __ld_r13_to_r13_ret, discovery__rx_start, find_mngr__listen_start, fw_log_emit0, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_mng__listen
find_mng__listen:
	.global L_8dafa8
L_8dafa8:
	push_s blink
L_8dafaa:
	push_s r13
L_8dafac:
	mov_s r13,r0
L_8dafae:
	ld_s r0,[r0,0x40]
L_8dafb0:
	brne_s r0,0,L_8dafc8
L_8dafb2:
	mov_s r0,0x1
L_8dafb4:
	st_s r0,[r13,0x40]
L_8dafb6:
	mov_s r1,0x1017a14
L_8dafbc:
	bl.d L_8dcba8
L_8dafc0:
	mov_s r0,0x2c
L_8dafc2:
	bl.d L_8f80b8
L_8dafc6:
	mov_s r0,0x0
	.global L_8dafc8
L_8dafc8:
	ld_s r1,[r13,0xc]
L_8dafca:
	mov_s r0,0x0
L_8dafcc:
	breq_s r1,0,L_8dafda
L_8dafce:
	bl L_8e9524
L_8dafd2:
	bmsk.f r0,r0,0x1
L_8dafd6:
	mov.eq r0,0x1
	.global L_8dafda
L_8dafda:
	ldw_s r1,[r13,0x12]
L_8dafdc:
	mulu64 r1,r0
L_8dafe0:
	extw r1,mlo
L_8dafe4:
	bl.d L_8daf40
L_8dafe8:
	mov_s r0,r13
L_8dafea:
	b L_8c025c
L_8dafee:
	nop_s
