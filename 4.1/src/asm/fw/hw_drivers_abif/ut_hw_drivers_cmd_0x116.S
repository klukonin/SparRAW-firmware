/* ut_hw_drivers_cmd_0x116 @ 0x8cbef8, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x116,"ax",@progbits
	.global ut_hw_drivers_cmd_0x116
ut_hw_drivers_cmd_0x116:
	.global L_8cbef8
L_8cbef8:
	push_s blink
L_8cbefa:
	bl L_8c02c0
L_8cbefe:
	mov_s r14,r1
L_8cbf00:
	mov_s r13,r2
L_8cbf02:
	brge.d r1,0x8,L_8cbf30
L_8cbf06:
	mov_s r15,r3
	.global L_8cbf08
L_8cbf08:
	brge r13,0x2,L_8cbf46
	.global L_8cbf0c
L_8cbf0c:
	rsub r0,r14,0x7
L_8cbf10:
	extb_s r0,r0
L_8cbf12:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8cbf14:
	extb_s r0,r0
L_8cbf16:
	mov_s r1,0x88af30
L_8cbf1c:
	add2_s r1,r1,r13
L_8cbf1e:
	ld_s r3,[r1]
L_8cbf20:
	mov_s r2,0xf
L_8cbf22:
	asl_s r2,r2,r0
L_8cbf24:
	bic_s r3,r3,r2
L_8cbf26:
	asl_s r15,r15,r0
L_8cbf28:
	or_s r15,r15,r3
L_8cbf2a:
	st_s r15,[r1]
L_8cbf2c:
	b L_8c032c
	.global L_8cbf30
L_8cbf30:
	mov_s r0,blink
L_8cbf32:
	mov_s r2,0x1019954
L_8cbf38:
	mov_s r1,0xb3
L_8cbf3a:
	bset_s r1,r1,0xc
L_8cbf3c:
	bl.d L_8c82c0
L_8cbf40:
	mov r3,0x34a
L_8cbf44:
	b_s L_8cbf08
	.global L_8cbf46
L_8cbf46:
	mov_s r0,blink
L_8cbf48:
	mov_s r2,0x1019954
L_8cbf4e:
	mov_s r1,0xb4
L_8cbf50:
	bset_s r1,r1,0xc
L_8cbf52:
	bl.d L_8c82c0
L_8cbf56:
	mov r3,0x34b
L_8cbf5a:
	b_s L_8cbf0c
