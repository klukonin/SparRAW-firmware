/* rf_sector__apply_on_radio_locked @ 0x8db364, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, wmi_handler_set_rf_sector_params__set_rf_sector_params
 */
	.section .text.rf_sector__apply_on_radio_locked,"ax",@progbits
	.global rf_sector__apply_on_radio_locked
rf_sector__apply_on_radio_locked:
L_8db364:
	push_s blink
L_8db366:
	bl L_8c02c4
L_8db36a:
	mov_s r14,r0
L_8db36c:
	mov_s r13,r1
L_8db36e:
	bl.d L_8cb114
L_8db372:
	mov_s r0,r1
L_8db374:
	bl.d L_8e54d8
L_8db378:
	mov_s r0,r14
L_8db37a:
	mov_s r0,0x0
L_8db37c:
	b.d L_8c0334
L_8db380:
	st r0,[r13, 0xc8]
