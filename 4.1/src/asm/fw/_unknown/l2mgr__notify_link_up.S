/* l2mgr__notify_link_up @ 0x8ebec0, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_l2mgr__notify_link_up
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, find_mngr__link_up, scan_mngr__handle_link_up_event
 */
	.section .text.l2mgr__notify_link_up,"ax",@progbits
	.global l2mgr__notify_link_up
l2mgr__notify_link_up:
	.global L_8ebec0
L_8ebec0:
	push_s blink
L_8ebec2:
	bl L_8c02c0
L_8ebec6:
	mov_s r14,r0
L_8ebec8:
	mov_s r15,r1
L_8ebeca:
	mov_s r13,r2
L_8ebecc:
	bl.d L_8ebee4
L_8ebed0:
	ld_s r0,[r0,0x8]
L_8ebed2:
	add r0,r14,0xc
L_8ebed6:
	mov_s r1,r15
L_8ebed8:
	bl.d L_8c3f4c
L_8ebedc:
	mov_s r2,r13
L_8ebede:
	b L_8c032c
L_8ebee2:
	nop_s
