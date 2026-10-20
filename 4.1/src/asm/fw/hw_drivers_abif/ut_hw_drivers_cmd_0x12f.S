/* ut_hw_drivers_cmd_0x12f @ 0x8ccec0, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x12f,"ax",@progbits
	.global ut_hw_drivers_cmd_0x12f
ut_hw_drivers_cmd_0x12f:
	.global L_8ccec0
L_8ccec0:
	push_s blink
L_8ccec2:
	bl L_8c02bc
L_8ccec6:
	mov_s r13,r0
L_8ccec8:
	brge.d r0,0x20,L_8cceec
L_8ccecc:
	mov_s r16,r1
	.global L_8ccece
L_8ccece:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cced0:
	/* add_s r13,0x2 */
	.byte 0x02,0xe5
L_8cced2:
	mov_s r0,0x88a004
L_8cced8:
	add2_s r0,r0,r13
L_8cceda:
	ld_s r1,[r0]
L_8ccedc:
	asl r14,r16,0x4
L_8ccee0:
	bic r1,r1,0x1f0
L_8ccee4:
	or_s r14,r14,r1
L_8ccee6:
	st_s r14,[r0]
L_8ccee8:
	b L_8c0324
	.global L_8cceec
L_8cceec:
	mov_s r0,blink
L_8cceee:
	mov_s r2,0x1019954
L_8ccef4:
	mov_s r1,0x20
L_8ccef6:
	bl.d L_8c82c0
L_8ccefa:
	mov r3,0x64a
L_8ccefe:
	b_s L_8ccece
