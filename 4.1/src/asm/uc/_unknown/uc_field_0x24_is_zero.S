/* uc_field_0x24_is_zero @ 0x921998, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__kick_and_dispatch
 * Зовёт сам: uc_indirect_is_zero
 */
	.section .text.uc_field_0x24_is_zero,"ax",@progbits
	.global uc_field_0x24_is_zero
uc_field_0x24_is_zero:
	.global L_921998
L_921998:
	push_s r13
L_92199a:
	mov_s r13,blink
L_92199c:
	bl.d L_928fc0
L_9219a0:
	add r0,r0,0x24
L_9219a4:
	rsub.f r0,r0,0x1
L_9219a8:
	mov_s blink,r13
L_9219aa:
	mov.cs r0,0x0
L_9219ae:
	j_s.d [blink]
L_9219b0:
	pop_s r13
L_9219b2:
	nop_s
