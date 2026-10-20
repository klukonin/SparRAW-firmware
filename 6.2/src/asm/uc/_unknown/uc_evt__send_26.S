/* uc_evt__send_26 @ 0x9278a8, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x20_handler
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_26
uc_evt__send_26:
	.global L_9278a8
L_9278a8:
	push_s blink
L_9278aa:
	push_s r13
L_9278ac:
	mov_s r13,r0
L_9278ae:
	mov_s r0,0x802470
L_9278b4:
	bl L_920d4c
L_9278b8:
	mov_s r1,0x26
L_9278ba:
	st_s r13,[r0]
L_9278bc:
	mov_s r2,0x4
L_9278be:
	bl.d L_927958
L_9278c2:
	mov_s r3,0x0
L_9278c4:
	b L_9202ac
