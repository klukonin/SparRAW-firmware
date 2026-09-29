/* uc_send_evt__rs_started @ 0x927764, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__rs_started
uc_send_evt__rs_started:
	.global L_927764
L_927764:
	push_s blink
L_927766:
	push_s r13
L_927768:
	mov_s r13,r0
L_92776a:
	mov_s r0,0x802470
L_927770:
	bl L_920d4c
L_927774:
	mov_s r1,0x13
L_927776:
	st_s r13,[r0]
L_927778:
	mov_s r2,0x4
L_92777a:
	bl.d L_927958
L_92777e:
	mov_s r3,0x0
L_927780:
	b L_9202ac
