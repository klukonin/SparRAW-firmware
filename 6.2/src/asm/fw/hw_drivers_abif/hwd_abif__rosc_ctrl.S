/* hwd_abif__rosc_ctrl @ 0x8ceddc, 80 байт.  Сгенерировано gen_asm_tree.py
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
	.global hwd_abif__rosc_ctrl
hwd_abif__rosc_ctrl:
	.global L_8ceddc
L_8ceddc:
	push_s blink
L_8cedde:
	mov_s r1,0x88af80
L_8cede4:
	cmp_s r0,0x1
L_8cede6:
	ld_s r0,[r1,0x24]
L_8cede8:
	bne_s L_8cee24
L_8cedea:
	bset_s r0,r0,0x1
L_8cedec:
	st_s r0,[r1,0x24]
L_8cedee:
	mov lp_count,0x61a80
L_8cedf6:
	nop_s
L_8cedf8:
	lp L_8cee04
L_8cedfc:
	ld_s r0,[r1,0x6c]
L_8cedfe:
	btst_s r0,0x1
L_8cee00:
	bne_s L_8cee04
L_8cee02:
	nop_s
	.global L_8cee04
L_8cee04:
	bbit1 r0,0x1,L_8cee2a
L_8cee08:
	mov_s r1,0x101eee4
L_8cee0e:
	bl.d L_8dcba8
L_8cee12:
	mov_s r0,0x0
L_8cee14:
	mov_s r0,blink
L_8cee16:
	mov_s r1,0x1324
L_8cee1c:
	bl L_8c9b28
	.global L_8cee20
L_8cee20:
	pop_s blink
L_8cee22:
	j_s [blink]
	.global L_8cee24
L_8cee24:
	bclr_s r0,r0,0x1
L_8cee26:
	st_s r0,[r1,0x24]
L_8cee28:
	b_s L_8cee20
	.global L_8cee2a
L_8cee2a:
	b_s L_8cee20
