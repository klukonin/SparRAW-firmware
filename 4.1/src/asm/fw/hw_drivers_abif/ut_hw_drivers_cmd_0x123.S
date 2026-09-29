/* ut_hw_drivers_cmd_0x123 @ 0x8ccf00, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x123,"ax",@progbits
	.global ut_hw_drivers_cmd_0x123
ut_hw_drivers_cmd_0x123:
	.global L_8ccf00
L_8ccf00:
	push_s blink
L_8ccf02:
	bl L_8c02bc
L_8ccf06:
	mov_s r13,r0
L_8ccf08:
	brge.d r0,0x20,L_8ccf30
L_8ccf0c:
	mov_s r16,r1
	.global L_8ccf0e
L_8ccf0e:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ccf10:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8ccf12:
	mov_s r0,0x88a004
L_8ccf18:
	add2_s r0,r0,r13
L_8ccf1a:
	ld_s r1,[r0]
L_8ccf1c:
	asl r14,r16,0x14
L_8ccf20:
	and r1,r1,0xff0fffff
L_8ccf28:
	or_s r14,r14,r1
L_8ccf2a:
	st_s r14,[r0]
L_8ccf2c:
	b L_8c0324
	.global L_8ccf30
L_8ccf30:
	mov_s r0,blink
L_8ccf32:
	mov_s r2,0x1019954
L_8ccf38:
	mov_s r1,0x112b
L_8ccf3e:
	bl.d L_8c82c0
L_8ccf42:
	mov r3,0x6e4
L_8ccf46:
	b_s L_8ccf0e
