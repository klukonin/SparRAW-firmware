/* uc_send_evt__set_rf_sector_done @ 0x925cfc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: set_selected_rf_sector_index_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, basic_if__alloc_evt_slot, memcpy_uc, uc_send_event
 */
	.section .text.uc_send_evt__set_rf_sector_done,"ax",@progbits
	.global uc_send_evt__set_rf_sector_done
uc_send_evt__set_rf_sector_done:
	.global L_925cfc
L_925cfc:
	push_s blink
L_925cfe:
	bl L_920214
L_925d02:
	mov_s r14,r0
L_925d04:
	mov_s r0,0x801618
L_925d0a:
	bl L_921930
L_925d0e:
	mov_s r1,r14
L_925d10:
	mov_s r13,r0
L_925d12:
	bl.d L_920310
L_925d16:
	mov_s r2,0x4
L_925d18:
	mov_s r0,r13
L_925d1a:
	mov_s r1,0x28
L_925d1c:
	mov_s r2,0x4
L_925d1e:
	bl.d L_925dd8
L_925d22:
	mov_s r3,0x0
L_925d24:
	b L_920284
