/* hwd_abif__set_agc004_w4 @ 0x8cccf4, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_if_gain__apply_agc_table
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__set_agc004_w4,"ax",@progbits
	.global hwd_abif__set_agc004_w4
hwd_abif__set_agc004_w4:
	.global L_8cccf4
L_8cccf4:
	push_s blink
L_8cccf6:
	bl L_8c02bc
L_8cccfa:
	mov_s r13,r0
L_8cccfc:
	cmp_s r0,0x40
L_8cccfe:
	mov_s r14,r1
L_8ccd00:
	mov_s r15,r2
L_8ccd02:
	bge_s L_8ccd2e
	.global L_8ccd04
L_8ccd04:
	mov r16,0x0
L_8ccd08:
	breq r14,0x1,L_8ccd44
L_8ccd0c:
	breq r14,0x2,L_8ccd48
L_8ccd10:
	breq r14,0x3,L_8ccd4c
L_8ccd14:
	mov_s r0,blink
L_8ccd16:
	mov_s r2,0x1019954
L_8ccd1c:
	mov_s r1,0x1121
L_8ccd22:
	bl.d L_8c82c0
L_8ccd26:
	mov r3,0x6b6
L_8ccd2a:
	mov_s r1,r16
L_8ccd2c:
	b_s L_8ccd4e
	.global L_8ccd2e
L_8ccd2e:
	mov_s r0,blink
L_8ccd30:
	mov_s r2,0x1019954
L_8ccd36:
	mov_s r1,0x89
L_8ccd38:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8ccd3a:
	bl.d L_8c82c0
L_8ccd3e:
	mov r3,0x6a7
L_8ccd42:
	b_s L_8ccd04
	.global L_8ccd44
L_8ccd44:
	mov_s r1,0x5
L_8ccd46:
	b_s L_8ccd4e
	.global L_8ccd48
L_8ccd48:
	mov_s r1,0x9
L_8ccd4a:
	b_s L_8ccd4e
	.global L_8ccd4c
L_8ccd4c:
	mov_s r1,0xd
	.global L_8ccd4e
L_8ccd4e:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ccd50:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8ccd52:
	mov_s r0,0x88a004
L_8ccd58:
	add2_s r0,r0,r13
L_8ccd5a:
	ld_s r3,[r0]
L_8ccd5c:
	mov_s r2,0xf
L_8ccd5e:
	asl_s r2,r2,r1
L_8ccd60:
	bic_s r3,r3,r2
L_8ccd62:
	asl_s r15,r15,r1
L_8ccd64:
	or_s r3,r3,r15
L_8ccd66:
	st_s r3,[r0]
L_8ccd68:
	b L_8c0324
