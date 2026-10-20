/* uc_send_evt__bf_done @ 0x9275a8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: notify_aoa, uc_evt__build_and_post_report
 * Зовёт сам: __ld_r13_to_r13_ret, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__bf_done
uc_send_evt__bf_done:
	.global L_9275a8
L_9275a8:
	sub_s sp,sp,0x20
L_9275aa:
	push_s blink
L_9275ac:
	push_s r13
L_9275ae:
	st_s r0,[sp,0x8]
L_9275b0:
	st_s r1,[sp,0xc]
L_9275b2:
	st_s r2,[sp,0x10]
L_9275b4:
	st_s r3,[sp,0x14]
L_9275b6:
	st r4,[sp, 0x18]
L_9275ba:
	st r5,[sp, 0x1c]
L_9275be:
	st r6,[sp, 0x20]
L_9275c2:
	mov_s r0,0x802470
L_9275c8:
	bl.d L_920d4c
L_9275cc:
	st r7,[sp, 0x24]
L_9275d0:
	mov_s r13,r0
L_9275d2:
	add_s r1,sp,0x8
L_9275d4:
	bl.d L_920330
L_9275d8:
	mov_s r2,0x44
L_9275da:
	mov_s r0,r13
L_9275dc:
	mov_s r1,0x6
L_9275de:
	mov_s r2,0x44
L_9275e0:
	bl.d L_927958
L_9275e4:
	mov_s r3,0x0
L_9275e6:
	mov_s r12,0x24
L_9275e8:
	b L_9202ae
