/* ut_hw_drivers_cmd_0x416 @ 0x8cfa04, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x416,"ax",@progbits
	.global ut_hw_drivers_cmd_0x416
ut_hw_drivers_cmd_0x416:
	.global L_8cfa04
L_8cfa04:
	push_s blink
L_8cfa06:
	push_s r13
L_8cfa08:
	cmp_s r0,0x0
L_8cfa0a:
	mov_s r13,0x1
L_8cfa0c:
	sub_s.ne r13,r13,r13
L_8cfa0e:
	mov_s r12,r13
L_8cfa10:
	bic.f r12,r12,-0xff
L_8cfa14:
	bne_s L_8cfa2a
	.global L_8cfa16
L_8cfa16:
	mov_s r1,0x883580
L_8cfa1c:
	ld_s r0,[r1,0x4]
L_8cfa1e:
	asl_s r13,r13,0x9
L_8cfa20:
	bclr_s r0,r0,0x9
L_8cfa22:
	or_s r13,r13,r0
L_8cfa24:
	st_s r13,[r1,0x4]
L_8cfa26:
	b L_8c033c
	.global L_8cfa2a
L_8cfa2a:
	mov_s r0,blink
L_8cfa2c:
	mov_s r2,0x1018690
L_8cfa32:
	mov_s r1,0xac
L_8cfa34:
	bl.d L_8c82c0
L_8cfa38:
	mov r3,0x258
L_8cfa3c:
	b_s L_8cfa16
L_8cfa3e:
	nop_s
