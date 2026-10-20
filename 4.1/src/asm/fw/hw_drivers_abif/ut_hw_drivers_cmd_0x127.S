/* ut_hw_drivers_cmd_0x127 @ 0x8ccb48, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, rladder__step_code
 * Глобалы (через gp): 0x800205
 */
	.section .text.ut_hw_drivers_cmd_0x127,"ax",@progbits
	.global ut_hw_drivers_cmd_0x127
ut_hw_drivers_cmd_0x127:
	.global L_8ccb48
L_8ccb48:
	push_s r13
L_8ccb4a:
	mov_s r3,0x880b00
L_8ccb50:
	ld_s r1,[r3]
L_8ccb52:
	ldb_s r0,[gp,0x95]
L_8ccb54:
	bclr_s r1,r1,0x8
L_8ccb56:
	bset r13,r1,0x8
L_8ccb5a:
	brlt.d r0,0x1,L_8ccb6e
L_8ccb5e:
	mov_s r2,0x0
	.global L_8ccb60
L_8ccb60:
	st_s r1,[r3]
L_8ccb62:
	st_s r13,[r3]
L_8ccb64:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8ccb66:
	ldb_s r0,[gp,0x95]
L_8ccb68:
	extb_s r2,r2
L_8ccb6a:
	brlt r2,r0,L_8ccb60
	.global L_8ccb6e
L_8ccb6e:
	mov_s r0,0x889380
L_8ccb74:
	ld_s r0,[r0,0x10]
L_8ccb76:
	bmsk_s r0,r0,0x0
L_8ccb78:
	j_s.d [blink]
L_8ccb7a:
	pop_s r13
