/* ut_hw_drivers_cmd_0x121 @ 0x8ccd6c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x121,"ax",@progbits
	.global ut_hw_drivers_cmd_0x121
ut_hw_drivers_cmd_0x121:
	.global L_8ccd6c
L_8ccd6c:
	push_s blink
L_8ccd6e:
	bl L_8c02c4
L_8ccd72:
	mov_s r13,r0
L_8ccd74:
	brge.d r0,0x20,L_8ccd94
L_8ccd78:
	mov_s r14,r1
	.global L_8ccd7a
L_8ccd7a:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ccd7c:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8ccd7e:
	mov_s r1,0x88a004
L_8ccd84:
	add2_s r1,r1,r13
L_8ccd86:
	ld_s r0,[r1]
L_8ccd88:
	bic r0,r0,0x1f
L_8ccd8c:
	or_s r14,r14,r0
L_8ccd8e:
	st_s r14,[r1]
L_8ccd90:
	b L_8c0334
	.global L_8ccd94
L_8ccd94:
	mov_s r0,blink
L_8ccd96:
	mov_s r2,0x1019954
L_8ccd9c:
	mov_s r1,0x1126
L_8ccda2:
	bl.d L_8c82c0
L_8ccda6:
	mov r3,0x6c6
L_8ccdaa:
	b_s L_8ccd7a
