/* wmi_handler_set_rf_sector_params__handle @ 0x8cae0c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_set_rf_sector_params::handle(): Radio is still locked by outdated request m_radio_handle=0x%X, cmd.rf_modules_vec=0x%X, cmd.sector_idx=%d
 *   wmi_handlers.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.wmi_handler_set_rf_sector_params__handle,"ax",@progbits
	.global wmi_handler_set_rf_sector_params__handle
wmi_handler_set_rf_sector_params__handle:
	.global L_8cae0c
L_8cae0c:
	push_s blink
L_8cae0e:
	push_s r13
L_8cae10:
	ld r3,[r0, 0xc8]
L_8cae14:
	mov_s r13,r0
L_8cae16:
	brne_s r3,0,L_8cae36
	.global L_8cae18
L_8cae18:
	mov_s r0,0x1b364
L_8cae1e:
	mov_s r1,r13
L_8cae20:
	mov_s r2,0x0
L_8cae22:
	mov_s r3,0xffff
L_8cae28:
	bl.d L_8d938c
L_8cae2c:
	mov_s r4,r2
L_8cae2e:
	b.d L_8c033c
L_8cae32:
	st r0,[r13, 0xc8]
	.global L_8cae36
L_8cae36:
	ldb r4,[r13, 0x3]
L_8cae3a:
	mov_s r2,0x10078f8
L_8cae40:
	ldw r5,[r13]
L_8cae44:
	mov_s r0,0x0
L_8cae46:
	bl.d L_8ee034
L_8cae4a:
	mov_s r1,r0
L_8cae4c:
	mov_s r0,blink
L_8cae4e:
	mov_s r2,0x100710c
L_8cae54:
	mov_s r1,0x1468
L_8cae5a:
	bl.d L_8c82c0
L_8cae5e:
	mov r3,0x1af
L_8cae62:
	b_s L_8cae18
