/* hwd_phy__online_measurement_config @ 0x8d1df0, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__online_measurement_config
hwd_phy__online_measurement_config:
	.global L_8d1df0
L_8d1df0:
	push_s blink
L_8d1df2:
	bl.d L_8c01e0
L_8d1df6:
	mov_s r7,r1
L_8d1df8:
	mov_s r6,r2
L_8d1dfa:
	mov_s r2,0x1
L_8d1dfc:
	mov_s r14,0x0
L_8d1dfe:
	bset r14,r14,r5
L_8d1e02:
	asr r1,r14,0x1f
L_8d1e06:
	mov_s r15,0x885000
L_8d1e0c:
	st_s r14,[r15,0x8]
L_8d1e0e:
	st_s r1,[r15,0xc]
L_8d1e10:
	st_s r2,[r15,0x4]
L_8d1e12:
	asl_s r0,r0
L_8d1e14:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8d1e16:
	asl r1,r7,0x4
L_8d1e1a:
	add_s r1,r1,r0
L_8d1e1c:
	asl r0,r6,0x5
L_8d1e20:
	add_s r0,r0,r1
L_8d1e22:
	asl_s r3,r3,0x8
L_8d1e24:
	add_s r3,r3,r0
L_8d1e26:
	asl r13,r4,0x14
L_8d1e2a:
	add_s r13,r13,r3
L_8d1e2c:
	st_s r13,[r15]
L_8d1e2e:
	b L_8c024c
L_8d1e32:
	nop_s
