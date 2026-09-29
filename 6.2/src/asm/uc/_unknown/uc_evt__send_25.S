/* uc_evt__send_25 @ 0x9279a0, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_0x34_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_25
uc_evt__send_25:
	.global L_9279a0
L_9279a0:
	push_s blink
L_9279a2:
	bl L_920234
L_9279a6:
	mov_s r14,r0
L_9279a8:
	mov_s r0,0x802470
L_9279ae:
	bl.d L_920d4c
L_9279b2:
	mov_s r13,r1
L_9279b4:
	stb_s r14,[r0]
L_9279b6:
	stb_s r13,[r0,0x1]
L_9279b8:
	mov_s r1,0x25
L_9279ba:
	mov_s r2,0x2
L_9279bc:
	bl.d L_927958
L_9279c0:
	mov_s r3,0x0
L_9279c2:
	b L_9202a4
L_9279c6:
	nop_s
