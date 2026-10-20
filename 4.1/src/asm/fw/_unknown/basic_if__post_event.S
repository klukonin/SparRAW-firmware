/* basic_if__post_event @ 0x8e0460, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, host_if__bf_ctrl_hal, host_if__get_status_hal, host_if__timestamp_sync, l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit, l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit, l2mgr__send_temp_sense_done, lmac_echo__report_to_host, lmac_if__send_get_rf_sector_done, lmac_if__send_set_rf_sector_done
 * Зовёт сам: __ld_r13_ret, basic_if__mailbox_send
 */
	.section .text.basic_if__post_event,"ax",@progbits
	.global basic_if__post_event
basic_if__post_event:
	.global L_8e0460
L_8e0460:
	push_s blink
L_8e0462:
	push_s r13
L_8e0464:
	mov_s r13,r0
L_8e0466:
	mov_s r9,r1
L_8e0468:
	mov_s r8,r3
L_8e046a:
	brne_s r2,0,L_8e0474
L_8e046c:
	add r4,r4,0x8
L_8e0470:
	extw r4,r4
	.global L_8e0474
L_8e0474:
	mov_s r0,r13
L_8e0476:
	mov_s r1,r9
L_8e0478:
	bl.d L_8e048c
L_8e047c:
	mov_s r3,r8
L_8e047e:
	ld_s r0,[r13,0x44]
L_8e0480:
	ld_s r1,[r0,0xc]
L_8e0482:
	jl_s.d [r1]
L_8e0484:
	mov_s r0,r13
L_8e0486:
	b L_8c033c
L_8e048a:
	nop_s
