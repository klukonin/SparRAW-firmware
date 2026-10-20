/* uc_send_evt__get_rf_sector_done @ 0x927664, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_selected_rf_sector_index_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, irq_safe__deref_field_04, memcpy_uc, uc_evt__enqueue
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt__get_rf_sector_done
uc_send_evt__get_rf_sector_done:
	.global L_927664
L_927664:
	push_s blink
L_927666:
	bl L_920234
L_92766a:
	mov_s r14,r0
L_92766c:
	mov_s r0,0x802470
L_927672:
	bl L_920d4c
L_927676:
	mov_s r1,r14
L_927678:
	mov_s r13,r0
L_92767a:
	bl.d L_920330
L_92767e:
	mov_s r2,0x10
L_927680:
	mov_s r0,r13
L_927682:
	mov_s r1,0x27
L_927684:
	mov_s r2,0x10
L_927686:
	bl.d L_927958
L_92768a:
	mov_s r3,0x0
L_92768c:
	b L_9202a4
