/* uc_evt__send_30 @ 0x927784, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1__enter_fixed_sched
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_30
uc_evt__send_30:
	.global L_927784
L_927784:
	push_s blink
L_927786:
	push_s r13
L_927788:
	mov_s r13,r0
L_92778a:
	mov_s r0,0x802470
L_927790:
	bl L_920d4c
L_927794:
	ld_s r2,[r13]
L_927796:
	ld_s r1,[r13,0x4]
L_927798:
	st_s r2,[r0]
L_92779a:
	st_s r1,[r0,0x4]
L_92779c:
	mov_s r1,0x30
L_92779e:
	mov_s r2,0x8
L_9277a0:
	bl.d L_927958
L_9277a4:
	mov_s r3,0x0
L_9277a6:
	b L_9202ac
L_9277aa:
	nop_s
