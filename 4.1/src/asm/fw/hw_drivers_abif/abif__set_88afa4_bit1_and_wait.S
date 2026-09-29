/* abif__set_88afa4_bit1_and_wait @ 0x8cbd30, 92 байт.  Сгенерировано gen_asm_tree.py
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
	.section .text.abif__set_88afa4_bit1_and_wait,"ax",@progbits
	.global abif__set_88afa4_bit1_and_wait
abif__set_88afa4_bit1_and_wait:
	.global L_8cbd30
L_8cbd30:
	push_s blink
L_8cbd32:
	mov_s r1,0x88af80
L_8cbd38:
	cmp_s r0,0x1
L_8cbd3a:
	ld_s r0,[r1,0x24]
L_8cbd3c:
	bne_s L_8cbd84
L_8cbd3e:
	bset_s r0,r0,0x1
L_8cbd40:
	st_s r0,[r1,0x24]
L_8cbd42:
	mov lp_count,0x61a80
L_8cbd4a:
	nop_s
L_8cbd4c:
	lp L_8cbd58
L_8cbd50:
	ld_s r2,[r1,0x6c]
L_8cbd52:
	btst_s r2,0x1
L_8cbd54:
	bne_s L_8cbd58
L_8cbd56:
	nop_s
	.global L_8cbd58
L_8cbd58:
	bbit1 r2,0x1,L_8cbd8a
L_8cbd5c:
	mov_s r2,0x1019934
L_8cbd62:
	mov_s r0,0x0
L_8cbd64:
	bl.d L_8edfb0
L_8cbd68:
	mov_s r1,r0
L_8cbd6a:
	mov_s r0,blink
L_8cbd6c:
	mov_s r2,0x1019954
L_8cbd72:
	mov_s r1,0x1324
L_8cbd78:
	bl.d L_8c82c0
L_8cbd7c:
	mov r3,0x10a
	.global L_8cbd80
L_8cbd80:
	pop_s blink
L_8cbd82:
	j_s [blink]
	.global L_8cbd84
L_8cbd84:
	bclr_s r0,r0,0x1
L_8cbd86:
	st_s r0,[r1,0x24]
L_8cbd88:
	b_s L_8cbd80
	.global L_8cbd8a
L_8cbd8a:
	b_s L_8cbd80
