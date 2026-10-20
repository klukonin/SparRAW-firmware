/* calib_vga_gain_step @ 0x8d3964, 268 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_FLOWS_SUBTYPE_DIG_LOOPBACK_BER_TEST, calib_bb_gain_dc__vga_dc_fine, calib_row_step, hwf_calib_all
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, hwd_abif__set_agc_field, hwd_abif__set_vga_gain, hwd_abif_rx_table_config_vga_gain, hwd_abif_rx_table_read_vga_gain, hwf_vga_dc__calibrate
 */
	.section .text.calib_vga_gain_step,"ax",@progbits
	.global calib_vga_gain_step
calib_vga_gain_step:
	.global L_8d3964
L_8d3964:
	push_s blink
L_8d3966:
	bl L_8c02b8
L_8d396a:
	sub_s sp,sp,0x4
L_8d396c:
	cmp_s r1,r0
L_8d396e:
	mov_s r13,r0
L_8d3970:
	blt.d L_8d3a66
L_8d3974:
	mov_s r15,0x1
L_8d3976:
	sub_s r1,r1,r13
L_8d3978:
	extb_s r1,r1
L_8d397a:
	add r16,r1,0x1
	.global L_8d397e
L_8d397e:
	mov_s r14,0x1
L_8d3980:
	b_s L_8d3998
	.global L_8d3982
L_8d3982:
	bl.d L_8cc278
L_8d3986:
	mov_s r3,r2
L_8d3988:
	mov_s r0,r13
L_8d398a:
	mov_s r1,r14
L_8d398c:
	mov_s r2,0x1
L_8d398e:
	bl.d L_8cc278
L_8d3992:
	mov_s r3,0x0
	.global L_8d3994
L_8d3994:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d3996:
	extb_s r14,r14
	.global L_8d3998
L_8d3998:
	brhs r14,0x5,L_8d39ec
L_8d399c:
	mov_s r0,r13
L_8d399e:
	mov_s r1,r14
L_8d39a0:
	mov_s r2,0x0
L_8d39a2:
	bl.d L_8cc3c8
L_8d39a6:
	mov_s r3,0xf
L_8d39a8:
	mov_s r0,r13
L_8d39aa:
	mov_s r1,r14
L_8d39ac:
	mov_s r2,0x1
L_8d39ae:
	bl.d L_8cc3c8
L_8d39b2:
	mov_s r3,0xf
L_8d39b4:
	ldb.x r0,[gp, 0xf6]
L_8d39b8:
	mov_s r1,r14
L_8d39ba:
	cmp_s r0,0x0
L_8d39bc:
	mov_s r0,r13
L_8d39be:
	mov_s r2,0x0
L_8d39c0:
	blt_s L_8d3982
L_8d39c2:
	bl L_8cc8c0
L_8d39c6:
	sub r1,sp,0x1
L_8d39ca:
	add_s r1,r1,r14
L_8d39cc:
	stb_s r0,[r1]
L_8d39ce:
	mov_s r0,r13
L_8d39d0:
	mov_s r1,r14
L_8d39d2:
	mov_s r2,0x0
L_8d39d4:
	bl.d L_8cc4a0
L_8d39d8:
	ldb r3,[gp, 0xf6]
L_8d39dc:
	mov_s r0,r13
L_8d39de:
	mov_s r1,r14
L_8d39e0:
	mov_s r2,0x1
L_8d39e2:
	bl.d L_8cc4a0
L_8d39e6:
	ldb r3,[gp, 0xf6]
L_8d39ea:
	b_s L_8d3994
	.global L_8d39ec
L_8d39ec:
	mov_s r14,0x0
L_8d39ee:
	b_s L_8d39f4
	.global L_8d39f0
L_8d39f0:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d39f2:
	extb_s r14,r14
	.global L_8d39f4
L_8d39f4:
	brhs r14,0x2,L_8d3a5a
L_8d39f8:
	mov r17,0x1
L_8d39fc:
	b_s L_8d3a14
	.global L_8d39fe
L_8d39fe:
	mov_s r0,r13
L_8d3a00:
	mov_s r1,r14
L_8d3a02:
	mov r4,r17
	.global L_8d3a06
L_8d3a06:
	bl.d L_8d3a70
L_8d3a0a:
	add r17,r17,0x1
L_8d3a0e:
	mov_s r15,r0
L_8d3a10:
	extb r17,r17
	.global L_8d3a14
L_8d3a14:
	brhs r17,0x5,L_8d39f0
L_8d3a18:
	ldb.x r0,[gp, 0xf6]
L_8d3a1c:
	brge r0,0x0,L_8d3a2e
L_8d3a20:
	mov_s r0,r13
L_8d3a22:
	mov_s r1,r17
L_8d3a24:
	mov_s r2,r14
L_8d3a26:
	bl.d L_8cc278
L_8d3a2a:
	mov_s r3,0x1
L_8d3a2c:
	b_s L_8d3a40
	.global L_8d3a2e
L_8d3a2e:
	sub r0,sp,0x1
L_8d3a32:
	ldb r3,[r0,r17]
L_8d3a36:
	mov_s r0,r13
L_8d3a38:
	mov_s r1,r17
L_8d3a3a:
	bl.d L_8cc4a0
L_8d3a3e:
	mov_s r2,r14
	.global L_8d3a40
L_8d3a40:
	ldb r2,[gp, 0xf4]
L_8d3a44:
	brhs.d r17,0x4,L_8d39fe
L_8d3a48:
	ldb r3,[gp, 0xf5]
L_8d3a4c:
	add r4,r17,0x1
L_8d3a50:
	extb r4,r4
L_8d3a54:
	mov_s r0,r13
L_8d3a56:
	mov_s r1,r14
L_8d3a58:
	b_s L_8d3a06
	.global L_8d3a5a
L_8d3a5a:
	sub r16,r16,0x1
L_8d3a5e:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8d3a60:
	brhs.d r16,0x1,L_8d397e
L_8d3a64:
	extb_s r13,r13
	.global L_8d3a66
L_8d3a66:
	mov_s r0,r15
L_8d3a68:
	b.d L_8c031c
L_8d3a6c:
	add_s sp,sp,0x4
L_8d3a6e:
	nop_s
