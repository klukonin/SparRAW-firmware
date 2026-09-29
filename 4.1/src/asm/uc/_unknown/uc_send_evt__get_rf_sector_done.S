/* uc_send_evt__get_rf_sector_done @ 0x925c14, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_selected_rf_sector_index_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__get_rf_sector_done,"ax",@progbits
	.global uc_send_evt__get_rf_sector_done
uc_send_evt__get_rf_sector_done:
	.global L_925c14
L_925c14:
	push_s blink
L_925c16:
	bl L_920214
L_925c1a:
	mov_s r14,r0
L_925c1c:
	mov_s r0,0x801618
L_925c22:
	bl L_921930
L_925c26:
	mov_s r1,r14
L_925c28:
	mov_s r13,r0
L_925c2a:
	bl.d L_920310
L_925c2e:
	mov_s r2,0x10
L_925c30:
	mov_s r0,r13
L_925c32:
	mov_s r1,0x27
L_925c34:
	mov_s r2,0x10
L_925c36:
	bl.d L_925dd8
L_925c3a:
	mov_s r3,0x0
L_925c3c:
	b L_920284
