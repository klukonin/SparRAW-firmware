/* hwd_abif__sensor_get_comp_out @ 0x8cf9b0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, rladder__step_code
 * Глобалы (через gp): 0x80021e
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__sensor_get_comp_out
hwd_abif__sensor_get_comp_out:
	.global L_8cf9b0
L_8cf9b0:
	push_s r13
L_8cf9b2:
	mov_s r3,0x880b00
L_8cf9b8:
	ld_s r1,[r3]
L_8cf9ba:
	ldb_s r0,[gp,0x9a]
L_8cf9bc:
	bclr_s r1,r1,0x8
L_8cf9be:
	bset r13,r1,0x8
L_8cf9c2:
	brlt.d r0,0x1,L_8cf9d6
L_8cf9c6:
	mov_s r2,0x0
	.global L_8cf9c8
L_8cf9c8:
	st_s r1,[r3]
L_8cf9ca:
	st_s r13,[r3]
L_8cf9cc:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8cf9ce:
	ldb_s r0,[gp,0x9a]
L_8cf9d0:
	extb_s r2,r2
L_8cf9d2:
	brlt r2,r0,L_8cf9c8
	.global L_8cf9d6
L_8cf9d6:
	mov_s r0,0x889380
L_8cf9dc:
	ld_s r0,[r0,0x10]
L_8cf9de:
	bmsk_s r0,r0,0x0
L_8cf9e0:
	j_s.d [blink]
L_8cf9e2:
	pop_s r13
