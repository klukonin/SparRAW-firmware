/* wmi_evt__post @ 0x8e4fc4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__wmi_ps_dev_profile_cfg_cmd, beacon_interval, evt_get_selected_rf_sector_index_done, evt_set_selected_rf_sector_index_done, fixed_sched__start, host_if__bf_ctrl_hal, host_if__get_status_hal, host_if__read_rf_xpm_handler, host_if__write_rf_xpm_handler, l2_mgr__wmi_cmd_handler_get_mgmt_retry_limit
 * Зовёт сам: __ld_r13_to_r13_ret, wmi_evt__build_and_post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__post
wmi_evt__post:
	.global L_8e4fc4
L_8e4fc4:
	push_s blink
L_8e4fc6:
	push_s r13
L_8e4fc8:
	sub_s sp,sp,0x4
L_8e4fca:
	mov_s r13,r0
L_8e4fcc:
	mov_s r9,r1
L_8e4fce:
	mov_s r8,r3
L_8e4fd0:
	brne_s r2,0,L_8e4fda
L_8e4fd2:
	add r4,r4,0x8
L_8e4fd6:
	extw r4,r4
	.global L_8e4fda
L_8e4fda:
	ld_s r0,[sp,0xc]
L_8e4fdc:
	mov_s r1,r9
L_8e4fde:
	st_s r0,[sp,0x0]
L_8e4fe0:
	mov_s r0,r13
L_8e4fe2:
	bl.d L_8e4ff8
L_8e4fe6:
	mov_s r3,r8
L_8e4fe8:
	ld_s r0,[r13,0x44]
L_8e4fea:
	ld_s r1,[r0,0xc]
L_8e4fec:
	jl_s.d [r1]
L_8e4fee:
	mov_s r0,r13
L_8e4ff0:
	b.d L_8c025c
L_8e4ff4:
	add_s sp,sp,0x4
L_8e4ff6:
	nop_s
