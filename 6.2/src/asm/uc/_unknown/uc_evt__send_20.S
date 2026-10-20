/* uc_evt__send_20 @ 0x92785c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta_slot
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_20
uc_evt__send_20:
	.global L_92785c
L_92785c:
	push_s blink
L_92785e:
	push_s r13
L_927860:
	mov_s r13,r0
L_927862:
	mov_s r0,0x802470
L_927868:
	bl L_920d4c
L_92786c:
	mov_s r1,0x20
L_92786e:
	st_s r13,[r0]
L_927870:
	mov_s r2,0x4
L_927872:
	bl.d L_927958
L_927876:
	mov_s r3,0x0
L_927878:
	b L_9202ac
