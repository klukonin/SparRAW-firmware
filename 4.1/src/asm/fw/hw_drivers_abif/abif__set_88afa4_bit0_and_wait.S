/* abif__set_88afa4_bit0_and_wait @ 0x8cd088, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hw_modes__pll_bypass, hw_modes__pll_engage
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.abif__set_88afa4_bit0_and_wait,"ax",@progbits
	.global abif__set_88afa4_bit0_and_wait
abif__set_88afa4_bit0_and_wait:
	.global L_8cd088
L_8cd088:
	push_s blink
L_8cd08a:
	mov_s r1,0x88af80
L_8cd090:
	cmp_s r0,0x1
L_8cd092:
	ld_s r0,[r1,0x24]
L_8cd094:
	bne_s L_8cd0d6
L_8cd096:
	bset_s r0,r0,0x0
L_8cd098:
	st_s r0,[r1,0x24]
L_8cd09a:
	mov lp_count,0x12c
L_8cd09e:
	nop_s
L_8cd0a0:
	lp L_8cd0ac
L_8cd0a4:
	ld_s r2,[r1,0x6c]
L_8cd0a6:
	btst_s r2,0x0
L_8cd0a8:
	bne_s L_8cd0ac
L_8cd0aa:
	nop_s
	.global L_8cd0ac
L_8cd0ac:
	bbit1 r2,0x0,L_8cd0dc
L_8cd0b0:
	mov_s r2,0x1019934
L_8cd0b6:
	mov_s r0,0x0
L_8cd0b8:
	bl.d L_8edfb0
L_8cd0bc:
	mov_s r1,r0
L_8cd0be:
	mov_s r0,blink
L_8cd0c0:
	mov_s r2,0x1019954
L_8cd0c6:
	mov_s r1,0x1323
L_8cd0cc:
	bl.d L_8c82c0
L_8cd0d0:
	mov_s r3,0xd4
	.global L_8cd0d2
L_8cd0d2:
	pop_s blink
L_8cd0d4:
	j_s [blink]
	.global L_8cd0d6
L_8cd0d6:
	bclr_s r0,r0,0x0
L_8cd0d8:
	st_s r0,[r1,0x24]
L_8cd0da:
	b_s L_8cd0d2
	.global L_8cd0dc
L_8cd0dc:
	b_s L_8cd0d2
L_8cd0de:
	nop_s
