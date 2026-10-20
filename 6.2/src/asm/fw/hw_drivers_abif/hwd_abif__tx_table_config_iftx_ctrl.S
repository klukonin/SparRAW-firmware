/* hwd_abif__tx_table_config_iftx_ctrl @ 0x8cfcb4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: IF_GAIN__GAIN, UT_HW_DRIVERS_cmd_handler, hwf_if_gain__apply_agc_table
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_iftx_ctrl
hwd_abif__tx_table_config_iftx_ctrl:
	.global L_8cfcb4
L_8cfcb4:
	push_s blink
L_8cfcb6:
	bl L_8c01dc
L_8cfcba:
	mov_s r13,r0
L_8cfcbc:
	cmp_s r0,0x40
L_8cfcbe:
	mov_s r14,r1
L_8cfcc0:
	mov_s r15,r2
L_8cfcc2:
	bge_s L_8cfce4
	.global L_8cfcc4
L_8cfcc4:
	mov r16,0x0
L_8cfcc8:
	breq r14,0x1,L_8cfcf0
L_8cfccc:
	breq r14,0x2,L_8cfcf4
L_8cfcd0:
	breq r14,0x3,L_8cfcf8
L_8cfcd4:
	mov_s r0,blink
L_8cfcd6:
	mov_s r1,0x1121
L_8cfcdc:
	bl L_8c9b28
L_8cfce0:
	mov_s r1,r16
L_8cfce2:
	b_s L_8cfcfa
	.global L_8cfce4
L_8cfce4:
	mov_s r0,blink
L_8cfce6:
	mov_s r1,0x89
L_8cfce8:
	/* bl.d 0x008c9b28 */
	.byte 0x42,0x0e,0xef,0xfc
L_8cfcec:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8cfcee:
	b_s L_8cfcc4
	.global L_8cfcf0
L_8cfcf0:
	mov_s r1,0x5
L_8cfcf2:
	b_s L_8cfcfa
	.global L_8cfcf4
L_8cfcf4:
	mov_s r1,0x9
L_8cfcf6:
	b_s L_8cfcfa
	.global L_8cfcf8
L_8cfcf8:
	mov_s r1,0xd
	.global L_8cfcfa
L_8cfcfa:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8cfcfc:
	/* add_s r13,0x3 */
	.byte 0x03,0xe5
L_8cfcfe:
	mov_s r0,0x88a004
L_8cfd04:
	add2_s r0,r0,r13
L_8cfd06:
	ld_s r3,[r0]
L_8cfd08:
	mov_s r2,0xf
L_8cfd0a:
	asl_s r2,r2,r1
L_8cfd0c:
	bic_s r3,r3,r2
L_8cfd0e:
	asl_s r15,r15,r1
L_8cfd10:
	or_s r3,r3,r15
L_8cfd12:
	st_s r3,[r0]
L_8cfd14:
	b L_8c0244
