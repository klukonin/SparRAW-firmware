/* abif__power_up_analog @ 0x8cec90, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__enable_pll, hwm__reset_analog_block
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__power_up_analog
abif__power_up_analog:
	.global L_8cec90
L_8cec90:
	push_s blink
L_8cec92:
	bl L_8c01e4
L_8cec96:
	mov_s r13,0x889380
L_8cec9c:
	brne r0,0x1,L_8ced3c
L_8ceca0:
	mov_s r14,0x88af80
L_8ceca6:
	ld_s r0,[r14,0x30]
L_8ceca8:
	mov lp_count,0x4e20
L_8cecb0:
	and r0,r0,0xfffd0fff
L_8cecb8:
	bset_s r0,r0,0xf
L_8cecba:
	st_s r0,[r14,0x30]
L_8cecbc:
	ld_s r0,[r13,0x74]
L_8cecbe:
	bclr_s r0,r0,0x5
L_8cecc0:
	bclr_s r0,r0,0x6
L_8cecc2:
	or r0,r0,0x60
L_8cecc6:
	st_s r0,[r13,0x74]
L_8cecc8:
	ld_s r0,[r13,0x74]
L_8cecca:
	bic r0,r0,0x7
L_8cecce:
	or r0,r0,0x3
L_8cecd2:
	st_s r0,[r13,0x74]
L_8cecd4:
	ld_s r0,[r13,0x74]
L_8cecd6:
	bclr_s r0,r0,0x4
L_8cecd8:
	st_s r0,[r13,0x74]
L_8cecda:
	lp L_8cece6
L_8cecde:
	ld_s r0,[r14,0x6c]
L_8cece0:
	btst_s r0,0x2
L_8cece2:
	bne_s L_8cece6
L_8cece4:
	nop_s
	.global L_8cece6
L_8cece6:
	bbit1 r0,0x2,L_8ced02
L_8cecea:
	mov_s r1,0x101eee4
L_8cecf0:
	bl.d L_8dcba8
L_8cecf4:
	mov_s r0,0x0
L_8cecf6:
	mov_s r0,blink
L_8cecf8:
	mov_s r1,0x1321
L_8cecfe:
	bl L_8c9b28
	.global L_8ced02
L_8ced02:
	mov lp_count,0x4e20
L_8ced0a:
	nop_s
L_8ced0c:
	lp L_8ced18
L_8ced10:
	ld_s r0,[r14,0x6c]
L_8ced12:
	btst_s r0,0x3
L_8ced14:
	bne_s L_8ced18
L_8ced16:
	nop_s
	.global L_8ced18
L_8ced18:
	bbit1 r0,0x3,L_8ced34
L_8ced1c:
	mov_s r1,0x101eee4
L_8ced22:
	bl.d L_8dcba8
L_8ced26:
	mov_s r0,0x0
L_8ced28:
	mov_s r0,blink
L_8ced2a:
	mov_s r1,0x1322
L_8ced30:
	bl L_8c9b28
	.global L_8ced34
L_8ced34:
	ld_s r0,[r13,0x74]
L_8ced36:
	bclr_s r0,r0,0x5
L_8ced38:
	bclr_s r0,r0,0x6
L_8ced3a:
	b_s L_8ced46
	.global L_8ced3c
L_8ced3c:
	ld_s r0,[r13,0x74]
L_8ced3e:
	bic r0,r0,0x6
L_8ced42:
	bset_s r0,r0,0x2
L_8ced44:
	bclr_s r0,r0,0x0
	.global L_8ced46
L_8ced46:
	st_s r0,[r13,0x74]
L_8ced48:
	b L_8c0254
