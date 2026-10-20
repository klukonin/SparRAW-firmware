/* uc_evt__send_2e @ 0x9278fc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fixed_sched__read_slot_id, peer_masks__or_into_8571c4
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_2e
uc_evt__send_2e:
	.global L_9278fc
L_9278fc:
	push_s blink
L_9278fe:
	bl L_920230
L_927902:
	mov_s r14,r0
L_927904:
	mov_s r13,r1
L_927906:
	mov_s r0,0x802470
L_92790c:
	bl.d L_920d4c
L_927910:
	mov_s r15,r2
L_927912:
	stb_s r14,[r0]
L_927914:
	stb_s r13,[r0,0x1]
L_927916:
	stw_s r15,[r0,0x2]
L_927918:
	mov_s r1,0x2e
L_92791a:
	mov_s r2,0x4
L_92791c:
	bl.d L_927958
L_927920:
	mov_s r3,0x0
L_927922:
	b L_92029c
L_927926:
	nop_s
