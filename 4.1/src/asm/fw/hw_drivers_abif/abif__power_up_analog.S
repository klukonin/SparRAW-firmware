/* abif__power_up_analog @ 0x8cbbc0, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__enable_pll, hwm__reset_analog_block
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.abif__power_up_analog,"ax",@progbits
	.global abif__power_up_analog
abif__power_up_analog:
	.global L_8cbbc0
L_8cbbc0:
	push_s blink
L_8cbbc2:
	bl L_8c02c4
L_8cbbc6:
	mov_s r14,0x889380
L_8cbbcc:
	brne r0,0x1,L_8cbc80
L_8cbbd0:
	mov_s r13,0x88af80
L_8cbbd6:
	ld_s r0,[r13,0x30]
L_8cbbd8:
	mov lp_count,0x4e20
L_8cbbe0:
	and r0,r0,0xfffd0fff
L_8cbbe8:
	bset_s r0,r0,0xf
L_8cbbea:
	st_s r0,[r13,0x30]
L_8cbbec:
	ld_s r0,[r14,0x74]
L_8cbbee:
	bclr_s r0,r0,0x5
L_8cbbf0:
	bclr_s r0,r0,0x6
L_8cbbf2:
	or r0,r0,0x60
L_8cbbf6:
	st_s r0,[r14,0x74]
L_8cbbf8:
	ld_s r0,[r14,0x74]
L_8cbbfa:
	bic r0,r0,0x7
L_8cbbfe:
	or r0,r0,0x3
L_8cbc02:
	st_s r0,[r14,0x74]
L_8cbc04:
	ld_s r0,[r14,0x74]
L_8cbc06:
	bclr_s r0,r0,0x4
L_8cbc08:
	st_s r0,[r14,0x74]
L_8cbc0a:
	lp L_8cbc16
L_8cbc0e:
	ld_s r1,[r13,0x6c]
L_8cbc10:
	btst_s r1,0x2
L_8cbc12:
	bne_s L_8cbc16
L_8cbc14:
	nop_s
	.global L_8cbc16
L_8cbc16:
	bbit1 r1,0x2,L_8cbc3c
L_8cbc1a:
	mov_s r2,0x1019934
L_8cbc20:
	mov_s r0,0x0
L_8cbc22:
	bl.d L_8edfb0
L_8cbc26:
	mov_s r1,r0
L_8cbc28:
	mov_s r0,blink
L_8cbc2a:
	mov_s r2,0x1019954
L_8cbc30:
	mov_s r1,0x1321
L_8cbc36:
	bl.d L_8c82c0
L_8cbc3a:
	mov_s r3,0x9a
	.global L_8cbc3c
L_8cbc3c:
	mov lp_count,0x4e20
L_8cbc44:
	nop_s
L_8cbc46:
	lp L_8cbc52
L_8cbc4a:
	ld_s r1,[r13,0x6c]
L_8cbc4c:
	btst_s r1,0x3
L_8cbc4e:
	bne_s L_8cbc52
L_8cbc50:
	nop_s
	.global L_8cbc52
L_8cbc52:
	bbit1 r1,0x3,L_8cbc78
L_8cbc56:
	mov_s r2,0x1019934
L_8cbc5c:
	mov_s r0,0x0
L_8cbc5e:
	bl.d L_8edfb0
L_8cbc62:
	mov_s r1,r0
L_8cbc64:
	mov_s r0,blink
L_8cbc66:
	mov_s r2,0x1019954
L_8cbc6c:
	mov_s r1,0x1322
L_8cbc72:
	bl.d L_8c82c0
L_8cbc76:
	mov_s r3,0xa1
	.global L_8cbc78
L_8cbc78:
	ld_s r0,[r14,0x74]
L_8cbc7a:
	bclr_s r0,r0,0x5
L_8cbc7c:
	bclr_s r0,r0,0x6
L_8cbc7e:
	b_s L_8cbc8a
	.global L_8cbc80
L_8cbc80:
	ld_s r0,[r14,0x74]
L_8cbc82:
	bic r0,r0,0x6
L_8cbc86:
	bset_s r0,r0,0x2
L_8cbc88:
	bclr_s r0,r0,0x0
	.global L_8cbc8a
L_8cbc8a:
	st_s r0,[r14,0x74]
L_8cbc8c:
	b L_8c0334
