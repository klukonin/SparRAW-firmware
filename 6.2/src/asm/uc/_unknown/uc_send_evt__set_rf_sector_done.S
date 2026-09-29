/* uc_send_evt__set_rf_sector_done @ 0x9277e4, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_selected_rf_sector_index_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__set_rf_sector_done
uc_send_evt__set_rf_sector_done:
	.global L_9277e4
L_9277e4:
	push_s blink
L_9277e6:
	bl L_920234
L_9277ea:
	mov_s r14,r0
L_9277ec:
	mov_s r0,0x802470
L_9277f2:
	bl L_920d4c
L_9277f6:
	mov_s r1,r14
L_9277f8:
	mov_s r13,r0
L_9277fa:
	bl.d L_920330
L_9277fe:
	mov_s r2,0x4
L_927800:
	mov_s r0,r13
L_927802:
	mov_s r1,0x28
L_927804:
	mov_s r2,0x4
L_927806:
	bl.d L_927958
L_92780a:
	mov_s r3,0x0
L_92780c:
	b L_9202a4
