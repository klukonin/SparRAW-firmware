/* ut_hw_drivers_cmd_0x41a @ 0x8cfa74, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x41a,"ax",@progbits
	.global ut_hw_drivers_cmd_0x41a
ut_hw_drivers_cmd_0x41a:
	.global L_8cfa74
L_8cfa74:
	brge r0,0x0,L_8cfa7e
L_8cfa78:
	add_s r0,r0,0x10
L_8cfa7a:
	extb_s r0,r0
L_8cfa7c:
	b_s L_8cfa80
	.global L_8cfa7e
L_8cfa7e:
	extb_s r0,r0
	.global L_8cfa80
L_8cfa80:
	brge r1,0x0,L_8cfa8a
L_8cfa84:
	add_s r1,r1,0x10
L_8cfa86:
	extb_s r1,r1
L_8cfa88:
	b_s L_8cfa8c
	.global L_8cfa8a
L_8cfa8a:
	extb_s r1,r1
	.global L_8cfa8c
L_8cfa8c:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8cfa8e:
	add_s r1,r1,r0
L_8cfa90:
	mov_s r2,0x883580
L_8cfa96:
	ld_s r0,[r2,0x4]
L_8cfa98:
	extb_s r1,r1
L_8cfa9a:
	bic r0,r0,0xff
L_8cfa9e:
	or_s r0,r0,r1
L_8cfaa0:
	st_s r0,[r2,0x4]
L_8cfaa2:
	j_s [blink]
