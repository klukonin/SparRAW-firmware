/* radio_manager_main_sm__on_ch_switch_done @ 0x8dcb9c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, radio_mgr__set_tune_result, rm_main_sm__enter_primary_non_locked
 */
	.section .text.radio_manager_main_sm__on_ch_switch_done,"ax",@progbits
	.global radio_manager_main_sm__on_ch_switch_done
radio_manager_main_sm__on_ch_switch_done:
L_8dcb9c:
	push_s blink
L_8dcb9e:
	bl L_8c02c4
L_8dcba2:
	mov_s r13,r0
L_8dcba4:
	mov_s r14,r1
L_8dcba6:
	mov_s r1,r2
L_8dcba8:
	bl.d L_8e49f8
L_8dcbac:
	mov_s r2,r14
L_8dcbae:
	bl.d L_8c80c8
L_8dcbb2:
	mov_s r0,r13
L_8dcbb4:
	b L_8c0334
