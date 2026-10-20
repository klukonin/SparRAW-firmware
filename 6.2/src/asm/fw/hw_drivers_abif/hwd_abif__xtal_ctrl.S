/* hwd_abif__xtal_ctrl @ 0x8cffc4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__pll_bypass, hw_modes__pll_engage
 * Зовёт сам: fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__xtal_ctrl
hwd_abif__xtal_ctrl:
	.global L_8cffc4
L_8cffc4:
	push_s blink
L_8cffc6:
	mov_s r1,0x88af80
L_8cffcc:
	cmp_s r0,0x1
L_8cffce:
	ld_s r0,[r1,0x24]
L_8cffd0:
	bne_s L_8d0008
L_8cffd2:
	bset_s r0,r0,0x0
L_8cffd4:
	st_s r0,[r1,0x24]
L_8cffd6:
	mov lp_count,0x12c
L_8cffda:
	nop_s
L_8cffdc:
	lp L_8cffe8
L_8cffe0:
	ld_s r0,[r1,0x6c]
L_8cffe2:
	btst_s r0,0x0
L_8cffe4:
	bne_s L_8cffe8
L_8cffe6:
	nop_s
	.global L_8cffe8
L_8cffe8:
	bbit1 r0,0x0,L_8d000e
L_8cffec:
	mov_s r1,0x101eee4
L_8cfff2:
	bl.d L_8dcba8
L_8cfff6:
	mov_s r0,0x0
L_8cfff8:
	mov_s r0,blink
L_8cfffa:
	mov_s r1,0x1323
L_8d0000:
	bl L_8c9b28
	.global L_8d0004
L_8d0004:
	pop_s blink
L_8d0006:
	j_s [blink]
	.global L_8d0008
L_8d0008:
	bclr_s r0,r0,0x0
L_8d000a:
	st_s r0,[r1,0x24]
L_8d000c:
	b_s L_8d0004
	.global L_8d000e
L_8d000e:
	b_s L_8d0004
