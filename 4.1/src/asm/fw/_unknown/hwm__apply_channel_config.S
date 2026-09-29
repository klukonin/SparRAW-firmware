/* hwm__apply_channel_config @ 0x8d508c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, calib_mngr__switch_channel, rgf_reg_88a200
 * Зовёт сам: hwd_abif__rgf_88a200_8cc674, hwd_mac__set_886d80_8ce294, hwd_phy__rgf_883000_8cf4c8, hwd_phy__rgf_884000, hwd_phy__set_mode, set_reg_886dc8
 * Глобалы (через gp): 0x800201, 0x800202
 */
	.section .text.hwm__apply_channel_config,"ax",@progbits
	.global hwm__apply_channel_config
hwm__apply_channel_config:
	.global L_8d508c
L_8d508c:
	push_s blink
L_8d508e:
	breq_s r0,0,L_8d50ca
L_8d5090:
	ldb_s r0,[gp,0x91]
L_8d5092:
	cmp_s r0,0x0
L_8d5094:
	mov_s r0,0x0
L_8d5096:
	mov.eq r1,r0
L_8d509a:
	beq_s L_8d50a2
L_8d509c:
	ldb r1,[gp, 0x90]
L_8d50a0:
	mov_s r0,0x1
	.global L_8d50a2
L_8d50a2:
	bl L_8cc674
L_8d50a6:
	ldb_s r0,[gp,0x92]
L_8d50a8:
	cmp_s r0,0x0
L_8d50aa:
	mov_s r0,0x1
L_8d50ac:
	mov.eq r0,0x0
L_8d50b0:
	bl L_8cf588
L_8d50b4:
	bl L_8ce2ac
L_8d50b8:
	bl L_8ce294
L_8d50bc:
	bl.d L_8cf4fc
L_8d50c0:
	mov_s r0,0x1
L_8d50c2:
	bl.d L_8cf4c8
L_8d50c6:
	mov_s r0,0x1
L_8d50c8:
	b_s L_8d50de
	.global L_8d50ca
L_8d50ca:
	bl.d L_8cf4fc
L_8d50ce:
	mov_s r0,0x0
L_8d50d0:
	bl.d L_8cf4c8
L_8d50d4:
	mov_s r0,0x0
L_8d50d6:
	bl L_8ce2ac
L_8d50da:
	bl L_8ce294
	.global L_8d50de
L_8d50de:
	pop_s blink
L_8d50e0:
	j_s [blink]
L_8d50e2:
	nop_s
