/* ut_hw_drivers_cmd_0x418 @ 0x8cfad8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x418,"ax",@progbits
	.global ut_hw_drivers_cmd_0x418
ut_hw_drivers_cmd_0x418:
	.global L_8cfad8
L_8cfad8:
	push_s blink
L_8cfada:
	bl L_8c02c0
L_8cfade:
	mov_s r13,r0
L_8cfae0:
	mov_s r14,r1
L_8cfae2:
	brge.d r0,0x8,L_8cfb14
L_8cfae6:
	mov_s r15,r2
	.global L_8cfae8
L_8cfae8:
	brge r14,0x2,L_8cfb2a
	.global L_8cfaec
L_8cfaec:
	asr_s r0,r13,0x2
L_8cfaee:
	add1_s r0,r0,r14
L_8cfaf0:
	extb_s r0,r0
L_8cfaf2:
	bmsk_s r13,r13,0x1
L_8cfaf4:
	asl_s r1,r13,0x3
L_8cfaf6:
	bmsk_s r15,r15,0x5
L_8cfaf8:
	mov_s r2,0x8851a4
L_8cfafe:
	add2_s r2,r2,r0
L_8cfb00:
	ld_s r3,[r2]
L_8cfb02:
	mov r0,-0x1
L_8cfb06:
	asl_s r0,r0,r1
L_8cfb08:
	bic_s r3,r3,r0
L_8cfb0a:
	asl_s r15,r15,r1
L_8cfb0c:
	or_s r15,r15,r3
L_8cfb0e:
	st_s r15,[r2]
L_8cfb10:
	b L_8c032c
	.global L_8cfb14
L_8cfb14:
	mov_s r0,blink
L_8cfb16:
	mov_s r2,0x1018690
L_8cfb1c:
	mov_s r1,0xde
L_8cfb1e:
	bset_s r1,r1,0xc
L_8cfb20:
	bl.d L_8c82c0
L_8cfb24:
	mov r3,0x26a
L_8cfb28:
	b_s L_8cfae8
	.global L_8cfb2a
L_8cfb2a:
	mov_s r0,blink
L_8cfb2c:
	mov_s r2,0x1018690
L_8cfb32:
	mov_s r1,0xdf
L_8cfb34:
	bset_s r1,r1,0xc
L_8cfb36:
	bl.d L_8c82c0
L_8cfb3a:
	mov r3,0x26b
L_8cfb3e:
	b_s L_8cfaec
