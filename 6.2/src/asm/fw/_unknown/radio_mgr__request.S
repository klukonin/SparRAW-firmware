/* radio_mgr__request @ 0x8dcaf4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TEMPERATURE_SERVICE__timer_exp_handler, calib_engine__on_lock_radio, channels_switch_sm__action_allocate_radio, hw_sysapi__set_freq_ratio, hw_sysapi_rfc_read_write_rgf, l2_mgr__lmac_high_false_alarm_evt_handler, state_sm_8030f4__action_8f0dd4, state_sm_8034c0__action_8f058c, wmi_handler_get_rf_sector_params__handle, wmi_handler_set_rf_sector_params__handle
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__request
radio_mgr__request:
	.global L_8dcaf4
L_8dcaf4:
	push_s blink
L_8dcaf6:
	push_s r13
L_8dcaf8:
	mov_s r9,r0
L_8dcafa:
	mov_s r8,r1
L_8dcafc:
	mov_s r7,r2
L_8dcafe:
	ld_s r0,[gp,-0x40]
L_8dcb00:
	mov r5,r4
L_8dcb04:
	ld_s r1,[r0]
L_8dcb06:
	mov_s r6,r3
L_8dcb08:
	ld_s r13,[r1,0xc]
L_8dcb0a:
	mov_s r1,r9
L_8dcb0c:
	mov_s r2,r8
L_8dcb0e:
	mov_s r3,r7
L_8dcb10:
	jl_s.d [r13]
L_8dcb12:
	mov r4,r6
L_8dcb16:
	b L_8c025c
L_8dcb1a:
	nop_s
