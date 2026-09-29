/* uc_field_0x24_is_zero @ 0x920dac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__kick_and_dispatch_uc
 * Зовёт сам: uc_indirect_is_zero
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_field_0x24_is_zero
uc_field_0x24_is_zero:
	.global L_920dac
L_920dac:
	push_s r13
L_920dae:
	mov_s r13,blink
L_920db0:
	bl.d L_92be20
L_920db4:
	add r0,r0,0x24
L_920db8:
	rsub.f r0,r0,0x1
L_920dbc:
	mov_s blink,r13
L_920dbe:
	mov.cs r0,0x0
L_920dc2:
	j_s.d [blink]
L_920dc4:
	pop_s r13
L_920dc6:
	nop_s
