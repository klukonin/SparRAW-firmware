/* ut_hw_drivers_cmd_0x419 @ 0x8cfaa4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x419,"ax",@progbits
	.global ut_hw_drivers_cmd_0x419
ut_hw_drivers_cmd_0x419:
	.global L_8cfaa4
L_8cfaa4:
	push_s blink
L_8cfaa6:
	push_s r13
L_8cfaa8:
	mov_s r13,r0
L_8cfaaa:
	bclr.f r0,r0,0x0
L_8cfaae:
	bne_s L_8cfac4
	.global L_8cfab0
L_8cfab0:
	mov_s r1,0x883580
L_8cfab6:
	ld_s r0,[r1,0x4]
L_8cfab8:
	asl_s r13,r13,0x8
L_8cfaba:
	bclr_s r0,r0,0x8
L_8cfabc:
	or_s r13,r13,r0
L_8cfabe:
	st_s r13,[r1,0x4]
L_8cfac0:
	b L_8c033c
	.global L_8cfac4
L_8cfac4:
	mov_s r0,blink
L_8cfac6:
	mov_s r2,0x1018690
L_8cfacc:
	mov_s r1,0xac
L_8cface:
	bl.d L_8c82c0
L_8cfad2:
	mov r3,0x27f
L_8cfad6:
	b_s L_8cfab0
