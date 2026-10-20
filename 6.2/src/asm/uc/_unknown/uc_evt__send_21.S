/* uc_evt__send_21 @ 0x9278c8, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf__reset_sta_slot
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_evt__send_21
uc_evt__send_21:
	.global L_9278c8
L_9278c8:
	push_s blink
L_9278ca:
	bl L_920230
L_9278ce:
	mov_s r14,r0
L_9278d0:
	mov_s r0,0x802470
L_9278d6:
	bl.d L_920d4c
L_9278da:
	mov_s r15,r1
L_9278dc:
	mov_s r13,r0
L_9278de:
	stb.ab r14,[r0,0x4]
L_9278e2:
	mov_s r1,r15
L_9278e4:
	bl.d L_920330
L_9278e8:
	mov_s r2,0x20
L_9278ea:
	mov_s r0,r13
L_9278ec:
	mov_s r1,0x21
L_9278ee:
	mov_s r2,0x24
L_9278f0:
	bl.d L_927958
L_9278f4:
	mov_s r3,0x0
L_9278f6:
	b L_92029c
L_9278fa:
	nop_s
