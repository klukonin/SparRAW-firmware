/* hwd_abif__tx_table_config_xif_gain @ 0x8cfe9c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, abif__set_3bit_all_chains
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_abif__tx_table_config_xif_gain
hwd_abif__tx_table_config_xif_gain:
	.global L_8cfe9c
L_8cfe9c:
	push_s blink
L_8cfe9e:
	bl L_8c01dc
L_8cfea2:
	mov_s r14,r0
L_8cfea4:
	brge.d r0,0x20,L_8cfeca
L_8cfea8:
	mov_s r16,r1
	.global L_8cfeaa
L_8cfeaa:
	/* asl_s r14,r14,0x2 */
	.byte 0x02,0xbe
L_8cfeac:
	/* add_s r14,0x3 */
	.byte 0x03,0xe6
L_8cfeae:
	mov_s r0,0x88a004
L_8cfeb4:
	add2_s r0,r0,r14
L_8cfeb6:
	ld_s r1,[r0]
L_8cfeb8:
	asl r13,r16,0x11
L_8cfebc:
	bclr_s r1,r1,0x11
L_8cfebe:
	bclr_s r1,r1,0x12
L_8cfec0:
	bclr_s r1,r1,0x13
L_8cfec2:
	or_s r13,r13,r1
L_8cfec4:
	st_s r13,[r0]
L_8cfec6:
	b L_8c0244
	.global L_8cfeca
L_8cfeca:
	mov_s r0,blink
L_8cfecc:
	mov_s r1,0x1127
L_8cfed2:
	bl L_8c9b28
L_8cfed6:
	b_s L_8cfeaa
