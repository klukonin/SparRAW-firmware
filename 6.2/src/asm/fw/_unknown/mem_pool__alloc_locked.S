/* mem_pool__alloc_locked @ 0x8c33d0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, beacon_interval, evt_get_selected_rf_sector_index_done, evt_set_selected_rf_sector_index_done, fixed_sched__start, ftm__send_ucode_session_cfg, host_if__bf_ctrl_hal, host_if__get_status_hal, host_if__read_rf_xpm_handler, host_if__send_pair
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__alloc_cell
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mem_pool__alloc_locked
mem_pool__alloc_locked:
	.global L_8c33d0
L_8c33d0:
	push_s blink
L_8c33d2:
	bl L_8c01e4
L_8c33d6:
	lr r13,[0xa]
L_8c33da:
	bclr r1,r13,0x1
L_8c33de:
	flag r1
L_8c33e2:
	bl.d L_8c34b8
L_8c33e6:
	/* _add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c33e8:
	mov_s r14,r0
L_8c33ea:
	lr r0,[0xa]
L_8c33ee:
	bic r13,r13,-0x3
L_8c33f2:
	or_s r13,r13,r0
L_8c33f4:
	flag r13
L_8c33f8:
	cmp_s r14,0x0
L_8c33fa:
	add.ne r14,r14,0x10
L_8c33fe:
	mov.eq r0,blink
L_8c3402:
	mov.eq r1,0xc1
L_8c340a:
	bl.eq L_8c9b28
L_8c340e:
	b.d L_8c0254
L_8c3412:
	mov_s r0,r14
