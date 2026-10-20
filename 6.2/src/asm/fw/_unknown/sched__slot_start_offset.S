/* sched__slot_start_offset @ 0x8ccc48, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   IDO cur_slot_start_offset=%d, m_last_slot_end_offset=%d
 * Зовут его: schedule_scheme_builder__build_allocations
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sched__slot_start_offset
sched__slot_start_offset:
	.global L_8ccc48
L_8ccc48:
	push_s blink
L_8ccc4a:
	push_s r13
L_8ccc4c:
	mov_s r2,0x803c00
L_8ccc52:
	ld_s r2,[r2,0x10]
L_8ccc54:
	breq_s r2,0,L_8ccc72
L_8ccc56:
	ldw_s r3,[r1,0x6]
L_8ccc58:
	mov_s r1,0x1014418
L_8ccc5e:
	ld_s r13,[r0,0x14]
L_8ccc60:
	add_s r3,r3,r13
L_8ccc62:
	add3 r3,r3,0x1f4
L_8ccc66:
	st_s r3,[r0,0x14]
L_8ccc68:
	mov_s r0,0x2b
L_8ccc6a:
	bl.d L_8dcc80
L_8ccc6e:
	mov_s r2,r13
L_8ccc70:
	b_s L_8ccc74
	.global L_8ccc72
L_8ccc72:
	ld_s r13,[r1]
	.global L_8ccc74
L_8ccc74:
	b.d L_8c025c
L_8ccc78:
	mov_s r0,r13
L_8ccc7a:
	nop_s
