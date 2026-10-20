/* ut_hw_drivers_cmd_0x11d @ 0x8cccb4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x11d,"ax",@progbits
	.global ut_hw_drivers_cmd_0x11d
ut_hw_drivers_cmd_0x11d:
	.global L_8cccb4
L_8cccb4:
	push_s blink
L_8cccb6:
	bl L_8c02c4
L_8cccba:
	mov_s r13,r0
L_8cccbc:
	brge.d r0,0x20,L_8cccda
L_8cccc0:
	mov_s r14,r1
	.global L_8cccc2
L_8cccc2:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cccc4:
	mov_s r1,0x88a004
L_8cccca:
	add2_s r1,r1,r13
L_8ccccc:
	ld_s r0,[r1]
L_8cccce:
	bic r0,r0,0x3f
L_8cccd2:
	or_s r14,r14,r0
L_8cccd4:
	st_s r14,[r1]
L_8cccd6:
	b L_8c0334
	.global L_8cccda
L_8cccda:
	mov_s r0,blink
L_8cccdc:
	mov_s r2,0x1019954
L_8ccce2:
	mov_s r1,0x1105
L_8ccce8:
	bl.d L_8c82c0
L_8cccec:
	mov r3,0x638
L_8cccf0:
	b_s L_8cccc2
L_8cccf2:
	nop_s
