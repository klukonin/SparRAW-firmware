/* radio_manager_main_sm__on_sec_tune @ 0x8e0350, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, radio_mgr__copy_tune_params, rm_main_sm__assert_line, rm_main_sm__kick_channel_switch_sm
 */
	.section .text.radio_manager_main_sm__on_sec_tune,"ax",@progbits
	.global radio_manager_main_sm__on_sec_tune
radio_manager_main_sm__on_sec_tune:
L_8e0350:
	push_s blink
L_8e0352:
	bl L_8c02c4
L_8e0356:
	mov_s r13,r0
L_8e0358:
	ld r0,[r0, 0xc8]
L_8e035c:
	mov_s r14,r1
L_8e035e:
	/* brne r1,r0,0x008e0374 */
	.byte 0x19,0x09,0x01,0x00
	.global L_8e0362
L_8e0362:
	mov_s r0,r13
L_8e0364:
	bl.d L_8e59f4
L_8e0368:
	mov_s r1,r14
L_8e036a:
	bl.d L_8d75dc
L_8e036e:
	mov_s r0,r13
L_8e0370:
	b L_8c0334
