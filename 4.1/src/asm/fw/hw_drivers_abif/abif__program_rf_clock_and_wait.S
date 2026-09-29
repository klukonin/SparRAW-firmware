/* abif__program_rf_clock_and_wait @ 0x8cba10, 272 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__program_rf_clocks, hwm_analog_channel_switch, marlon_r_if_class__init_board_file_inteface
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, hwd_abif__set_889800_8cd1e0
 */
	.section .text.abif__program_rf_clock_and_wait,"ax",@progbits
	.global abif__program_rf_clock_and_wait
abif__program_rf_clock_and_wait:
	.global L_8cba10
L_8cba10:
	push_s blink
L_8cba12:
	bl L_8c02bc
L_8cba16:
	mov_s r16,r0
L_8cba18:
	mov_s r1,0x889480
L_8cba1e:
	ld_s r0,[r1,0x24]
L_8cba20:
	bic r0,r0,0x7c0
L_8cba24:
	bset_s r0,r0,0x9
L_8cba26:
	st_s r0,[r1,0x24]
L_8cba28:
	mov_s r0,0x7d
L_8cba2a:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8cba2c:
	mov lp_count,r0
L_8cba30:
	nop_s
L_8cba32:
	lp L_8cba3a
L_8cba36:
	nop_s
L_8cba38:
	nop_s
	.global L_8cba3a
L_8cba3a:
	mov_s r13,0x889400
L_8cba40:
	ld_s r0,[r13,0x1c]
L_8cba42:
	bic.f 0x0,r16,0xf
L_8cba46:
	bclr_s r0,r0,0x5
L_8cba48:
	bclr_s r0,r0,0x6
L_8cba4a:
	or r0,r0,0x60
L_8cba4e:
	st_s r0,[r13,0x1c]
L_8cba50:
	bne_s L_8cbb0a
	.global L_8cba52
L_8cba52:
	ld_s r1,[r13,0x1c]
L_8cba54:
	asl r0,r16,0x10
L_8cba58:
	and r1,r1,0xfff0ffff
L_8cba60:
	or_s r0,r0,r1
L_8cba62:
	st_s r0,[r13,0x1c]
L_8cba64:
	ld_s r0,[r13,0x1c]
L_8cba66:
	mov lp_count,0x30d40
L_8cba6e:
	or r0,r0,0x3
L_8cba72:
	st_s r0,[r13,0x1c]
L_8cba74:
	ld_s r0,[r13,0x1c]
L_8cba76:
	bclr_s r0,r0,0x4
L_8cba78:
	st_s r0,[r13,0x1c]
L_8cba7a:
	mov_s r13,0x88af80
L_8cba80:
	lp L_8cba8c
L_8cba84:
	ld_s r1,[r13,0x6c]
L_8cba86:
	btst_s r1,0x4
L_8cba88:
	bne_s L_8cba8c
L_8cba8a:
	nop_s
	.global L_8cba8c
L_8cba8c:
	ld_s r0,[r13,0x6c]
L_8cba8e:
	bbit1 r0,0x4,L_8cbaa2
L_8cba92:
	mov_s r3,blink
L_8cba94:
	mov_s r2,0x1019968
L_8cba9a:
	mov_s r0,0x0
L_8cba9c:
	bl.d L_8edfcc
L_8cbaa0:
	mov_s r1,r0
	.global L_8cbaa2
L_8cbaa2:
	mov_s r0,0x7d
L_8cbaa4:
	/* asl_s r0,r0,0x5 */
	.byte 0x05,0xb8
L_8cbaa6:
	mov lp_count,r0
L_8cbaaa:
	nop_s
L_8cbaac:
	lp L_8cbab4
L_8cbab0:
	nop_s
L_8cbab2:
	nop_s
	.global L_8cbab4
L_8cbab4:
	mov lp_count,0x30d40
L_8cbabc:
	nop_s
L_8cbabe:
	lp L_8cbaca
L_8cbac2:
	ld_s r1,[r13,0x6c]
L_8cbac4:
	btst_s r1,0x5
L_8cbac6:
	bne_s L_8cbaca
L_8cbac8:
	nop_s
	.global L_8cbaca
L_8cbaca:
	ld_s r0,[r13,0x6c]
L_8cbacc:
	bbit1 r0,0x5,L_8cbaf4
L_8cbad0:
	mov_s r2,0x1019934
L_8cbad6:
	mov_s r0,0x0
L_8cbad8:
	bl.d L_8edfb0
L_8cbadc:
	mov_s r1,r0
L_8cbade:
	mov_s r0,blink
L_8cbae0:
	mov_s r2,0x1019954
L_8cbae6:
	mov_s r1,0x1348
L_8cbaec:
	bl.d L_8c82c0
L_8cbaf0:
	mov r3,0x134
	.global L_8cbaf4
L_8cbaf4:
	mov_s r1,0x889400
L_8cbafa:
	ld_s r0,[r1,0x1c]
L_8cbafc:
	bclr_s r0,r0,0x5
L_8cbafe:
	bclr_s r0,r0,0x6
L_8cbb00:
	st_s r0,[r1,0x1c]
L_8cbb02:
	bl L_8cd1e0
L_8cbb06:
	b L_8c0324
	.global L_8cbb0a
L_8cbb0a:
	mov_s r0,blink
L_8cbb0c:
	mov_s r2,0x1019954
L_8cbb12:
	mov_s r1,0xac
L_8cbb14:
	bl.d L_8c82c0
L_8cbb18:
	mov r3,0x122
L_8cbb1c:
	b_s L_8cba52
L_8cbb1e:
	nop_s
