/* ut_hw_drivers_cmd_0x111 @ 0x8cbe6c, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.ut_hw_drivers_cmd_0x111,"ax",@progbits
	.global ut_hw_drivers_cmd_0x111
ut_hw_drivers_cmd_0x111:
	.global L_8cbe6c
L_8cbe6c:
	push_s blink
L_8cbe6e:
	bl L_8c02bc
L_8cbe72:
	mov_s r14,r0
L_8cbe74:
	mov_s r15,r1
L_8cbe76:
	mov_s r13,r2
L_8cbe78:
	brge.d r0,0x8,L_8cbeb6
L_8cbe7c:
	mov_s r16,r3
	.global L_8cbe7e
L_8cbe7e:
	brge r15,0x2,L_8cbecc
	.global L_8cbe82
L_8cbe82:
	brge r13,0x2,L_8cbee2
	.global L_8cbe86
L_8cbe86:
	rsub r0,r14,0x7
L_8cbe8a:
	extb_s r0,r0
L_8cbe8c:
	/* asl_s r15,r15,0x2 */
	.byte 0x02,0xbf
L_8cbe8e:
	add1_s r15,r15,r13
L_8cbe90:
	asr_s r2,r0,0x2
L_8cbe92:
	add_s r2,r2,r15
L_8cbe94:
	extb_s r2,r2
L_8cbe96:
	bmsk_s r0,r0,0x1
L_8cbe98:
	asl_s r1,r0,0x3
L_8cbe9a:
	mov_s r0,0x88af10
L_8cbea0:
	add2_s r0,r0,r2
L_8cbea2:
	ld_s r3,[r0]
L_8cbea4:
	mov_s r2,0x1f
L_8cbea6:
	asl_s r2,r2,r1
L_8cbea8:
	bic_s r3,r3,r2
L_8cbeaa:
	asl r2,r16,r1
L_8cbeae:
	or_s r3,r3,r2
L_8cbeb0:
	st_s r3,[r0]
L_8cbeb2:
	b L_8c0324
	.global L_8cbeb6
L_8cbeb6:
	mov_s r0,blink
L_8cbeb8:
	mov_s r2,0x1019954
L_8cbebe:
	mov_s r1,0xae
L_8cbec0:
	bset_s r1,r1,0xc
L_8cbec2:
	bl.d L_8c82c0
L_8cbec6:
	mov r3,0x287
L_8cbeca:
	b_s L_8cbe7e
	.global L_8cbecc
L_8cbecc:
	mov_s r0,blink
L_8cbece:
	mov_s r2,0x1019954
L_8cbed4:
	mov_s r1,0xaf
L_8cbed6:
	bset_s r1,r1,0xc
L_8cbed8:
	bl.d L_8c82c0
L_8cbedc:
	mov r3,0x288
L_8cbee0:
	b_s L_8cbe82
	.global L_8cbee2
L_8cbee2:
	mov_s r0,blink
L_8cbee4:
	mov_s r2,0x1019954
L_8cbeea:
	mov_s r1,0xb0
L_8cbeec:
	bset_s r1,r1,0xc
L_8cbeee:
	bl.d L_8c82c0
L_8cbef2:
	mov r3,0x289
L_8cbef6:
	b_s L_8cbe86
