/* uc_send_evt__new_link @ 0x9276bc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: notify_aoa, uc_evt__build_and_post_report
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__new_link
uc_send_evt__new_link:
	.global L_9276bc
L_9276bc:
	sub_s sp,sp,0x20
L_9276be:
	push_s blink
L_9276c0:
	push_s r13
L_9276c2:
	st_s r0,[sp,0x8]
L_9276c4:
	st_s r1,[sp,0xc]
L_9276c6:
	st_s r2,[sp,0x10]
L_9276c8:
	st_s r3,[sp,0x14]
L_9276ca:
	st r4,[sp, 0x18]
L_9276ce:
	st r5,[sp, 0x1c]
L_9276d2:
	st r6,[sp, 0x20]
L_9276d6:
	mov_s r0,0x802470
L_9276dc:
	bl.d L_920d4c
L_9276e0:
	st r7,[sp, 0x24]
L_9276e4:
	mov_s r13,r0
L_9276e6:
	add_s r1,sp,0x8
L_9276e8:
	bl.d L_920330
L_9276ec:
	mov_s r2,0x44
L_9276ee:
	mov_s r0,r13
L_9276f0:
	mov_s r1,0x5
L_9276f2:
	mov_s r2,0x44
L_9276f4:
	bl.d L_927958
L_9276f8:
	mov_s r3,0x0
L_9276fa:
	mov_s r12,0x24
L_9276fc:
	b L_9202ae
