/* ut_hw_drivers_cmd_0x122 @ 0x8ccf48, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_abif__set_3bit_chain_sel
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x122,"ax",@progbits
	.global ut_hw_drivers_cmd_0x122
ut_hw_drivers_cmd_0x122:
	.global L_8ccf48
L_8ccf48:
	push_s blink
L_8ccf4a:
	bl L_8c02bc
L_8ccf4e:
	mov_s r13,r0
L_8ccf50:
	brge.d r0,0x20,L_8ccf76
L_8ccf54:
	mov_s r16,r1
	.global L_8ccf56
L_8ccf56:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ccf58:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8ccf5a:
	mov_s r0,0x88a004
L_8ccf60:
	add2_s r0,r0,r13
L_8ccf62:
	ld_s r1,[r0]
L_8ccf64:
	asl r14,r16,0x11
L_8ccf68:
	bclr_s r1,r1,0x11
L_8ccf6a:
	bclr_s r1,r1,0x12
L_8ccf6c:
	bclr_s r1,r1,0x13
L_8ccf6e:
	or_s r14,r14,r1
L_8ccf70:
	st_s r14,[r0]
L_8ccf72:
	b L_8c0324
	.global L_8ccf76
L_8ccf76:
	mov_s r0,blink
L_8ccf78:
	mov_s r2,0x1019954
L_8ccf7e:
	mov_s r1,0x1127
L_8ccf84:
	bl.d L_8c82c0
L_8ccf88:
	mov r3,0x6d5
L_8ccf8c:
	b_s L_8ccf56
L_8ccf8e:
	nop_s
