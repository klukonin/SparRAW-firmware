/* wmi_handler_get_rf_sector_params__handle @ 0x8cadb8, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wmi_handler_get_rf_sector_params::handle(): Radio is still locked by outdated request m_radio_handle=0x%X, cmd.rf_modules_vec=0x%X, cmd.sector_idx=%d
 *   wmi_handlers.cpp
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: RADIO_MGR__lock_secondary, __ld_r13_ret, fw_log__emit3, fw_sysassert_fatal
 */
	.section .text.wmi_handler_get_rf_sector_params__handle,"ax",@progbits
	.global wmi_handler_get_rf_sector_params__handle
wmi_handler_get_rf_sector_params__handle:
	.global L_8cadb8
L_8cadb8:
	push_s blink
L_8cadba:
	push_s r13
L_8cadbc:
	ld_s r3,[r0,0x8]
L_8cadbe:
	mov_s r13,r0
L_8cadc0:
	brne_s r3,0,L_8cadde
	.global L_8cadc2
L_8cadc2:
	mov_s r0,0x1b344
L_8cadc8:
	mov_s r1,r13
L_8cadca:
	mov_s r2,0x0
L_8cadcc:
	mov_s r3,0xffff
L_8cadd2:
	bl.d L_8d938c
L_8cadd6:
	mov_s r4,r2
L_8cadd8:
	b.d L_8c033c
L_8caddc:
	st_s r0,[r13,0x8]
	.global L_8cadde
L_8cadde:
	ldb r4,[r13, 0x3]
L_8cade2:
	mov_s r2,0x10074ac
L_8cade8:
	ldw r5,[r13]
L_8cadec:
	mov_s r0,0x0
L_8cadee:
	bl.d L_8ee034
L_8cadf2:
	mov_s r1,r0
L_8cadf4:
	mov_s r0,blink
L_8cadf6:
	mov_s r2,0x100710c
L_8cadfc:
	mov_s r1,0x1466
L_8cae02:
	bl.d L_8c82c0
L_8cae06:
	mov r3,0x111
L_8cae0a:
	b_s L_8cadc2
