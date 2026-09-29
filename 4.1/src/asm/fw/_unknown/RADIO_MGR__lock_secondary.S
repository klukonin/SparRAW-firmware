/* RADIO_MGR__lock_secondary @ 0x8d938c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RADIO_MGR::lock_secondary() [tune=%d, channelId=%d]. Handle:0x%x
 * Зовут его: calib_engine__on_lock_radio, channels_switch_sm__action_allocate_radio, l2_mgr__lmac_high_false_alarm_evt_handler, radio_mgr__reset_and_lock_secondary, timer_exp_handler, wmi_handler_get_rf_sector_params__handle, wmi_handler_set_rf_sector_params__handle
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3
 */
	.section .text.RADIO_MGR__lock_secondary,"ax",@progbits
	.global RADIO_MGR__lock_secondary
RADIO_MGR__lock_secondary:
	.global L_8d938c
L_8d938c:
	push_s blink
L_8d938e:
	bl.d L_8c02bc
L_8d9392:
	mov_s r7,r0
L_8d9394:
	mov_s r6,r1
L_8d9396:
	mov_s r16,r2
L_8d9398:
	ld_s r0,[gp,-0x30]
L_8d939a:
	mov r5,r4
L_8d939e:
	ld_s r1,[r0]
L_8d93a0:
	mov_s r14,r3
L_8d93a2:
	ld_s r13,[r1,0xc]
L_8d93a4:
	mov_s r1,r7
L_8d93a6:
	mov_s r2,r6
L_8d93a8:
	mov_s r3,r16
L_8d93aa:
	jl_s.d [r13]
L_8d93ac:
	mov_s r4,r14
L_8d93ae:
	mov_s r15,r0
L_8d93b0:
	mov_s r2,0x1015bf4
L_8d93b6:
	mov_s r0,0x8
L_8d93b8:
	mov_s r1,0x2
L_8d93ba:
	mov_s r3,r16
L_8d93bc:
	mov_s r4,r14
L_8d93be:
	bl.d L_8ee034
L_8d93c2:
	mov_s r5,r15
L_8d93c4:
	b.d L_8c0324
L_8d93c8:
	mov_s r0,r15
L_8d93ca:
	nop_s
