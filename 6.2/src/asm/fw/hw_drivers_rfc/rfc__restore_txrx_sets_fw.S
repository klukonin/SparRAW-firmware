/* rfc__restore_txrx_sets_fw @ 0x8d3460, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc_powerup_deep_all_rfs_fw, hwm_analog_select_active_rf_module, silent_rssi__calibrate_single_rf_module
 * Зовёт сам: rf__set_txrx_sets_save_fw, rfc__write_core_reg6, rfc__write_field_1136
 * Глобалы (через gp): 0x800244
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__restore_txrx_sets_fw
rfc__restore_txrx_sets_fw:
	.global L_8d3460
L_8d3460:
	push_s blink
L_8d3462:
	sub_s sp,sp,0x8
L_8d3464:
	mov_s r2,sp
L_8d3466:
	add_s r3,sp,0x4
L_8d3468:
	mov_s r0,0xf
L_8d346a:
	bl.d L_8d3efc
L_8d346e:
	mov_s r1,0xff
L_8d3470:
	mov_s r1,0x889100
L_8d3476:
	ld_s r0,[r1,0x18]
L_8d3478:
	bclr_s r0,r0,0x4
L_8d347a:
	st_s r0,[r1,0x18]
L_8d347c:
	ldb_s r0,[gp,0xc0]
L_8d347e:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_8d3480:
	add2_s r0,r0,r0
L_8d3482:
	mov lp_count,r0
L_8d3486:
	nop_s
L_8d3488:
	lp L_8d3490
L_8d348c:
	nop_s
L_8d348e:
	nop_s
	.global L_8d3490
L_8d3490:
	mov_s r1,0x889100
L_8d3496:
	ld_s r0,[r1,0x18]
L_8d3498:
	bset_s r0,r0,0x4
L_8d349a:
	st_s r0,[r1,0x18]
L_8d349c:
	ld_s r2,[sp,0x0]
L_8d349e:
	mov_s r0,0x889480
L_8d34a4:
	st_s r2,[r0,0x8]
L_8d34a6:
	ld_s r0,[sp,0x4]
L_8d34a8:
	st_s r0,[r1,0x54]
L_8d34aa:
	mov_s r0,0x0
L_8d34ac:
	bl.d L_8d32a4
L_8d34b0:
	mov_s r1,r0
L_8d34b2:
	bl.d L_8d4064
L_8d34b6:
	mov_s r0,0x0
L_8d34b8:
	add_s sp,sp,0x8
L_8d34ba:
	pop_s blink
L_8d34bc:
	j_s [blink]
L_8d34be:
	nop_s
