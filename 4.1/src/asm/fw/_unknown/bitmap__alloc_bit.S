/* bitmap__alloc_bit @ 0x8db194, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: frag_8f1908, fwq_tx__handle_completion, l2_mgr__chk_sys_idle, l2_mgr__scan_complete_handle, l2_mgr__validate_scan, l2_mgr__wmi_scan_cmd, scan_mngr__dband_beacon_ind, wmi_handler_get_rf_sector_params__on_radio_locked_cb, wmi_handler_set_rf_sector_params__set_rf_sector_params
 * Зовёт сам: bitmap__any_free
 */
	.section .text.bitmap__alloc_bit,"ax",@progbits
	.global bitmap__alloc_bit
bitmap__alloc_bit:
	.global L_8db194
L_8db194:
	push_s blink
L_8db196:
	mov_s r2,r0
L_8db198:
	bl.d L_8cb680
L_8db19c:
	mov r1,-0x1
L_8db1a0:
	cmp_s r0,0x0
L_8db1a2:
	mov.eq r0,r1
L_8db1a6:
	beq_s L_8db1be
L_8db1a8:
	ld_s r1,[r2]
L_8db1aa:
	mov_s r0,0x1f
L_8db1ac:
	bbit1 r1,0x1f,L_8db1b8
L_8db1b0:
	norm r3,r1
L_8db1b4:
	rsub r0,r3,0x1e
	.global L_8db1b8
L_8db1b8:
	bclr r1,r1,r0
L_8db1bc:
	st_s r1,[r2]
	.global L_8db1be
L_8db1be:
	pop_s blink
L_8db1c0:
	j_s [blink]
L_8db1c2:
	nop_s
