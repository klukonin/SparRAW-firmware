/* rf_sector__read_on_radio_locked @ 0x8db344, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, wmi_handler_get_rf_sector_params__on_radio_locked_cb
 */
	.section .text.rf_sector__read_on_radio_locked,"ax",@progbits
	.global rf_sector__read_on_radio_locked
rf_sector__read_on_radio_locked:
L_8db344:
	push_s blink
L_8db346:
	bl L_8c02c4
L_8db34a:
	mov_s r14,r0
L_8db34c:
	mov_s r13,r1
L_8db34e:
	bl.d L_8caff0
L_8db352:
	mov_s r0,r1
L_8db354:
	bl.d L_8e54d8
L_8db358:
	mov_s r0,r14
L_8db35a:
	mov_s r0,0x0
L_8db35c:
	b.d L_8c0334
