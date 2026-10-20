/* basic_if__alloc_mbox_slot @ 0x8c2c38, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_if.cpp
 * Зовут его: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, host_if__bf_ctrl_hal, host_if__get_status_hal, host_if__timestamp_sync, l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit, l2_mgr__wmi_cmd_handler_set_mgmt_retry_limit, l2mgr__send_temp_sense_done, lmac_echo__alloc_mbox_slot, lmac_if__send_bcon_mgt, lmac_if__send_get_rf_sector_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mbox__alloc_from_pool
 */
	.section .text.basic_if__alloc_mbox_slot,"ax",@progbits
	.global basic_if__alloc_mbox_slot
basic_if__alloc_mbox_slot:
	.global L_8c2c38
L_8c2c38:
	push_s blink
L_8c2c3a:
	bl L_8c02c4
L_8c2c3e:
	lr r14,[0xa]
L_8c2c42:
	bclr r1,r14,0x1
L_8c2c46:
	flag r1
L_8c2c4a:
	/* bl.d 0x008c2d34 */
	.byte 0xee,0x08,0x20,0x00
L_8c2c4e:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c2c50:
	mov_s r13,r0
L_8c2c52:
	lr r0,[0xa]
L_8c2c56:
	bic r14,r14,-0x3
L_8c2c5a:
	or_s r14,r14,r0
L_8c2c5c:
	flag r14
L_8c2c60:
	cmp_s r13,0x0
L_8c2c62:
	add.ne r13,r13,0x10
L_8c2c66:
	bne_s L_8c2c78
L_8c2c68:
	mov_s r0,blink
L_8c2c6a:
	mov_s r2,0x100269c
L_8c2c70:
	mov_s r1,0xc1
L_8c2c72:
	bl.d L_8c82c0
L_8c2c76:
	mov_s r3,0x19
	.global L_8c2c78
L_8c2c78:
	b.d L_8c0334
L_8c2c7c:
	mov_s r0,r13
L_8c2c7e:
	nop_s
